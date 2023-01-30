import 'dart:io';

import 'package:azure_app_config/src/feature_filter.dart';
import 'package:test/test.dart';

void main() {
  final before = DateTime.utc(2022, 08, 21, 14, 22, 50);
  final current = DateTime.utc(2022, 09, 21, 14, 22, 50);
  final after = DateTime.utc(2022, 10, 21, 14, 22, 50);

  var percentageFilter = TimeWindow(clock: current);

  test('''
Percentage filter should return the same value for the same user string''', () {
    final params = <String, dynamic>{
      'Audience': {
        'DefaultRolloutPercentage': 25,
      },
    };

    final filter = FeatureFilter.percentage();

    var actual = filter.evaluate(
      params,
      const FeatureFilterSettings(user: 'test.user@company.com'),
      'feature-a',
    );

    expect(actual, false);

    actual = filter.evaluate(
      params,
      const FeatureFilterSettings(user: 'test.user8@company.com'),
      'feature-b',
    );

    expect(actual, true);
  });

  test('Time Filter should return good result based on current time and input',
      () {
    // START ONLY
    var params = <String, dynamic>{
      'Start': HttpDate.format(before),
    };

    var actual = percentageFilter.evaluate(params, null, '');
    var expected = true;

    expect(actual, expected);

    // END ONLY
    params = <String, dynamic>{
      'End': HttpDate.format(after),
    };

    actual = percentageFilter.evaluate(params, null, '');
    expected = true;

    expect(actual, expected);

    // START AND END
    percentageFilter = TimeWindow(clock: before);
    params = {
      'Start': HttpDate.format(current),
      'End': HttpDate.format(after),
    };

    actual = percentageFilter.evaluate(params, null, '');
    expected = false;
    expect(actual, expected);

    percentageFilter = TimeWindow(clock: after);
    params = {
      'Start': HttpDate.format(before),
      'End': HttpDate.format(current),
    };

    actual = percentageFilter.evaluate(params, null, '');
    expected = false;
    expect(actual, expected);

    // Invalid Inputs should return true
    params = <String, dynamic>{};
    actual = percentageFilter.evaluate(params, null, '');
    expected = true;

    expect(actual, expected);

    params = <String, dynamic>{'Start': 23};

    actual = percentageFilter.evaluate(params, null, '');
    expected = true;

    expect(actual, expected);
  });
}
