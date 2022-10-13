
# azure_app_config  
This package makes it easier to communicate with Microsoft Azure App Configuration resources.

## Usage
To use this plugin, add `azure_app_config` to your `pubspec.yaml` file

## Example
Creating an instance of AzureRemoteService:

      final service = AzureRemoteService(
        connectionString: "<CONNECTION_STRING>",
      ); 


**To get all KeyValues**:

    final keyValue = await service.getKeyValues()

**... or a specific keyValue:**

    final keyValue = await service.getKeyValue("key", "label")

To convert a KeyValue to a feature flag entity use the method 

    keyValue.asFeatureFlag()

To get if a feature is enabled, use the `getFeatureEnabled` method.

    final enabled = await getFeatureEnabled("example_key", "example_tag");

---

### FeatureFilters

This package currently has the current built-in FeatureFilters:

#### Percentage
This will enable the flag to `Value` percentage of users.

    "parameters": {
    	"Value": 50
    }


#### Microsoft.TimeWindow
If current time is inbetween start and end time, return true. 

    "parameters": {
       	"Start": "Wed, 21 Sep 2022 00:25:00 GMT",
       	"End": "Wed, 21 Sep 2022 01:15:00 GMT"
       }

### Custom FeatureFilter

This package enables you to create custom FeatureFilters by extending the FeatureFilter class. For example, this is how the Percentage filter is implemented:

    class Percentage extends FeatureFilter {
      Percentage() : super(name: "Microsoft.Targeting");

      @override
      bool evaluate(Map<String, dynamic> parameters) {
        final value = parameters['Audience']['DefaultRolloutPercentage'] as int;
        final random = Random().nextInt(100);

        return random < value;
      }
    


Register the FeatureFilter by calling `service.registerFeatureFilter(filter)`. The filters above are automatically registered.


---

