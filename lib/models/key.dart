// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AzureKey {
  final String name;

  const AzureKey(
    this.name,
  );

  AzureKey copyWith({
    String? name,
  }) {
    return AzureKey(
      name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory AzureKey.fromMap(Map<String, dynamic> map) {
    return AzureKey(
      map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AzureKey.fromJson(String source) =>
      AzureKey.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AzureKey(name: $name)';

  @override
  bool operator ==(covariant AzureKey other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
