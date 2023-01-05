import 'package:azure_app_config/src/models/key_value.dart';

/// Defines constants that are related to
/// filtering operations that can be made.
class AzureFilters {
  /// Matches any of a type.
  static const String any = '*';

  /// Matches any [KeyValue]s without a label.
  static const String noLabel = '%00';
}
