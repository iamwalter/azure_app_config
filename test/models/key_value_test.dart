import 'package:azure_app_config/models/feature_flag.dart';
import 'package:azure_app_config/models/key_value.dart';
import 'package:test/test.dart';

void main() {
  final testFeatureFlag = FeatureFlag(
    id: "testid",
    enabled: false,
    description: "description",
    conditions: {},
  );

  final validKv = KeyValue(
    etag: "etag",
    key: "key",
    value: testFeatureFlag.toJson(),
    tags: {},
    locked: false,
    last_modified: "last_modified",
  );

  final invalidKv = validKv.copyWith(value: "");

  test('asFeatureFlag should convert to a featureFlag if value is valid',
      () async {
    final actual = validKv.asFeatureFlag();
    final expected = testFeatureFlag;

    expect(actual, expected);
  });

  test('asFeatureFlag should return null if value is invalid ', () async {
    final actual = invalidKv.asFeatureFlag();

    expect(actual, null);
  });
}
