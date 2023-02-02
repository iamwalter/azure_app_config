[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

# Azure App Configuration  
This package makes it easier to communicate with Microsoft Azure App Configuration KeyValue and FeatureFlag resources.

## Installation
To use this plugin, add `azure_app_config` to your `pubspec.yaml` file.


## Authentication

There are two methods of using Azure App Configuration:

1. (simple) Use the connection string which can be obtained from the App Configuration Dashboard under 'Access keys'. If the connection string is invalid or not specified, an ArgumentError will occur.

2. (complex) Use the factory constructor `AzureRemoteService.customAuthentication()` which enables you to provide a custom way of signing requests.

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
        } // .asFeatureFlag() will throw this exception if it's unable to parse.
        on AzureKeyValueNotParsableAsFeatureFlagException {
            developer.log('Oh no!');
        }
        
        try {
            // (!!) Make sure to register a FeatureFilter before using it.
            service.registerFeatureFilter(
                FeatureFilter.targeting(
                    user: 'test.user@company.com',
                ),
            );
            // To check if a featureflag is enabled while parsing the featurefilters, use
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



## Complex Types

You are able to register types with their associated 
encode and decode functions. After registering the types, the library will automatically use those functions to retrieve/set values in the database.

    class TimeRange {
        String start;
        String end;
        TimeRange(this.start, this.end);
        factory TimeRange.fromJson(Map<String, dynamic>)
        Map<String, dynamic> toMap() => {'start': start, 'end': end}
    }
    
    ...

    // Register a type, so that the library knows how to encode and decode the model
    service.registerType<TimeRange>(
      decode: (jsonData) => TimeRange.fromJson(jsonData),
      encode: (timeRange) => timeRange.toMap(),
    );

    // Uses the passed-in [encode] method to know the json structure to use.
    await service.setTyped(
        TimeRange('Monday', 'Friday'),
        key: 'time_range',
        label: 'some_label',
    );
    
    // Uses the passed-in [decode] method to know how to serialize [TimeRange]
    final timeRange = await service.getTyped<TimeRange>(
        key: 'time_range',
        label: 'some_label',
    ); 

---

### FeatureFilters
This package currently has 2 built-in FeatureFilters based on the defaults which can be found in the App Configuration dashboard:

**Microsoft.Targeting** -> Enable a flag based on some Targeting parameters which can be found in the Azure dashboard.  

**Microsoft.TimeWindow** -> Enable a feature flag during a specified window of time.

Make sure to register the FeatureFilter before retrieving a feature's value. <br>
`service.registerFeatureFilter(FeatureFilter.timeWindow())` 
or <br>
`service.registerFeatureFilter(FeatureFilter.targeting())`. 

### Implement your own FeatureFilter

This package enables you to create custom FeatureFilters by extending the FeatureFilter class. An example of this can be found by looking at how the built-in FeatureFilters are implemented [here](lib/src/feature_filters/targeting_filter.dart).


## More Information
For more information about Azure App Configuration, take a look at the following resources.

 - [Azure App Configuration Overview](https://learn.microsoft.com/en-us/azure/azure-app-configuration/overview)
 - [Feature Management Overview](https://learn.microsoft.com/en-us/azure/azure-app-configuration/concept-feature-management)


Feel free to submit any pull requests!




Package created by Walter Tesevic commissioned by Ordina
