// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ErrorResponse _$$_ErrorResponseFromJson(Map<String, dynamic> json) =>
    _$_ErrorResponse(
      type: json['type'] as String?,
      title: json['title'] as String?,
      name: json['name'] as String?,
      detail: json['detail'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$$_ErrorResponseToJson(_$_ErrorResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'name': instance.name,
      'detail': instance.detail,
      'status': instance.status,
    };
