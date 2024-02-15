// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'animation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AnimationTrack _$AnimationTrackFromJson(Map<String, dynamic> json) {
  return _AnimationTrack.fromJson(json);
}

/// @nodoc
mixin _$AnimationTrack {
  String get name => throw _privateConstructorUsedError;
  Map<int, AnimationKey> get keys => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  int get fps => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnimationTrackCopyWith<AnimationTrack> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnimationTrackCopyWith<$Res> {
  factory $AnimationTrackCopyWith(
          AnimationTrack value, $Res Function(AnimationTrack) then) =
      _$AnimationTrackCopyWithImpl<$Res, AnimationTrack>;
  @useResult
  $Res call({String name, Map<int, AnimationKey> keys, int duration, int fps});
}

/// @nodoc
class _$AnimationTrackCopyWithImpl<$Res, $Val extends AnimationTrack>
    implements $AnimationTrackCopyWith<$Res> {
  _$AnimationTrackCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? keys = null,
    Object? duration = null,
    Object? fps = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      keys: null == keys
          ? _value.keys
          : keys // ignore: cast_nullable_to_non_nullable
              as Map<int, AnimationKey>,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      fps: null == fps
          ? _value.fps
          : fps // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnimationTrackImplCopyWith<$Res>
    implements $AnimationTrackCopyWith<$Res> {
  factory _$$AnimationTrackImplCopyWith(_$AnimationTrackImpl value,
          $Res Function(_$AnimationTrackImpl) then) =
      __$$AnimationTrackImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, Map<int, AnimationKey> keys, int duration, int fps});
}

/// @nodoc
class __$$AnimationTrackImplCopyWithImpl<$Res>
    extends _$AnimationTrackCopyWithImpl<$Res, _$AnimationTrackImpl>
    implements _$$AnimationTrackImplCopyWith<$Res> {
  __$$AnimationTrackImplCopyWithImpl(
      _$AnimationTrackImpl _value, $Res Function(_$AnimationTrackImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? keys = null,
    Object? duration = null,
    Object? fps = null,
  }) {
    return _then(_$AnimationTrackImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      keys: null == keys
          ? _value._keys
          : keys // ignore: cast_nullable_to_non_nullable
              as Map<int, AnimationKey>,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      fps: null == fps
          ? _value.fps
          : fps // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnimationTrackImpl extends _AnimationTrack {
  const _$AnimationTrackImpl(
      {this.name = '',
      final Map<int, AnimationKey> keys = const <int, AnimationKey>{},
      this.duration = 250,
      this.fps = 24})
      : _keys = keys,
        super._();

  factory _$AnimationTrackImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnimationTrackImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  final Map<int, AnimationKey> _keys;
  @override
  @JsonKey()
  Map<int, AnimationKey> get keys {
    if (_keys is EqualUnmodifiableMapView) return _keys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_keys);
  }

  @override
  @JsonKey()
  final int duration;
  @override
  @JsonKey()
  final int fps;

  @override
  String toString() {
    return 'AnimationTrack(name: $name, keys: $keys, duration: $duration, fps: $fps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnimationTrackImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._keys, _keys) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.fps, fps) || other.fps == fps));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name,
      const DeepCollectionEquality().hash(_keys), duration, fps);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnimationTrackImplCopyWith<_$AnimationTrackImpl> get copyWith =>
      __$$AnimationTrackImplCopyWithImpl<_$AnimationTrackImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnimationTrackImplToJson(
      this,
    );
  }
}

abstract class _AnimationTrack extends AnimationTrack {
  const factory _AnimationTrack(
      {final String name,
      final Map<int, AnimationKey> keys,
      final int duration,
      final int fps}) = _$AnimationTrackImpl;
  const _AnimationTrack._() : super._();

  factory _AnimationTrack.fromJson(Map<String, dynamic> json) =
      _$AnimationTrackImpl.fromJson;

  @override
  String get name;
  @override
  Map<int, AnimationKey> get keys;
  @override
  int get duration;
  @override
  int get fps;
  @override
  @JsonKey(ignore: true)
  _$$AnimationTrackImplCopyWith<_$AnimationTrackImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnimationKey _$AnimationKeyFromJson(Map<String, dynamic> json) {
  return _AnimationKey.fromJson(json);
}

/// @nodoc
mixin _$AnimationKey {
  @DoublePointJsonConverter()
  Point<double>? get cameraPosition => throw _privateConstructorUsedError;
  double? get cameraZoom => throw _privateConstructorUsedError;
  bool get breakpoint => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnimationKeyCopyWith<AnimationKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnimationKeyCopyWith<$Res> {
  factory $AnimationKeyCopyWith(
          AnimationKey value, $Res Function(AnimationKey) then) =
      _$AnimationKeyCopyWithImpl<$Res, AnimationKey>;
  @useResult
  $Res call(
      {@DoublePointJsonConverter() Point<double>? cameraPosition,
      double? cameraZoom,
      bool breakpoint});
}

/// @nodoc
class _$AnimationKeyCopyWithImpl<$Res, $Val extends AnimationKey>
    implements $AnimationKeyCopyWith<$Res> {
  _$AnimationKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cameraPosition = freezed,
    Object? cameraZoom = freezed,
    Object? breakpoint = null,
  }) {
    return _then(_value.copyWith(
      cameraPosition: freezed == cameraPosition
          ? _value.cameraPosition
          : cameraPosition // ignore: cast_nullable_to_non_nullable
              as Point<double>?,
      cameraZoom: freezed == cameraZoom
          ? _value.cameraZoom
          : cameraZoom // ignore: cast_nullable_to_non_nullable
              as double?,
      breakpoint: null == breakpoint
          ? _value.breakpoint
          : breakpoint // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnimationKeyImplCopyWith<$Res>
    implements $AnimationKeyCopyWith<$Res> {
  factory _$$AnimationKeyImplCopyWith(
          _$AnimationKeyImpl value, $Res Function(_$AnimationKeyImpl) then) =
      __$$AnimationKeyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@DoublePointJsonConverter() Point<double>? cameraPosition,
      double? cameraZoom,
      bool breakpoint});
}

/// @nodoc
class __$$AnimationKeyImplCopyWithImpl<$Res>
    extends _$AnimationKeyCopyWithImpl<$Res, _$AnimationKeyImpl>
    implements _$$AnimationKeyImplCopyWith<$Res> {
  __$$AnimationKeyImplCopyWithImpl(
      _$AnimationKeyImpl _value, $Res Function(_$AnimationKeyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cameraPosition = freezed,
    Object? cameraZoom = freezed,
    Object? breakpoint = null,
  }) {
    return _then(_$AnimationKeyImpl(
      cameraPosition: freezed == cameraPosition
          ? _value.cameraPosition
          : cameraPosition // ignore: cast_nullable_to_non_nullable
              as Point<double>?,
      cameraZoom: freezed == cameraZoom
          ? _value.cameraZoom
          : cameraZoom // ignore: cast_nullable_to_non_nullable
              as double?,
      breakpoint: null == breakpoint
          ? _value.breakpoint
          : breakpoint // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnimationKeyImpl extends _AnimationKey {
  const _$AnimationKeyImpl(
      {@DoublePointJsonConverter() this.cameraPosition,
      this.cameraZoom,
      this.breakpoint = false})
      : super._();

  factory _$AnimationKeyImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnimationKeyImplFromJson(json);

  @override
  @DoublePointJsonConverter()
  final Point<double>? cameraPosition;
  @override
  final double? cameraZoom;
  @override
  @JsonKey()
  final bool breakpoint;

  @override
  String toString() {
    return 'AnimationKey(cameraPosition: $cameraPosition, cameraZoom: $cameraZoom, breakpoint: $breakpoint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnimationKeyImpl &&
            (identical(other.cameraPosition, cameraPosition) ||
                other.cameraPosition == cameraPosition) &&
            (identical(other.cameraZoom, cameraZoom) ||
                other.cameraZoom == cameraZoom) &&
            (identical(other.breakpoint, breakpoint) ||
                other.breakpoint == breakpoint));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, cameraPosition, cameraZoom, breakpoint);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnimationKeyImplCopyWith<_$AnimationKeyImpl> get copyWith =>
      __$$AnimationKeyImplCopyWithImpl<_$AnimationKeyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnimationKeyImplToJson(
      this,
    );
  }
}

abstract class _AnimationKey extends AnimationKey {
  const factory _AnimationKey(
      {@DoublePointJsonConverter() final Point<double>? cameraPosition,
      final double? cameraZoom,
      final bool breakpoint}) = _$AnimationKeyImpl;
  const _AnimationKey._() : super._();

  factory _AnimationKey.fromJson(Map<String, dynamic> json) =
      _$AnimationKeyImpl.fromJson;

  @override
  @DoublePointJsonConverter()
  Point<double>? get cameraPosition;
  @override
  double? get cameraZoom;
  @override
  bool get breakpoint;
  @override
  @JsonKey(ignore: true)
  _$$AnimationKeyImplCopyWith<_$AnimationKeyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
