// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:azure_app_config/models/feature_flag.dart';

/// This class represents a Azure App Configuration Key-value resource.
///
/// A Key-value is a resource identified by unique combination of key + label.

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

  @override
  String toString() => jsonEncode(this);

  factory KeyValue.fromJson(Map<String, dynamic> json) => KeyValue(
        etag: json['etag'] as String,
        key: json['key'] as String,
        label: json['label'] as String?,
        content_type: json['content_type'] as String?,
        value: json['value'] as String?,
        tags: Map<String, dynamic>.from(json['tags'] as Map<String, dynamic>),
        locked: json['locked'] as bool,
        last_modified: json['last_modified'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'etag': etag,
        'key': key,
        'label': label,
        'content_type': content_type,
        'value': value,
        'locked': locked,
        'last_modified': last_modified,
      };

  /// Returns the KeyValue as a FeatureFlag.
  ///
  /// Returns null if the KeyValue is unable to be parsed as a FeatureFlag.
  FeatureFlag? asFeatureFlag() {
    if (value == null) return null;

    try {
      return FeatureFlag.fromJson(value!);
    } catch (e) {
      return null;
    }
  }
}
