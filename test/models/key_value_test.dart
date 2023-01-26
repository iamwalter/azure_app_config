import 'dart:convert';

import 'package:azure_app_config/src/models/errors/azure_errors.dart';
import 'package:azure_app_config/src/models/feature_flag.dart';
import 'package:azure_app_config/src/models/key_value.dart';
import 'package:test/test.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  const tFeatureFlag = FeatureFlag(
    id: 'testid',
    enabled: false,
    description: 'description',
    conditions: {},
  );

  final validKv = KeyValue(
    etag: 'etag',
    key: 'key',
    value: json.encode(tFeatureFlag.toJson()),
    tags: {},
    locked: false,
    lastModified: 'last_modified',
  );

  test('should return a valid model from JSON full', () async {
    const tKeyValue = KeyValue(
      etag: 'tEtag',
      contentType: 'tContentType',
      label: 'tLabel',
      value: 'tValue',
      key: 'tKey',
      tags: {},
      locked: false,
      lastModified: '2022-10-28T09:07:51+00:00',
    );
    // arrange
    final jsonMap =
        json.decode(fixture('key_value_fixture.json')) as Map<String, dynamic>;
    // act
    final result = KeyValue.fromJson(jsonMap);
    // assert
    expect(result, tKeyValue);
  });

  test('should return a valid model from mostly empty JSON', () async {
    const tKeyValue = KeyValue(
      etag: 'tEtag',
      key: 'tKey',
      tags: {},
      locked: false,
      lastModified: '2022-10-28T09:07:51+00:00',
    );
    // arrange
    final jsonMap = json.decode(fixture('key_value_empty_fixture.json'))
        as Map<String, dynamic>;
    // act
    final result = KeyValue.fromJson(jsonMap);
    // assert
    expect(result, tKeyValue);
  });
  final invalidKv = validKv.copyWith(value: '');

  test('asFeatureFlag should convert to a featureFlag if value is valid',
      () async {
    final actual = validKv.asFeatureFlag();
    const expected = tFeatureFlag;

    expect(actual, expected);
  });

  test('''
asFeatureFlag throws AzureKeyValueNotParsableAsFeatureFlagException
       when value is unparsable''', () async {
    expect(
      invalidKv.asFeatureFlag,
      throwsA(
        isA<AzureKeyValueNotParsableAsFeatureFlagException>(),
      ),
    );
  });
}
