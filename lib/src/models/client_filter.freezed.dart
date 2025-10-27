// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClientFilter {

 String get name; Map<String, dynamic> get parameters;
/// Create a copy of ClientFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientFilterCopyWith<ClientFilter> get copyWith => _$ClientFilterCopyWithImpl<ClientFilter>(this as ClientFilter, _$identity);

  /// Serializes this ClientFilter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientFilter&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.parameters, parameters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(parameters));

@override
String toString() {
  return 'ClientFilter(name: $name, parameters: $parameters)';
}


}

/// @nodoc
abstract mixin class $ClientFilterCopyWith<$Res>  {
  factory $ClientFilterCopyWith(ClientFilter value, $Res Function(ClientFilter) _then) = _$ClientFilterCopyWithImpl;
@useResult
$Res call({
 String name, Map<String, dynamic> parameters
});




}
/// @nodoc
class _$ClientFilterCopyWithImpl<$Res>
    implements $ClientFilterCopyWith<$Res> {
  _$ClientFilterCopyWithImpl(this._self, this._then);

  final ClientFilter _self;
  final $Res Function(ClientFilter) _then;

/// Create a copy of ClientFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? parameters = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,parameters: null == parameters ? _self.parameters : parameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ClientFilter].
extension ClientFilterPatterns on ClientFilter {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientFilter() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientFilter value)  $default,){
final _that = this;
switch (_that) {
case _ClientFilter():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientFilter value)?  $default,){
final _that = this;
switch (_that) {
case _ClientFilter() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  Map<String, dynamic> parameters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientFilter() when $default != null:
return $default(_that.name,_that.parameters);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  Map<String, dynamic> parameters)  $default,) {final _that = this;
switch (_that) {
case _ClientFilter():
return $default(_that.name,_that.parameters);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  Map<String, dynamic> parameters)?  $default,) {final _that = this;
switch (_that) {
case _ClientFilter() when $default != null:
return $default(_that.name,_that.parameters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClientFilter implements ClientFilter {
  const _ClientFilter({required this.name, required final  Map<String, dynamic> parameters}): _parameters = parameters;
  factory _ClientFilter.fromJson(Map<String, dynamic> json) => _$ClientFilterFromJson(json);

@override final  String name;
 final  Map<String, dynamic> _parameters;
@override Map<String, dynamic> get parameters {
  if (_parameters is EqualUnmodifiableMapView) return _parameters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_parameters);
}


/// Create a copy of ClientFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientFilterCopyWith<_ClientFilter> get copyWith => __$ClientFilterCopyWithImpl<_ClientFilter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClientFilterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientFilter&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._parameters, _parameters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_parameters));

@override
String toString() {
  return 'ClientFilter(name: $name, parameters: $parameters)';
}


}

/// @nodoc
abstract mixin class _$ClientFilterCopyWith<$Res> implements $ClientFilterCopyWith<$Res> {
  factory _$ClientFilterCopyWith(_ClientFilter value, $Res Function(_ClientFilter) _then) = __$ClientFilterCopyWithImpl;
@override @useResult
$Res call({
 String name, Map<String, dynamic> parameters
});




}
/// @nodoc
class __$ClientFilterCopyWithImpl<$Res>
    implements _$ClientFilterCopyWith<$Res> {
  __$ClientFilterCopyWithImpl(this._self, this._then);

  final _ClientFilter _self;
  final $Res Function(_ClientFilter) _then;

/// Create a copy of ClientFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? parameters = null,}) {
  return _then(_ClientFilter(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,parameters: null == parameters ? _self._parameters : parameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
