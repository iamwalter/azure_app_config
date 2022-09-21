import 'package:azure_app_config/azure_remote_interceptor.dart';
import 'package:azure_app_config/feature_filter.dart';
import 'package:azure_app_config/models/feature_flag.dart';
import 'package:azure_app_config/models/key.dart';
import 'package:azure_app_config/models/key_value.dart';
import 'package:dio/dio.dart';

class AzureRemoteService {
  final String API_VERSION = "api_version=1.0";
  final Dio dio = Dio();

  final String host;

  List<FeatureFilter> _featureFilters = [];

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

    // Add Standard Filters
    addFeatureFilter(Percentage());
    addFeatureFilter(TimeWindow(() => DateTime.now()));
  }

  void addFeatureFilter(FeatureFilter filter) {
    _featureFilters.add(filter);
  }

  Future<Response> _get(String path, Map<String, String> queryParams) async {
    return await dio.get(
      "$host$path",
      queryParameters: queryParams,
    );
  }

  Future<bool?> getFeatureEnabled(String key, String label) async {
    final feature = await getFeatureFlag(key, label);

    final clientFilters = feature.conditions['client_filters'];

    bool? enabled = null;

    if (feature.enabled == false) return false;

    for (final filter in clientFilters) {
      final String name = filter['name'];
      final Map<String, dynamic> params = filter['parameters'];

      for (final filter in _featureFilters) {
        if (filter.name == name) {
          enabled = filter.evaluate(params);
          print("AZURE FILTER [$key] => $name");
        }
      }
    }

    return enabled;
  }

  Future<FeatureFlag> getFeatureFlag(String key, String label) async {
    final path = "/kv/.appconfig.featureflag/$key";
    final params = {
      "label": label,
      "api_version": "1.0",
    };

    final response = await _get(path, params);

    final KeyValue keyValue = KeyValue.fromJson(response.data);
    final FeatureFlag featureFlag = FeatureFlag.fromJson(keyValue.value);

    return featureFlag;
  }

  Future<List<KeyValue>> getKeyValues() async {
    final path = "/kv/";
    final params = {
      "label": "*",
      "api_version": "1.0",
    };

    final response = await _get(path, params);

    final items = <KeyValue>[];

    response.data["items"].forEach((json) {
      items.add(KeyValue.fromJson(json));
    });

    return items;
  }

  Future<KeyValue> getConfigurationSetting(String key, String label) async {
    final path = "/kv/$key";
    final params = {
      "label": label,
      "api_version": "1.0",
    };

    final response = await _get(path, params);

    return KeyValue.fromJson(response.data);
  }

  Future<List<AzureKey>> getKeys() async {
    final path = "/keys";
    final params = {
      "api_version": "1.0",
    };

    final response = await _get(path, params);

    final List<AzureKey> items = [];

    for (final i in response.data["items"]) {
      final item = AzureKey.fromJson(i);
      items.add(item);
    }

    return items;
  }
}
