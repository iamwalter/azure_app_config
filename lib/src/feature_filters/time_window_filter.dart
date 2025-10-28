import 'package:azure_app_config/src/feature_filters/feature_filter.dart';
import 'package:intl/intl.dart';

/// Microsoft's default TimeWindow Filter.
class TimeWindowFilter extends FeatureFilter {
  /// Instantiate the [TimeWindowFilter] filter.
  TimeWindowFilter({this.clock}) : super(name: 'Microsoft.TimeWindow');

  /// Optional time for the timewindow to use. Used for testing.
  final DateTime? clock;

  static final _httpDateFormat = DateFormat(
    "EEE, dd MMM yyyy HH:mm:ss 'GMT'",
    'en_US',
  );

  DateTime? _tryParseHttpDate(String? value) {
    if (value == null) return null;
    try {
      return _httpDateFormat.parseUtc(value);
    } catch (_) {
      return null;
    }
  }

  @override
  bool evaluate(Map<String, dynamic> parameters, String featureKey) {
    try {
      final now = clock ?? DateTime.now().toUtc();

      final startTime = parameters['Start'] as String?;
      final endTime = parameters['End'] as String?;

      final start = _tryParseHttpDate(startTime);
      final end = _tryParseHttpDate(endTime);

      if (start == null && end == null) return true;
      if (start == null) return now.isBefore(end!);
      if (end == null) return now.isAfter(start);

      return now.isAfter(start) && now.isBefore(end);
    } catch (_) {
      return true;
    }
  }
}
