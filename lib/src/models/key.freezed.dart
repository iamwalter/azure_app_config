// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'key.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AzureKey _$AzureKeyFromJson(Map<String, dynamic> json) {
  return _AzureKey.fromJson(json);
}

/// @nodoc
mixin _$AzureKey {
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AzureKeyCopyWith<AzureKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AzureKeyCopyWith<$Res> {
  factory $AzureKeyCopyWith(AzureKey value, $Res Function(AzureKey) then) =
      _$AzureKeyCopyWithImpl<$Res, AzureKey>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$AzureKeyCopyWithImpl<$Res, $Val extends AzureKey>
    implements $AzureKeyCopyWith<$Res> {
  _$AzureKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AzureKeyCopyWith<$Res> implements $AzureKeyCopyWith<$Res> {
  factory _$$_AzureKeyCopyWith(
          _$_AzureKey value, $Res Function(_$_AzureKey) then) =
      __$$_AzureKeyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$_AzureKeyCopyWithImpl<$Res>
    extends _$AzureKeyCopyWithImpl<$Res, _$_AzureKey>
    implements _$$_AzureKeyCopyWith<$Res> {
  __$$_AzureKeyCopyWithImpl(
      _$_AzureKey _value, $Res Function(_$_AzureKey) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$_AzureKey(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AzureKey implements _AzureKey {
  const _$_AzureKey({required this.name});

  factory _$_AzureKey.fromJson(Map<String, dynamic> json) =>
      _$$_AzureKeyFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'AzureKey(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AzureKey &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AzureKeyCopyWith<_$_AzureKey> get copyWith =>
      __$$_AzureKeyCopyWithImpl<_$_AzureKey>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AzureKeyToJson(
      this,
    );
  }
}

abstract class _AzureKey implements AzureKey {
  const factory _AzureKey({required final String name}) = _$_AzureKey;

  factory _AzureKey.fromJson(Map<String, dynamic> json) = _$_AzureKey.fromJson;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_AzureKeyCopyWith<_$_AzureKey> get copyWith =>
      throw _privateConstructorUsedError;
}
