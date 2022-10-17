import 'package:azure_app_config/azure_remote_interceptor.dart';
import 'package:dio/dio.dart';

import '../util/connection_string_parser.dart';

class Client {
  final String apiVersion;
  final Dio dio;

  late final endpoint;

  Client({required String connectionString})
      : apiVersion = "1.0",
        dio = Dio() {
    Map<String, String> azureValues = parseConnectionString(connectionString);

    if (azureValues['Id'] == null ||
        azureValues['Secret'] == null ||
        azureValues['Endpoint'] == null) {
      throw ArgumentError(
          'The connection string does not contain all required values.');
    }

    String credential = azureValues['Id']!;
    String secret = azureValues['Secret']!;

    endpoint = azureValues['Endpoint']!;

    dio.interceptors.add(
      AzureRemoteInterceptor(
        credential: credential,
        secret: secret,
      ),
    );
  }

  Future<Response> get(String path, Map<String, String> params) async {
    params["api_version"] = "1.0";

    final response = await dio.get("$endpoint$path", queryParameters: params);

    return response;
  }

  Future<Response> put(String path, Map<String, String> params, dynamic data) {
    params["api_version"] = "1.0";

    return dio.put("$endpoint$path", queryParameters: params, data: data);
  }
}
