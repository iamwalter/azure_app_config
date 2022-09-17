// var credential = "Vqun-l9-s0:6Nnb+djRMh41P4ZQV+2L"; // Id
// var secret = "j4tlgYuIrIvz4VAUyLWB+9fTK2oIoaXzZ2VH/+w8JiI="; // Value

library azure_remote_config;

import 'dart:async';
import 'dart:convert';

import 'package:azure_remote_config/models/key.dart';
import 'package:azure_remote_config/models/key_value.dart';
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

  Future<KeyValue> getKeyValue(String key, String label) async {
    final url = "/kv/$key?label=$label&api_version=1.0";

    final headers = _signRequest(
      host: host,
      method: "GET",
      url: url,
      body: "",
    );

    final path = "https://$host$url";

    print(path);
    try {
      final dioResponse =
          await dio.get(path, options: Options(headers: headers));

      if (dioResponse.data == null) {
        return Future.error(ApiError("data was null"));
      }

      return KeyValue.fromJson(dioResponse.data);
    } on DioError catch (e) {
      return Future.error(ApiError(e.message));
    }
  }

  Future<List<Key>> getKeys() async {
    final url = "/keys?api-version=1.0";

    final headers = _signRequest(
      host: host,
      method: "GET",
      url: url,
      body: "",
    );

    final path = "https://$host$url";

    final response = await dio.get(path, options: Options(headers: headers));

    final List<Key> items = [];

    for (final i in response.data["items"]) {
      final item = Key.fromJson(i);
      items.add(item);
    }

    return items;
  }

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
    required String host,
    required String method, // GET, PUT, POST, DELETE
    required String url, // path+query
    required String body, // request body (undefined of none)
  }) {
    final verb = method.toUpperCase();
    final t = DateTime.now().toUtc();

    final utcNow = _formatDate(t);

    var contentHash = base64.encode(sha256.convert(utf8.encode(body)).bytes);

    var message = verb +
        '\n' + // VERB
        url +
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
}

class ApiError {
  final String error;

  const ApiError(this.error);

  @override
  String toString() => error;
}
