import 'dart:math';

abstract class FeatureFilter {
  final String name;

  FeatureFilter({required this.name});

  bool evaluate(Map<String, dynamic> parameters);
}

class UserPercentage extends FeatureFilter {
  UserPercentage({String? name}) : super(name: name ?? "PercentageFilter");

  @override
  bool evaluate(Map<String, dynamic> parameters) {
    final value = parameters['Value'] as int;

    final random = Random().nextInt(101) < value;

    return random;
  }
}
