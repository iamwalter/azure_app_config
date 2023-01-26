import 'package:azure_app_config/src/models/client_filter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_flag.freezed.dart';
part 'feature_flag.g.dart';

/// This class represents a FeatureFlag.
///
/// These are represented in the 'Feature Manager' section of
/// the app configuration dashboard.
///
/// More about [FeatureFlag's](https://learn.microsoft.com/en-us/azure/azure-app-configuration/concept-feature-management).
@freezed
class FeatureFlag with _$FeatureFlag {
  /// Instantiate a [FeatureFlag]
  const factory FeatureFlag({
    required String id,
    required String description,
    required bool enabled,
    required Map<String, dynamic> conditions,
  }) = _FeatureFlag;

  const FeatureFlag._();

  factory FeatureFlag.fromJson(Map<String, Object?> json) =>
      _$FeatureFlagFromJson(json);

  /// Gets the filters associated to the [FeatureFlag].
  List<ClientFilter> getClientFilters() {
    final clientFilters = conditions['client_filters'] as List<dynamic>;

    final filters = <ClientFilter>[];

    for (final json in clientFilters) {
      final filter = ClientFilter.fromJson(json as Map<String, Object?>);

      filters.add(filter);
    }

    return filters;
  }
}
