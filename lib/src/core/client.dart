import 'dart:convert';

import 'package:azure_app_config/src/core/azure_remote_interceptor.dart';
import 'package:azure_app_config/src/models/errors/azure_errors.dart';
import 'package:azure_app_config/src/models/errors/error_response.dart';
import 'package:azure_app_config/src/util/connection_string_parser.dart';
import 'package:dio/dio.dart';

abstract class Client {
  factory Client({
    required String connectionString,
  }) {
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
    final endpoint = azureValues['Endpoint']!;

    final dio = Dio();

    dio.interceptors.add(
      AzureRemoteInterceptor(credential: credential, secret: secret),
    );

    return ClientImpl(endpoint: endpoint, dio: dio);
  }

  factory Client.customAuthentication({
    required String endpoint,
    required Interceptor interceptor,
  }) {
    final dio = Dio();

    dio.interceptors.add(interceptor);

    return ClientImpl(endpoint: endpoint, dio: dio);
  }

  Dio get dio;

  /// Returns the [Response] of a GET request.
  ///
  /// Returns the response from 'http://endpoint/[path]?[params]'.
  Future<Response<dynamic>> get({
    required String path,
    required Map<String, String> params,
  });

  /// Returns the [Response] of a PUT request.
  ///
  /// A request is made to 'http://endpoint/[path]?[params]'.
  /// where [data] is the request body, which expects an object which is
  /// parsable to a JSON String. [headers] usually indicates which type of data
  /// the server can expect.
  Future<Response<dynamic>> put({
    required String path,
    required Map<String, String> params,
    required Map<String, dynamic> data,
    required Map<String, String> headers,
  });
}

/// Handles communication with the API. Deals with Authentication & Generic API
/// Parameters.
class ClientImpl implements Client {
  ClientImpl({
    required this.endpoint,
    required this.dio,
  });

  @override
  final Dio dio;

  final String apiVersion = '1.0';

  final String endpoint;

  /// Handle any exceptions that may be thrown during the execution of
  /// the passed-in [callBack].
  Future<Response<dynamic>> _requestHelper(
    Future<Response<dynamic>> Function() callBack,
  ) async {
    try {
      return await callBack();
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        if (e.response?.statusCode == 400) {
          // Expecting a response object from API
          final errorResponse = ErrorResponse.fromJson(
            e.response?.data as Map<String, dynamic>,
          );

          throw AzureFilterValidationException(errorResponse);
        }

        if (e.response?.statusCode == 401) {
          throw AzureAuthenticationException();
        }

        if (e.response?.statusCode == 404) {
          throw AzureRecordNotFoundException();
        }
        if (e.response?.statusCode == 409) {
          // Expecting a response object from API
          final errorResponse = ErrorResponse.fromJson(
            e.response?.data as Map<String, dynamic>,
          );

          throw AzureRecordLockedException(errorResponse);
        }
      } 

      if (e.type == DioErrorType.unknown) {
        throw (e.error as Exception?) ?? 
        Exception('''
Something went wrong fetching values from Azure App Configuration''');
      }

      rethrow;
    }
  }

  /// Returns the [Response] of a GET request.
  ///
  /// Returns the response from 'http://[endpoint]/[path]?[params]'.
  @override
  Future<Response<dynamic>> get({
    required String path,
    required Map<String, String> params,
  }) async {
    return _requestHelper(() async {
      params['api_version'] = '1.0';

      return dio.get<dynamic>(
        '$endpoint$path',
        queryParameters: params,
      );
    });
  }

  /// Returns the [Response] of a PUT request.
  ///
  /// A request is made to 'http://[endpoint]/[path]?[params]'.
  /// where [data] is the request body, which expects an object which is
  /// parsable to a JSON String. [headers] usually indicates which type of data
  /// the server can expect.
  @override
  Future<Response<dynamic>> put({
    required String path,
    required Map<String, String> params,
    required Map<String, dynamic> data,
    required Map<String, String> headers,
  }) {
    return _requestHelper(() async {
      params['api_version'] = '1.0';

      return dio.put(
        '$endpoint$path',
        queryParameters: params,
        data: jsonEncode(data),
        options: Options(headers: headers),
      );
    });
  }
}
