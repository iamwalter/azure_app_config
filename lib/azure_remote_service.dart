import 'dart:convert';

import 'package:azure_app_config/azure_remote_interceptor.dart';
import 'package:azure_app_config/feature_filter.dart';
import 'package:azure_app_config/models/feature_flag.dart';
import 'package:azure_app_config/models/key.dart';
import 'package:azure_app_config/models/key_value.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoadingStrategy {
  ALWAYS_ONLINE,
  OFFLINE_CACHE_ONLINE,
}

class AzureRemoteService {
  final String API_VERSION = "1.0";

  final Dio dio = Dio();

  final String host;
  final LoadingStrategy loadingStrategy;

  List<FeatureFilter> _featureFilters = [];

  AzureRemoteService({
    required this.host,
    required String credential,
    required String secret,
    this.loadingStrategy = LoadingStrategy.ALWAYS_ONLINE,
  }) {
    dio.interceptors.add(
      AzureRemoteInterceptor(
        credential: credential,
        secret: secret,
      ),
    );

    // Add Standard Filters
    addFeatureFilter(Percentage());
    addFeatureFilter(TimeWindow(() => DateTime.now()));
  }

  void addFeatureFilter(FeatureFilter filter) {
    _featureFilters.add(filter);
  }

  Future<Map<String, dynamic>> _get(
      String path, Map<String, String> queryParams) async {
    final storage = await SharedPreferences.getInstance();

    final String storageKey = "$path$queryParams";

    final String? data = storage.getString(storageKey);

    if (data != null) {
      print("AZURE LOCAL REQUEST[GET] => $path");
      return json.decode(data);
    } else {
      final networkResponse = await dio.get(
        "$host$path",
        queryParameters: queryParams,
      );

      await storage.setString(storageKey, json.encode(networkResponse.data));

      return networkResponse.data;
    }
  }

  Future<bool> getFeatureEnabled(String key, String label) async {
    final feature = await getFeatureFlag(key, label);

    final clientFilters = feature.conditions['client_filters'];

    bool enabled = feature.enabled;

    if (enabled == false) return false;

    for (final filter in clientFilters) {
      final String name = filter['name'];
      final Map<String, dynamic> params = filter['parameters'];

      for (final filter in _featureFilters) {
        if (filter.name == name) {
          enabled = filter.evaluate(params);
          print("AZURE FILTER [$key] => $name");
        }
      }
    }

    return enabled;
  }

  Future<FeatureFlag> getFeatureFlag(String key, String label) async {
    final path = "/kv/.appconfig.featureflag/$key";
    final params = {
      "label": label,
      "api_version": API_VERSION,
    };

    final data = await _get(path, params);

    final KeyValue keyValue = KeyValue.fromJson(data);
    final FeatureFlag featureFlag = FeatureFlag.fromJson(keyValue.value);

    return featureFlag;
  }

  Future<List<KeyValue>> getKeyValues() async {
    final path = "/kv/";
    final params = {
      "label": "*",
      "api_version": API_VERSION,
    };

    final data = await _get(path, params);

    final items = <KeyValue>[];

    data["items"].forEach((json) {
      items.add(KeyValue.fromJson(json));
    });

    return items;
  }

  Future<KeyValue> getKeyValue(String key, String label) async {
    final path = "/kv/$key";
    final params = {
      "label": label,
      "api_version": API_VERSION,
    };

    final data = await _get(path, params);

    return KeyValue.fromJson(data);
  }

  Future<List<AzureKey>> getKeys() async {
    final path = "/keys";
    final params = {
      "api_version": "1.0",
    };

    final data = await _get(path, params);

    final List<AzureKey> items = [];

    for (final i in data["items"]) {
      final item = AzureKey.fromJson(i);
      items.add(item);
    }

    return items;
  }
}
