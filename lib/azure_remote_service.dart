import 'package:azure_remote_config/azure_remote_config.dart';
import 'package:azure_remote_config/models/key.dart';
import 'package:azure_remote_config/models/key_value.dart';

class AzureRemoteService {
  final AzureRemoteConfig azureRemoteConfig;

  AzureRemoteService({required this.azureRemoteConfig});

  final String API_VERSION = "api_version=1.0";

  Future<KeyValue> getKeyValue(String key, String label) async {
    final params = "/kv/$key?label=$label&$API_VERSION";

    try {
      final response = await azureRemoteConfig.get(params);

      return Future.value(KeyValue.fromJson(response.data));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Key>> getKeys() async {
    final params = "/keys?$API_VERSION";

    try {
      final response = await azureRemoteConfig.get(params);

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
