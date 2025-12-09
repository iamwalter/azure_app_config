// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_flag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeatureFlag _$FeatureFlagFromJson(Map<String, dynamic> json) => _FeatureFlag(
  id: json['id'] as String,
  enabled: json['enabled'] as bool,
  description: json['description'] as String?,
  conditions: json['conditions'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$FeatureFlagToJson(_FeatureFlag instance) =>
    <String, dynamic>{
      'id': instance.id,
      'enabled': instance.enabled,
      'description': instance.description,
      'conditions': instance.conditions,
    };
