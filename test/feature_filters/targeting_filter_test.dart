import 'package:azure_app_config/src/feature_filters/targeting_filter.dart';
import 'package:test/test.dart';

void main() {
  var params = <String, dynamic>{
    'Audience': {
      'Users': <String>[],
      'Groups': <dynamic>[],
      'DefaultRolloutPercentage': 0,
    },
  };

  group('no filters', () {
    test(
      '''if user is not provided in the params use the defaultrolloutprecentage''',
      () {
        final filter = TargetingFilter(userIdentifier: 'unknownUser');

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
            'Groups': <dynamic>[],
            'DefaultRolloutPercentage': 50,
          },
        };

        final filter = TargetingFilter(userIdentifier: 'unknownUser');

        var actual = filter.evaluate(params, 'featureKey-a');

        expect(actual, true);

        actual = filter.evaluate(params, 'featureKey-b');

        expect(actual, false);
      },
    );
  });

  group('inclusions & exclusions', () {
    setUp(() {
      params = {
        'Audience': {
          'Users': ['user1', 'user2'],
          'Groups': [
            {'Name': 'groupNotExcluded', 'RolloutPercentage': 100},
          ],
          'DefaultRolloutPercentage': 100,
          'Exclusion': {
            'Users': ['user3'],
            'Groups': ['group2'],
          },
        },
      };
    });

    test('''if user is excluded return false''', () {
      final filter = TargetingFilter(userIdentifier: 'user3');

      final actual = filter.evaluate(params, '');

      expect(actual, false);
    });

    test('''if user is included return true''', () {
      final filter = TargetingFilter(userIdentifier: 'userNotExcluded');

      final actual = filter.evaluate(params, '');

      expect(actual, true);
    });

    test('''if group is excluded return false''', () {
      final filter = TargetingFilter(groupIdentifier: 'group2');

      final actual = filter.evaluate(params, '');

      expect(actual, false);
    });

    test('''if group is included return true''', () {
      final filter = TargetingFilter(groupIdentifier: 'groupNotExcluded');

      final actual = filter.evaluate(params, '');

      expect(actual, true);
    });
  });
}
