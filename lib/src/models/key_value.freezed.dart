// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'key_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KeyValue {

 String get etag; String get key; bool get locked; Map<String, dynamic> get tags;@JsonKey(name: 'last_modified') String get lastModified; String? get label;@JsonKey(name: 'content_type') String? get contentType; String get value;
/// Create a copy of KeyValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeyValueCopyWith<KeyValue> get copyWith => _$KeyValueCopyWithImpl<KeyValue>(this as KeyValue, _$identity);

  /// Serializes this KeyValue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeyValue&&(identical(other.etag, etag) || other.etag == etag)&&(identical(other.key, key) || other.key == key)&&(identical(other.locked, locked) || other.locked == locked)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.lastModified, lastModified) || other.lastModified == lastModified)&&(identical(other.label, label) || other.label == label)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,etag,key,locked,const DeepCollectionEquality().hash(tags),lastModified,label,contentType,value);

@override
String toString() {
  return 'KeyValue(etag: $etag, key: $key, locked: $locked, tags: $tags, lastModified: $lastModified, label: $label, contentType: $contentType, value: $value)';
}


}

/// @nodoc
abstract mixin class $KeyValueCopyWith<$Res>  {
  factory $KeyValueCopyWith(KeyValue value, $Res Function(KeyValue) _then) = _$KeyValueCopyWithImpl;
@useResult
$Res call({
 String etag, String key, bool locked, Map<String, dynamic> tags,@JsonKey(name: 'last_modified') String lastModified, String? label,@JsonKey(name: 'content_type') String? contentType, String value
});




}
/// @nodoc
class _$KeyValueCopyWithImpl<$Res>
    implements $KeyValueCopyWith<$Res> {
  _$KeyValueCopyWithImpl(this._self, this._then);

  final KeyValue _self;
  final $Res Function(KeyValue) _then;

/// Create a copy of KeyValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? etag = null,Object? key = null,Object? locked = null,Object? tags = null,Object? lastModified = null,Object? label = freezed,Object? contentType = freezed,Object? value = null,}) {
  return _then(_self.copyWith(
etag: null == etag ? _self.etag : etag // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,lastModified: null == lastModified ? _self.lastModified : lastModified // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,contentType: freezed == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String?,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [KeyValue].
extension KeyValuePatterns on KeyValue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KeyValue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KeyValue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KeyValue value)  $default,){
final _that = this;
switch (_that) {
case _KeyValue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KeyValue value)?  $default,){
final _that = this;
switch (_that) {
case _KeyValue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String etag,  String key,  bool locked,  Map<String, dynamic> tags, @JsonKey(name: 'last_modified')  String lastModified,  String? label, @JsonKey(name: 'content_type')  String? contentType,  String value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KeyValue() when $default != null:
return $default(_that.etag,_that.key,_that.locked,_that.tags,_that.lastModified,_that.label,_that.contentType,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String etag,  String key,  bool locked,  Map<String, dynamic> tags, @JsonKey(name: 'last_modified')  String lastModified,  String? label, @JsonKey(name: 'content_type')  String? contentType,  String value)  $default,) {final _that = this;
switch (_that) {
case _KeyValue():
return $default(_that.etag,_that.key,_that.locked,_that.tags,_that.lastModified,_that.label,_that.contentType,_that.value);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String etag,  String key,  bool locked,  Map<String, dynamic> tags, @JsonKey(name: 'last_modified')  String lastModified,  String? label, @JsonKey(name: 'content_type')  String? contentType,  String value)?  $default,) {final _that = this;
switch (_that) {
case _KeyValue() when $default != null:
return $default(_that.etag,_that.key,_that.locked,_that.tags,_that.lastModified,_that.label,_that.contentType,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KeyValue extends KeyValue {
  const _KeyValue({required this.etag, required this.key, required this.locked, required final  Map<String, dynamic> tags, @JsonKey(name: 'last_modified') required this.lastModified, this.label, @JsonKey(name: 'content_type') this.contentType, this.value = ''}): _tags = tags,super._();
  factory _KeyValue.fromJson(Map<String, dynamic> json) => _$KeyValueFromJson(json);

@override final  String etag;
@override final  String key;
@override final  bool locked;
 final  Map<String, dynamic> _tags;
@override Map<String, dynamic> get tags {
  if (_tags is EqualUnmodifiableMapView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_tags);
}

@override@JsonKey(name: 'last_modified') final  String lastModified;
@override final  String? label;
@override@JsonKey(name: 'content_type') final  String? contentType;
@override@JsonKey() final  String value;

/// Create a copy of KeyValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KeyValueCopyWith<_KeyValue> get copyWith => __$KeyValueCopyWithImpl<_KeyValue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KeyValueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KeyValue&&(identical(other.etag, etag) || other.etag == etag)&&(identical(other.key, key) || other.key == key)&&(identical(other.locked, locked) || other.locked == locked)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.lastModified, lastModified) || other.lastModified == lastModified)&&(identical(other.label, label) || other.label == label)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,etag,key,locked,const DeepCollectionEquality().hash(_tags),lastModified,label,contentType,value);

@override
String toString() {
  return 'KeyValue(etag: $etag, key: $key, locked: $locked, tags: $tags, lastModified: $lastModified, label: $label, contentType: $contentType, value: $value)';
}


}

/// @nodoc
abstract mixin class _$KeyValueCopyWith<$Res> implements $KeyValueCopyWith<$Res> {
  factory _$KeyValueCopyWith(_KeyValue value, $Res Function(_KeyValue) _then) = __$KeyValueCopyWithImpl;
@override @useResult
$Res call({
 String etag, String key, bool locked, Map<String, dynamic> tags,@JsonKey(name: 'last_modified') String lastModified, String? label,@JsonKey(name: 'content_type') String? contentType, String value
});




}
/// @nodoc
class __$KeyValueCopyWithImpl<$Res>
    implements _$KeyValueCopyWith<$Res> {
  __$KeyValueCopyWithImpl(this._self, this._then);

  final _KeyValue _self;
  final $Res Function(_KeyValue) _then;

/// Create a copy of KeyValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? etag = null,Object? key = null,Object? locked = null,Object? tags = null,Object? lastModified = null,Object? label = freezed,Object? contentType = freezed,Object? value = null,}) {
  return _then(_KeyValue(
etag: null == etag ? _self.etag : etag // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,lastModified: null == lastModified ? _self.lastModified : lastModified // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,contentType: freezed == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String?,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
