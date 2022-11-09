import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_filter.freezed.dart';
part 'client_filter.g.dart';


/// Holds data about the 
/// custom parameters of a FeatureFilter.
@freezed
class ClientFilter with _$ClientFilter {
  /// Instanciate a [ClientFilter].
  const factory ClientFilter({
    required String name,
    required Map<String, dynamic> parameters,
  }) = _ClientFilter;

  factory ClientFilter.fromJson(Map<String, Object?> json) =>
      _$ClientFilterFromJson(json);
}
