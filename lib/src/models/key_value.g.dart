// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_KeyValue _$$_KeyValueFromJson(Map<String, dynamic> json) => _$_KeyValue(
      etag: json['etag'] as String,
      key: json['key'] as String,
      label: json['label'] as String?,
      contentType: json['content_type'] as String?,
      value: json['value'] as String? ?? '',
      tags: json['tags'] as Map<String, dynamic>,
      locked: json['locked'] as bool,
      lastModified: json['last_modified'] as String,
    );

Map<String, dynamic> _$$_KeyValueToJson(_$_KeyValue instance) =>
    <String, dynamic>{
      'etag': instance.etag,
      'key': instance.key,
      'label': instance.label,
      'content_type': instance.contentType,
      'value': instance.value,
      'tags': instance.tags,
      'locked': instance.locked,
      'last_modified': instance.lastModified,
    };
