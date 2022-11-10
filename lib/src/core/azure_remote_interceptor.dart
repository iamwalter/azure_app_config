// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

/// Handles configuring the Content & Authorization correct
/// headers for each API call that is made to Azure.
class AzureRemoteInterceptor extends Interceptor {
  /// Instanciates a [AzureRemoteInterceptor]
  AzureRemoteInterceptor({
    required String credential,
    required String secret,
    this.clock,
  })  : _credential = credential,
        _secret = secret;

  /// Access key credential
  final String _credential;

  /// Access key secret
  final String _secret;

  /// Optional time for the interceptor to use. Used for testing.
  DateTime? clock;

  String hashBody(String body) =>
      base64.encode(sha256.convert(utf8.encode(body)).bytes);

  String utcString() =>
      clock == null ? HttpDate.format(DateTime.now()) : HttpDate.format(clock!);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final host = options.uri.host;
    final path = options.uri.path;

    final method = options.method.toUpperCase();
    final params = options.uri.query;
    final body = options.data as String? ?? '';

    final pathAndParams = '$path?$params';

    final utc = utcString();

    final contentHash = hashBody(body);

    final message = '$method\n$pathAndParams\n$utc;$host;$contentHash';

    final signedMessage = signature(message);

    const signedHeaders = 'x-ms-date;host;x-ms-content-sha256';

    options.headers['x-ms-date'] = utc;
    options.headers['x-ms-content-sha256'] = contentHash;
    options.headers['Authorization'] =
        'HMAC-SHA256 Credential=$_credential&SignedHeaders=$signedHeaders&Signature=$signedMessage';

    developer.log(
      'AZURE REQUEST[${options.method}] => ${options.path}?${options.uri.query}',
    );

    handler.next(options);
  }

  String signature(String msg) {
    final hmac = Hmac(sha256, base64.decode(_secret));
    final digest = hmac.convert(utf8.encode(msg));

    return base64.encode(digest.bytes);
  }
}
