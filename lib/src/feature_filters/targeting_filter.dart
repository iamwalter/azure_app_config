// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:math';

import 'package:azure_app_config/azure_app_config.dart';
import 'package:crypto/crypto.dart';

/// Microsoft's default Targeting Filter.
class TargetingFilter extends FeatureFilter {
  /// Instantiate the [TargetingFilter] filter.
  ///
  /// When the passed in [user] matches, returns true.
  /// When the [group] parameter matches, uses the groups percentage.
  ///
  /// If none if the above are provided, it uses the default rollout percentage.
  TargetingFilter({this.user, this.group}) : super(name: 'Microsoft.Targeting');

  String? user;
  String? group;

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
    String featureKey,
  ) {
    int? seed;

    if (user != null) {
      // also encoding the featurekey, to make sure that the result is different
      // for each feature.
      final userHash = md5.convert(utf8.encode('$featureKey-$user')).toString();
      // get the seed to use for the random based on the user object,
      // to ensure the same result for the same user.
      seed = extractNumbersFromMD5(userHash);
    }

    final users = parameters['Audience']['Users'] as List<dynamic>;

    if (users.contains(user)) return true;

    final groups = parameters['Audience']['Groups'] as List<dynamic>;

    int? value;

    for (final subGroup in groups) {
      if (subGroup['Name'] == group) {
        value = subGroup['RolloutPercentage'] as int;
      }
    }

    value ??= parameters['Audience']['DefaultRolloutPercentage'] as int;

    final random = Random(seed).nextInt(100);

    return random < value;
  }
}
