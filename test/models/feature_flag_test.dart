import 'package:azure_app_config/src/models/client_filter.dart';
import 'package:azure_app_config/src/models/feature_flag.dart';
import 'package:test/test.dart';

void main() {
  const filter1 = ClientFilter(
    name: 'filter1',
    parameters: {
      'key1': 'value1',
      'key2': 'value2',
    },
  );

  final filter2 = filter1.copyWith(name: 'filter2');

  final featureFlag = FeatureFlag(
    id: 'id',
    description: 'description',
    enabled: true,
    conditions: {
      'client_filters': [
        filter1.toJson(),
        filter2.toJson(),
      ],
    },
  );

  test(
    'getClientFilters() should get client filters',
    () async {
      final expected = [filter1, filter2];

      final actual = featureFlag.getClientFilters();

      expect(actual, expected);
    },
  );
}
