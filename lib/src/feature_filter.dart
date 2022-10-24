import 'dart:io';
import 'dart:math';

/// A filter that can be used to determine whether some criteria is
/// met to enable a feature flag.
abstract class FeatureFilter {
  /// Represents the FeatureFilter name. Make sure this name is the same as the
  /// [FeatureFilter] name in Azure App Configuration.
  final String name;

  FeatureFilter({required this.name});

  /// Microsoft's default 'Percentage' Filter.
  factory FeatureFilter.percentage() => Percentage();

  /// Microsoft's default 'TimeWindow' filter.
  factory FeatureFilter.timeWindow() => TimeWindow();

  /// The callback that is executed while evaluating the [FeatureFilter].
  bool evaluate(Map<String, dynamic> parameters);
}

class Percentage extends FeatureFilter {
  Percentage() : super(name: "Microsoft.Targeting");

  @override
  bool evaluate(Map<String, dynamic> parameters) {
    final value = parameters['Audience']['DefaultRolloutPercentage'] as int;
    final random = Random().nextInt(100);

    return random < value;
  }
}

class TimeWindow extends FeatureFilter {
  /// Optional time for the timewindow to use. Used for testing.
  final DateTime? clock;

  TimeWindow({this.clock}) : super(name: "Microsoft.TimeWindow");

  @override
  bool evaluate(Map<String, dynamic> parameters) {
    try {
      final now = clock ?? DateTime.now();

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

      if (start == null && end == null) return true;

      if (start == null) {
        return now.isBefore(end!);
      }

      if (end == null) {
        return now.isAfter(start);
      }

      return now.isAfter(start) && now.isBefore(end);
    } catch (e) {
      return true;
    }
  }
}
