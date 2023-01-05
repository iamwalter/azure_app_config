/// When an KeyValue cannot be parsed to a FeatureFlag.
class AzureKeyValueNotParsableAsFeatureFlagException implements Exception {}

/// When an invalid filter has been provided.
class AzureFilterValidationException implements Exception {
  AzureFilterValidationException(this.message);

  final String? message;

  @override
  String toString() => 'AzureFilterValidationException: $message';
}
