import 'dart:io';

import 'package:azure_app_config/azure_remote_interceptor.dart';

import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:test/test.dart';

import 'azure_remote_interceptor_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<Uri>(),
  MockSpec<RequestInterceptorHandler>(),
  MockSpec<RequestOptions>()
])
void main() {
  /// Using the values from a 'real' call
  void stubRequest(MockRequestOptions options) {
    final uri = MockUri();

    when(options.uri).thenReturn(uri);

    when(uri.query).thenReturn("label=%2A&api_version=1.0");
    when(uri.path).thenReturn("/kv");
    when(uri.host).thenReturn("ac-cz-test.eigenrisico.azconfig.io");

    when(options.method).thenReturn("get");
    when(options.data).thenReturn(null);
    when(options.headers).thenReturn({});
  }

  group('utility functions', () {
    test('utcString() should return correct string based on clock', () {
      final moonLanding = DateTime.utc(1969, 7, 20, 20, 18, 04);

      final interceptor = AzureRemoteInterceptor(
        credential: '',
        secret: '',
        clock: moonLanding,
      );
      final actual = interceptor.utcString();
      final expected = 'Sun, 20 Jul 1969 20:18:04 GMT';

      expect(actual, expected);
    });

    test("hashBody('') should return correct string", () {
      final i = AzureRemoteInterceptor(credential: '', secret: '');

      final expected = "47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=";
      final actual = i.hashBody('');
      expect(actual, expected);
    });

    test("signature('') should return correct string", () async {
      final i = AzureRemoteInterceptor(credential: '', secret: '');
      final expected = "thNnmggU2ex3L5XXeMNfxf8Wl8STcVZTxscSFEKSxa0=";
      final actual = i.signature('');

      expect(actual, expected);
    });
  });

  test(
      'onRequest() should end with a call to handler.next(options) with correct headers',
      () {
    // Resolves to a specific time that the interceptor uses
    // so the calculations will resolve to the expected outputs
    final DateTime timeUsedForTesting =
        DateTime.fromMicrosecondsSinceEpoch(1666132930809223);

    final interceptor = AzureRemoteInterceptor(
      credential: "7Qyz-l9-s0:LforJ2ejnzUGbk9vUzBN",
      secret: "7a6zzKlWF+HIExno09Xkkympgg6YM0YdAGLr68tbfUs=",
      clock: timeUsedForTesting,
    );

    final options = MockRequestOptions();
    final handler = MockRequestInterceptorHandler();

    stubRequest(options);

    interceptor.onRequest(options, handler);

    final expectedAuthorizationHeader = """
HMAC-SHA256 Credential=7Qyz-l9-s0:LforJ2ejnzUGbk9vUzBN&SignedHeaders=x-ms-date;host;x-ms-content-sha256&Signature=0BoRwX5ieCfF7X4IOhW8MwTznRG+BvZfh/gUnuODlok=""";
    final expectedContentSha256Header =
        "47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=";
    final expectedDateHeader = HttpDate.format(timeUsedForTesting);

    expect(options.headers["Authorization"], expectedAuthorizationHeader);
    expect(options.headers["x-ms-content-sha256"], expectedContentSha256Header);
    expect(options.headers["x-ms-date"], expectedDateHeader);

    verify(handler.next(options)).called(1);

    verifyNoMoreInteractions(handler);
  });
}
