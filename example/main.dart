// ignore_for_file: avoid_print, unused_local_variable

import 'package:azure_app_config/azure_app_config.dart';

void main() async {
  const exampleKey = 'example_key';
  const exampleLabel = 'example_label';

  // Creating an instance needs a connection String. This can be obtained through
  // the Azure Portal, under "Access Keys".
  final service = AzureRemoteService(connectionString: '<CONNECTION_STRING>');

  // Getting a keyvalue
  late KeyValue keyValue;

  try {
    keyValue = await service.getKeyValue(key: exampleKey, label: exampleLabel);
  } catch (error) {
    // Handle any exceptions that might occur when interacting with the Azure service
    print('Error occurred while getting key value: $error');
  }

  // Now you can retrieve any property of the keyValue, for instance
  final value = keyValue.value;

  // .. if the keyValue is a FeatureFlag, you can use .asFeatureFlag()
  // to get the properties of the FeatureFlag
  final featureFlag = keyValue.asFeatureFlag();

  if (featureFlag == null) return;

  // to check if the featureflag is enabled, use
  final isFeatureFlagEnabled = featureFlag.enabled;

  // to check if a featureflag is enabled while parsing the featurefilters, use
  bool isFeatureEnabled;

  try {
    isFeatureEnabled =
        await service.getFeatureEnabled(key: exampleKey, label: exampleLabel);
  } catch (error) {
    // Handle any exceptions that might occur when interacting with the Azure service
    print('Error occurred while checking if feature is enabled: $error');
  }
}
