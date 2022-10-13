library azure_app_config;

import 'package:azure_app_config/azure_remote_interceptor.dart';
import 'package:azure_app_config/feature_filter.dart';
import 'package:azure_app_config/models/feature_flag.dart';
import 'package:azure_app_config/models/key.dart';
import 'package:azure_app_config/models/key_value.dart';
import 'package:azure_app_config/util/connection_string_parser.dart';
import 'package:dio/dio.dart';
import 'dart:developer' as developer;

class AzureRemoteService {
  final String apiVersion = "1.0";
  final Dio dio = Dio();

  late final String endpoint;

  List<FeatureFilter> _featureFilters = [];

  AzureRemoteService({
    required String connectionString,
  }) {
    Map<String, String> azureValues = parseConnectionString(connectionString);

    if (azureValues['Id'] == null ||
        azureValues['Secret'] == null ||
        azureValues['Endpoint'] == null) {
      throw Exception("Invalid connection string");
    }

    String credential = azureValues['Id']!;
    String secret = azureValues['Secret']!;

    endpoint = azureValues['Endpoint']!;

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

  void addFeatureFilter(FeatureFilter filter) {
    _featureFilters.add(filter);
  }

  Future<Map<String, dynamic>> _get(
      String path, Map<String, String> queryParams) async {
    final networkResponse = await dio.get(
      "$endpoint$path",
      queryParameters: queryParams,
    );

    return networkResponse.data;
  }

  /// Retrieve whether a feature is enabled. This method also validates the featurefilters.
  Future<bool> getFeatureEnabled(String key, String label) async {
    final keyValue = await getKeyValue('.appconfig.featureflag/$key', label);

    final FeatureFlag? feature = keyValue.asFeatureFlag();

    if (feature == null) {
      return Future.error("KeyValue is not parsable as feature flag");
    }

    final clientFilters = feature.conditions['client_filters'];

    bool enabled = feature.enabled;

    if (enabled == false) return false;

    for (final filter in clientFilters) {
      final String name = filter['name'];
      final Map<String, dynamic> params = filter['parameters'];

      for (final filter in _featureFilters) {
        if (filter.name == name) {
          enabled = filter.evaluate(params);
          developer.log("AZURE FILTER [$key] => $name");
        }
      }
    }

    return enabled;
  }

  /// Retrieve a list of all feature flags.
  Future<List<FeatureFlag>> getFeatureFlags() async {
    final featureFlags = <FeatureFlag>[];

    final keyValues = await getKeyValues();

    for (final kv in keyValues) {
      final FeatureFlag? featureFlag = kv.asFeatureFlag();

      if (featureFlag != null) featureFlags.add(featureFlag);
    }

    return featureFlags;
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

    for (final json in data["items"]) {
      items.add(KeyValue.fromJson(json));
    }

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
      "api_version": apiVersion,
    };

    final data = await _get(path, params);

    final List<AzureKey> items = [];

    for (final json in data["items"]) {
      final item = AzureKey.fromJson(json);
      items.add(item);
    }

    return items;
  }
}
