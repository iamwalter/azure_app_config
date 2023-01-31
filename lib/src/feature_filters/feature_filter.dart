import 'package:azure_app_config/src/feature_filters/targeting_filter.dart';
import 'package:azure_app_config/src/feature_filters/time_window_filter.dart';

/// A filter that can be used to determine whether some criteria is
/// met to enable a feature flag.
abstract class FeatureFilter {
  const FeatureFilter({required this.name});

  /// Microsoft's default 'TimeWindow' filter.
  factory FeatureFilter.timeWindow() => TimeWindowFilter();

  /// Microsoft's default 'Targeting' Filter.
  ///
  /// When the passed in [user] matches, returns true.
  /// When the [group] parameter matches, uses the groups percentage.
  ///
  /// If none if the above are provided, it uses the default rollout percentage.
  factory FeatureFilter.targeting({
    String? user,
    String? group,
  }) =>
      TargetingFilter(
        user: user,
        group: group,
      );

  /// Represents the FeatureFilter name. Make sure this name is the same as the
  /// [FeatureFilter] name in Azure App Configuration.
  final String name;

  /// The callback that is executed while evaluating the [FeatureFilter].
  ///
  /// [parameters] holds the parameters that can be configured in
  /// the App Configuration Dashboard.
  ///
  /// [featureKey] the key string that is being checked.
  /// For a feature flag '.appconfig.featureflag/myKey' the key will equal
  /// 'myKey'.
  bool evaluate(
    Map<String, dynamic> parameters,
    String featureKey,
  );
}
