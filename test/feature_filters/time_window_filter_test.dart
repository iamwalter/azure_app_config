import 'dart:io';

import 'package:azure_app_config/src/feature_filters/time_window_filter.dart';
import 'package:test/test.dart';

void main() {
  final before = DateTime.utc(2022, 08, 21, 14, 22, 50);
  final current = DateTime.utc(2022, 09, 21, 14, 22, 50);
  final after = DateTime.utc(2022, 10, 21, 14, 22, 50);

  var timewindowFilter = TimeWindowFilter(clock: current);

  test('Time Filter should return good result based on current time and input',
      () {
    // START ONLY
    var params = <String, dynamic>{
      'Start': HttpDate.format(before),
    };

    var actual = timewindowFilter.evaluate(params, '');
    var expected = true;

    expect(actual, expected);

    // END ONLY
    params = <String, dynamic>{
      'End': HttpDate.format(after),
    };

    actual = timewindowFilter.evaluate(params, '');
    expected = true;

    expect(actual, expected);

    // START AND END
    timewindowFilter = TimeWindowFilter(clock: before);
    params = {
      'Start': HttpDate.format(current),
      'End': HttpDate.format(after),
    };

    actual = timewindowFilter.evaluate(params, '');
    expected = false;
    expect(actual, expected);

    timewindowFilter = TimeWindowFilter(clock: after);
    params = {
      'Start': HttpDate.format(before),
      'End': HttpDate.format(current),
    };

    actual = timewindowFilter.evaluate(params, '');
    expected = false;
    expect(actual, expected);

    // Invalid Inputs should return true
    params = <String, dynamic>{};
    actual = timewindowFilter.evaluate(params, '');
    expected = true;

    expect(actual, expected);

    params = <String, dynamic>{'Start': 23};

    actual = timewindowFilter.evaluate(params, '');
    expected = true;

    expect(actual, expected);
  });
}
