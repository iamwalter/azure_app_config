import 'dart:io';
import 'dart:math';

abstract class FeatureFilter {
  final String name;

  FeatureFilter({required this.name});

  bool evaluate(Map<String, dynamic> parameters);
}

class Targeting extends FeatureFilter {
  Targeting() : super(name: "Percentage");

  @override
  bool evaluate(Map<String, dynamic> parameters) {
    final value = parameters['Value'] as int;

    final random = Random().nextInt(101) < value;

    return random;
  }
}

class TimeWindow extends FeatureFilter {
  TimeWindow() : super(name: "Microsoft.TimeWindow");

  @override
  bool evaluate(Map<String, dynamic> parameters) {
    final now = DateTime.now();

    final String? startTime = parameters['Start'];
    final String? endTime = parameters['End'];

    DateTime? start;
    DateTime? end;

    if (startTime != null) {
      start = HttpDate.parse(startTime);
    }

    if (endTime != null) {
      end = HttpDate.parse(endTime);
    }

    if (start == null && end == null) return false;

    if (start == null) {
      return now.isBefore(end!);
    }

    if (end == null) {
      return now.isAfter(start);
    }

    return now.isAfter(start) && now.isBefore(end);
  }
}
