import 'dart:io';
import 'dart:math';

import 'package:clock/clock.dart';

abstract class FeatureFilter {
  final String name;

  FeatureFilter({required this.name});

  bool evaluate(Map<String, dynamic> parameters);
}

class Percentage extends FeatureFilter {
  Percentage() : super(name: "Percentage");

  @override
  bool evaluate(Map<String, dynamic> parameters) {
    final value = parameters['Value'] as int;
    final random = Random().nextInt(100);

    return random < value;
  }
}

class TimeWindow extends FeatureFilter {
  final DateTime Function() getTime;

  TimeWindow(this.getTime) : super(name: "Microsoft.TimeWindow");

  @override
  bool evaluate(Map<String, dynamic> parameters) {
    final now = Clock(getTime).now();

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
