import 'package:azure_app_config/azure_app_config.dart';

void main(List<String> args) async {
  final service = AzureRemoteService(
      connectionString:
          'Endpoint=https://ac-cz-test-eigenrisico.azconfig.io;Id=7Qyz-l9-s0:LforJ2ejnzUGbk9vUzBN;Secret=7a6zzKlWF+HIExno09Xkkympgg6YM0YdAGLr68tbfUs=');

  final kv = await service.findKeyValuesBy(labelFilter: AzureFilters.noLabel);

  for (final k in kv) {
    print(k.label);
  }
}
