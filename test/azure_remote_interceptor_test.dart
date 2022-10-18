import 'dart:convert';
import 'dart:io';

import 'package:azure_app_config/azure_remote_interceptor.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockRequestOptions extends Mock implements RequestOptions {}

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class MockAzureRemoteInterceptor extends Mock
    implements AzureRemoteInterceptor {}

void main() {
  group('utcString should return correct string for ', () {
    test('current time when no arguments', () {
      final i = AzureRemoteInterceptor(
        credential: "",
        secret: "",
      );

      final actual = i.utcString();
      final expected = HttpDate.format(DateTime.now());

      expect(expected, actual);
    });
    test('a given UTC value', () {
      final moonLanding = DateTime.utc(1969, 7, 20, 20, 18, 04);

      final i = AzureRemoteInterceptor(
        credential: '',
        secret: '',
        getTime: () => moonLanding,
      );
      final actual = i.utcString();
      final expected = 'Sun, 20 Jul 1969 20:18:04 GMT';

      expect(actual, expected);
    });
  });

  test("hashBody() with empty value ('') ", () {
    final expected = "47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=";
    final actual = base64.encode(sha256.convert(utf8.encode("")).bytes);
    expect(expected, actual);
  });

  test('signature() with empty message (' ') ', () async {
    final expected = "47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=";
    final actual = base64.encode(sha256.convert(utf8.encode("")).bytes);

    expect(expected, actual);
  });

  //
  test("headers should contain correct 'x-ms-date'", () {
    final interceptor = AzureRemoteInterceptor(
      credential: "",
      secret: "",
    );

    final options = MockRequestOptions();

    when(() => options.headers).thenReturn({});

    interceptor.onRequest(
      options,
      MockRequestInterceptorHandler(),
    );

    final actual = options.headers["x-ms-date"];
    final expected = HttpDate.format(DateTime.now());

    expect(expected, actual);
  });

  test(
    'onRequest() should call handler.next()',
    () async {
      final interceptor = AzureRemoteInterceptor(
        credential: "testCredential",
        secret: "testSecrettt",
      );

      final options = MockRequestOptions();
      final handler = MockRequestInterceptorHandler();

      when(() => options.uri)
          .thenReturn(Uri(query: "any", path: "any", host: "any"));
      when(() => options.path).thenReturn("any");
      when(() => options.method).thenReturn("GET");
      when(() => options.headers).thenReturn({});

      interceptor.onRequest(options, handler);

      verify(() => handler.next(options)).called(1);
    },
  );
}
