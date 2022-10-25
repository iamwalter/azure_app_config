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

  factory FeatureFlag.fromJson(Map<String, Object?> json) =>
      _$FeatureFlagFromJson(json);
}
