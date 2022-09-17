import 'dart:convert';

class Key {
  final String name;

  const Key(this.name);

  @override
  String toString() => jsonEncode(this);

  factory Key.fromJson(Map<String, dynamic> json) {
    return Key(json["name"] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
