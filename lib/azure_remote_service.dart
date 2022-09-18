import 'package:azure_remote_config/azure_remote_interceptor.dart';
import 'package:azure_remote_config/models/key.dart';
import 'package:azure_remote_config/models/key_value.dart';
import 'package:dio/dio.dart';

class AzureRemoteService {
  final String host;

  AzureRemoteService({
    required this.host,
    required String credential,
    required String secret,
  }) {
    dio.interceptors.add(
      AzureRemoteInterceptor(
        credential: credential,
        secret: secret,
      ),
    );
  }

  final String API_VERSION = "api_version=1.0";

  final Dio dio = Dio();

  Future<Response> _get(String path, Map<String, String> queryParams) {
    return dio.get(
      "https://$host$path",
      queryParameters: queryParams,
    );
  }

  Future<KeyValue> getKeyValue(String key, String label) async {
    final path = "/kv/$key";
    final params = {
      "label": label,
      "api_version": "1.0",
    };

    try {
      final response = await _get(path, params);

      return KeyValue.fromJson(response.data);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Key>> getKeys() async {
    final path = "/keys";
    final params = {
      "api_version": "1.0",
    };

    try {
      final response = await _get(path, params);

      final List<Key> items = [];

      for (final i in response.data["items"]) {
        final item = Key.fromJson(i);
        items.add(item);
      }

      return items;
    } catch (e) {
      return Future.error(e);
    }
  }
}
