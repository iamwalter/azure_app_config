// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:azure_app_config/src/models/feature_flag.dart';
import 'package:collection/collection.dart';

/// This class represents an Azure App Configuration [Key-value](https://learn.microsoft.com/en-us/azure/azure-app-configuration/rest-api-key-value) resource.
///
/// A Key-value is a resource identified by unique combination of key + label.
/// A Key-value can have any type of value, usually this type is represented in [content_type].
///
/// To create a parsable FeatureFlag, use [asFeatureFlag].
class KeyValue {
  final String etag;
  final String key;
  final String? label;
  final String? content_type;
  final String? value;
  final Map<String, dynamic> tags;
  final bool locked;
  final String last_modified;

  KeyValue({
    required this.etag,
    required this.key,
    this.label,
    this.content_type,
    required this.value,
    required this.tags,
    required this.locked,
    required this.last_modified,
  });

  /// Returns the [KeyValue] as a [FeatureFlag].
  ///
  /// Returns null if the [KeyValue] is unable to be parsed as a [FeatureFlag].
  FeatureFlag? asFeatureFlag() {
    if (value == null) return null;

    try {
      return FeatureFlag.fromJson(value!);
    } catch (e) {
      return null;
    }
  }

  KeyValue copyWith({
    String? etag,
    String? key,
    String? label,
    String? content_type,
    String? value,
    Map<String, dynamic>? tags,
    bool? locked,
    String? last_modified,
  }) {
    return KeyValue(
      etag: etag ?? this.etag,
      key: key ?? this.key,
      label: label ?? this.label,
      content_type: content_type ?? this.content_type,
      value: value ?? this.value,
      tags: tags ?? this.tags,
      locked: locked ?? this.locked,
      last_modified: last_modified ?? this.last_modified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'etag': etag,
      'key': key,
      'label': label,
      'content_type': content_type,
      'value': value,
      'tags': tags,
      'locked': locked,
      'last_modified': last_modified,
    };
  }

  factory KeyValue.fromMap(Map<String, dynamic> map) {
    return KeyValue(
      etag: map['etag'] as String,
      key: map['key'] as String,
      label: map['label'] != null ? map['label'] as String : null,
      content_type:
          map['content_type'] != null ? map['content_type'] as String : null,
      value: map['value'] != null ? map['value'] as String : null,
      tags: Map<String, dynamic>.from((map['tags'] as Map<String, dynamic>)),
      locked: map['locked'] as bool,
      last_modified: map['last_modified'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory KeyValue.fromJson(String source) =>
      KeyValue.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'KeyValue(etag: $etag, key: $key, label: $label, content_type: $content_type, value: $value, tags: $tags, locked: $locked, last_modified: $last_modified)';
  }

  @override
  bool operator ==(covariant KeyValue other) {
    if (identical(this, other)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return other.etag == etag &&
        other.key == key &&
        other.label == label &&
        other.content_type == content_type &&
        other.value == value &&
        mapEquals(other.tags, tags) &&
        other.locked == locked &&
        other.last_modified == last_modified;
  }

  @override
  int get hashCode {
    return etag.hashCode ^
        key.hashCode ^
        label.hashCode ^
        content_type.hashCode ^
        value.hashCode ^
        tags.hashCode ^
        locked.hashCode ^
        last_modified.hashCode;
  }
}
