library azure_remote_config;

import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class AzureRemoteConfig {
  final String credential; // access key id
  final String secret; // access key value (base64 encoded)
  final String host;

  final Dio dio = Dio();

  AzureRemoteConfig({
    required this.credential,
    required this.secret,
    required this.host,
  });

  String _formatDate(DateTime date) {
    // Format to something like: "Thu, 15 Sep 2022 23:59:24 GMT"

    final format = DateFormat("E, d MMM y", "en_US").add_Hms();
    var str = format.format(date);
    str = str + " " + "GMT";

    return str;
  }

  String _signature(String msg) {
    final hmac = Hmac(sha256, base64.decode(secret));
    final digest = hmac.convert(utf8.encode(msg));

    return base64.encode(digest.bytes);
  }

  Map<String, String> _signRequest({
    required String method, // GET, PUT, POST, DELETE
    required String params, // path+query
    required String body, // request body (undefined of none)
  }) {
    final verb = method.toUpperCase();
    final t = DateTime.now().toUtc();

    final utcNow = _formatDate(t);

    var contentHash = base64.encode(sha256.convert(utf8.encode(body)).bytes);

    var message = verb +
        '\n' + // VERB
        params +
        '\n' + // path_and_query
        utcNow +
        ';' +
        host +
        ';' +
        contentHash;

    final signature = _signature(message);

    final Map<String, String> headers = {};

    var signedHeaders = "x-ms-date;host;x-ms-content-sha256";

    headers["x-ms-date"] = utcNow;
    headers["x-ms-content-sha256"] = contentHash;
    headers["Authorization"] = "HMAC-SHA256 Credential=" +
        credential +
        "&SignedHeaders=" +
        signedHeaders +
        "&Signature=" +
        signature;

    return headers;
  }

  Future<Response> get(String params) {
    final path = "https://$host$params";

    print(path);

    final headers = _signRequest(
      method: "GET",
      params: params,
      body: "",
    );

    return dio.get(path, options: Options(headers: headers));
  }
}
