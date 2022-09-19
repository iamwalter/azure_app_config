import 'dart:convert';

class KeyValue {
  final String etag;
  final String key;
  final String? label;
  final String content_type;
  final String value;
  final bool locked;
  final String last_modified;

  KeyValue({
    required this.etag,
    required this.key,
    this.label,
    required this.content_type,
    required this.value,
    // required this.tags,
    required this.locked,
    required this.last_modified,
  });

  @override
  String toString() => jsonEncode(this);

  factory KeyValue.fromJson(Map<String, dynamic> json) => KeyValue(
        etag: json['etag'] as String,
        key: json['key'] as String,
        label: json['label'] as String?,
        content_type: json['content_type'] as String,
        value: json['value'] as String,
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
}
