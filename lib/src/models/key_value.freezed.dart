// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'key_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

KeyValue _$KeyValueFromJson(Map<String, dynamic> json) {
  return _KeyValue.fromJson(json);
}

/// @nodoc
mixin _$KeyValue {
  String get etag => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  String? get content_type => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;
  Map<String, dynamic> get tags => throw _privateConstructorUsedError;
  bool get locked => throw _privateConstructorUsedError;
  String get last_modified => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KeyValueCopyWith<KeyValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyValueCopyWith<$Res> {
  factory $KeyValueCopyWith(KeyValue value, $Res Function(KeyValue) then) =
      _$KeyValueCopyWithImpl<$Res, KeyValue>;
  @useResult
  $Res call(
      {String etag,
      String key,
      String? label,
      String? content_type,
      String? value,
      Map<String, dynamic> tags,
      bool locked,
      String last_modified});
}

/// @nodoc
class _$KeyValueCopyWithImpl<$Res, $Val extends KeyValue>
    implements $KeyValueCopyWith<$Res> {
  _$KeyValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? etag = null,
    Object? key = null,
    Object? label = freezed,
    Object? content_type = freezed,
    Object? value = freezed,
    Object? tags = null,
    Object? locked = null,
    Object? last_modified = null,
  }) {
    return _then(_value.copyWith(
      etag: null == etag
          ? _value.etag
          : etag // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      content_type: freezed == content_type
          ? _value.content_type
          : content_type // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      locked: null == locked
          ? _value.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      last_modified: null == last_modified
          ? _value.last_modified
          : last_modified // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_KeyValueCopyWith<$Res> implements $KeyValueCopyWith<$Res> {
  factory _$$_KeyValueCopyWith(
          _$_KeyValue value, $Res Function(_$_KeyValue) then) =
      __$$_KeyValueCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String etag,
      String key,
      String? label,
      String? content_type,
      String? value,
      Map<String, dynamic> tags,
      bool locked,
      String last_modified});
}

/// @nodoc
class __$$_KeyValueCopyWithImpl<$Res>
    extends _$KeyValueCopyWithImpl<$Res, _$_KeyValue>
    implements _$$_KeyValueCopyWith<$Res> {
  __$$_KeyValueCopyWithImpl(
      _$_KeyValue _value, $Res Function(_$_KeyValue) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? etag = null,
    Object? key = null,
    Object? label = freezed,
    Object? content_type = freezed,
    Object? value = freezed,
    Object? tags = null,
    Object? locked = null,
    Object? last_modified = null,
  }) {
    return _then(_$_KeyValue(
      etag: null == etag
          ? _value.etag
          : etag // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      content_type: freezed == content_type
          ? _value.content_type
          : content_type // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      locked: null == locked
          ? _value.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      last_modified: null == last_modified
          ? _value.last_modified
          : last_modified // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_KeyValue extends _KeyValue {
  const _$_KeyValue(
      {required this.etag,
      required this.key,
      this.label,
      this.content_type,
      this.value,
      required final Map<String, dynamic> tags,
      required this.locked,
      required this.last_modified})
      : _tags = tags,
        super._();

  factory _$_KeyValue.fromJson(Map<String, dynamic> json) =>
      _$$_KeyValueFromJson(json);

  @override
  final String etag;
  @override
  final String key;
  @override
  final String? label;
  @override
  final String? content_type;
  @override
  final String? value;
  final Map<String, dynamic> _tags;
  @override
  Map<String, dynamic> get tags {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_tags);
  }

  @override
  final bool locked;
  @override
  final String last_modified;

  @override
  String toString() {
    return 'KeyValue(etag: $etag, key: $key, label: $label, content_type: $content_type, value: $value, tags: $tags, locked: $locked, last_modified: $last_modified)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_KeyValue &&
            (identical(other.etag, etag) || other.etag == etag) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.content_type, content_type) ||
                other.content_type == content_type) &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.locked, locked) || other.locked == locked) &&
            (identical(other.last_modified, last_modified) ||
                other.last_modified == last_modified));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, etag, key, label, content_type,
      value, const DeepCollectionEquality().hash(_tags), locked, last_modified);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_KeyValueCopyWith<_$_KeyValue> get copyWith =>
      __$$_KeyValueCopyWithImpl<_$_KeyValue>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_KeyValueToJson(
      this,
    );
  }
}

abstract class _KeyValue extends KeyValue {
  const factory _KeyValue(
      {required final String etag,
      required final String key,
      final String? label,
      final String? content_type,
      final String? value,
      required final Map<String, dynamic> tags,
      required final bool locked,
      required final String last_modified}) = _$_KeyValue;
  const _KeyValue._() : super._();

  factory _KeyValue.fromJson(Map<String, dynamic> json) = _$_KeyValue.fromJson;

  @override
  String get etag;
  @override
  String get key;
  @override
  String? get label;
  @override
  String? get content_type;
  @override
  String? get value;
  @override
  Map<String, dynamic> get tags;
  @override
  bool get locked;
  @override
  String get last_modified;
  @override
  @JsonKey(ignore: true)
  _$$_KeyValueCopyWith<_$_KeyValue> get copyWith =>
      throw _privateConstructorUsedError;
}
