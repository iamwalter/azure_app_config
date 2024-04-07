// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'key_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KeyValue _$KeyValueFromJson(Map<String, dynamic> json) {
  return _KeyValue.fromJson(json);
}

/// @nodoc
mixin _$KeyValue {
  String get etag => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  bool get locked => throw _privateConstructorUsedError;
  Map<String, dynamic> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_modified')
  String get lastModified => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  @JsonKey(name: 'content_type')
  String? get contentType => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

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
      bool locked,
      Map<String, dynamic> tags,
      @JsonKey(name: 'last_modified') String lastModified,
      String? label,
      @JsonKey(name: 'content_type') String? contentType,
      String value});
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
    Object? locked = null,
    Object? tags = null,
    Object? lastModified = null,
    Object? label = freezed,
    Object? contentType = freezed,
    Object? value = null,
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
      locked: null == locked
          ? _value.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      lastModified: null == lastModified
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KeyValueImplCopyWith<$Res>
    implements $KeyValueCopyWith<$Res> {
  factory _$$KeyValueImplCopyWith(
          _$KeyValueImpl value, $Res Function(_$KeyValueImpl) then) =
      __$$KeyValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String etag,
      String key,
      bool locked,
      Map<String, dynamic> tags,
      @JsonKey(name: 'last_modified') String lastModified,
      String? label,
      @JsonKey(name: 'content_type') String? contentType,
      String value});
}

/// @nodoc
class __$$KeyValueImplCopyWithImpl<$Res>
    extends _$KeyValueCopyWithImpl<$Res, _$KeyValueImpl>
    implements _$$KeyValueImplCopyWith<$Res> {
  __$$KeyValueImplCopyWithImpl(
      _$KeyValueImpl _value, $Res Function(_$KeyValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? etag = null,
    Object? key = null,
    Object? locked = null,
    Object? tags = null,
    Object? lastModified = null,
    Object? label = freezed,
    Object? contentType = freezed,
    Object? value = null,
  }) {
    return _then(_$KeyValueImpl(
      etag: null == etag
          ? _value.etag
          : etag // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      locked: null == locked
          ? _value.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      lastModified: null == lastModified
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KeyValueImpl extends _KeyValue {
  const _$KeyValueImpl(
      {required this.etag,
      required this.key,
      required this.locked,
      required final Map<String, dynamic> tags,
      @JsonKey(name: 'last_modified') required this.lastModified,
      this.label,
      @JsonKey(name: 'content_type') this.contentType,
      this.value = ''})
      : _tags = tags,
        super._();

  factory _$KeyValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$KeyValueImplFromJson(json);

  @override
  final String etag;
  @override
  final String key;
  @override
  final bool locked;
  final Map<String, dynamic> _tags;
  @override
  Map<String, dynamic> get tags {
    if (_tags is EqualUnmodifiableMapView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_tags);
  }

  @override
  @JsonKey(name: 'last_modified')
  final String lastModified;
  @override
  final String? label;
  @override
  @JsonKey(name: 'content_type')
  final String? contentType;
  @override
  @JsonKey()
  final String value;

  @override
  String toString() {
    return 'KeyValue(etag: $etag, key: $key, locked: $locked, tags: $tags, lastModified: $lastModified, label: $label, contentType: $contentType, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeyValueImpl &&
            (identical(other.etag, etag) || other.etag == etag) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.locked, locked) || other.locked == locked) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.lastModified, lastModified) ||
                other.lastModified == lastModified) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      etag,
      key,
      locked,
      const DeepCollectionEquality().hash(_tags),
      lastModified,
      label,
      contentType,
      value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KeyValueImplCopyWith<_$KeyValueImpl> get copyWith =>
      __$$KeyValueImplCopyWithImpl<_$KeyValueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KeyValueImplToJson(
      this,
    );
  }
}

abstract class _KeyValue extends KeyValue {
  const factory _KeyValue(
      {required final String etag,
      required final String key,
      required final bool locked,
      required final Map<String, dynamic> tags,
      @JsonKey(name: 'last_modified') required final String lastModified,
      final String? label,
      @JsonKey(name: 'content_type') final String? contentType,
      final String value}) = _$KeyValueImpl;
  const _KeyValue._() : super._();

  factory _KeyValue.fromJson(Map<String, dynamic> json) =
      _$KeyValueImpl.fromJson;

  @override
  String get etag;
  @override
  String get key;
  @override
  bool get locked;
  @override
  Map<String, dynamic> get tags;
  @override
  @JsonKey(name: 'last_modified')
  String get lastModified;
  @override
  String? get label;
  @override
  @JsonKey(name: 'content_type')
  String? get contentType;
  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$KeyValueImplCopyWith<_$KeyValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
