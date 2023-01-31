import 'dart:developer' as developer;

import 'package:azure_app_config/azure_app_config.dart';

void main() async {
  const exampleKey = 'example_key';
  const exampleLabel = 'example_label';

  // Creating an instance needs a connection String. This can be
  // obtained through the Azure Portal, under "Access Keys".
  final service = AzureRemoteService(connectionString: '<CONNECTION_STRING>')
    // Make sure to register a FeatureFilter before using it.
    ..registerFeatureFilter(FeatureFilter.percentage())
    // Provide the FeatureFilters with information about the current user.
    // When used the result will be consistent for each user
    // each time the same feature is retrieved.
    ..setFeatureFilterSettings(
      user: 'test.user@company.com',
    );

  // Getting a keyvalue
  late KeyValue keyValue;

  try {
    keyValue = await service.getKeyValue(key: exampleKey, label: exampleLabel);
  } catch (err) {
    // Handle any exceptions that might occur when interacting with the Azure
    // service
    developer.log('Error occurred while getting key value: $err');
  }

  // Now you can retrieve any property of the keyValue, for instance
  developer.log(keyValue.value);

  // If the KeyValue is a FeatureFlag, you can use .asFeatureFlag()
  // to get the properties of the FeatureFlag
  try {
    final featureFlag = keyValue.asFeatureFlag();

    // To check if the featureflag is enabled, use
    developer.log('${featureFlag.enabled}');
  } // .asFeatureFlag() will throw this exception if it's unable to parse.
  on AzureKeyValueNotParsableAsFeatureFlagException {
    developer.log('Oh no!');
  }

  // To check if a featureflag is enabled while parsing the featurefilters, use
  try {
    final isFeatureEnabled =
        await service.getFeatureEnabled(key: exampleKey, label: exampleLabel);

    developer.log('$isFeatureEnabled');
  } catch (err) {
    // Handle any exceptions that might occur when interacting with the Azure
    // service
    developer.log('Error occurred while checking if feature is enabled: $err');
  }

  // To find FeatureFlags based on a key and label filter use findKeyValuesBy().
  // This example searches for the keyValues that start with '.appconfig.'
  // without a label:
  try {
    final keyValues = await service.findKeyValuesBy(
      key: '.appconfig.*',
      label: AzureFilters.noLabel,
    );

    // Loop through the values
    for (final keyValue in keyValues) {
      developer.log(keyValue.value);
    }

    // When an invalid filter has been provided, for example, '.appconfig.**',
    // an [AzureFilterValidationException] is thrown.
  } on AzureFilterValidationException catch (e) {
    developer.log(e.errorResponse.detail ?? 'Error occurred!');
  }
}
