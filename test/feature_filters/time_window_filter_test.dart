import 'package:azure_app_config/src/feature_filters/time_window_filter.dart';
import 'package:intl/intl.dart';
import 'package:test/test.dart';

void main() {
  final before = DateTime.utc(2022, 08, 21, 14, 22, 50);
  final current = DateTime.utc(2022, 09, 21, 14, 22, 50);
  final after = DateTime.utc(2022, 10, 21, 14, 22, 50);

  final httpDateFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'", 'en_US');

  String formatHttpDate(DateTime date) => httpDateFormat.format(date.toUtc());

  var filter = TimeWindowFilter(clock: current);

  test(
    'Time Filter should return good result based on current time and input',
    () {
      // START ONLY
      var params = <String, dynamic>{'Start': formatHttpDate(before)};

      var actual = filter.evaluate(params, '');
      var expected = true;

      expect(actual, expected);

      // END ONLY
      params = <String, dynamic>{'End': formatHttpDate(after)};

      actual = filter.evaluate(params, '');
      expected = true;

      expect(actual, expected);

      // START AND END
      filter = TimeWindowFilter(clock: before);
      params = {'Start': formatHttpDate(current), 'End': formatHttpDate(after)};

      actual = filter.evaluate(params, '');
      expected = false;
      expect(actual, expected);

      filter = TimeWindowFilter(clock: after);
      params = {
        'Start': formatHttpDate(before),
        'End': formatHttpDate(current),
      };

      actual = filter.evaluate(params, '');
      expected = false;
      expect(actual, expected);

      // Invalid Inputs should return true
      params = <String, dynamic>{};
      actual = filter.evaluate(params, '');
      expected = true;

      expect(actual, expected);

      params = <String, dynamic>{'Start': 23};

      actual = filter.evaluate(params, '');
      expected = true;

      expect(actual, expected);
    },
  );
}
