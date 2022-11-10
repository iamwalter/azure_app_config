import 'dart:convert';

import 'package:azure_app_config/src/core/azure_remote_interceptor.dart';
import 'package:azure_app_config/src/util/connection_string_parser.dart';
import 'package:dio/dio.dart';

/// Handles communication with the API. Deals with Authentication & Generic API
/// Parameters.
class Client {
  Client({required String connectionString})
      : apiVersion = '1.0',
        dio = Dio() {
    final azureValues = parseConnectionString(connectionString);

    if (azureValues['Id'] == null ||
        azureValues['Secret'] == null ||
        azureValues['Endpoint'] == null) {
      throw ArgumentError(
        'The connection string does not contain all required values.',
      );
    }

    final credential = azureValues['Id']!;
    final secret = azureValues['Secret']!;

    _endpoint = azureValues['Endpoint']!;

    dio.interceptors.add(
      AzureRemoteInterceptor(
        credential: credential,
        secret: secret,
      ),
    );
  }

  final String apiVersion;
  final Dio dio;
  late final String _endpoint;

  /// Returns the [Response] of a GET request.
  ///
  /// Returns the response from 'http://[_endpoint]/[path]?[params]'.
  Future<Response<dynamic>> get({
    required String path,
    required Map<String, String> params,
  }) async {
    params['api_version'] = '1.0';

    final response = await dio.get<dynamic>(
      '$_endpoint$path',
      queryParameters: params,
    );

    return response;
  }

  /// Returns the [Response] of a PUT request.
  ///
  /// A request is made to 'http://[_endpoint]/[path]?[params]'.
  /// where [data] is the request body, which expects an object which is
  /// parsable to a JSON String. [headers] usually indicates which type of data
  /// the server can expect.
  Future<Response<dynamic>> put({
    required String path,
    required Map<String, String> params,
    required Map<String, dynamic> data,
    required Map<String, String> headers,
  }) {
    params['api_version'] = '1.0';

    return dio.put(
      '$_endpoint$path',
      queryParameters: params,
      data: jsonEncode(data),
      options: Options(headers: headers),
    );
  }
}
