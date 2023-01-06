[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

# Azure App Configuration  
This package makes it easier to communicate with Microsoft Azure App Configuration KeyValue and FeatureFlag resources.

## Installation
To use this plugin, add `azure_app_config` to your `pubspec.yaml` file.

## Example
Creating an instance of AzureRemoteService:

      final service = AzureRemoteService(
        connectionString: "<CONNECTION_STRING>",
      ); 

## Authentication

A connection string is required to use App Configuration.
The connection string can be obtained from the App Configuration Dashboard under 'Access keys'.

When the connection string is invalid or not specified, an ArgumentError will occur.

## Example 

    import 'dart:developer' as developer;

    import 'package:azure_app_config/azure_app_config.dart';

    void main() async {
        const exampleKey = 'example_key';
        const exampleLabel = 'example_label';

        // Creating an instance needs a connection String. This can be
        // obtained through the Azure Portal, under "Access Keys".
        final service = AzureRemoteService(connectionString: '<CONNECTION_STRING>');

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

            // .asFeatureFlag() will throw this exception if it's unable to parse.
        } on AzureKeyValueNotParsableAsFeatureFlagException {
            rethrow;
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
                keyFilter: '.appconfig.*',
                labelFilter: AzureFilters.noLabel,
            );

            // Loop through the values
            for (final keyValue in keyValues) {
            developer.log(keyValue.value);
            }

            // When an invalid filter has been provided, for example, '.appconfig.**',
            // an [AzureFilterValidationException] is thrown.
        } on AzureFilterValidationException catch (e) {
            developer.log(e.message ?? '');
        }
    }


---

### FeatureFilters
This package currently has 2 built-in FeatureFilters based on the defaults which can be found in the App Configuration dashboard:

**Microsoft.Targeting** -> Enable a flag based on a percentage. Use 'Default Percentage' for this. The Groups section is still a work in progress, and is not included in this library. 

**Microsoft.TimeWindow** -> Enable a feature flag during a specified window of time.

### Implement your own FeatureFilter

This package enables you to create custom FeatureFilters by extending the FeatureFilter class. For example, this is how the Percentage filter is implemented:

    class Percentage extends FeatureFilter {
      Percentage() : super(name: "Microsoft.Targeting");

      @override
      bool evaluate(Map<String, dynamic> parameters) {
        final value = parameters['Audience']['DefaultRolloutPercentage'] as int;
        final random = Random().nextInt(100);

        return random < value;
      }
    


Register the FeatureFilter by calling `service.registerFeatureFilter(filter)`. The build-in filters are automatically registered.

## More Information
For more information about Azure App Configuration, take a look at the following resources.

 - [Azure App Configuration Overview](https://learn.microsoft.com/en-us/azure/azure-app-configuration/overview)
 - [Feature Management Overview](https://learn.microsoft.com/en-us/azure/azure-app-configuration/concept-feature-management)


Feel free to submit any pull requests!




Package created by Walter Tesevic commissioned by Ordina
