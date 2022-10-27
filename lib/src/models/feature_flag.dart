import 'package:azure_app_config/src/models/client_filter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_flag.freezed.dart';
part 'feature_flag.g.dart';

@freezed
class FeatureFlag with _$FeatureFlag {
  const factory FeatureFlag({
    required String id,
    required String description,
    required bool enabled,
    required Map<String, dynamic> conditions,
  }) = _FeatureFlag;

  const FeatureFlag._();

  factory FeatureFlag.fromJson(Map<String, Object?> json) =>
      _$FeatureFlagFromJson(json);

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
