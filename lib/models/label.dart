import 'dart:convert';

class Label {
  final String name;

  Label({required this.name});

  @override
  String toString() => jsonEncode(this);

  factory Label.fromJson(Map<String, dynamic> json) => Label(
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
      };
}
