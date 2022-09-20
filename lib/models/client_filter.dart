// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class ClientFilter {
  final String name;
  final Map<String, dynamic> parameters;

  ClientFilter({
    required this.name,
    required this.parameters,
  });

  ClientFilter copyWith({
    String? name,
    Map<String, dynamic>? parameters,
  }) {
    return ClientFilter(
      name: name ?? this.name,
      parameters: parameters ?? this.parameters,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'parameters': parameters,
    };
  }

  factory ClientFilter.fromMap(Map<String, dynamic> map) {
    return ClientFilter(
        name: map['name'] as String,
        parameters: Map<String, dynamic>.from(
          (map['parameters'] as Map<String, dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory ClientFilter.fromJson(String source) =>
      ClientFilter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ClientFilter(name: $name, parameters: $parameters)';

  @override
  bool operator ==(covariant ClientFilter other) {
    if (identical(this, other)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return other.name == name && mapEquals(other.parameters, parameters);
  }

  @override
  int get hashCode => name.hashCode ^ parameters.hashCode;
}
