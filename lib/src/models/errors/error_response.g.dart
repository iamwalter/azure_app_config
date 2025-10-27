// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    _ErrorResponse(
      type: json['type'] as String?,
      title: json['title'] as String?,
      name: json['name'] as String?,
      detail: json['detail'] as String?,
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ErrorResponseToJson(_ErrorResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'name': instance.name,
      'detail': instance.detail,
      'status': instance.status,
    };
