// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClientFilter _$ClientFilterFromJson(Map<String, dynamic> json) {
  return _ClientFilter.fromJson(json);
}

/// @nodoc
mixin _$ClientFilter {
  String get name => throw _privateConstructorUsedError;
  Map<String, dynamic> get parameters => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientFilterCopyWith<ClientFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientFilterCopyWith<$Res> {
  factory $ClientFilterCopyWith(
          ClientFilter value, $Res Function(ClientFilter) then) =
      _$ClientFilterCopyWithImpl<$Res, ClientFilter>;
  @useResult
  $Res call({String name, Map<String, dynamic> parameters});
}

/// @nodoc
class _$ClientFilterCopyWithImpl<$Res, $Val extends ClientFilter>
    implements $ClientFilterCopyWith<$Res> {
  _$ClientFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? parameters = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClientFilterCopyWith<$Res>
    implements $ClientFilterCopyWith<$Res> {
  factory _$$_ClientFilterCopyWith(
          _$_ClientFilter value, $Res Function(_$_ClientFilter) then) =
      __$$_ClientFilterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, Map<String, dynamic> parameters});
}

/// @nodoc
class __$$_ClientFilterCopyWithImpl<$Res>
    extends _$ClientFilterCopyWithImpl<$Res, _$_ClientFilter>
    implements _$$_ClientFilterCopyWith<$Res> {
  __$$_ClientFilterCopyWithImpl(
      _$_ClientFilter _value, $Res Function(_$_ClientFilter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? parameters = null,
  }) {
    return _then(_$_ClientFilter(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ClientFilter implements _ClientFilter {
  const _$_ClientFilter(
      {required this.name, required final Map<String, dynamic> parameters})
      : _parameters = parameters;

  factory _$_ClientFilter.fromJson(Map<String, dynamic> json) =>
      _$$_ClientFilterFromJson(json);

  @override
  final String name;
  final Map<String, dynamic> _parameters;
  @override
  Map<String, dynamic> get parameters {
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_parameters);
  }

  @override
  String toString() {
    return 'ClientFilter(name: $name, parameters: $parameters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClientFilter &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_parameters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClientFilterCopyWith<_$_ClientFilter> get copyWith =>
      __$$_ClientFilterCopyWithImpl<_$_ClientFilter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClientFilterToJson(
      this,
    );
  }
}

abstract class _ClientFilter implements ClientFilter {
  const factory _ClientFilter(
      {required final String name,
      required final Map<String, dynamic> parameters}) = _$_ClientFilter;

  factory _ClientFilter.fromJson(Map<String, dynamic> json) =
      _$_ClientFilter.fromJson;

  @override
  String get name;
  @override
  Map<String, dynamic> get parameters;
  @override
  @JsonKey(ignore: true)
  _$$_ClientFilterCopyWith<_$_ClientFilter> get copyWith =>
      throw _privateConstructorUsedError;
}
