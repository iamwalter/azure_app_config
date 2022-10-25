import 'package:azure_app_config/src/azure_remote_service.dart';
import 'package:azure_app_config/src/core/client.dart';
import 'package:azure_app_config/src/feature_filter.dart';
import 'package:azure_app_config/src/models/errors/azure_errors.dart';
import 'package:azure_app_config/src/models/feature_flag.dart';
import 'package:azure_app_config/src/models/key.dart';
import 'package:azure_app_config/src/models/key_value.dart';
import 'package:dio/dio.dart';

import 'dart:developer' as developer;

class AzureRemoteServiceImpl implements AzureRemoteService {
  AzureRemoteServiceImpl({
    required this.client,
  }) {
    // Add Standard Filters
    registerFeatureFilter(FeatureFilter.percentage());
    registerFeatureFilter(FeatureFilter.timeWindow());
  }

  final Client client;

  List<FeatureFilter> featureFilters = [];

  Dio get dio => client.dio;

  void registerFeatureFilter(FeatureFilter filter) {
    featureFilters.add(filter);
  }

  Future<bool> getFeatureEnabled(String key, String label) async {
    final keyValue = await getKeyValue('.appconfig.featureflag/$key', label);

    final FeatureFlag? feature = keyValue.asFeatureFlag();

    if (feature == null) {
      throw AzureKeyValueNotParsableAsFeatureFlag();
    }

    final clientFilters = feature.conditions['client_filters'];

    bool enabled = feature.enabled;

    if (enabled == false) return false;

    for (final filter in clientFilters) {
      final String name = filter['name'];
      final Map<String, dynamic> params = filter['parameters'];

      for (final filter in featureFilters) {
        if (filter.name == name) {
          enabled = filter.evaluate(params);
          developer.log("AZURE FILTER [$key] => $name");
        }
      }
    }

    return enabled;
  }

  Future<List<FeatureFlag>> getFeatureFlags() async {
    final featureFlags = <FeatureFlag>[];

    final keyValues = await getKeyValues();

    for (final kv in keyValues) {
      final FeatureFlag? featureFlag = kv.asFeatureFlag();

      if (featureFlag != null) featureFlags.add(featureFlag);
    }

    return featureFlags;
  }

  Future<List<KeyValue>> getKeyValues() async {
    final path = "/kv";
    final params = {
      "label": "*",
    };

    final response = await client.get(
      path: path,
      params: params,
    );
    final data = response.data;

    final items = <KeyValue>[];

    for (final json in data["items"]) {
      items.add(KeyValue.fromJson(json));
    }

    return items;
  }

  Future<KeyValue> getKeyValue(String key, String label) async {
    final path = "/kv/$key";
    final params = {
      "label": label,
    };
    final response = await client.get(
      path: path,
      params: params,
    );
    final data = response.data;

    return KeyValue.fromJson(data);
  }

  Future<List<AzureKey>> getKeys() async {
    final path = "/keys";
    final params = <String, String>{};

    final response = await client.get(
      path: path,
      params: params,
    );
    final data = response.data;

    final List<AzureKey> items = [];

    for (final json in data["items"]) {
      final item = AzureKey.fromJson(json);
      items.add(item);
    }

    return items;
  }

  Future<Response> setKeyValue({
    required String key,
    required String label,
    String? value,
    String? contentType,
    Map<String, dynamic>? tags,
  }) async {
    final path = '/kv/$key';
    final params = {
      "label": label,
    };

    final data = <String, dynamic>{};

    if (value != null) data['value'] = value;
    if (contentType != null) data['content_type'] = contentType;
    if (tags != null) data['tags'] = tags;

    return client.put(
      path: path,
      params: params,
      data: data,
      headers: {
        "Content-Type": "application/vnd.microsoft.appconfig.kv+json",
      },
    );
  }
}
