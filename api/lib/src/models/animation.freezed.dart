// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'animation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnimationTrack {

 String get name; Map<int, AnimationKey> get keys; int get duration; int get fps;
/// Create a copy of AnimationTrack
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimationTrackCopyWith<AnimationTrack> get copyWith => _$AnimationTrackCopyWithImpl<AnimationTrack>(this as AnimationTrack, _$identity);

  /// Serializes this AnimationTrack to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimationTrack&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.keys, keys)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.fps, fps) || other.fps == fps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(keys),duration,fps);

@override
String toString() {
  return 'AnimationTrack(name: $name, keys: $keys, duration: $duration, fps: $fps)';
}


}

/// @nodoc
abstract mixin class $AnimationTrackCopyWith<$Res>  {
  factory $AnimationTrackCopyWith(AnimationTrack value, $Res Function(AnimationTrack) _then) = _$AnimationTrackCopyWithImpl;
@useResult
$Res call({
 String name, Map<int, AnimationKey> keys, int duration, int fps
});




}
/// @nodoc
class _$AnimationTrackCopyWithImpl<$Res>
    implements $AnimationTrackCopyWith<$Res> {
  _$AnimationTrackCopyWithImpl(this._self, this._then);

  final AnimationTrack _self;
  final $Res Function(AnimationTrack) _then;

/// Create a copy of AnimationTrack
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? keys = null,Object? duration = null,Object? fps = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,keys: null == keys ? _self.keys : keys // ignore: cast_nullable_to_non_nullable
as Map<int, AnimationKey>,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,fps: null == fps ? _self.fps : fps // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AnimationTrack extends AnimationTrack {
  const _AnimationTrack({this.name = '', final  Map<int, AnimationKey> keys = const <int, AnimationKey>{}, this.duration = 250, this.fps = 24}): _keys = keys,super._();
  factory _AnimationTrack.fromJson(Map<String, dynamic> json) => _$AnimationTrackFromJson(json);

@override@JsonKey() final  String name;
 final  Map<int, AnimationKey> _keys;
@override@JsonKey() Map<int, AnimationKey> get keys {
  if (_keys is EqualUnmodifiableMapView) return _keys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_keys);
}

@override@JsonKey() final  int duration;
@override@JsonKey() final  int fps;

/// Create a copy of AnimationTrack
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnimationTrackCopyWith<_AnimationTrack> get copyWith => __$AnimationTrackCopyWithImpl<_AnimationTrack>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimationTrackToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimationTrack&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._keys, _keys)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.fps, fps) || other.fps == fps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_keys),duration,fps);

@override
String toString() {
  return 'AnimationTrack(name: $name, keys: $keys, duration: $duration, fps: $fps)';
}


}

/// @nodoc
abstract mixin class _$AnimationTrackCopyWith<$Res> implements $AnimationTrackCopyWith<$Res> {
  factory _$AnimationTrackCopyWith(_AnimationTrack value, $Res Function(_AnimationTrack) _then) = __$AnimationTrackCopyWithImpl;
@override @useResult
$Res call({
 String name, Map<int, AnimationKey> keys, int duration, int fps
});




}
/// @nodoc
class __$AnimationTrackCopyWithImpl<$Res>
    implements _$AnimationTrackCopyWith<$Res> {
  __$AnimationTrackCopyWithImpl(this._self, this._then);

  final _AnimationTrack _self;
  final $Res Function(_AnimationTrack) _then;

/// Create a copy of AnimationTrack
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? keys = null,Object? duration = null,Object? fps = null,}) {
  return _then(_AnimationTrack(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,keys: null == keys ? _self._keys : keys // ignore: cast_nullable_to_non_nullable
as Map<int, AnimationKey>,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,fps: null == fps ? _self.fps : fps // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AnimationKey {

@DoublePointJsonConverter() Point<double>? get cameraPosition; double? get cameraZoom; bool get breakpoint;
/// Create a copy of AnimationKey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimationKeyCopyWith<AnimationKey> get copyWith => _$AnimationKeyCopyWithImpl<AnimationKey>(this as AnimationKey, _$identity);

  /// Serializes this AnimationKey to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimationKey&&(identical(other.cameraPosition, cameraPosition) || other.cameraPosition == cameraPosition)&&(identical(other.cameraZoom, cameraZoom) || other.cameraZoom == cameraZoom)&&(identical(other.breakpoint, breakpoint) || other.breakpoint == breakpoint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cameraPosition,cameraZoom,breakpoint);

@override
String toString() {
  return 'AnimationKey(cameraPosition: $cameraPosition, cameraZoom: $cameraZoom, breakpoint: $breakpoint)';
}


}

/// @nodoc
abstract mixin class $AnimationKeyCopyWith<$Res>  {
  factory $AnimationKeyCopyWith(AnimationKey value, $Res Function(AnimationKey) _then) = _$AnimationKeyCopyWithImpl;
@useResult
$Res call({
@DoublePointJsonConverter() Point<double>? cameraPosition, double? cameraZoom, bool breakpoint
});




}
/// @nodoc
class _$AnimationKeyCopyWithImpl<$Res>
    implements $AnimationKeyCopyWith<$Res> {
  _$AnimationKeyCopyWithImpl(this._self, this._then);

  final AnimationKey _self;
  final $Res Function(AnimationKey) _then;

/// Create a copy of AnimationKey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cameraPosition = freezed,Object? cameraZoom = freezed,Object? breakpoint = null,}) {
  return _then(_self.copyWith(
cameraPosition: freezed == cameraPosition ? _self.cameraPosition : cameraPosition // ignore: cast_nullable_to_non_nullable
as Point<double>?,cameraZoom: freezed == cameraZoom ? _self.cameraZoom : cameraZoom // ignore: cast_nullable_to_non_nullable
as double?,breakpoint: null == breakpoint ? _self.breakpoint : breakpoint // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AnimationKey extends AnimationKey {
  const _AnimationKey({@DoublePointJsonConverter() this.cameraPosition, this.cameraZoom, this.breakpoint = false}): super._();
  factory _AnimationKey.fromJson(Map<String, dynamic> json) => _$AnimationKeyFromJson(json);

@override@DoublePointJsonConverter() final  Point<double>? cameraPosition;
@override final  double? cameraZoom;
@override@JsonKey() final  bool breakpoint;

/// Create a copy of AnimationKey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnimationKeyCopyWith<_AnimationKey> get copyWith => __$AnimationKeyCopyWithImpl<_AnimationKey>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimationKeyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimationKey&&(identical(other.cameraPosition, cameraPosition) || other.cameraPosition == cameraPosition)&&(identical(other.cameraZoom, cameraZoom) || other.cameraZoom == cameraZoom)&&(identical(other.breakpoint, breakpoint) || other.breakpoint == breakpoint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cameraPosition,cameraZoom,breakpoint);

@override
String toString() {
  return 'AnimationKey(cameraPosition: $cameraPosition, cameraZoom: $cameraZoom, breakpoint: $breakpoint)';
}


}

/// @nodoc
abstract mixin class _$AnimationKeyCopyWith<$Res> implements $AnimationKeyCopyWith<$Res> {
  factory _$AnimationKeyCopyWith(_AnimationKey value, $Res Function(_AnimationKey) _then) = __$AnimationKeyCopyWithImpl;
@override @useResult
$Res call({
@DoublePointJsonConverter() Point<double>? cameraPosition, double? cameraZoom, bool breakpoint
});




}
/// @nodoc
class __$AnimationKeyCopyWithImpl<$Res>
    implements _$AnimationKeyCopyWith<$Res> {
  __$AnimationKeyCopyWithImpl(this._self, this._then);

  final _AnimationKey _self;
  final $Res Function(_AnimationKey) _then;

/// Create a copy of AnimationKey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cameraPosition = freezed,Object? cameraZoom = freezed,Object? breakpoint = null,}) {
  return _then(_AnimationKey(
cameraPosition: freezed == cameraPosition ? _self.cameraPosition : cameraPosition // ignore: cast_nullable_to_non_nullable
as Point<double>?,cameraZoom: freezed == cameraZoom ? _self.cameraZoom : cameraZoom // ignore: cast_nullable_to_non_nullable
as double?,breakpoint: null == breakpoint ? _self.breakpoint : breakpoint // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
