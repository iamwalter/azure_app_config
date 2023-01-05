import 'package:azure_app_config/src/azure_remote_service_impl.dart';
import 'package:azure_app_config/src/core/client.dart';
import 'package:azure_app_config/src/feature_filter.dart';
import 'package:azure_app_config/src/models/errors/azure_errors.dart';
import 'package:azure_app_config/src/models/feature_flag.dart';
import 'package:azure_app_config/src/models/key.dart';
import 'package:azure_app_config/src/models/key_value.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

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
/// instance of [AzureRemoteService].
abstract class AzureRemoteService {
  /// Instanciate an instance of [AzureRemoteService] using a [connectionString]
  factory AzureRemoteService({
    required String connectionString,
  }) {
    final client = Client(connectionString: connectionString);

    return AzureRemoteServiceImpl(client: client);
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

  /// Sets a given Feature to be enabled or disabled based on [isEnabled].
  ///
  /// Throws a [AzureKeyValueNotParsableAsFeatureFlagException] if the
  /// [KeyValue] does not parse to a [FeatureFlag].
  Future<Response<dynamic>> setFeatureEnabled({
    required String key,
    required String label,
    required bool isEnabled,
  });

  /// Sets a given feature to be enabled.
  ///
  /// Throws a [AzureKeyValueNotParsableAsFeatureFlagException] if the
  /// [KeyValue] does not parse to a [FeatureFlag].
  Future<Response<dynamic>> enableFeature({
    required String key,
    required String label,
  });

  /// Sets a given feature to be disabled.
  ///
  /// Throws a [AzureKeyValueNotParsableAsFeatureFlagException] if the
  /// [KeyValue] does not parse to a [FeatureFlag].
  Future<Response<dynamic>> disableFeature({
    required String key,
    required String label,
  });

  /// Retrieve a list of [FeatureFlag].
  Future<List<FeatureFlag>> getFeatureFlags();

  /// Retrieve a list of [KeyValue].
  Future<List<KeyValue>> getKeyValues();

  /// Retrieve key values based on filters.
  ///
  /// [keyFilter] can be used in the following ways:
  /// - key=*           : Matches any key
  /// - key=abc         : Matches a key named abc
  /// - key=abc*        : Matches keys names that start with abc
  /// - key=abc,xyz     : Matches keys names abc or xyz (limited to 5 CSV)
  ///
  /// [labelFilter] can be used in the following ways:
  /// - label=*         : Matches any label
  /// - label=%00       : Matches KV without label
  /// - label=prod      : Matches the label prod
  /// - label=prod*     : Matches labels that start with prod
  /// - label=prod,test : Matches labels prod or test (limited to 5 CSV)
  ///
  /// Reserved characters: '*', '\\', ','.
  ///
  /// If a reserved character is part of the value, then it must be escaped by
  ///  using \\{Reserved Character}. Non-reserved characters can also be escaped.
  ///
  /// In the case of a filter validation error, e.g. 'key=abc**', an
  /// [AzureFilterValidationException] is thrown.
  ///
  /// Read more at the [API Reference]
  /// (https://learn.microsoft.com/en-gb/azure/azure-app-configuration/rest-api-key-value#supported-filters)
  Future<List<KeyValue>> findKeyValuesBy({
    required String keyFilter,
    required String labelFilter,
  });

  /// Get a specific [KeyValue].
  Future<KeyValue> getKeyValue({
    required String key,
    required String label,
  });

  /// Retrieve a list of [AzureKey]'s.
  Future<List<AzureKey>> getKeys();

  /// This method registers a [FeatureFilter]. The evaluation will happen when
  /// using the method [getFeatureEnabled].
  void registerFeatureFilter(FeatureFilter filter);

  /// Adds or modifies a [KeyValue] in the repository.
  Future<Response<dynamic>> setKeyValue({
    required String key,
    required String label,
    String? value,
    String? contentType,
    Map<String, dynamic>? tags,
  });

  /// Make Dio available for tests.
  @visibleForTesting
  Dio get dio;
}
