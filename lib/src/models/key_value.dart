// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:azure_app_config/src/models/feature_flag.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'key_value.freezed.dart';
part 'key_value.g.dart';

/// This class represents an Azure App Configuration [Key-value](https://learn.microsoft.com/en-us/azure/azure-app-configuration/rest-api-key-value) resource.
///
/// A Key-value is a resource identified by unique combination of key + label.
/// A Key-value can have any type of value, usually this type
/// is represented in [contentType].
///
/// To create a parsable FeatureFlag, use [asFeatureFlag].
@freezed
class KeyValue with _$KeyValue {
  const factory KeyValue({
    required String etag,
    required String key,
    String? label,
    @JsonKey(name: 'content_type') String? contentType,
    String? value,
    required Map<String, dynamic> tags,
    required bool locked,
    @JsonKey(name: 'last_modified') required String lastModified,
  }) = _KeyValue;

  factory KeyValue.fromJson(Map<String, Object?> json) =>
      _$KeyValueFromJson(json);

  const KeyValue._();

  /// Returns the [KeyValue] as a [FeatureFlag].
  ///
  /// Returns null if the [KeyValue] is unable to be parsed as a [FeatureFlag].
  FeatureFlag? asFeatureFlag() {
    if (value == null) return null;

    try {
      return FeatureFlag.fromJson(jsonDecode(value!) as Map<String, Object?>);
    } catch (e) {
      return null;
    }
  }
}
