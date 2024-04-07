// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ErrorResponseImpl _$$ErrorResponseImplFromJson(Map<String, dynamic> json) =>
    _$ErrorResponseImpl(
      type: json['type'] as String?,
      title: json['title'] as String?,
      name: json['name'] as String?,
      detail: json['detail'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$$ErrorResponseImplToJson(_$ErrorResponseImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'name': instance.name,
      'detail': instance.detail,
      'status': instance.status,
    };
