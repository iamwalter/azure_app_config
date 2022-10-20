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

/// This class represents the Microsoft Azure App Configuration.
///
/// # Authentication
///
/// A connection string is required to use App Configuration.
/// The connection string can be obtained from the App Configuration Dashboard
/// under 'Access keys'.
///
/// Please note that when a connection string is invalid or not specified,
/// an [ArgumentError] will occur when creating an instance of [AzureRemoteService].
abstract class AzureRemoteService {
  factory AzureRemoteService({
    required String connectionString,
  }) {
    final client = Client(connectionString: connectionString);

    return _AzureRemoteServiceImpl(client: client);
  }

  /// Retrieves whether a [FeatureFlag] is enabled, using registered [FeatureFilter]'s. See [registerFeatureFilter].
  ///
  /// Throws a [AzureKeyValueNotParsableAsFeatureFlag] if the [KeyValue] is not parsable to a
  /// [FeatureFlag].
  Future<bool> getFeatureEnabled(String key, String label);

  /// Retrieve a list of [FeatureFlag].
  Future<List<FeatureFlag>> getFeatureFlags();

  /// Retrieve a list of [KeyValue].
  Future<List<KeyValue>> getKeyValues();

  /// Get a specific [KeyValue].
  Future<KeyValue> getKeyValue(String key, String label);

  /// Retrieve a list of [AzureKey]'s.
  Future<List<AzureKey>> getKeys();

  /// This method registers a [FeatureFilter]. The evaluation will happen when using the method
  /// [getFeatureEnabled].
  void registerFeatureFilter(FeatureFilter filter);

  /// Adds or modifies a [KeyValue] in the repository.
  Future<Response> setKeyValue({
    required String key,
    required String label,
    String? value,
    String? contentType,
    Map<String, String>? tags,
  });

  /// A way to provide dependencies to the implementation.
  @visibleForTesting
  factory AzureRemoteService.mock(Client client) =>
      _AzureRemoteServiceImpl(client: client);

  /// Make Dio available for tests.
  @visibleForTesting
  Dio get dio;
}

class _AzureRemoteServiceImpl implements AzureRemoteService {
  _AzureRemoteServiceImpl({
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
      items.add(KeyValue.fromMap(json));
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

    return KeyValue.fromMap(data);
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
      final item = AzureKey.fromMap(json);
      items.add(item);
    }

    return items;
  }

  Future<Response> setKeyValue({
    required String key,
    required String label,
    String? value,
    String? contentType,
    Map<String, String>? tags,
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
