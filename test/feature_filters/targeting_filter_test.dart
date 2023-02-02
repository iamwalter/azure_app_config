import 'package:azure_app_config/src/feature_filters/targeting_filter.dart';
import 'package:test/test.dart';

void main() {
  final params = <String, dynamic>{
    'Audience': {
      'Users': ['user1', 'user2'],
      'Groups': [
        {
          'Name': 'group1',
          'RolloutPercentage': 100,
        },
        {
          'Name': 'testGroup',
          'RolloutPercentage': 100,
        },
      ],
      'DefaultRolloutPercentage': 0,
    },
  };

  test(
    '''if user is provided in the params return true''',
    () {
      final filter = TargetingFilter(userName: 'user1');

      final actual = filter.evaluate(params, '');

      expect(actual, true);
    },
  );

  test(
    '''if user is not provided in the params use the defaultrolloutprecentage''',
    () {
      final filter = TargetingFilter(userName: 'unknownUser');

      final actual = filter.evaluate(params, '');

      expect(actual, false);
    },
  );

  test(
    '''if user is not provided in the params still return the same value for the same user (based on seed)''',
    () {
      final params = <String, dynamic>{
        'Audience': {
          'Users': <String>[],
          'Groups': <Map<String, dynamic>>[],
          'DefaultRolloutPercentage': 50,
        },
      };

      final filter = TargetingFilter(userName: 'unknownUser');

      var actual = filter.evaluate(params, 'featureKey-a');

      expect(actual, true);

      actual = filter.evaluate(params, 'featureKey-b');

      expect(actual, false);
    },
  );
}
