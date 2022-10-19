import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import 'dart:developer' as developer;

class AzureRemoteInterceptor extends Interceptor {
  /// Access key credential
  final String _credential;

  /// Access key secret
  final String _secret;

  /// Optional time for the interceptor to use. Used for testing.
  DateTime? clock;

  AzureRemoteInterceptor({
    required String credential,
    required String secret,
    this.clock,
  })  : _credential = credential,
        _secret = secret;

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
    String body = options.data ?? "";

    final pathAndParams = "$path?$params";

    final _utcString = utcString();

    final _contentHash = hashBody(body);

    var message = method +
        '\n' + // VERB
        pathAndParams +
        '\n' + // path_and_query
        _utcString +
        ';' +
        host +
        ';' +
        _contentHash;

    final _signature = signature(message);

    final signedHeaders = "x-ms-date;host;x-ms-content-sha256";

    options.headers["x-ms-date"] = _utcString;
    options.headers["x-ms-content-sha256"] = _contentHash;
    options.headers["Authorization"] = "HMAC-SHA256 Credential=" +
        _credential +
        "&SignedHeaders=" +
        signedHeaders +
        "&Signature=" +
        _signature;

    developer.log(
        'AZURE REQUEST[${options.method}] => ${options.path}?${options.uri.query}');

    handler.next(options);
  }

  String signature(String msg) {
    final hmac = Hmac(sha256, base64.decode(_secret));
    final digest = hmac.convert(utf8.encode(msg));

    return base64.encode(digest.bytes);
  }
}
