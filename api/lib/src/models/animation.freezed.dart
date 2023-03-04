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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_AnimationTrackCopyWith<$Res>
    implements $AnimationTrackCopyWith<$Res> {
  factory _$$_AnimationTrackCopyWith(
          _$_AnimationTrack value, $Res Function(_$_AnimationTrack) then) =
      __$$_AnimationTrackCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, Map<int, AnimationKey> keys, int duration, int fps});
}

/// @nodoc
class __$$_AnimationTrackCopyWithImpl<$Res>
    extends _$AnimationTrackCopyWithImpl<$Res, _$_AnimationTrack>
    implements _$$_AnimationTrackCopyWith<$Res> {
  __$$_AnimationTrackCopyWithImpl(
      _$_AnimationTrack _value, $Res Function(_$_AnimationTrack) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? keys = null,
    Object? duration = null,
    Object? fps = null,
  }) {
    return _then(_$_AnimationTrack(
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
class _$_AnimationTrack extends _AnimationTrack {
  const _$_AnimationTrack(
      {this.name = '',
      final Map<int, AnimationKey> keys = const <int, AnimationKey>{},
      this.duration = 250,
      this.fps = 24})
      : _keys = keys,
        super._();

  factory _$_AnimationTrack.fromJson(Map<String, dynamic> json) =>
      _$$_AnimationTrackFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AnimationTrack &&
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
  _$$_AnimationTrackCopyWith<_$_AnimationTrack> get copyWith =>
      __$$_AnimationTrackCopyWithImpl<_$_AnimationTrack>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AnimationTrackToJson(
      this,
    );
  }
}

abstract class _AnimationTrack extends AnimationTrack {
  const factory _AnimationTrack(
      {final String name,
      final Map<int, AnimationKey> keys,
      final int duration,
      final int fps}) = _$_AnimationTrack;
  const _AnimationTrack._() : super._();

  factory _AnimationTrack.fromJson(Map<String, dynamic> json) =
      _$_AnimationTrack.fromJson;

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
  _$$_AnimationTrackCopyWith<_$_AnimationTrack> get copyWith =>
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
  bool get breakPoint => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @DoublePointJsonConverter() Point<double>? cameraPosition,
            double? cameraZoom,
            bool breakPoint)
        camera,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(@DoublePointJsonConverter() Point<double>? cameraPosition,
            double? cameraZoom, bool breakPoint)?
        camera,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(@DoublePointJsonConverter() Point<double>? cameraPosition,
            double? cameraZoom, bool breakPoint)?
        camera,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AnimationKey value) camera,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AnimationKey value)? camera,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AnimationKey value)? camera,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
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
      bool breakPoint});
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
    Object? breakPoint = null,
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
      breakPoint: null == breakPoint
          ? _value.breakPoint
          : breakPoint // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AnimationKeyCopyWith<$Res>
    implements $AnimationKeyCopyWith<$Res> {
  factory _$$_AnimationKeyCopyWith(
          _$_AnimationKey value, $Res Function(_$_AnimationKey) then) =
      __$$_AnimationKeyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@DoublePointJsonConverter() Point<double>? cameraPosition,
      double? cameraZoom,
      bool breakPoint});
}

/// @nodoc
class __$$_AnimationKeyCopyWithImpl<$Res>
    extends _$AnimationKeyCopyWithImpl<$Res, _$_AnimationKey>
    implements _$$_AnimationKeyCopyWith<$Res> {
  __$$_AnimationKeyCopyWithImpl(
      _$_AnimationKey _value, $Res Function(_$_AnimationKey) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cameraPosition = freezed,
    Object? cameraZoom = freezed,
    Object? breakPoint = null,
  }) {
    return _then(_$_AnimationKey(
      cameraPosition: freezed == cameraPosition
          ? _value.cameraPosition
          : cameraPosition // ignore: cast_nullable_to_non_nullable
              as Point<double>?,
      cameraZoom: freezed == cameraZoom
          ? _value.cameraZoom
          : cameraZoom // ignore: cast_nullable_to_non_nullable
              as double?,
      breakPoint: null == breakPoint
          ? _value.breakPoint
          : breakPoint // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AnimationKey extends _AnimationKey {
  const _$_AnimationKey(
      {@DoublePointJsonConverter() this.cameraPosition,
      this.cameraZoom,
      this.breakPoint = false})
      : super._();

  factory _$_AnimationKey.fromJson(Map<String, dynamic> json) =>
      _$$_AnimationKeyFromJson(json);

  @override
  @DoublePointJsonConverter()
  final Point<double>? cameraPosition;
  @override
  final double? cameraZoom;
  @override
  @JsonKey()
  final bool breakPoint;

  @override
  String toString() {
    return 'AnimationKey.camera(cameraPosition: $cameraPosition, cameraZoom: $cameraZoom, breakPoint: $breakPoint)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AnimationKey &&
            (identical(other.cameraPosition, cameraPosition) ||
                other.cameraPosition == cameraPosition) &&
            (identical(other.cameraZoom, cameraZoom) ||
                other.cameraZoom == cameraZoom) &&
            (identical(other.breakPoint, breakPoint) ||
                other.breakPoint == breakPoint));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, cameraPosition, cameraZoom, breakPoint);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AnimationKeyCopyWith<_$_AnimationKey> get copyWith =>
      __$$_AnimationKeyCopyWithImpl<_$_AnimationKey>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @DoublePointJsonConverter() Point<double>? cameraPosition,
            double? cameraZoom,
            bool breakPoint)
        camera,
  }) {
    return camera(cameraPosition, cameraZoom, breakPoint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(@DoublePointJsonConverter() Point<double>? cameraPosition,
            double? cameraZoom, bool breakPoint)?
        camera,
  }) {
    return camera?.call(cameraPosition, cameraZoom, breakPoint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(@DoublePointJsonConverter() Point<double>? cameraPosition,
            double? cameraZoom, bool breakPoint)?
        camera,
    required TResult orElse(),
  }) {
    if (camera != null) {
      return camera(cameraPosition, cameraZoom, breakPoint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AnimationKey value) camera,
  }) {
    return camera(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AnimationKey value)? camera,
  }) {
    return camera?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AnimationKey value)? camera,
    required TResult orElse(),
  }) {
    if (camera != null) {
      return camera(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_AnimationKeyToJson(
      this,
    );
  }
}

abstract class _AnimationKey extends AnimationKey {
  const factory _AnimationKey(
      {@DoublePointJsonConverter() final Point<double>? cameraPosition,
      final double? cameraZoom,
      final bool breakPoint}) = _$_AnimationKey;
  const _AnimationKey._() : super._();

  factory _AnimationKey.fromJson(Map<String, dynamic> json) =
      _$_AnimationKey.fromJson;

  @override
  @DoublePointJsonConverter()
  Point<double>? get cameraPosition;
  @override
  double? get cameraZoom;
  @override
  bool get breakPoint;
  @override
  @JsonKey(ignore: true)
  _$$_AnimationKeyCopyWith<_$_AnimationKey> get copyWith =>
      throw _privateConstructorUsedError;
}
