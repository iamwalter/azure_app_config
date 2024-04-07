## 0.17.0
- Fix issue where `FeatureFlag`s could sometimes not be retrieved.

## 0.16.0
- An issue that limited getKeyValues() to retrieving only up to 100 items has been resolved.

## 0.15.2

- This version introduces an optional parameter 'name' for the `setFeatureFlag()` method.

## 0.15.1

- Add constant `FeatureFlag.contentType`

## 0.15.0

- `AzureRemoteService` is deprecated in favor of `AzureAppConfig`.
- Added method: `setFeatureFlag()`
- Simplified feature flag methods to use key names only (before: .appconfig.featureflag/mykey, now: mykey).
- `KeyValue.asFeatureFlag()` now returns null if it's not parsable instead of throwing an `AzureKeyValueNotParsableAsFeatureFlagException`.
- Update dependencies 

## 0.14.0

- Improved Readme 
- Updated dependencies to latest versions

## 0.13.0

- Complete Azure's Default 'Targeting' filter by implementing the 'groups' and 'users' feature. 

## 0.12.0

- Add registering of ComplexTypes for automatic (de)serialization of models.

## 0.11.0

- Add factory constructor `AzureRemoteService.customAuthentication()` to provide custom way of signing requests.
- Add ability to find `AzureKey`s by introducing the `findKeyBy` method.

## 0.10.0

- Added the ability to find KeyValues by key- and label filters using the `findKeyValuesBy` method.

## 0.9.0

- Initial version.