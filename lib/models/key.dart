import 'dart:convert';

class AzureKey {
  final String name;

  const AzureKey(this.name);

  @override
  String toString() => jsonEncode(this);

  factory AzureKey.fromJson(Map<String, dynamic> json) {
    return AzureKey(json["name"] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
