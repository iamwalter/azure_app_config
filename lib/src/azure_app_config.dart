import 'package:azure_app_config/src/azure_app_config_impl.dart';
import 'package:azure_app_config/src/azure_filters.dart';
import 'package:azure_app_config/src/core/client.dart';
import 'package:azure_app_config/src/feature_filters/feature_filter.dart';
import 'package:azure_app_config/src/models/errors/azure_errors.dart';
import 'package:azure_app_config/src/models/feature_flag.dart';
import 'package:azure_app_config/src/models/key.dart';
import 'package:azure_app_config/src/models/key_value.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

@Deprecated('Use AzureAppConfig instead of AzureRemoteService')
typedef AzureRemoteService = AzureAppConfig;

/// This class represents the Microsoft Azure App Configuration.
///
/// # Authentication
///
/// A connection string is required to use App Configuration.
/// The connection string can be obtained from the App Configuration Dashboard
/// under 'Access keys'.
///
/// Please note that when a connection string is invalid or not specified,
/// an [ArgumentError] will occur when creating an
/// instance of [AzureAppConfig].
abstract class AzureAppConfig {
  /// Instantiate an instance of [AzureAppConfig] using a [connectionString]
  factory AzureAppConfig({
    required String connectionString,
  }) {
    final client = Client(connectionString: connectionString);

    return AzureAppConfigImpl(client: client);
  }

  /// Instantiate an instance of [AzureAppConfig] using an endpoint and
  /// providing a custom interceptor.
  ///
  /// Using this method you are able to intercept requests and provide a custom
  /// method of signing API requests.
  factory AzureAppConfig.customAuthentication({
    required String endpoint,
    required Interceptor interceptor,
  }) {
    final client = Client.customAuthentication(
      endpoint: endpoint,
      interceptor: interceptor,
    );

    return AzureAppConfigImpl(client: client);
  }

  /// Retrieves whether a [FeatureFlag] is enabled, using registered
  /// [FeatureFilter]'s. See [registerFeatureFilter].
  ///
  /// Throws a [AzureKeyValueNotParsableAsFeatureFlagException] if the
  /// [KeyValue] is not parsable to [FeatureFlag].
  Future<bool> getFeatureEnabled({
    required String key,
    required String label,
  });

  /// Updates a given Feature to be enabled or disabled based on [isEnabled].
  /// 
  /// The [FeatureFlag] must already exist. Use [setFeatureFlag] for new values.
  /// 
  /// Throws a [AzureRecordNotFoundException] if the [KeyValue] does not exist.
  Future<Response<dynamic>> setFeatureEnabled({
    required String key,
    required String label,
    required bool isEnabled,
  });

  /// Updates an existing [FeatureFlag] to be enabled.
  ///
  /// Throws a [AzureRecordNotFoundException] if the [KeyValue] does not exist.
  Future<Response<dynamic>> enableFeature({
    required String key,
    required String label,
  });

  /// Updates an existing [FeatureFlag] to be disabled.
  ///
  /// Throws a [AzureRecordNotFoundException] if the [KeyValue] does not exist.
  Future<Response<dynamic>> disableFeature({
    required String key,
    required String label,
  });

  /// Retrieve a list of [FeatureFlag]s.
  Future<List<FeatureFlag>> getFeatureFlags();

  /// Retrieve a list of [KeyValue]s.
  Future<List<KeyValue>> getKeyValues();

  ///  Retrieve [KeyValue] records based on filters.
  ///
  ///  Filter the records by [key].
  ///
  /// - key=[AzureFilters.any] (default)  : Matches any key.
  /// - key=abc                           : Matches a key named abc
  /// - key=abc*                          : Matches keys names that start with
  ///                                       abc
  /// - key=abc,xyz                       : Matches keys names abc or xyz
  ///                               (limited to 5 values)
  ///
  ///  Filters the records by [label].
  ///
  /// - label=[AzureFilters.any] (default): Matches empty and non-empty labels
  /// - label=[AzureFilters.noLabel]      : Only matches [KeyValue]s without a
  ///                                       label.
  /// - label=prod                        : Matches the label prod
  /// - label=prod*                       : Matches labels that start with prod
  /// - label=prod,test                   : Matches labels prod or test
  ///                                       (limited to 5 values)
  ///
  /// Reserved characters: '*', '\\', ','.
  ///
  /// If a reserved character is part of the value, it must be escaped by using
  ///  \\{Reserved Character}. Non-reserved characters can also be escaped.
  ///
  /// If a filter validation error occurs (e.g. 'key=abc**'),
  /// an [AzureFilterValidationException] is thrown.
  ///
  /// For examples see [Microsoft's API Reference](https://learn.microsoft.com/en-gb/azure/azure-app-configuration/rest-api-key-value#supported-filters).
  Future<List<KeyValue>> findKeyValuesBy({
    String key,
    String label,
  });

  ///  Retrieve [AzureKey] records based on filters.
  ///
  ///  Filter the records by [name].
  ///
  /// - name=[AzureFilters.any] (default) : Matches any key.
  /// - name=abc                           : Matches a key named abc
  /// - name=abc*                          : Matches keys names that start with
  ///                                       abc
  /// - name=abc,xyz                       : Matches keys names abc or xyz
  ///                                       (limited to 5 values)
  ///
  /// Reserved characters: '*', '\\', ','.
  ///
  /// If a reserved character is part of the value, it must be escaped by using
  ///  \\{Reserved Character}. Non-reserved characters can also be escaped.
  ///
  /// If a filter validation error occurs (e.g. 'key=abc**'),
  /// an [AzureFilterValidationException] is thrown.
  ///
  /// For examples see [Microsoft's API Reference](https://learn.microsoft.com/en-us/azure/azure-app-configuration/rest-api-keys#filtering).
  Future<List<AzureKey>> findKeyBy({String name});

  /// Get a specific [KeyValue].
  Future<KeyValue> getKeyValue({
    required String key,
    required String label,
  });

  /// Retrieve a list of [AzureKey]'s.
  Future<List<AzureKey>> getKeys();

  /// This method registers a [FeatureFilter]. The evaluation will happen when
  /// using the method [getFeatureEnabled].
  ///
  /// To register Azure's TimeWindow filter, use:
  /// ```dart
  /// service.registerFeatureFilter(FeatureFilter.timeWindow());
  /// ```
  ///
  /// Note that re-registering a filter will overwrite the previous one.
  void registerFeatureFilter(FeatureFilter filter);

  /// Adds or modifies a [KeyValue] in the repository.
  Future<Response<dynamic>> setKeyValue({
    required String key,
    required String label,
    String? value,
    String? contentType,
    Map<String, dynamic>? tags,
  });

  /// Add a new FeatureFlag to the repository.
  Future<Response<dynamic>> setFeatureFlag({
    required String key,
    required String label,
    required bool enabled,
    String description = '',
    Map<String, dynamic>? conditions,
  });

  /// Register a mapping for a Type.
  ///
  /// Enables you to register type and provide
  /// encode/decode instructions for that type.
  ///
  /// After registering a type, you can use [getTyped] to retrieve the object
  /// which will use the [decode] function, or [setTyped] to set a value in
  /// which will use the [encode] function.
  ///
  /// Throws a [AzureComplexTypeException] if the Type is already registered.
  void registerType<O>({
    O Function(Map<String, dynamic> jsonData)? decode,
    Map<String, dynamic> Function(O object)? encode,
  });

  /// Unregister a mapping for a Type.
  void unregisterType<O>();

  /// Retrieve a certain type and use the encode mapping provided
  /// in [registerType].
  ///
  /// Throws a [AzureComplexTypeException] if the Type is not registered or does
  /// not have a decode mapping.
  Future<O> getTyped<O>({
    required String key,
    required String label,
  });

  /// Set a certain type and use the encode mapping provided
  /// in [registerType].
  ///
  /// Throws a [AzureComplexTypeException] if the Type is not registered or does
  /// not have a encode mapping.
  Future<void> setTyped<O>(
    O object, {
    required String key,
    required String label,
  });

  /// Make Dio available for tests.
  @visibleForTesting
  Dio get dio;
}
