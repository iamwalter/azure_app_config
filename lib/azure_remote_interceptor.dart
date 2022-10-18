import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import 'dart:developer' as developer;

class AzureRemoteInterceptor extends Interceptor {
  final String _credential; // access key id
  final String _secret; // access key value (base64 encoded)

  late DateTime Function() getTime;

  AzureRemoteInterceptor({
    required String credential,
    required String secret,
    DateTime Function()? getTime,
  })  : _credential = credential,
        _secret = secret {
    if (getTime == null) {
      this.getTime = () => DateTime.now();
    } else {
      this.getTime = getTime;
    }
  }

  String hashBody(String body) =>
      base64.encode(sha256.convert(utf8.encode(body)).bytes);

  String utcString() {
    return HttpDate.format(getTime.call());
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final params = options.uri.query;
    final path = options.uri.path;
    final pathAndParams = "$path?$params";

    final method = options.method.toUpperCase();
    final _utcString = utcString();

    final body = "";

    final _contentHash = hashBody(body);

    final host = options.uri.host;

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
