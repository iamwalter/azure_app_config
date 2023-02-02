import 'dart:io';

import 'package:azure_app_config/src/feature_filters/feature_filter.dart';

/// Microsoft's default TimeWindow Filter.
class TimeWindowFilter extends FeatureFilter {
  /// Instantiate the [TimeWindowFilter] filter.
  TimeWindowFilter({this.clock}) : super(name: 'Microsoft.TimeWindow');

  /// Optional time for the timewindow to use. Used for testing.
  final DateTime? clock;

  @override
  bool evaluate(
    Map<String, dynamic> parameters,
    String featureKey,
  ) {
    try {
      final now = clock ?? DateTime.now();

      final startTime = parameters['Start'] as String?;
      final endTime = parameters['End'] as String?;

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
