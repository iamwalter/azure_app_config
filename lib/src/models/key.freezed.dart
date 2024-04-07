// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'key.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$AzureKeyImplCopyWith<$Res>
    implements $AzureKeyCopyWith<$Res> {
  factory _$$AzureKeyImplCopyWith(
          _$AzureKeyImpl value, $Res Function(_$AzureKeyImpl) then) =
      __$$AzureKeyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$AzureKeyImplCopyWithImpl<$Res>
    extends _$AzureKeyCopyWithImpl<$Res, _$AzureKeyImpl>
    implements _$$AzureKeyImplCopyWith<$Res> {
  __$$AzureKeyImplCopyWithImpl(
      _$AzureKeyImpl _value, $Res Function(_$AzureKeyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$AzureKeyImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AzureKeyImpl implements _AzureKey {
  const _$AzureKeyImpl({required this.name});

  factory _$AzureKeyImpl.fromJson(Map<String, dynamic> json) =>
      _$$AzureKeyImplFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'AzureKey(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AzureKeyImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AzureKeyImplCopyWith<_$AzureKeyImpl> get copyWith =>
      __$$AzureKeyImplCopyWithImpl<_$AzureKeyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AzureKeyImplToJson(
      this,
    );
  }
}

abstract class _AzureKey implements AzureKey {
  const factory _AzureKey({required final String name}) = _$AzureKeyImpl;

  factory _AzureKey.fromJson(Map<String, dynamic> json) =
      _$AzureKeyImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$AzureKeyImplCopyWith<_$AzureKeyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
