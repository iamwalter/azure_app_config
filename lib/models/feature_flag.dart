// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class FeatureFlag {
  final String id;
  final String description;
  final bool enabled;
  final List<dynamic> conditions;

  FeatureFlag({
    required this.id,
    required this.description,
    required this.enabled,
    required this.conditions,
  });

  FeatureFlag copyWith({
    String? id,
    String? description,
    bool? enabled,
    List<dynamic>? conditions,
  }) {
    return FeatureFlag(
      id: id ?? this.id,
      description: description ?? this.description,
      enabled: enabled ?? this.enabled,
      conditions: conditions ?? this.conditions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'enabled': enabled,
      'conditions': conditions,
    };
  }

  factory FeatureFlag.fromMap(Map<String, dynamic> map) {
    return FeatureFlag(
      id: map['id'] as String,
      description: map['description'] as String,
      enabled: map['enabled'] as bool,
      conditions: List<dynamic>.from((map['conditions'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory FeatureFlag.fromJson(String source) =>
      FeatureFlag.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FeatureFlag(id: $id, description: $description, enabled: $enabled, conditions: $conditions)';
  }

  @override
  bool operator ==(covariant FeatureFlag other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.description == description &&
        other.enabled == enabled &&
        listEquals(other.conditions, conditions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        enabled.hashCode ^
        conditions.hashCode;
  }
}
