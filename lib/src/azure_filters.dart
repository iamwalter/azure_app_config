/// Defines constants that are related to
/// filtering operations that can be made.
class AzureFilters {
  const AzureFilters._();

  /// Matches any record.
  static const String any = '*';

  /// Matches if a record's label is an empty value.
  static final String noLabel = String.fromCharCode(0);
}
