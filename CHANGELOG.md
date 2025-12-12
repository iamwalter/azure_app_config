## 1.2.0
- [bugfix] make FeatureFlag's `description` and `conditions` nullable.

## 1.1.1
- [feat] remove import on `dart:io` to support web 

## 1.0.0
- [chore] align SDK constraint to `>=3.8.0 <4.0.0`  
- [deps] update `dio` from ^5.7.0 → ^5.9.0  
- [deps] update `freezed_annotation` from ^2.4.4 → ^3.1.0  
- [deps] update `meta` from ^1.16.0 → ^1.17.0  

## 0.18.0
- [feat] `TargetingFilter` now supports exclusion ([#14](https://github.com/iamwalter/azure_app_config/pull/14))  

## 0.16.0 – 0.17.1
- [fix] resolve various pagination issues  
- [fix] ensure `FeatureFlag`s can always be retrieved  

## 0.15.2
- [feat] add optional parameter `name` to `setFeatureFlag()`  

## 0.15.1
- [feat] add constant `FeatureFlag.contentType`  

## 0.15.0
- [deprecate] `AzureRemoteService` in favor of `AzureAppConfig`  
- [feat] add `setFeatureFlag()` method  
- [feat] simplify feature flag key usage (now `mykey` instead of `.appconfig.featureflag/mykey`)  
- [fix] `KeyValue.asFeatureFlag()` now returns `null` instead of throwing `AzureKeyValueNotParsableAsFeatureFlagException`  
- [deps] update dependencies  

## 0.14.0
- [docs] improve README  
- [deps] update to latest dependency versions  

## 0.13.0
- [feat] complete Azure’s default `Targeting` filter (`groups` and `users` support)  

## 0.12.0
- [feat] add registration of `ComplexType`s for automatic (de)serialization  

## 0.11.0
- [feat] add `AzureRemoteService.customAuthentication()` factory for custom signing  
- [feat] add `findKeyBy()` method to locate `AzureKey`s  

## 0.10.0
- [feat] add `findKeyValuesBy()` method to filter by key and label  

## 0.9.0
- [init] initial release  
