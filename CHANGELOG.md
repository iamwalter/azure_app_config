## 0.16.0
- Fix getKeyValues() only retrieving up to 100 items.

## 0.15.2

- Added optional parameter 'name' to setFeatureFlag()
- Update dependencies

## 0.15.1

- Add constant FeatureFlag.contentType

## 0.15.0

- Deprecate 'AzureRemoteService' for 'AzureAppConfig'
- Added method: setFeatureFlag()
- Methods setFeatureEnabled, enableFeature and disableFeature now only take the last part of the key because this is more user friendly. So, before -> '.appconfig.featureflag/mykey'. After -> 'mykey'
- KeyValue.asFeatureFlag() now returns null if it's not parsable instead of throwing an AzureKeyValueNotParsableAsFeatureFlagException.
- Update dependencies 

## 0.14.0

- Improved Readme 
- Updated dependencies to latest versions

## 0.13.0

- Complete Azure's Default 'Targeting' filter by implementing the 'groups' and 'users' feature. 

## 0.12.0

- Add registering of ComplexTypes for automatic (de)serialization of models.

## 0.11.0

- Add factory constructor AzureRemoteService.customAuthentication() to provide custom way of signing requests.
- Add ability to find Azure Keys by using the `findKeyBy` method.

## 0.10.0

- Added the ability to find KeyValues by key- and label filters using the `findKeyValuesBy` method.

## 0.9.0

- Initial version.