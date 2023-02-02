// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:math';

import 'package:azure_app_config/azure_app_config.dart';
import 'package:crypto/crypto.dart';

/// Microsoft's default Targeting Filter.
class TargetingFilter extends FeatureFilter {
  /// Instantiate the [TargetingFilter] filter.
  TargetingFilter({
    this.userIdentifier,
    this.groupIdentifier,
  }) : super(name: 'Microsoft.Targeting');

  String? userIdentifier;
  String? groupIdentifier;

  // Get the first 10 numbers from a md5 hash
  int _extractNumbersFromMD5(String md5Hash) {
    final exp = RegExp(r'\d+');

    return int.parse(
      exp.allMatches(md5Hash).map((m) => m.group(0)).join().substring(0, 10),
    );
  }

  @override
  bool evaluate(
    Map<String, dynamic> parameters,
    String featureKey,
  ) {
    final audienceUsers = parameters['Audience']['Users'] as List<dynamic>;

    // When the passed in [userIdentifier] matches, returns true.
    if (userIdentifier != null && audienceUsers.contains(userIdentifier)) {
      return true;
    }

    final audienceGroups = parameters['Audience']['Groups'] as List<dynamic>;

    // Use the default rollout percentage as default.
    var rolloutPercentage =
        parameters['Audience']['DefaultRolloutPercentage'] as int;

    for (final audienceGroup in audienceGroups) {
      // When the [groupIdentifier] parameter matches, uses the groups percentage.
      if (audienceGroup['Name'] == groupIdentifier) {
        rolloutPercentage = audienceGroup['RolloutPercentage'] as int;
      }
    }

    int? seed;

    // If a user identifier is passed, use it to generate a seed
    if (userIdentifier != null) {
      // Hash the feature key and user identifier to ensure a unique result for
      // each feature
      final userHash =
          md5.convert(utf8.encode('$featureKey-$userIdentifier')).toString();

      // Get the seed based on the hashed user identifier to ensure consistent
      // results for the same user + feature
      seed = _extractNumbersFromMD5(userHash);
    }

    return Random(seed).nextInt(100) < rolloutPercentage;
  }
}
