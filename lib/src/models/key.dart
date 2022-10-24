import 'package:freezed_annotation/freezed_annotation.dart';

part 'key.freezed.dart';
part 'key.g.dart';

/// Represents an App Configuration [Key](https://learn.microsoft.com/en-us/azure/azure-app-configuration/rest-api-keys) resource.
@freezed
class AzureKey with _$AzureKey {
  const factory AzureKey({
    required String name,
  }) = _AzureKey;

  factory AzureKey.fromJson(Map<String, Object?> json) =>
      _$AzureKeyFromJson(json);
}
