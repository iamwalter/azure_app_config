
# azure_app_config  
This package makes it easier to communicate with Microsoft Azure App Configuration resources.

## Usage
To use this plugin, add `azure_app_config` to your `pubspec.yaml` file

## Example
Creating an instance of AzureRemoteService:

      final service = AzureRemoteService(
        host: "https://test.database.com",
        credential: "<YOUR_CREDENTIAL>",
        secret: "<YOUR_SECRET>,
      ); 

To get if a feature is enabled, use the `getFeatureEnabled` method.

    final enabled = await getFeatureEnabled("example_key", "example_tag");

If an error occurs during a call, `null` will be returned.

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


This package enables you to create custom FeatureFilters by extending the FeatureFilter class. For example, this is how the Percentage filter is implemented:

    class Percentage extends FeatureFilter {
      Percentage() : super(name: "Percentage");
    
      @override
      bool evaluate(Map<String, dynamic> parameters) {
        final value = parameters['Value'] as int;
    
        final random = Random().nextInt(101) < value;
    
        return random;
      }
    }


Afterwards, register the FeatureFilter by calling `service.addFeatureFilter(filter);`. The filters above are automatically registered.




