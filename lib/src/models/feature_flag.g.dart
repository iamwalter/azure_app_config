// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_flag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeatureFlagImpl _$$FeatureFlagImplFromJson(Map<String, dynamic> json) =>
    _$FeatureFlagImpl(
      id: json['id'] as String,
      description: json['description'] as String,
      enabled: json['enabled'] as bool,
      conditions: json['conditions'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$FeatureFlagImplToJson(_$FeatureFlagImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'enabled': instance.enabled,
      'conditions': instance.conditions,
    };
