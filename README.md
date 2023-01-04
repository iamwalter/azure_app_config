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

## Example Usages

To get all KeyValues:

    final keyValue = await service.getKeyValues()

... or a specific keyValue:

    final keyValue = await service.getKeyValue(key: "example_key", label: "example_label")

To convert a `KeyValue` to a `FeatureFlag`  use the method. This method will throw an `AzureKeyValueNotParsableAsFeatureFlagException` if the 
`KeyValue` cannot be parsed to `FeatureFlag`.

    final featureFlag = keyValue.asFeatureFlag()

To retrieve wheter the FeatureFlag is enabled in the database, use:

    final isEnabledInDatabase = featureFlag.enabled;


To get if a feature is enabled while running it through the FeatureFilters, use the `getFeatureEnabled` method.

    final enabled = await getFeatureEnabled(key: "example_key", label: "example_label");

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
