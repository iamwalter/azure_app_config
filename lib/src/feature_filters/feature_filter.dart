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
  /// When the passed in [user] matches, returns true. If it does not match,
  /// passing in a user will still make the filter 'sticky', meaning it will
  /// return the same result. User can be any string, for example an email,
  /// username or a unique device ID. If the [user] param is ommitted, the
  /// filter's result will be random each time.
  ///
  /// When the [group] parameter matches, the filter uses the groups percentage.
  ///
  /// If no group or user match the filter uses the 'Default Percentage'.
  factory FeatureFilter.targeting({
    String? user,
    String? group,
  }) =>
      TargetingFilter(
        userIdentifier: user,
        groupIdentifier: group,
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
