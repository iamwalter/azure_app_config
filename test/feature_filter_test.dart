import 'dart:io';

import 'package:azure_app_config/feature_filter.dart';
import 'package:test/test.dart';

void main() {
  final before = DateTime.utc(2022, 08, 21, 14, 22, 50);
  final current = DateTime.utc(2022, 09, 21, 14, 22, 50);
  final after = DateTime.utc(2022, 10, 21, 14, 22, 50);

  var percentageFilter = TimeWindow(() => current);

  test('Time Filter should return correct boolean', () {
    // START ONLY
    var params = <String, dynamic>{
      "Start": HttpDate.format(before),
    };

    var actual = percentageFilter.evaluate(params);
    var expected = true;

    expect(actual, expected);

    // END ONLY
    params = <String, dynamic>{
      "End": HttpDate.format(after),
    };

    actual = percentageFilter.evaluate(params);
    expected = true;

    expect(actual, expected);

    // START AND END
    percentageFilter = TimeWindow(() => before);
    params = {
      "Start": HttpDate.format(current),
      "End": HttpDate.format(after),
    };

    actual = percentageFilter.evaluate(params);
    expected = false;
    expect(actual, expected);

    percentageFilter = TimeWindow(() => after);
    params = {
      "Start": HttpDate.format(before),
      "End": HttpDate.format(current),
    };

    actual = percentageFilter.evaluate(params);
    expected = false;
    expect(actual, expected);

    // Invalid Inputs should return true
    params = <String, dynamic>{};
    actual = percentageFilter.evaluate(params);
    expected = true;

    expect(actual, expected);

    params = <String, dynamic>{"Start": 23};

    actual = percentageFilter.evaluate(params);
    expected = true;

    expect(actual, expected);
  });
}
