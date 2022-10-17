library azure_app_config;

import 'package:azure_app_config/feature_filter.dart';
import 'package:azure_app_config/models/errors/azure_errors.dart';
import 'package:azure_app_config/models/feature_flag.dart';
import 'package:azure_app_config/models/key.dart';
import 'package:azure_app_config/models/key_value.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'dart:developer' as developer;

import 'core/client.dart';

abstract class AzureRemoteService {
  factory AzureRemoteService({required String connectionString}) =>
      _AzureRemoteService(connectionString: connectionString);

  /// Retrieves whether a [FeatureFlag] is enabled, using registered [FeatureFilter]'s. See [registerFeatureFilter].
  ///
  /// Throws a [AzureKeyValueNotParsableAsFeatureFlag] if the [KeyValue] is not parsable to a
  /// [FeatureFlag].
  Future<bool> getFeatureEnabled(String key, String label);

  /// Retrieve a list of [FeatureFlag].
  Future<List<FeatureFlag>> getFeatureFlags();

  /// Retrieve a list of [KeyValue].
  Future<List<KeyValue>> getKeyValues();

  /// Get a specific [KeyValue]'s.
  Future<KeyValue> getKeyValue(String key, String label);

  /// Retrieve a list of [AzureKey].
  Future<List<AzureKey>> getKeys();

  /// This method registers a [FeatureFilter]. The evaluation will happen when using the method
  /// [getFeatureEnabled].
  void registerFeatureFilter(FeatureFilter filter);

  /// Make Dio available for tests.
  @protected
  Dio get dio;
}

class _AzureRemoteService implements AzureRemoteService {
  List<FeatureFilter> featureFilters = [];

  Dio get dio => client.dio;

  final Client client;

  _AzureRemoteService({
    required String connectionString,
  }) : client = Client(connectionString: connectionString) {
    // Add Standard Filters
    registerFeatureFilter(FeatureFilter.percentage());
    registerFeatureFilter(FeatureFilter.timeWindow());
  }

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

    final response = await client.get(path, params);
    final data = response.data;

    final items = <KeyValue>[];

    for (final json in data["items"]) {
      items.add(KeyValue.fromMap(json));
    }

    return items;
  }

  Future<KeyValue> getKeyValue(String key, String label) async {
    final path = "/kv/$key";
    final params = {
      "label": label,
    };
    final response = await client.get(path, params);
    final data = response.data;

    return KeyValue.fromMap(data);
  }

  Future<List<AzureKey>> getKeys() async {
    final path = "/keys";
    final params = <String, String>{};

    final response = await client.get(path, params);
    final data = response.data;

    final List<AzureKey> items = [];

    for (final json in data["items"]) {
      final item = AzureKey.fromMap(json);
      items.add(item);
    }

    return items;
  }
}
