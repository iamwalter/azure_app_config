// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_KeyValue _$$_KeyValueFromJson(Map<String, dynamic> json) => _$_KeyValue(
      etag: json['etag'] as String,
      key: json['key'] as String,
      locked: json['locked'] as bool,
      tags: json['tags'] as Map<String, dynamic>,
      lastModified: json['last_modified'] as String,
      label: json['label'] as String?,
      contentType: json['content_type'] as String?,
      value: json['value'] as String? ?? '',
    );

Map<String, dynamic> _$$_KeyValueToJson(_$_KeyValue instance) =>
    <String, dynamic>{
      'etag': instance.etag,
      'key': instance.key,
      'locked': instance.locked,
      'tags': instance.tags,
      'last_modified': instance.lastModified,
      'label': instance.label,
      'content_type': instance.contentType,
      'value': instance.value,
    };
