import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// Settings that all feature filters can use.
class FeatureFilterSettings {
  const FeatureFilterSettings({required this.user});

  final String user;
}

/// A filter that can be used to determine whether some criteria is
/// met to enable a feature flag.
abstract class FeatureFilter {
  const FeatureFilter({required this.name});

  /// Microsoft's default 'TimeWindow' filter.
  factory FeatureFilter.timeWindow() => TimeWindow();

  /// Microsoft's default 'Percentage' Filter.
  factory FeatureFilter.percentage() => Percentage();

  /// Represents the FeatureFilter name. Make sure this name is the same as the
  /// [FeatureFilter] name in Azure App Configuration.
  final String name;

  /// The callback that is executed while evaluating the [FeatureFilter].
  ///
  /// The [parameters] parameter holds the parameters that can be configured in the
  /// App Configuration Dashboard.
  ///
  /// The [settings] object gives access to the global settings object that can
  /// be used to check certain values, e.g. the current user.
  ///
  /// The [featureKey] parameter is the key string that is being checked.
  /// For a feature flag '.appconfig.featureflag/myKey' the key will equal
  /// 'myKey'.
  bool evaluate(
    Map<String, dynamic> parameters,
    FeatureFilterSettings? settings,
    String featureKey,
  );
}

/// Microsoft's default Percentage Filter.
class Percentage extends FeatureFilter {
  /// Instantiate the [Percentage] filter.
  Percentage() : super(name: 'Microsoft.Targeting');

  // Get the first 10 numbers from a md5 hash
  int extractNumbersFromMD5(String md5Hash) {
    final exp = RegExp(r'\d+');

    return int.parse(
      exp.allMatches(md5Hash).map((m) => m.group(0)).join().substring(0, 10),
    );
  }

  @override
  bool evaluate(
    Map<String, dynamic> parameters,
    FeatureFilterSettings? settings,
    String featureKey,
  ) {
    int? seed;
    // check if a user object is provided
    if (settings?.user != null) {
      // also encoding the featurekey, to make sure that the result is different
      // for each feature.
      final userHash =
          md5.convert(utf8.encode('$featureKey-${settings!.user}')).toString();
      // get the seed to use for the random based on the user object,
      // to ensure the same result for the same user.
      seed = extractNumbersFromMD5(userHash);
    }

    // ignore: avoid_dynamic_calls
    final value = parameters['Audience']['DefaultRolloutPercentage'] as int;
    final random = Random(seed).nextInt(100);

    return random < value;
  }
}

/// Microsoft's default TimeWindow Filter.
class TimeWindow extends FeatureFilter {
  /// Instantiate the [TimeWindow] filter.
  TimeWindow({this.clock}) : super(name: 'Microsoft.TimeWindow');

  /// Optional time for the timewindow to use. Used for testing.
  final DateTime? clock;

  @override
  bool evaluate(
    Map<String, dynamic> parameters,
    FeatureFilterSettings? settings,
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
