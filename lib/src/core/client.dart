import 'dart:convert';

import 'package:azure_app_config/src/azure_filters.dart';
import 'package:azure_app_config/src/core/azure_remote_interceptor.dart';
import 'package:azure_app_config/src/models/errors/azure_errors.dart';
import 'package:azure_app_config/src/models/errors/error_response.dart';
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

    try {
      var url = '$_endpoint$path';

      // Handles an edgecase where dio.get(queryParameters) encodes the
      // URL parameter for a null character differently than
      // what the Azure API expects (Dio encodes %00 to %2500, API expects %00)
      if (params['label'] == AzureFilters.noLabel) {
        params.remove('label');

        // so the solution is to hardcode the label parameter into the url
        url = '$url?label=${AzureFilters.noLabel}';
      }

      return await dio.get<dynamic>(
        url,
        queryParameters: params,
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        final errorModel =
            ErrorResponse.fromJson(e.response?.data as Map<String, dynamic>);

        throw AzureFilterValidationException(errorModel);
      }

      rethrow;
    } catch (e) {
      rethrow;
    }
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
