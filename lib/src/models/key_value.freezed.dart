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
  @JsonKey(name: 'content_type')
  String? get contentType => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  Map<String, dynamic> get tags => throw _privateConstructorUsedError;
  bool get locked => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_modified')
  String get lastModified => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'content_type') String? contentType,
      String value,
      Map<String, dynamic> tags,
      bool locked,
      @JsonKey(name: 'last_modified') String lastModified});
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
    Object? contentType = freezed,
    Object? value = null,
    Object? tags = null,
    Object? locked = null,
    Object? lastModified = null,
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
      contentType: freezed == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      locked: null == locked
          ? _value.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      lastModified: null == lastModified
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
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
      @JsonKey(name: 'content_type') String? contentType,
      String value,
      Map<String, dynamic> tags,
      bool locked,
      @JsonKey(name: 'last_modified') String lastModified});
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
    Object? contentType = freezed,
    Object? value = null,
    Object? tags = null,
    Object? locked = null,
    Object? lastModified = null,
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
      contentType: freezed == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      locked: null == locked
          ? _value.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      lastModified: null == lastModified
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
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
      @JsonKey(name: 'content_type') this.contentType,
      this.value = '',
      required final Map<String, dynamic> tags,
      required this.locked,
      @JsonKey(name: 'last_modified') required this.lastModified})
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
  @JsonKey(name: 'content_type')
  final String? contentType;
  @override
  @JsonKey()
  final String value;
  final Map<String, dynamic> _tags;
  @override
  Map<String, dynamic> get tags {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_tags);
  }

  @override
  final bool locked;
  @override
  @JsonKey(name: 'last_modified')
  final String lastModified;

  @override
  String toString() {
    return 'KeyValue(etag: $etag, key: $key, label: $label, contentType: $contentType, value: $value, tags: $tags, locked: $locked, lastModified: $lastModified)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_KeyValue &&
            (identical(other.etag, etag) || other.etag == etag) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.locked, locked) || other.locked == locked) &&
            (identical(other.lastModified, lastModified) ||
                other.lastModified == lastModified));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, etag, key, label, contentType,
      value, const DeepCollectionEquality().hash(_tags), locked, lastModified);

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
          @JsonKey(name: 'content_type') final String? contentType,
          final String value,
          required final Map<String, dynamic> tags,
          required final bool locked,
          @JsonKey(name: 'last_modified') required final String lastModified}) =
      _$_KeyValue;
  const _KeyValue._() : super._();

  factory _KeyValue.fromJson(Map<String, dynamic> json) = _$_KeyValue.fromJson;

  @override
  String get etag;
  @override
  String get key;
  @override
  String? get label;
  @override
  @JsonKey(name: 'content_type')
  String? get contentType;
  @override
  String get value;
  @override
  Map<String, dynamic> get tags;
  @override
  bool get locked;
  @override
  @JsonKey(name: 'last_modified')
  String get lastModified;
  @override
  @JsonKey(ignore: true)
  _$$_KeyValueCopyWith<_$_KeyValue> get copyWith =>
      throw _privateConstructorUsedError;
}
