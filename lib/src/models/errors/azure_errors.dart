import 'package:azure_app_config/src/models/errors/error_response.dart';

/// When an KeyValue cannot be parsed to a FeatureFlag.
class AzureKeyValueNotParsableAsFeatureFlagException implements Exception {}

/// When Azure response with an Authentication error
class AzureAuthenticationException implements Exception {}

/// When a record cannot be found.
class AzureRecordNotFoundException implements Exception {
  @override
  String toString() => 'AzureRecordNotFoundException: 404';
}

class AzureFilterValidationException implements Exception {
  AzureFilterValidationException(this.errorResponse);

  final ErrorResponse errorResponse;

  @override
  String toString() =>
      'AzureFilterValidationException: ${errorResponse.title} - ${errorResponse.detail}';
}

class AzureRecordLockedException implements Exception {
  AzureRecordLockedException(this.errorResponse);

  final ErrorResponse errorResponse;

  @override
  String toString() =>
      'AzureRecordLockedException: ${errorResponse.title} - ${errorResponse.detail}';
}
