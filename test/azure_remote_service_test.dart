import 'package:azure_app_config/azure_remote_service.dart';
import 'package:azure_app_config/models/feature_flag.dart';
import 'package:azure_app_config/models/key.dart';
import 'package:azure_app_config/models/key_value.dart';
import 'package:dio/dio.dart';
import "package:test/test.dart";
import 'package:http_mock_adapter/http_mock_adapter.dart';

final testKeyValue = KeyValue(
  etag: "etag",
  key: "testKey",
  label: "testKey",
  value: "testvalue",
  tags: {},
  locked: false,
  last_modified: "last_modified",
);

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late AzureRemoteService service;

  final endpoint = "https://test.website.com";

  setUp(() {
    service = AzureRemoteService(
      connectionString: "Endpoint=$endpoint;Secret=tttestSecret;Id=testId",
    );

    dio = service.dio;
    dioAdapter = DioAdapter(dio: dio);
  });

  test('getKeys should return keys', () async {
    final key1 = AzureKey("testkey");
    final key2 = AzureKey("testkey2");

    dioAdapter.onGet("$endpoint/keys", (server) {
      return server.reply(200, {
        "items": [
          {"name": "testkey"},
          {"name": "testkey2"},
        ]
      });
    }, queryParameters: {"api_version": "1.0"});

    final actual = await service.getKeys();
    final expected = [key1, key2];

    expect(actual, expected);
  });

  test('getKeyValue', () async {
    final key = testKeyValue.key;
    final label = testKeyValue.label;

    dioAdapter.onGet("$endpoint/kv/$key", (server) {
      return server.reply(
        200,
        testKeyValue.toMap(),
      );
    }, queryParameters: {
      "label": label,
      "api_version": "1.0",
    });

    final actual = await service.getKeyValue(key, label ?? "");

    expect(actual, testKeyValue);
  });

  test('getKeyValues', () async {
    final expected = <KeyValue>[testKeyValue, testKeyValue];

    dioAdapter.onGet("$endpoint/kv", (server) {
      return server.reply(200, {
        "items": [
          testKeyValue.toMap(),
          testKeyValue.toMap(),
        ]
      });
    }, queryParameters: {"api_version": "1.0"});
    final actual = await service.getKeyValues();
    expect(actual, expected);
  });

  test('getFeatureFlags should only retrieve feature flags', () async {
    final testFeatureFlag = FeatureFlag(
        id: "id", description: "description", enabled: false, conditions: {});
    final keyValueWithFeatureFlag =
        testKeyValue.copyWith(value: testFeatureFlag.toJson());

    dioAdapter.onGet("$endpoint/kv", (server) {
      return server.reply(200, {
        "items": [
          keyValueWithFeatureFlag.toMap(),
          testKeyValue.toMap(),
        ],
      });
    }, queryParameters: {"label": "*", "api_version": "1.0"});

    final expected = [testFeatureFlag];
    final actual = await service.getFeatureFlags();

    expect(actual, expected);
  });

  test('getFeatureEnabled', () {
    // todo
  });
}
