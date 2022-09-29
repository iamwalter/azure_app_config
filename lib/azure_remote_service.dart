library azure_app_config;

import 'dart:convert';

import 'package:azure_app_config/azure_remote_interceptor.dart';
import 'package:azure_app_config/feature_filter.dart';
import 'package:azure_app_config/models/feature_flag.dart';
import 'package:azure_app_config/models/key.dart';
import 'package:azure_app_config/models/key_value.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoadingStrategy {
  /// Check if the key has already been saved to storage.
  OFFLINE_FIRST,

  /// Always check the latest value
  ONLINE_ALWAYS,
}

class AzureRemoteService {
  final String apiVersion = "1.0";
  final Dio dio = Dio();
  final String host;

  LoadingStrategy loadingStrategy;
  List<FeatureFilter> _featureFilters = [];

  AzureRemoteService({
    required this.host,
    required String credential,
    required String secret,
    this.loadingStrategy = LoadingStrategy.ONLINE_ALWAYS,
  }) {
    dio.interceptors.add(
      AzureRemoteInterceptor(
        credential: credential,
        secret: secret,
      ),
    );

    // Add Standard Filters
    addFeatureFilter(FeatureFilter.percentage());
    addFeatureFilter(FeatureFilter.timeWindow());
  }

  void switchStrategy(LoadingStrategy strategy) {
    print("Changing strategy to $strategy");
    loadingStrategy = strategy;
  }

  void addFeatureFilter(FeatureFilter filter) {
    _featureFilters.add(filter);
  }

  Future<bool> clearStorage() async {
    final storage = await SharedPreferences.getInstance();
    return storage.clear();
  }

  Future<Map<String, dynamic>> _get(
      String path, Map<String, String> queryParams) async {
    final storage = await SharedPreferences.getInstance();

    final String storageKey = "$path$queryParams";
    final String? data = storage.getString(storageKey);

    if (loadingStrategy == LoadingStrategy.OFFLINE_FIRST && data != null) {
      print("AZURE LOCAL REQUEST[GET] => $path ($queryParams)");

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

  /// Retrieve whether a feature is enabled. This method also validates the featurefilters.
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

  /// Retrieve a list of all feature flags.
  Future<List<FeatureFlag>> getFeatureFlags() async {
    final returned = <FeatureFlag>[];
    final features = await getKeyValues();

    for (final kv in features) {
      if (kv.content_type ==
          "application/vnd.microsoft.appconfig.ff+json;charset=utf-8") {
        final feature = await getFeatureFlag(kv.key, kv.label ?? "");

        returned.add(feature);
      }
    }

    return returned;
  }

  /// Retrieve a specified feature flag.
  Future<FeatureFlag> getFeatureFlag(String key, String label) async {
    final path = "/kv/$key";
    final params = {
      "label": label,
      "api_version": apiVersion,
    };

    final data = await _get(path, params);

    final KeyValue keyValue = KeyValue.fromJson(data);
    final FeatureFlag featureFlag = FeatureFlag.fromJson(keyValue.value);

    return featureFlag;
  }

  /// Retrieve a list of key-values.
  Future<List<KeyValue>> getKeyValues() async {
    final path = "/kv/";
    final params = {
      "label": "*",
      "api_version": apiVersion,
    };

    final data = await _get(path, params);

    final items = <KeyValue>[];

    data["items"].forEach((json) {
      items.add(KeyValue.fromJson(json));
    });

    return items;
  }

  /// Get a specific key-value
  Future<KeyValue> getKeyValue(String key, String label) async {
    final path = "/kv/$key";
    final params = {
      "label": label,
      "api_version": apiVersion,
    };

    final data = await _get(path, params);

    return KeyValue.fromJson(data);
  }

  /// Get a specific key-value
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
