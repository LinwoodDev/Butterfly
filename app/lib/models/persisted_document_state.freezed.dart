// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'persisted_document_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PersistedToolSelection {

 String? get toolId; int? get toolIndex;
/// Create a copy of PersistedToolSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersistedToolSelectionCopyWith<PersistedToolSelection> get copyWith => _$PersistedToolSelectionCopyWithImpl<PersistedToolSelection>(this as PersistedToolSelection, _$identity);

  /// Serializes this PersistedToolSelection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersistedToolSelection&&(identical(other.toolId, toolId) || other.toolId == toolId)&&(identical(other.toolIndex, toolIndex) || other.toolIndex == toolIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,toolId,toolIndex);

@override
String toString() {
  return 'PersistedToolSelection(toolId: $toolId, toolIndex: $toolIndex)';
}


}

/// @nodoc
abstract mixin class $PersistedToolSelectionCopyWith<$Res>  {
  factory $PersistedToolSelectionCopyWith(PersistedToolSelection value, $Res Function(PersistedToolSelection) _then) = _$PersistedToolSelectionCopyWithImpl;
@useResult
$Res call({
 String? toolId, int? toolIndex
});




}
/// @nodoc
class _$PersistedToolSelectionCopyWithImpl<$Res>
    implements $PersistedToolSelectionCopyWith<$Res> {
  _$PersistedToolSelectionCopyWithImpl(this._self, this._then);

  final PersistedToolSelection _self;
  final $Res Function(PersistedToolSelection) _then;

/// Create a copy of PersistedToolSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? toolId = freezed,Object? toolIndex = freezed,}) {
  return _then(_self.copyWith(
toolId: freezed == toolId ? _self.toolId : toolId // ignore: cast_nullable_to_non_nullable
as String?,toolIndex: freezed == toolIndex ? _self.toolIndex : toolIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _PersistedToolSelection implements PersistedToolSelection {
  const _PersistedToolSelection({this.toolId, this.toolIndex});
  factory _PersistedToolSelection.fromJson(Map<String, dynamic> json) => _$PersistedToolSelectionFromJson(json);

@override final  String? toolId;
@override final  int? toolIndex;

/// Create a copy of PersistedToolSelection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersistedToolSelectionCopyWith<_PersistedToolSelection> get copyWith => __$PersistedToolSelectionCopyWithImpl<_PersistedToolSelection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersistedToolSelectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersistedToolSelection&&(identical(other.toolId, toolId) || other.toolId == toolId)&&(identical(other.toolIndex, toolIndex) || other.toolIndex == toolIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,toolId,toolIndex);

@override
String toString() {
  return 'PersistedToolSelection(toolId: $toolId, toolIndex: $toolIndex)';
}


}

/// @nodoc
abstract mixin class _$PersistedToolSelectionCopyWith<$Res> implements $PersistedToolSelectionCopyWith<$Res> {
  factory _$PersistedToolSelectionCopyWith(_PersistedToolSelection value, $Res Function(_PersistedToolSelection) _then) = __$PersistedToolSelectionCopyWithImpl;
@override @useResult
$Res call({
 String? toolId, int? toolIndex
});




}
/// @nodoc
class __$PersistedToolSelectionCopyWithImpl<$Res>
    implements _$PersistedToolSelectionCopyWith<$Res> {
  __$PersistedToolSelectionCopyWithImpl(this._self, this._then);

  final _PersistedToolSelection _self;
  final $Res Function(_PersistedToolSelection) _then;

/// Create a copy of PersistedToolSelection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? toolId = freezed,Object? toolIndex = freezed,}) {
  return _then(_PersistedToolSelection(
toolId: freezed == toolId ? _self.toolId : toolId // ignore: cast_nullable_to_non_nullable
as String?,toolIndex: freezed == toolIndex ? _self.toolIndex : toolIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$PersistedCameraState {

 double get positionX; double get positionY; double get zoom;
/// Create a copy of PersistedCameraState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersistedCameraStateCopyWith<PersistedCameraState> get copyWith => _$PersistedCameraStateCopyWithImpl<PersistedCameraState>(this as PersistedCameraState, _$identity);

  /// Serializes this PersistedCameraState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersistedCameraState&&(identical(other.positionX, positionX) || other.positionX == positionX)&&(identical(other.positionY, positionY) || other.positionY == positionY)&&(identical(other.zoom, zoom) || other.zoom == zoom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,positionX,positionY,zoom);

@override
String toString() {
  return 'PersistedCameraState(positionX: $positionX, positionY: $positionY, zoom: $zoom)';
}


}

/// @nodoc
abstract mixin class $PersistedCameraStateCopyWith<$Res>  {
  factory $PersistedCameraStateCopyWith(PersistedCameraState value, $Res Function(PersistedCameraState) _then) = _$PersistedCameraStateCopyWithImpl;
@useResult
$Res call({
 double positionX, double positionY, double zoom
});




}
/// @nodoc
class _$PersistedCameraStateCopyWithImpl<$Res>
    implements $PersistedCameraStateCopyWith<$Res> {
  _$PersistedCameraStateCopyWithImpl(this._self, this._then);

  final PersistedCameraState _self;
  final $Res Function(PersistedCameraState) _then;

/// Create a copy of PersistedCameraState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? positionX = null,Object? positionY = null,Object? zoom = null,}) {
  return _then(_self.copyWith(
positionX: null == positionX ? _self.positionX : positionX // ignore: cast_nullable_to_non_nullable
as double,positionY: null == positionY ? _self.positionY : positionY // ignore: cast_nullable_to_non_nullable
as double,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _PersistedCameraState implements PersistedCameraState {
  const _PersistedCameraState({this.positionX = 0, this.positionY = 0, this.zoom = 1});
  factory _PersistedCameraState.fromJson(Map<String, dynamic> json) => _$PersistedCameraStateFromJson(json);

@override@JsonKey() final  double positionX;
@override@JsonKey() final  double positionY;
@override@JsonKey() final  double zoom;

/// Create a copy of PersistedCameraState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersistedCameraStateCopyWith<_PersistedCameraState> get copyWith => __$PersistedCameraStateCopyWithImpl<_PersistedCameraState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersistedCameraStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersistedCameraState&&(identical(other.positionX, positionX) || other.positionX == positionX)&&(identical(other.positionY, positionY) || other.positionY == positionY)&&(identical(other.zoom, zoom) || other.zoom == zoom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,positionX,positionY,zoom);

@override
String toString() {
  return 'PersistedCameraState(positionX: $positionX, positionY: $positionY, zoom: $zoom)';
}


}

/// @nodoc
abstract mixin class _$PersistedCameraStateCopyWith<$Res> implements $PersistedCameraStateCopyWith<$Res> {
  factory _$PersistedCameraStateCopyWith(_PersistedCameraState value, $Res Function(_PersistedCameraState) _then) = __$PersistedCameraStateCopyWithImpl;
@override @useResult
$Res call({
 double positionX, double positionY, double zoom
});




}
/// @nodoc
class __$PersistedCameraStateCopyWithImpl<$Res>
    implements _$PersistedCameraStateCopyWith<$Res> {
  __$PersistedCameraStateCopyWithImpl(this._self, this._then);

  final _PersistedCameraState _self;
  final $Res Function(_PersistedCameraState) _then;

/// Create a copy of PersistedCameraState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? positionX = null,Object? positionY = null,Object? zoom = null,}) {
  return _then(_PersistedCameraState(
positionX: null == positionX ? _self.positionX : positionX // ignore: cast_nullable_to_non_nullable
as double,positionY: null == positionY ? _self.positionY : positionY // ignore: cast_nullable_to_non_nullable
as double,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PersistentLockState {

 bool get lockCollection; bool get lockLayer; bool get lockZoom; bool get lockHorizontal; bool get lockVertical;
/// Create a copy of PersistentLockState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersistentLockStateCopyWith<PersistentLockState> get copyWith => _$PersistentLockStateCopyWithImpl<PersistentLockState>(this as PersistentLockState, _$identity);

  /// Serializes this PersistentLockState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersistentLockState&&(identical(other.lockCollection, lockCollection) || other.lockCollection == lockCollection)&&(identical(other.lockLayer, lockLayer) || other.lockLayer == lockLayer)&&(identical(other.lockZoom, lockZoom) || other.lockZoom == lockZoom)&&(identical(other.lockHorizontal, lockHorizontal) || other.lockHorizontal == lockHorizontal)&&(identical(other.lockVertical, lockVertical) || other.lockVertical == lockVertical));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lockCollection,lockLayer,lockZoom,lockHorizontal,lockVertical);

@override
String toString() {
  return 'PersistentLockState(lockCollection: $lockCollection, lockLayer: $lockLayer, lockZoom: $lockZoom, lockHorizontal: $lockHorizontal, lockVertical: $lockVertical)';
}


}

/// @nodoc
abstract mixin class $PersistentLockStateCopyWith<$Res>  {
  factory $PersistentLockStateCopyWith(PersistentLockState value, $Res Function(PersistentLockState) _then) = _$PersistentLockStateCopyWithImpl;
@useResult
$Res call({
 bool lockCollection, bool lockLayer, bool lockZoom, bool lockHorizontal, bool lockVertical
});




}
/// @nodoc
class _$PersistentLockStateCopyWithImpl<$Res>
    implements $PersistentLockStateCopyWith<$Res> {
  _$PersistentLockStateCopyWithImpl(this._self, this._then);

  final PersistentLockState _self;
  final $Res Function(PersistentLockState) _then;

/// Create a copy of PersistentLockState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lockCollection = null,Object? lockLayer = null,Object? lockZoom = null,Object? lockHorizontal = null,Object? lockVertical = null,}) {
  return _then(_self.copyWith(
lockCollection: null == lockCollection ? _self.lockCollection : lockCollection // ignore: cast_nullable_to_non_nullable
as bool,lockLayer: null == lockLayer ? _self.lockLayer : lockLayer // ignore: cast_nullable_to_non_nullable
as bool,lockZoom: null == lockZoom ? _self.lockZoom : lockZoom // ignore: cast_nullable_to_non_nullable
as bool,lockHorizontal: null == lockHorizontal ? _self.lockHorizontal : lockHorizontal // ignore: cast_nullable_to_non_nullable
as bool,lockVertical: null == lockVertical ? _self.lockVertical : lockVertical // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _PersistentLockState extends PersistentLockState {
  const _PersistentLockState({this.lockCollection = false, this.lockLayer = false, this.lockZoom = false, this.lockHorizontal = false, this.lockVertical = false}): super._();
  factory _PersistentLockState.fromJson(Map<String, dynamic> json) => _$PersistentLockStateFromJson(json);

@override@JsonKey() final  bool lockCollection;
@override@JsonKey() final  bool lockLayer;
@override@JsonKey() final  bool lockZoom;
@override@JsonKey() final  bool lockHorizontal;
@override@JsonKey() final  bool lockVertical;

/// Create a copy of PersistentLockState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersistentLockStateCopyWith<_PersistentLockState> get copyWith => __$PersistentLockStateCopyWithImpl<_PersistentLockState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersistentLockStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersistentLockState&&(identical(other.lockCollection, lockCollection) || other.lockCollection == lockCollection)&&(identical(other.lockLayer, lockLayer) || other.lockLayer == lockLayer)&&(identical(other.lockZoom, lockZoom) || other.lockZoom == lockZoom)&&(identical(other.lockHorizontal, lockHorizontal) || other.lockHorizontal == lockHorizontal)&&(identical(other.lockVertical, lockVertical) || other.lockVertical == lockVertical));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lockCollection,lockLayer,lockZoom,lockHorizontal,lockVertical);

@override
String toString() {
  return 'PersistentLockState(lockCollection: $lockCollection, lockLayer: $lockLayer, lockZoom: $lockZoom, lockHorizontal: $lockHorizontal, lockVertical: $lockVertical)';
}


}

/// @nodoc
abstract mixin class _$PersistentLockStateCopyWith<$Res> implements $PersistentLockStateCopyWith<$Res> {
  factory _$PersistentLockStateCopyWith(_PersistentLockState value, $Res Function(_PersistentLockState) _then) = __$PersistentLockStateCopyWithImpl;
@override @useResult
$Res call({
 bool lockCollection, bool lockLayer, bool lockZoom, bool lockHorizontal, bool lockVertical
});




}
/// @nodoc
class __$PersistentLockStateCopyWithImpl<$Res>
    implements _$PersistentLockStateCopyWith<$Res> {
  __$PersistentLockStateCopyWithImpl(this._self, this._then);

  final _PersistentLockState _self;
  final $Res Function(_PersistentLockState) _then;

/// Create a copy of PersistentLockState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lockCollection = null,Object? lockLayer = null,Object? lockZoom = null,Object? lockHorizontal = null,Object? lockVertical = null,}) {
  return _then(_PersistentLockState(
lockCollection: null == lockCollection ? _self.lockCollection : lockCollection // ignore: cast_nullable_to_non_nullable
as bool,lockLayer: null == lockLayer ? _self.lockLayer : lockLayer // ignore: cast_nullable_to_non_nullable
as bool,lockZoom: null == lockZoom ? _self.lockZoom : lockZoom // ignore: cast_nullable_to_non_nullable
as bool,lockHorizontal: null == lockHorizontal ? _self.lockHorizontal : lockHorizontal // ignore: cast_nullable_to_non_nullable
as bool,lockVertical: null == lockVertical ? _self.lockVertical : lockVertical // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PersistedNavigatorState {

 bool get enabled; String get page;
/// Create a copy of PersistedNavigatorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersistedNavigatorStateCopyWith<PersistedNavigatorState> get copyWith => _$PersistedNavigatorStateCopyWithImpl<PersistedNavigatorState>(this as PersistedNavigatorState, _$identity);

  /// Serializes this PersistedNavigatorState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersistedNavigatorState&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.page, page) || other.page == page));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,page);

@override
String toString() {
  return 'PersistedNavigatorState(enabled: $enabled, page: $page)';
}


}

/// @nodoc
abstract mixin class $PersistedNavigatorStateCopyWith<$Res>  {
  factory $PersistedNavigatorStateCopyWith(PersistedNavigatorState value, $Res Function(PersistedNavigatorState) _then) = _$PersistedNavigatorStateCopyWithImpl;
@useResult
$Res call({
 bool enabled, String page
});




}
/// @nodoc
class _$PersistedNavigatorStateCopyWithImpl<$Res>
    implements $PersistedNavigatorStateCopyWith<$Res> {
  _$PersistedNavigatorStateCopyWithImpl(this._self, this._then);

  final PersistedNavigatorState _self;
  final $Res Function(PersistedNavigatorState) _then;

/// Create a copy of PersistedNavigatorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? page = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _PersistedNavigatorState implements PersistedNavigatorState {
  const _PersistedNavigatorState({this.enabled = false, this.page = 'waypoints'});
  factory _PersistedNavigatorState.fromJson(Map<String, dynamic> json) => _$PersistedNavigatorStateFromJson(json);

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  String page;

/// Create a copy of PersistedNavigatorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersistedNavigatorStateCopyWith<_PersistedNavigatorState> get copyWith => __$PersistedNavigatorStateCopyWithImpl<_PersistedNavigatorState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersistedNavigatorStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersistedNavigatorState&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.page, page) || other.page == page));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,page);

@override
String toString() {
  return 'PersistedNavigatorState(enabled: $enabled, page: $page)';
}


}

/// @nodoc
abstract mixin class _$PersistedNavigatorStateCopyWith<$Res> implements $PersistedNavigatorStateCopyWith<$Res> {
  factory _$PersistedNavigatorStateCopyWith(_PersistedNavigatorState value, $Res Function(_PersistedNavigatorState) _then) = __$PersistedNavigatorStateCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, String page
});




}
/// @nodoc
class __$PersistedNavigatorStateCopyWithImpl<$Res>
    implements _$PersistedNavigatorStateCopyWith<$Res> {
  __$PersistedNavigatorStateCopyWithImpl(this._self, this._then);

  final _PersistedNavigatorState _self;
  final $Res Function(_PersistedNavigatorState) _then;

/// Create a copy of PersistedNavigatorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? page = null,}) {
  return _then(_PersistedNavigatorState(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PersistedLayerState {

 String get currentLayer; String get currentCollection; Set<String> get invisibleLayers;
/// Create a copy of PersistedLayerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersistedLayerStateCopyWith<PersistedLayerState> get copyWith => _$PersistedLayerStateCopyWithImpl<PersistedLayerState>(this as PersistedLayerState, _$identity);

  /// Serializes this PersistedLayerState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersistedLayerState&&(identical(other.currentLayer, currentLayer) || other.currentLayer == currentLayer)&&(identical(other.currentCollection, currentCollection) || other.currentCollection == currentCollection)&&const DeepCollectionEquality().equals(other.invisibleLayers, invisibleLayers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentLayer,currentCollection,const DeepCollectionEquality().hash(invisibleLayers));

@override
String toString() {
  return 'PersistedLayerState(currentLayer: $currentLayer, currentCollection: $currentCollection, invisibleLayers: $invisibleLayers)';
}


}

/// @nodoc
abstract mixin class $PersistedLayerStateCopyWith<$Res>  {
  factory $PersistedLayerStateCopyWith(PersistedLayerState value, $Res Function(PersistedLayerState) _then) = _$PersistedLayerStateCopyWithImpl;
@useResult
$Res call({
 String currentLayer, String currentCollection, Set<String> invisibleLayers
});




}
/// @nodoc
class _$PersistedLayerStateCopyWithImpl<$Res>
    implements $PersistedLayerStateCopyWith<$Res> {
  _$PersistedLayerStateCopyWithImpl(this._self, this._then);

  final PersistedLayerState _self;
  final $Res Function(PersistedLayerState) _then;

/// Create a copy of PersistedLayerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentLayer = null,Object? currentCollection = null,Object? invisibleLayers = null,}) {
  return _then(_self.copyWith(
currentLayer: null == currentLayer ? _self.currentLayer : currentLayer // ignore: cast_nullable_to_non_nullable
as String,currentCollection: null == currentCollection ? _self.currentCollection : currentCollection // ignore: cast_nullable_to_non_nullable
as String,invisibleLayers: null == invisibleLayers ? _self.invisibleLayers : invisibleLayers // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _PersistedLayerState implements PersistedLayerState {
  const _PersistedLayerState({this.currentLayer = '', this.currentCollection = '', final  Set<String> invisibleLayers = const {}}): _invisibleLayers = invisibleLayers;
  factory _PersistedLayerState.fromJson(Map<String, dynamic> json) => _$PersistedLayerStateFromJson(json);

@override@JsonKey() final  String currentLayer;
@override@JsonKey() final  String currentCollection;
 final  Set<String> _invisibleLayers;
@override@JsonKey() Set<String> get invisibleLayers {
  if (_invisibleLayers is EqualUnmodifiableSetView) return _invisibleLayers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_invisibleLayers);
}


/// Create a copy of PersistedLayerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersistedLayerStateCopyWith<_PersistedLayerState> get copyWith => __$PersistedLayerStateCopyWithImpl<_PersistedLayerState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersistedLayerStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersistedLayerState&&(identical(other.currentLayer, currentLayer) || other.currentLayer == currentLayer)&&(identical(other.currentCollection, currentCollection) || other.currentCollection == currentCollection)&&const DeepCollectionEquality().equals(other._invisibleLayers, _invisibleLayers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentLayer,currentCollection,const DeepCollectionEquality().hash(_invisibleLayers));

@override
String toString() {
  return 'PersistedLayerState(currentLayer: $currentLayer, currentCollection: $currentCollection, invisibleLayers: $invisibleLayers)';
}


}

/// @nodoc
abstract mixin class _$PersistedLayerStateCopyWith<$Res> implements $PersistedLayerStateCopyWith<$Res> {
  factory _$PersistedLayerStateCopyWith(_PersistedLayerState value, $Res Function(_PersistedLayerState) _then) = __$PersistedLayerStateCopyWithImpl;
@override @useResult
$Res call({
 String currentLayer, String currentCollection, Set<String> invisibleLayers
});




}
/// @nodoc
class __$PersistedLayerStateCopyWithImpl<$Res>
    implements _$PersistedLayerStateCopyWith<$Res> {
  __$PersistedLayerStateCopyWithImpl(this._self, this._then);

  final _PersistedLayerState _self;
  final $Res Function(_PersistedLayerState) _then;

/// Create a copy of PersistedLayerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentLayer = null,Object? currentCollection = null,Object? invisibleLayers = null,}) {
  return _then(_PersistedLayerState(
currentLayer: null == currentLayer ? _self.currentLayer : currentLayer // ignore: cast_nullable_to_non_nullable
as String,currentCollection: null == currentCollection ? _self.currentCollection : currentCollection // ignore: cast_nullable_to_non_nullable
as String,invisibleLayers: null == invisibleLayers ? _self._invisibleLayers : invisibleLayers // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}


/// @nodoc
mixin _$PersistedAreaNavigatorState {

 bool get create; bool get exact; bool get ask;
/// Create a copy of PersistedAreaNavigatorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersistedAreaNavigatorStateCopyWith<PersistedAreaNavigatorState> get copyWith => _$PersistedAreaNavigatorStateCopyWithImpl<PersistedAreaNavigatorState>(this as PersistedAreaNavigatorState, _$identity);

  /// Serializes this PersistedAreaNavigatorState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersistedAreaNavigatorState&&(identical(other.create, create) || other.create == create)&&(identical(other.exact, exact) || other.exact == exact)&&(identical(other.ask, ask) || other.ask == ask));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,create,exact,ask);

@override
String toString() {
  return 'PersistedAreaNavigatorState(create: $create, exact: $exact, ask: $ask)';
}


}

/// @nodoc
abstract mixin class $PersistedAreaNavigatorStateCopyWith<$Res>  {
  factory $PersistedAreaNavigatorStateCopyWith(PersistedAreaNavigatorState value, $Res Function(PersistedAreaNavigatorState) _then) = _$PersistedAreaNavigatorStateCopyWithImpl;
@useResult
$Res call({
 bool create, bool exact, bool ask
});




}
/// @nodoc
class _$PersistedAreaNavigatorStateCopyWithImpl<$Res>
    implements $PersistedAreaNavigatorStateCopyWith<$Res> {
  _$PersistedAreaNavigatorStateCopyWithImpl(this._self, this._then);

  final PersistedAreaNavigatorState _self;
  final $Res Function(PersistedAreaNavigatorState) _then;

/// Create a copy of PersistedAreaNavigatorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? create = null,Object? exact = null,Object? ask = null,}) {
  return _then(_self.copyWith(
create: null == create ? _self.create : create // ignore: cast_nullable_to_non_nullable
as bool,exact: null == exact ? _self.exact : exact // ignore: cast_nullable_to_non_nullable
as bool,ask: null == ask ? _self.ask : ask // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _PersistedAreaNavigatorState implements PersistedAreaNavigatorState {
  const _PersistedAreaNavigatorState({this.create = true, this.exact = true, this.ask = false});
  factory _PersistedAreaNavigatorState.fromJson(Map<String, dynamic> json) => _$PersistedAreaNavigatorStateFromJson(json);

@override@JsonKey() final  bool create;
@override@JsonKey() final  bool exact;
@override@JsonKey() final  bool ask;

/// Create a copy of PersistedAreaNavigatorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersistedAreaNavigatorStateCopyWith<_PersistedAreaNavigatorState> get copyWith => __$PersistedAreaNavigatorStateCopyWithImpl<_PersistedAreaNavigatorState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersistedAreaNavigatorStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersistedAreaNavigatorState&&(identical(other.create, create) || other.create == create)&&(identical(other.exact, exact) || other.exact == exact)&&(identical(other.ask, ask) || other.ask == ask));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,create,exact,ask);

@override
String toString() {
  return 'PersistedAreaNavigatorState(create: $create, exact: $exact, ask: $ask)';
}


}

/// @nodoc
abstract mixin class _$PersistedAreaNavigatorStateCopyWith<$Res> implements $PersistedAreaNavigatorStateCopyWith<$Res> {
  factory _$PersistedAreaNavigatorStateCopyWith(_PersistedAreaNavigatorState value, $Res Function(_PersistedAreaNavigatorState) _then) = __$PersistedAreaNavigatorStateCopyWithImpl;
@override @useResult
$Res call({
 bool create, bool exact, bool ask
});




}
/// @nodoc
class __$PersistedAreaNavigatorStateCopyWithImpl<$Res>
    implements _$PersistedAreaNavigatorStateCopyWith<$Res> {
  __$PersistedAreaNavigatorStateCopyWithImpl(this._self, this._then);

  final _PersistedAreaNavigatorState _self;
  final $Res Function(_PersistedAreaNavigatorState) _then;

/// Create a copy of PersistedAreaNavigatorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? create = null,Object? exact = null,Object? ask = null,}) {
  return _then(_PersistedAreaNavigatorState(
create: null == create ? _self.create : create // ignore: cast_nullable_to_non_nullable
as bool,exact: null == exact ? _self.exact : exact // ignore: cast_nullable_to_non_nullable
as bool,ask: null == ask ? _self.ask : ask // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PersistedDocumentState {

 int get version; String? get pathKey; String? get contentHash; String? get pageName; PersistedCameraState get camera;@JsonKey(readValue: _readLocks) PersistentLockState get locks; PersistedToolSelection get selectedTool;@JsonKey(readValue: _readNavigator) PersistedNavigatorState get navigator;@JsonKey(readValue: _readLayers) PersistedLayerState get layers;@JsonKey(readValue: _readAreaNavigator) PersistedAreaNavigatorState get areaNavigator; DateTime? get updatedAt;
/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersistedDocumentStateCopyWith<PersistedDocumentState> get copyWith => _$PersistedDocumentStateCopyWithImpl<PersistedDocumentState>(this as PersistedDocumentState, _$identity);

  /// Serializes this PersistedDocumentState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersistedDocumentState&&(identical(other.version, version) || other.version == version)&&(identical(other.pathKey, pathKey) || other.pathKey == pathKey)&&(identical(other.contentHash, contentHash) || other.contentHash == contentHash)&&(identical(other.pageName, pageName) || other.pageName == pageName)&&(identical(other.camera, camera) || other.camera == camera)&&(identical(other.locks, locks) || other.locks == locks)&&(identical(other.selectedTool, selectedTool) || other.selectedTool == selectedTool)&&(identical(other.navigator, navigator) || other.navigator == navigator)&&(identical(other.layers, layers) || other.layers == layers)&&(identical(other.areaNavigator, areaNavigator) || other.areaNavigator == areaNavigator)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,pathKey,contentHash,pageName,camera,locks,selectedTool,navigator,layers,areaNavigator,updatedAt);

@override
String toString() {
  return 'PersistedDocumentState(version: $version, pathKey: $pathKey, contentHash: $contentHash, pageName: $pageName, camera: $camera, locks: $locks, selectedTool: $selectedTool, navigator: $navigator, layers: $layers, areaNavigator: $areaNavigator, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PersistedDocumentStateCopyWith<$Res>  {
  factory $PersistedDocumentStateCopyWith(PersistedDocumentState value, $Res Function(PersistedDocumentState) _then) = _$PersistedDocumentStateCopyWithImpl;
@useResult
$Res call({
 int version, String? pathKey, String? contentHash, String? pageName, PersistedCameraState camera,@JsonKey(readValue: _readLocks) PersistentLockState locks, PersistedToolSelection selectedTool,@JsonKey(readValue: _readNavigator) PersistedNavigatorState navigator,@JsonKey(readValue: _readLayers) PersistedLayerState layers,@JsonKey(readValue: _readAreaNavigator) PersistedAreaNavigatorState areaNavigator, DateTime? updatedAt
});


$PersistedCameraStateCopyWith<$Res> get camera;$PersistentLockStateCopyWith<$Res> get locks;$PersistedToolSelectionCopyWith<$Res> get selectedTool;$PersistedNavigatorStateCopyWith<$Res> get navigator;$PersistedLayerStateCopyWith<$Res> get layers;$PersistedAreaNavigatorStateCopyWith<$Res> get areaNavigator;

}
/// @nodoc
class _$PersistedDocumentStateCopyWithImpl<$Res>
    implements $PersistedDocumentStateCopyWith<$Res> {
  _$PersistedDocumentStateCopyWithImpl(this._self, this._then);

  final PersistedDocumentState _self;
  final $Res Function(PersistedDocumentState) _then;

/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? pathKey = freezed,Object? contentHash = freezed,Object? pageName = freezed,Object? camera = null,Object? locks = null,Object? selectedTool = null,Object? navigator = null,Object? layers = null,Object? areaNavigator = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,pathKey: freezed == pathKey ? _self.pathKey : pathKey // ignore: cast_nullable_to_non_nullable
as String?,contentHash: freezed == contentHash ? _self.contentHash : contentHash // ignore: cast_nullable_to_non_nullable
as String?,pageName: freezed == pageName ? _self.pageName : pageName // ignore: cast_nullable_to_non_nullable
as String?,camera: null == camera ? _self.camera : camera // ignore: cast_nullable_to_non_nullable
as PersistedCameraState,locks: null == locks ? _self.locks : locks // ignore: cast_nullable_to_non_nullable
as PersistentLockState,selectedTool: null == selectedTool ? _self.selectedTool : selectedTool // ignore: cast_nullable_to_non_nullable
as PersistedToolSelection,navigator: null == navigator ? _self.navigator : navigator // ignore: cast_nullable_to_non_nullable
as PersistedNavigatorState,layers: null == layers ? _self.layers : layers // ignore: cast_nullable_to_non_nullable
as PersistedLayerState,areaNavigator: null == areaNavigator ? _self.areaNavigator : areaNavigator // ignore: cast_nullable_to_non_nullable
as PersistedAreaNavigatorState,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersistedCameraStateCopyWith<$Res> get camera {
  
  return $PersistedCameraStateCopyWith<$Res>(_self.camera, (value) {
    return _then(_self.copyWith(camera: value));
  });
}/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersistentLockStateCopyWith<$Res> get locks {
  
  return $PersistentLockStateCopyWith<$Res>(_self.locks, (value) {
    return _then(_self.copyWith(locks: value));
  });
}/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersistedToolSelectionCopyWith<$Res> get selectedTool {
  
  return $PersistedToolSelectionCopyWith<$Res>(_self.selectedTool, (value) {
    return _then(_self.copyWith(selectedTool: value));
  });
}/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersistedNavigatorStateCopyWith<$Res> get navigator {
  
  return $PersistedNavigatorStateCopyWith<$Res>(_self.navigator, (value) {
    return _then(_self.copyWith(navigator: value));
  });
}/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersistedLayerStateCopyWith<$Res> get layers {
  
  return $PersistedLayerStateCopyWith<$Res>(_self.layers, (value) {
    return _then(_self.copyWith(layers: value));
  });
}/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersistedAreaNavigatorStateCopyWith<$Res> get areaNavigator {
  
  return $PersistedAreaNavigatorStateCopyWith<$Res>(_self.areaNavigator, (value) {
    return _then(_self.copyWith(areaNavigator: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _PersistedDocumentState extends PersistedDocumentState {
  const _PersistedDocumentState({this.version = kPersistedDocumentStateVersion, this.pathKey, this.contentHash, this.pageName, this.camera = const PersistedCameraState(), @JsonKey(readValue: _readLocks) this.locks = const PersistentLockState(), this.selectedTool = const PersistedToolSelection(), @JsonKey(readValue: _readNavigator) this.navigator = const PersistedNavigatorState(), @JsonKey(readValue: _readLayers) this.layers = const PersistedLayerState(), @JsonKey(readValue: _readAreaNavigator) this.areaNavigator = const PersistedAreaNavigatorState(), this.updatedAt}): super._();
  factory _PersistedDocumentState.fromJson(Map<String, dynamic> json) => _$PersistedDocumentStateFromJson(json);

@override@JsonKey() final  int version;
@override final  String? pathKey;
@override final  String? contentHash;
@override final  String? pageName;
@override@JsonKey() final  PersistedCameraState camera;
@override@JsonKey(readValue: _readLocks) final  PersistentLockState locks;
@override@JsonKey() final  PersistedToolSelection selectedTool;
@override@JsonKey(readValue: _readNavigator) final  PersistedNavigatorState navigator;
@override@JsonKey(readValue: _readLayers) final  PersistedLayerState layers;
@override@JsonKey(readValue: _readAreaNavigator) final  PersistedAreaNavigatorState areaNavigator;
@override final  DateTime? updatedAt;

/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersistedDocumentStateCopyWith<_PersistedDocumentState> get copyWith => __$PersistedDocumentStateCopyWithImpl<_PersistedDocumentState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersistedDocumentStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersistedDocumentState&&(identical(other.version, version) || other.version == version)&&(identical(other.pathKey, pathKey) || other.pathKey == pathKey)&&(identical(other.contentHash, contentHash) || other.contentHash == contentHash)&&(identical(other.pageName, pageName) || other.pageName == pageName)&&(identical(other.camera, camera) || other.camera == camera)&&(identical(other.locks, locks) || other.locks == locks)&&(identical(other.selectedTool, selectedTool) || other.selectedTool == selectedTool)&&(identical(other.navigator, navigator) || other.navigator == navigator)&&(identical(other.layers, layers) || other.layers == layers)&&(identical(other.areaNavigator, areaNavigator) || other.areaNavigator == areaNavigator)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,pathKey,contentHash,pageName,camera,locks,selectedTool,navigator,layers,areaNavigator,updatedAt);

@override
String toString() {
  return 'PersistedDocumentState(version: $version, pathKey: $pathKey, contentHash: $contentHash, pageName: $pageName, camera: $camera, locks: $locks, selectedTool: $selectedTool, navigator: $navigator, layers: $layers, areaNavigator: $areaNavigator, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PersistedDocumentStateCopyWith<$Res> implements $PersistedDocumentStateCopyWith<$Res> {
  factory _$PersistedDocumentStateCopyWith(_PersistedDocumentState value, $Res Function(_PersistedDocumentState) _then) = __$PersistedDocumentStateCopyWithImpl;
@override @useResult
$Res call({
 int version, String? pathKey, String? contentHash, String? pageName, PersistedCameraState camera,@JsonKey(readValue: _readLocks) PersistentLockState locks, PersistedToolSelection selectedTool,@JsonKey(readValue: _readNavigator) PersistedNavigatorState navigator,@JsonKey(readValue: _readLayers) PersistedLayerState layers,@JsonKey(readValue: _readAreaNavigator) PersistedAreaNavigatorState areaNavigator, DateTime? updatedAt
});


@override $PersistedCameraStateCopyWith<$Res> get camera;@override $PersistentLockStateCopyWith<$Res> get locks;@override $PersistedToolSelectionCopyWith<$Res> get selectedTool;@override $PersistedNavigatorStateCopyWith<$Res> get navigator;@override $PersistedLayerStateCopyWith<$Res> get layers;@override $PersistedAreaNavigatorStateCopyWith<$Res> get areaNavigator;

}
/// @nodoc
class __$PersistedDocumentStateCopyWithImpl<$Res>
    implements _$PersistedDocumentStateCopyWith<$Res> {
  __$PersistedDocumentStateCopyWithImpl(this._self, this._then);

  final _PersistedDocumentState _self;
  final $Res Function(_PersistedDocumentState) _then;

/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? pathKey = freezed,Object? contentHash = freezed,Object? pageName = freezed,Object? camera = null,Object? locks = null,Object? selectedTool = null,Object? navigator = null,Object? layers = null,Object? areaNavigator = null,Object? updatedAt = freezed,}) {
  return _then(_PersistedDocumentState(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,pathKey: freezed == pathKey ? _self.pathKey : pathKey // ignore: cast_nullable_to_non_nullable
as String?,contentHash: freezed == contentHash ? _self.contentHash : contentHash // ignore: cast_nullable_to_non_nullable
as String?,pageName: freezed == pageName ? _self.pageName : pageName // ignore: cast_nullable_to_non_nullable
as String?,camera: null == camera ? _self.camera : camera // ignore: cast_nullable_to_non_nullable
as PersistedCameraState,locks: null == locks ? _self.locks : locks // ignore: cast_nullable_to_non_nullable
as PersistentLockState,selectedTool: null == selectedTool ? _self.selectedTool : selectedTool // ignore: cast_nullable_to_non_nullable
as PersistedToolSelection,navigator: null == navigator ? _self.navigator : navigator // ignore: cast_nullable_to_non_nullable
as PersistedNavigatorState,layers: null == layers ? _self.layers : layers // ignore: cast_nullable_to_non_nullable
as PersistedLayerState,areaNavigator: null == areaNavigator ? _self.areaNavigator : areaNavigator // ignore: cast_nullable_to_non_nullable
as PersistedAreaNavigatorState,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersistedCameraStateCopyWith<$Res> get camera {
  
  return $PersistedCameraStateCopyWith<$Res>(_self.camera, (value) {
    return _then(_self.copyWith(camera: value));
  });
}/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersistentLockStateCopyWith<$Res> get locks {
  
  return $PersistentLockStateCopyWith<$Res>(_self.locks, (value) {
    return _then(_self.copyWith(locks: value));
  });
}/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersistedToolSelectionCopyWith<$Res> get selectedTool {
  
  return $PersistedToolSelectionCopyWith<$Res>(_self.selectedTool, (value) {
    return _then(_self.copyWith(selectedTool: value));
  });
}/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersistedNavigatorStateCopyWith<$Res> get navigator {
  
  return $PersistedNavigatorStateCopyWith<$Res>(_self.navigator, (value) {
    return _then(_self.copyWith(navigator: value));
  });
}/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersistedLayerStateCopyWith<$Res> get layers {
  
  return $PersistedLayerStateCopyWith<$Res>(_self.layers, (value) {
    return _then(_self.copyWith(layers: value));
  });
}/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersistedAreaNavigatorStateCopyWith<$Res> get areaNavigator {
  
  return $PersistedAreaNavigatorStateCopyWith<$Res>(_self.areaNavigator, (value) {
    return _then(_self.copyWith(areaNavigator: value));
  });
}
}

// dart format on
