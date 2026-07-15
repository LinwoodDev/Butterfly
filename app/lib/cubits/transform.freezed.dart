// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transform.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FrictionState implements DiagnosticableTreeMixin {

 Offset get beginOffset; double get beginSize; DateTime get lastUpdate; double get duration;
/// Create a copy of FrictionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FrictionStateCopyWith<FrictionState> get copyWith => _$FrictionStateCopyWithImpl<FrictionState>(this as FrictionState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FrictionState'))
    ..add(DiagnosticsProperty('beginOffset', beginOffset))..add(DiagnosticsProperty('beginSize', beginSize))..add(DiagnosticsProperty('lastUpdate', lastUpdate))..add(DiagnosticsProperty('duration', duration));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FrictionState&&(identical(other.beginOffset, beginOffset) || other.beginOffset == beginOffset)&&(identical(other.beginSize, beginSize) || other.beginSize == beginSize)&&(identical(other.lastUpdate, lastUpdate) || other.lastUpdate == lastUpdate)&&(identical(other.duration, duration) || other.duration == duration));
}


@override
int get hashCode => Object.hash(runtimeType,beginOffset,beginSize,lastUpdate,duration);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FrictionState(beginOffset: $beginOffset, beginSize: $beginSize, lastUpdate: $lastUpdate, duration: $duration)';
}


}

/// @nodoc
abstract mixin class $FrictionStateCopyWith<$Res>  {
  factory $FrictionStateCopyWith(FrictionState value, $Res Function(FrictionState) _then) = _$FrictionStateCopyWithImpl;
@useResult
$Res call({
 Offset beginOffset, double beginSize, DateTime lastUpdate, double duration
});




}
/// @nodoc
class _$FrictionStateCopyWithImpl<$Res>
    implements $FrictionStateCopyWith<$Res> {
  _$FrictionStateCopyWithImpl(this._self, this._then);

  final FrictionState _self;
  final $Res Function(FrictionState) _then;

/// Create a copy of FrictionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? beginOffset = null,Object? beginSize = null,Object? lastUpdate = null,Object? duration = null,}) {
  return _then(_self.copyWith(
beginOffset: null == beginOffset ? _self.beginOffset : beginOffset // ignore: cast_nullable_to_non_nullable
as Offset,beginSize: null == beginSize ? _self.beginSize : beginSize // ignore: cast_nullable_to_non_nullable
as double,lastUpdate: null == lastUpdate ? _self.lastUpdate : lastUpdate // ignore: cast_nullable_to_non_nullable
as DateTime,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}



/// @nodoc


class _FrictionState with DiagnosticableTreeMixin implements FrictionState {
  const _FrictionState(this.beginOffset, this.beginSize, this.lastUpdate, this.duration);
  

@override final  Offset beginOffset;
@override final  double beginSize;
@override final  DateTime lastUpdate;
@override final  double duration;

/// Create a copy of FrictionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FrictionStateCopyWith<_FrictionState> get copyWith => __$FrictionStateCopyWithImpl<_FrictionState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FrictionState'))
    ..add(DiagnosticsProperty('beginOffset', beginOffset))..add(DiagnosticsProperty('beginSize', beginSize))..add(DiagnosticsProperty('lastUpdate', lastUpdate))..add(DiagnosticsProperty('duration', duration));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FrictionState&&(identical(other.beginOffset, beginOffset) || other.beginOffset == beginOffset)&&(identical(other.beginSize, beginSize) || other.beginSize == beginSize)&&(identical(other.lastUpdate, lastUpdate) || other.lastUpdate == lastUpdate)&&(identical(other.duration, duration) || other.duration == duration));
}


@override
int get hashCode => Object.hash(runtimeType,beginOffset,beginSize,lastUpdate,duration);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FrictionState(beginOffset: $beginOffset, beginSize: $beginSize, lastUpdate: $lastUpdate, duration: $duration)';
}


}

/// @nodoc
abstract mixin class _$FrictionStateCopyWith<$Res> implements $FrictionStateCopyWith<$Res> {
  factory _$FrictionStateCopyWith(_FrictionState value, $Res Function(_FrictionState) _then) = __$FrictionStateCopyWithImpl;
@override @useResult
$Res call({
 Offset beginOffset, double beginSize, DateTime lastUpdate, double duration
});




}
/// @nodoc
class __$FrictionStateCopyWithImpl<$Res>
    implements _$FrictionStateCopyWith<$Res> {
  __$FrictionStateCopyWithImpl(this._self, this._then);

  final _FrictionState _self;
  final $Res Function(_FrictionState) _then;

/// Create a copy of FrictionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? beginOffset = null,Object? beginSize = null,Object? lastUpdate = null,Object? duration = null,}) {
  return _then(_FrictionState(
null == beginOffset ? _self.beginOffset : beginOffset // ignore: cast_nullable_to_non_nullable
as Offset,null == beginSize ? _self.beginSize : beginSize // ignore: cast_nullable_to_non_nullable
as double,null == lastUpdate ? _self.lastUpdate : lastUpdate // ignore: cast_nullable_to_non_nullable
as DateTime,null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$CameraTransform implements DiagnosticableTreeMixin {

 double get pixelRatio; Offset get position; double get size; double get rotation; FrictionState? get friction;
/// Create a copy of CameraTransform
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CameraTransformCopyWith<CameraTransform> get copyWith => _$CameraTransformCopyWithImpl<CameraTransform>(this as CameraTransform, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CameraTransform'))
    ..add(DiagnosticsProperty('pixelRatio', pixelRatio))..add(DiagnosticsProperty('position', position))..add(DiagnosticsProperty('size', size))..add(DiagnosticsProperty('rotation', rotation))..add(DiagnosticsProperty('friction', friction));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CameraTransform&&(identical(other.pixelRatio, pixelRatio) || other.pixelRatio == pixelRatio)&&(identical(other.position, position) || other.position == position)&&(identical(other.size, size) || other.size == size)&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.friction, friction) || other.friction == friction));
}


@override
int get hashCode => Object.hash(runtimeType,pixelRatio,position,size,rotation,friction);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CameraTransform(pixelRatio: $pixelRatio, position: $position, size: $size, rotation: $rotation, friction: $friction)';
}


}

/// @nodoc
abstract mixin class $CameraTransformCopyWith<$Res>  {
  factory $CameraTransformCopyWith(CameraTransform value, $Res Function(CameraTransform) _then) = _$CameraTransformCopyWithImpl;
@useResult
$Res call({
 double pixelRatio, Offset position, double size, double rotation, FrictionState? friction
});


$FrictionStateCopyWith<$Res>? get friction;

}
/// @nodoc
class _$CameraTransformCopyWithImpl<$Res>
    implements $CameraTransformCopyWith<$Res> {
  _$CameraTransformCopyWithImpl(this._self, this._then);

  final CameraTransform _self;
  final $Res Function(CameraTransform) _then;

/// Create a copy of CameraTransform
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pixelRatio = null,Object? position = null,Object? size = null,Object? rotation = null,Object? friction = freezed,}) {
  return _then(_self.copyWith(
pixelRatio: null == pixelRatio ? _self.pixelRatio : pixelRatio // ignore: cast_nullable_to_non_nullable
as double,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Offset,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as double,rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,friction: freezed == friction ? _self.friction : friction // ignore: cast_nullable_to_non_nullable
as FrictionState?,
  ));
}
/// Create a copy of CameraTransform
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FrictionStateCopyWith<$Res>? get friction {
    if (_self.friction == null) {
    return null;
  }

  return $FrictionStateCopyWith<$Res>(_self.friction!, (value) {
    return _then(_self.copyWith(friction: value));
  });
}
}



/// @nodoc


class _CameraTransform extends CameraTransform with DiagnosticableTreeMixin {
  const _CameraTransform([this.pixelRatio = 1, this.position = Offset.zero, this.size = 1, this.rotation = 0, this.friction]): super._();
  

@override@JsonKey() final  double pixelRatio;
@override@JsonKey() final  Offset position;
@override@JsonKey() final  double size;
@override@JsonKey() final  double rotation;
@override final  FrictionState? friction;

/// Create a copy of CameraTransform
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CameraTransformCopyWith<_CameraTransform> get copyWith => __$CameraTransformCopyWithImpl<_CameraTransform>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CameraTransform'))
    ..add(DiagnosticsProperty('pixelRatio', pixelRatio))..add(DiagnosticsProperty('position', position))..add(DiagnosticsProperty('size', size))..add(DiagnosticsProperty('rotation', rotation))..add(DiagnosticsProperty('friction', friction));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CameraTransform&&(identical(other.pixelRatio, pixelRatio) || other.pixelRatio == pixelRatio)&&(identical(other.position, position) || other.position == position)&&(identical(other.size, size) || other.size == size)&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.friction, friction) || other.friction == friction));
}


@override
int get hashCode => Object.hash(runtimeType,pixelRatio,position,size,rotation,friction);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CameraTransform(pixelRatio: $pixelRatio, position: $position, size: $size, rotation: $rotation, friction: $friction)';
}


}

/// @nodoc
abstract mixin class _$CameraTransformCopyWith<$Res> implements $CameraTransformCopyWith<$Res> {
  factory _$CameraTransformCopyWith(_CameraTransform value, $Res Function(_CameraTransform) _then) = __$CameraTransformCopyWithImpl;
@override @useResult
$Res call({
 double pixelRatio, Offset position, double size, double rotation, FrictionState? friction
});


@override $FrictionStateCopyWith<$Res>? get friction;

}
/// @nodoc
class __$CameraTransformCopyWithImpl<$Res>
    implements _$CameraTransformCopyWith<$Res> {
  __$CameraTransformCopyWithImpl(this._self, this._then);

  final _CameraTransform _self;
  final $Res Function(_CameraTransform) _then;

/// Create a copy of CameraTransform
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pixelRatio = null,Object? position = null,Object? size = null,Object? rotation = null,Object? friction = freezed,}) {
  return _then(_CameraTransform(
null == pixelRatio ? _self.pixelRatio : pixelRatio // ignore: cast_nullable_to_non_nullable
as double,null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Offset,null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as double,null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,freezed == friction ? _self.friction : friction // ignore: cast_nullable_to_non_nullable
as FrictionState?,
  ));
}

/// Create a copy of CameraTransform
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FrictionStateCopyWith<$Res>? get friction {
    if (_self.friction == null) {
    return null;
  }

  return $FrictionStateCopyWith<$Res>(_self.friction!, (value) {
    return _then(_self.copyWith(friction: value));
  });
}
}

// dart format on
