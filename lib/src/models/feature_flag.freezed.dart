// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'feature_flag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FeatureFlag _$FeatureFlagFromJson(Map<String, dynamic> json) {
  return _FeatureFlag.fromJson(json);
}

/// @nodoc
mixin _$FeatureFlag {
  String get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  Map<String, dynamic> get conditions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeatureFlagCopyWith<FeatureFlag> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeatureFlagCopyWith<$Res> {
  factory $FeatureFlagCopyWith(
          FeatureFlag value, $Res Function(FeatureFlag) then) =
      _$FeatureFlagCopyWithImpl<$Res, FeatureFlag>;
  @useResult
  $Res call(
      {String id,
      String description,
      bool enabled,
      Map<String, dynamic> conditions});
}

/// @nodoc
class _$FeatureFlagCopyWithImpl<$Res, $Val extends FeatureFlag>
    implements $FeatureFlagCopyWith<$Res> {
  _$FeatureFlagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
    Object? enabled = null,
    Object? conditions = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      conditions: null == conditions
          ? _value.conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FeatureFlagCopyWith<$Res>
    implements $FeatureFlagCopyWith<$Res> {
  factory _$$_FeatureFlagCopyWith(
          _$_FeatureFlag value, $Res Function(_$_FeatureFlag) then) =
      __$$_FeatureFlagCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String description,
      bool enabled,
      Map<String, dynamic> conditions});
}

/// @nodoc
class __$$_FeatureFlagCopyWithImpl<$Res>
    extends _$FeatureFlagCopyWithImpl<$Res, _$_FeatureFlag>
    implements _$$_FeatureFlagCopyWith<$Res> {
  __$$_FeatureFlagCopyWithImpl(
      _$_FeatureFlag _value, $Res Function(_$_FeatureFlag) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
    Object? enabled = null,
    Object? conditions = null,
  }) {
    return _then(_$_FeatureFlag(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      conditions: null == conditions
          ? _value._conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FeatureFlag implements _FeatureFlag {
  const _$_FeatureFlag(
      {required this.id,
      required this.description,
      required this.enabled,
      required final Map<String, dynamic> conditions})
      : _conditions = conditions;

  factory _$_FeatureFlag.fromJson(Map<String, dynamic> json) =>
      _$$_FeatureFlagFromJson(json);

  @override
  final String id;
  @override
  final String description;
  @override
  final bool enabled;
  final Map<String, dynamic> _conditions;
  @override
  Map<String, dynamic> get conditions {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_conditions);
  }

  @override
  String toString() {
    return 'FeatureFlag(id: $id, description: $description, enabled: $enabled, conditions: $conditions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FeatureFlag &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            const DeepCollectionEquality()
                .equals(other._conditions, _conditions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, description, enabled,
      const DeepCollectionEquality().hash(_conditions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FeatureFlagCopyWith<_$_FeatureFlag> get copyWith =>
      __$$_FeatureFlagCopyWithImpl<_$_FeatureFlag>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FeatureFlagToJson(
      this,
    );
  }
}

abstract class _FeatureFlag implements FeatureFlag {
  const factory _FeatureFlag(
      {required final String id,
      required final String description,
      required final bool enabled,
      required final Map<String, dynamic> conditions}) = _$_FeatureFlag;

  factory _FeatureFlag.fromJson(Map<String, dynamic> json) =
      _$_FeatureFlag.fromJson;

  @override
  String get id;
  @override
  String get description;
  @override
  bool get enabled;
  @override
  Map<String, dynamic> get conditions;
  @override
  @JsonKey(ignore: true)
  _$$_FeatureFlagCopyWith<_$_FeatureFlag> get copyWith =>
      throw _privateConstructorUsedError;
}
