import 'dart:convert';

import 'package:azure_app_config/src/models/client_filter.dart';
import 'package:azure_app_config/src/models/feature_flag.dart';
import 'package:test/test.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  const filter1 = ClientFilter(
    name: 'tName',
    parameters: {
      'tParam': {
        'tKey': 'tValue',
      }
    },
  );

  final filter2 = filter1.copyWith(name: 'tName2');

  final tFeatureFlag = FeatureFlag(
    id: 'tId',
    description: 'tDescription',
    enabled: true,
    conditions: {
      'client_filters': [
        filter1.toJson(),
        filter2.toJson(),
      ],
    },
  );

  test('should have correct pre-defined contentType', () {
    expect(
      FeatureFlag.contentType,
      'application/vnd.microsoft.appconfig.ff+json;charset=utf-8',
    );
  });

  test('should be parsable from JSON', () async {
    final jsonMap = json.decode(fixture('featureflag_fixture.json'))
        as Map<String, dynamic>;

    final actual = FeatureFlag.fromJson(jsonMap);

    expect(actual, tFeatureFlag);
  });

  test(
    'getClientFilters() should get client filters',
    () async {
      final expected = [filter1, filter2];

      final actual = tFeatureFlag.getClientFilters();

      expect(actual, expected);
    },
  );
}
