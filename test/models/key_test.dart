import 'dart:convert';

import 'package:azure_app_config/azure_app_config.dart';
import 'package:test/test.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  const tAzureKey = AzureKey(name: 'key1');

  test(
    'should return a valid model from JSON',
    () async {
      // arrange
      final jsonMap =
          json.decode(fixture('key_fixture.json')) as Map<String, dynamic>;
      // act
      final result = AzureKey.fromJson(jsonMap);
      // assert
      expect(result, tAzureKey);
    },
  );
}
