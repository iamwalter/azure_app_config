// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:developer' as developer;

import 'package:azure_app_config/src/azure_app_config.dart';
import 'package:azure_app_config/src/azure_filters.dart';
import 'package:azure_app_config/src/core/client.dart';
import 'package:azure_app_config/src/core/registered_type.dart';
import 'package:azure_app_config/src/feature_filters/feature_filter.dart';
import 'package:azure_app_config/src/models/errors/azure_errors.dart';
import 'package:azure_app_config/src/models/feature_flag.dart';
import 'package:azure_app_config/src/models/key.dart';
import 'package:azure_app_config/src/models/key_value.dart';
import 'package:dio/dio.dart';

class AzureAppConfigImpl implements AzureAppConfig {
  /// Constructs an instance and registers default [FeatureFilter]s.
  AzureAppConfigImpl({
    required this.client,
  });

  final Client client;

  Map<String, FeatureFilter> featureFilters = {};

  // Map that holds registeredType mapping data.
  Map<Type, RegisteredType<dynamic>> registeredTypes = {};

  @override
  Dio get dio => client.dio;

  static const String _featureFlagPrefix = '.appconfig.featureflag/';
  static const String _keyValueContentType =
      'application/vnd.microsoft.appconfig.kv+json';

  @override
  void registerFeatureFilter(FeatureFilter filter) {
    featureFilters[filter.name] = filter;
  }

  @override
  Future<bool> getFeatureEnabled({
    required String key,
    required String label,
  }) async {
    final keyValue =
        await getKeyValue(key: '$_featureFlagPrefix$key', label: label);

    final feature = keyValue.asFeatureFlag();

    if (feature == null) {
      throw AzureKeyValueNotParsableAsFeatureFlagException();
    }

    var enabled = feature.enabled;

    // If the feature is disabled, just return false.
    if (!enabled) return false;

    final clientFilters = feature.getClientFilters();

    for (final clientFilter in clientFilters) {
      final name = clientFilter.name;
      final params = clientFilter.parameters;

      if (featureFilters[name] != null) {
        final filter = featureFilters[name]!;

        enabled = filter.evaluate(params, key);

        // If any featureFilter returns false, return false.
        if (!enabled) return false;

        developer.log('AZURE FILTER [$key] => ${clientFilter.name}');
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
  Future<KeyValue> getKeyValue({
    required String key,
    required String label,
  }) async {
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

    final headers = {
      'Content-Type': _keyValueContentType,
    };

    return client.put(
      path: path,
      params: params,
      data: data,
      headers: headers,
    );
  }

  @override
  Future<Response<dynamic>> disableFeature({
    required String key,
    required String label,
  }) =>
      setFeatureEnabled(key: key, label: label, isEnabled: false);

  @override
  Future<Response<dynamic>> enableFeature({
    required String key,
    required String label,
  }) =>
      setFeatureEnabled(key: key, label: label, isEnabled: true);

  @override
  Future<Response<dynamic>> setFeatureEnabled({
    required String key,
    required String label,
    required bool isEnabled,
  }) async {
    final keyValue = await getKeyValue(
      key: '$_featureFlagPrefix$key',
      label: label,
    );

    final featureFlag = keyValue.asFeatureFlag();

    final description = featureFlag?.description;
    final conditions = featureFlag?.conditions;

    return setFeatureFlag(
      key: key,
      label: label,
      enabled: isEnabled,
      description: description,
      conditions: conditions,
    );

  }

  @override
  Future<List<KeyValue>> findKeyValuesBy({
    String key = AzureFilters.any,
    String label = AzureFilters.any,
  }) async {
    const path = '/kv';
    final params = {
      'key': key,
      'label': label,
    };

    final response = await client.get(path: path, params: params);

    final data = response.data;
    final items = <KeyValue>[];

    for (final json in data['items'] as List<dynamic>) {
      final item = KeyValue.fromJson(json as Map<String, dynamic>);
      items.add(item);
    }

    return items;
  }

  @override
  Future<List<AzureKey>> findKeyBy({
    String name = AzureFilters.any,
  }) async {
    const path = '/keys';
    final params = {
      'name': name,
    };

    final response = await client.get(path: path, params: params);

    final data = response.data;
    final items = <AzureKey>[];

    for (final json in data['items'] as List<dynamic>) {
      final item = AzureKey.fromJson(json as Map<String, dynamic>);
      items.add(item);
    }

    return items;
  }

  @override
  void registerType<O>({
    O Function(Map<String, dynamic> jsonData)? decode,
    Map<String, dynamic> Function(O object)? encode,
  }) {
    if (registeredTypes[O] != null) {
      throw AzureComplexTypeException(
        'ComplexType $O is already registered',
      );
    }

    registeredTypes[O] = RegisteredType<O>(
      decode: decode,
      encode: encode,
    );
  }

  @override
  void unregisterType<O>() {
    registeredTypes.remove(O);
  }

  @override
  Future<O> getTyped<O>({
    required String key,
    required String label,
  }) async {
    final keyValue = await getKeyValue(key: key, label: label);

    if (registeredTypes[O] == null) {
      throw AzureComplexTypeException(
        'ComplexType $O is not registered',
      );
    }

    if (registeredTypes[O]!.decode == null) {
      throw AzureComplexTypeException(
        'ComplexType $O decode is not registered!',
      );
    }

    return registeredTypes[O]!
        .decode!(json.decode(keyValue.value) as Map<String, dynamic>) as O;
  }

  @override
  Future<void> setTyped<O>(
    O object, {
    required String key,
    required String label,
  }) async {
    // make sure we're working with registeredType<O> and not
    // registeredType<dynamic>
    final registeredType = registeredTypes[O] as RegisteredType<O>?;

    if (registeredType == null) {
      throw AzureComplexTypeException(
        'ComplexType O is not registered',
      );
    }
    if (registeredType.encode == null) {
      throw AzureComplexTypeException('ComplexType encode not registered!');
    }

    final json = registeredType.encode!(object);

    await setKeyValue(
      key: key,
      label: label,
      value: jsonEncode(json),
      contentType: 'application/json',
    );
  }

  @override
  Future<Response<dynamic>> setFeatureFlag({
    required String key,
    required String? label,
    required bool enabled,
    String? description = '',
    Map<String, dynamic>? conditions,
  }) async {
    const featureFlagContentType =
        'application/vnd.microsoft.appconfig.ff+json;charset=utf-8';

    final response = await setKeyValue(
      key: '$_featureFlagPrefix$key',
      label: label ?? '',
      value: jsonEncode(
        FeatureFlag(
          id: key,
          description: description ?? '',
          enabled: enabled,
          conditions: conditions ?? {},
        ).toJson(),
      ),
      contentType: featureFlagContentType,
    );

    return response;
  }
}
