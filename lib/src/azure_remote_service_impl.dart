import 'dart:developer' as developer;

import 'package:azure_app_config/src/azure_remote_service.dart';
import 'package:azure_app_config/src/core/client.dart';
import 'package:azure_app_config/src/feature_filter.dart';
import 'package:azure_app_config/src/models/errors/azure_errors.dart';
import 'package:azure_app_config/src/models/feature_flag.dart';
import 'package:azure_app_config/src/models/key.dart';
import 'package:azure_app_config/src/models/key_value.dart';
import 'package:dio/dio.dart';

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

  @override
  Dio get dio => client.dio;

  @override
  void registerFeatureFilter(FeatureFilter filter) {
    featureFilters.add(filter);
  }

  @override
  Future<bool> getFeatureEnabled(String key, String label) async {
    final keyValue = await getKeyValue('.appconfig.featureflag/$key', label);

    final feature = keyValue.asFeatureFlag();

    if (feature == null) {
      throw AzureKeyValueNotParsableAsFeatureFlag();
    }

    var enabled = feature.enabled;

    final clientFilters = feature.getClientFilters();

    for (final clientFilter in clientFilters) {
      final name = clientFilter.name;
      final params = clientFilter.parameters;

      for (final featureFilter in featureFilters) {
        if (featureFilter.name == name) {
          enabled = featureFilter.evaluate(params);

          developer.log('AZURE FILTER [$key] => ${clientFilter.name}');
        }
      }
    }

    return enabled;
  }

  @override
  Future<List<FeatureFlag>> getFeatureFlags() async {
    final featureFlags = <FeatureFlag>[];

    final keyValues = await getKeyValues();

    for (final kv in keyValues) {
      final featureFlag = kv.asFeatureFlag();

      if (featureFlag != null) featureFlags.add(featureFlag);
    }

    return featureFlags;
  }

  @override
  Future<List<KeyValue>> getKeyValues() async {
    const path = '/kv';
    final params = {
      'label': '*',
    };

    final response = await client.get(
      path: path,
      params: params,
    );
    final data = response.data;

    final items = <KeyValue>[];
    for (final json in data['items'] as List<dynamic>) {
      items.add(KeyValue.fromJson(json as Map<String, Object?>));
    }

    return items;
  }

  @override
  Future<KeyValue> getKeyValue(String key, String label) async {
    final path = '/kv/$key';
    final params = {
      'label': label,
    };
    final response = await client.get(
      path: path,
      params: params,
    );
    final data = response.data;

    return KeyValue.fromJson(data as Map<String, Object?>);
  }

  @override
  Future<List<AzureKey>> getKeys() async {
    const path = '/keys';
    final params = <String, String>{};

    final response = await client.get(
      path: path,
      params: params,
    );
    final data = response.data;

    final items = <AzureKey>[];

    for (final json in data['items'] as List<dynamic>) {
      final item = AzureKey.fromJson(json as Map<String, Object?>);
      items.add(item);
    }

    return items;
  }

  @override
  Future<Response<dynamic>> setKeyValue({
    required String key,
    required String label,
    String? value,
    String? contentType,
    Map<String, dynamic>? tags,
  }) async {
    final path = '/kv/$key';
    final params = {
      'label': label,
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
        'Content-Type': 'application/vnd.microsoft.appconfig.kv+json',
      },
    );
  }
}
