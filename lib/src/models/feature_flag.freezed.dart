// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feature_flag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeatureFlag {

 String get id; String get description; bool get enabled; Map<String, dynamic> get conditions;
/// Create a copy of FeatureFlag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeatureFlagCopyWith<FeatureFlag> get copyWith => _$FeatureFlagCopyWithImpl<FeatureFlag>(this as FeatureFlag, _$identity);

  /// Serializes this FeatureFlag to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeatureFlag&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other.conditions, conditions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,description,enabled,const DeepCollectionEquality().hash(conditions));

@override
String toString() {
  return 'FeatureFlag(id: $id, description: $description, enabled: $enabled, conditions: $conditions)';
}


}

/// @nodoc
abstract mixin class $FeatureFlagCopyWith<$Res>  {
  factory $FeatureFlagCopyWith(FeatureFlag value, $Res Function(FeatureFlag) _then) = _$FeatureFlagCopyWithImpl;
@useResult
$Res call({
 String id, String description, bool enabled, Map<String, dynamic> conditions
});




}
/// @nodoc
class _$FeatureFlagCopyWithImpl<$Res>
    implements $FeatureFlagCopyWith<$Res> {
  _$FeatureFlagCopyWithImpl(this._self, this._then);

  final FeatureFlag _self;
  final $Res Function(FeatureFlag) _then;

/// Create a copy of FeatureFlag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? description = null,Object? enabled = null,Object? conditions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,conditions: null == conditions ? _self.conditions : conditions // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [FeatureFlag].
extension FeatureFlagPatterns on FeatureFlag {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeatureFlag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeatureFlag() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeatureFlag value)  $default,){
final _that = this;
switch (_that) {
case _FeatureFlag():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeatureFlag value)?  $default,){
final _that = this;
switch (_that) {
case _FeatureFlag() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String description,  bool enabled,  Map<String, dynamic> conditions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeatureFlag() when $default != null:
return $default(_that.id,_that.description,_that.enabled,_that.conditions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String description,  bool enabled,  Map<String, dynamic> conditions)  $default,) {final _that = this;
switch (_that) {
case _FeatureFlag():
return $default(_that.id,_that.description,_that.enabled,_that.conditions);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String description,  bool enabled,  Map<String, dynamic> conditions)?  $default,) {final _that = this;
switch (_that) {
case _FeatureFlag() when $default != null:
return $default(_that.id,_that.description,_that.enabled,_that.conditions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeatureFlag extends FeatureFlag {
  const _FeatureFlag({required this.id, required this.description, required this.enabled, required final  Map<String, dynamic> conditions}): _conditions = conditions,super._();
  factory _FeatureFlag.fromJson(Map<String, dynamic> json) => _$FeatureFlagFromJson(json);

@override final  String id;
@override final  String description;
@override final  bool enabled;
 final  Map<String, dynamic> _conditions;
@override Map<String, dynamic> get conditions {
  if (_conditions is EqualUnmodifiableMapView) return _conditions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_conditions);
}


/// Create a copy of FeatureFlag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeatureFlagCopyWith<_FeatureFlag> get copyWith => __$FeatureFlagCopyWithImpl<_FeatureFlag>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeatureFlagToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeatureFlag&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other._conditions, _conditions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,description,enabled,const DeepCollectionEquality().hash(_conditions));

@override
String toString() {
  return 'FeatureFlag(id: $id, description: $description, enabled: $enabled, conditions: $conditions)';
}


}

/// @nodoc
abstract mixin class _$FeatureFlagCopyWith<$Res> implements $FeatureFlagCopyWith<$Res> {
  factory _$FeatureFlagCopyWith(_FeatureFlag value, $Res Function(_FeatureFlag) _then) = __$FeatureFlagCopyWithImpl;
@override @useResult
$Res call({
 String id, String description, bool enabled, Map<String, dynamic> conditions
});




}
/// @nodoc
class __$FeatureFlagCopyWithImpl<$Res>
    implements _$FeatureFlagCopyWith<$Res> {
  __$FeatureFlagCopyWithImpl(this._self, this._then);

  final _FeatureFlag _self;
  final $Res Function(_FeatureFlag) _then;

/// Create a copy of FeatureFlag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? description = null,Object? enabled = null,Object? conditions = null,}) {
  return _then(_FeatureFlag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,conditions: null == conditions ? _self._conditions : conditions // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
