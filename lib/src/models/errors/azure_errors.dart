import 'package:azure_app_config/src/models/errors/error_response.dart';

/// When an KeyValue cannot be parsed to a FeatureFlag.
class AzureKeyValueNotParsableAsFeatureFlagException implements Exception {}

/// When an invalid filter has been provided.
class AzureFilterValidationException implements Exception {
  AzureFilterValidationException(this.errorResponse);

  final ErrorResponse? errorResponse;

  @override
  String toString() => 'AzureFilterValidationException: $errorResponse';
}
