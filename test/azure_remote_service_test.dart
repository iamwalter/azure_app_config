import 'dart:convert';

import 'package:azure_app_config/src/azure_remote_service.dart';
import 'package:azure_app_config/src/azure_remote_service_impl.dart';
import 'package:azure_app_config/src/core/client.dart';
import 'package:azure_app_config/src/models/feature_flag.dart';
import 'package:azure_app_config/src/models/key.dart';
import 'package:azure_app_config/src/models/key_value.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'azure_remote_service_test.mocks.dart';

const testKeyValue = KeyValue(
  etag: 'etag',
  key: 'testKey',
  label: 'testKey',
  value: 'testvalue',
  tags: {},
  locked: false,
  lastModified: 'last_modified',
);

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  test('when the connection string does not contain all required values.', () {
    expect(
      () => AzureRemoteService(
        connectionString: 'server=test;hello=bye;up=down;',
      ),
      throwsA(isA<ArgumentError>()),
    );
  });

  late DioAdapter dioAdapter;
  late AzureRemoteService service;
  const endpoint = 'https://test.website.com';

  setUp(() {
    service = AzureRemoteService(
      connectionString: 'Endpoint=$endpoint;Secret=tttestSecret;Id=testId',
    );

    dioAdapter = DioAdapter(dio: service.dio);
  });

  group('setKeyValue()', () {
    const key = 'testKey';
    const label = 'testLabel';

    test(
      'should call client with correct arguments and headers when full',
      () async {
        final client = MockClient();
        final service = AzureRemoteServiceImpl(client: client);

        await service.setKeyValue(
          key: key,
          label: label,
          value: 'testValue',
          contentType: 'testContentType',
          tags: {'testkey': 'testValue'},
        );

        verify(
          client.put(
            path: '/kv/$key',
            params: {'label': label},
            data: {
              'value': 'testValue',
              'content_type': 'testContentType',
              'tags': {'testkey': 'testValue'},
            },
            headers: {
              'Content-Type': 'application/vnd.microsoft.appconfig.kv+json',
            },
          ),
        ).called(1);
      },
    );

    test('should call client with correct arguments and headers when empty',
        () async {
      final client = MockClient();
      final service = AzureRemoteServiceImpl(client: client);

      await service.setKeyValue(
        key: key,
        label: label,
      );

      verify(
        client.put(
          path: '/kv/$key',
          params: {'label': label},
          data: {},
          headers: {
            'Content-Type': 'application/vnd.microsoft.appconfig.kv+json',
          },
        ),
      ).called(1);
    });
  });

  test('getFeatureEnabled', () {
    //todo
  });

  test('getKeys should return keys', () async {
    const key1 = AzureKey(name: 'testkey');
    const key2 = AzureKey(name: 'testkey2');

    dioAdapter.onGet(
      '$endpoint/keys',
      (server) {
        return server.reply(200, {
          'items': [
            key1.toJson(),
            key2.toJson(),
          ]
        });
      },
      queryParameters: {'api_version': '1.0'},
    );

    final actual = await service.getKeys();
    final expected = [key1, key2];

    expect(actual, expected);
  });

  test('getKeyValue should return a KeyValue', () async {
    final key = testKeyValue.key;
    final label = testKeyValue.label;

    dioAdapter.onGet(
      '$endpoint/kv/$key',
      (server) {
        return server.reply(
          200,
          testKeyValue.toJson(),
        );
      },
      queryParameters: {
        'label': label,
        'api_version': '1.0',
      },
    );

    final actual = await service.getKeyValue(key, label ?? '');

    expect(actual, testKeyValue);
  });

  test('getKeyValues should return keyValues', () async {
    final expected = <KeyValue>[testKeyValue, testKeyValue];

    dioAdapter.onGet(
      '$endpoint/kv',
      (server) {
        return server.reply(200, {
          'items': [
            testKeyValue.toJson(),
            testKeyValue.toJson(),
          ]
        });
      },
      queryParameters: {'api_version': '1.0'},
    );
    final actual = await service.getKeyValues();
    expect(actual, expected);
  });

  test('getFeatureFlags should retrieve feature flags', () async {
    const testFeatureFlag = FeatureFlag(
      id: 'id',
      description: 'description',
      enabled: false,
      conditions: {},
    );
    final keyValueWithFeatureFlag =
        testKeyValue.copyWith(value: json.encode(testFeatureFlag.toJson()));

    dioAdapter.onGet(
      '$endpoint/kv',
      (server) {
        return server.reply(200, {
          'items': [
            keyValueWithFeatureFlag.toJson(),
            testKeyValue.toJson(),
          ],
        });
      },
      queryParameters: {'label': '*', 'api_version': '1.0'},
    );

    final expected = [testFeatureFlag];
    final actual = await service.getFeatureFlags();

    expect(actual, expected);
  });
}
