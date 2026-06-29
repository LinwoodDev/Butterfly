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
mixin _$PersistedDocumentState {

 int get version; String? get pathKey; String? get contentHash; String? get pageName; PersistedCameraState get camera; UtilitiesState get utilities; PersistedToolSelection get selectedTool; bool get navigatorEnabled; String get navigatorPage; String get currentLayer; String get currentCollection; Set<String> get invisibleLayers; bool get areaNavigatorCreate; bool get areaNavigatorExact; bool get areaNavigatorAsk; DateTime? get updatedAt;
/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersistedDocumentStateCopyWith<PersistedDocumentState> get copyWith => _$PersistedDocumentStateCopyWithImpl<PersistedDocumentState>(this as PersistedDocumentState, _$identity);

  /// Serializes this PersistedDocumentState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersistedDocumentState&&(identical(other.version, version) || other.version == version)&&(identical(other.pathKey, pathKey) || other.pathKey == pathKey)&&(identical(other.contentHash, contentHash) || other.contentHash == contentHash)&&(identical(other.pageName, pageName) || other.pageName == pageName)&&(identical(other.camera, camera) || other.camera == camera)&&(identical(other.utilities, utilities) || other.utilities == utilities)&&(identical(other.selectedTool, selectedTool) || other.selectedTool == selectedTool)&&(identical(other.navigatorEnabled, navigatorEnabled) || other.navigatorEnabled == navigatorEnabled)&&(identical(other.navigatorPage, navigatorPage) || other.navigatorPage == navigatorPage)&&(identical(other.currentLayer, currentLayer) || other.currentLayer == currentLayer)&&(identical(other.currentCollection, currentCollection) || other.currentCollection == currentCollection)&&const DeepCollectionEquality().equals(other.invisibleLayers, invisibleLayers)&&(identical(other.areaNavigatorCreate, areaNavigatorCreate) || other.areaNavigatorCreate == areaNavigatorCreate)&&(identical(other.areaNavigatorExact, areaNavigatorExact) || other.areaNavigatorExact == areaNavigatorExact)&&(identical(other.areaNavigatorAsk, areaNavigatorAsk) || other.areaNavigatorAsk == areaNavigatorAsk)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,pathKey,contentHash,pageName,camera,utilities,selectedTool,navigatorEnabled,navigatorPage,currentLayer,currentCollection,const DeepCollectionEquality().hash(invisibleLayers),areaNavigatorCreate,areaNavigatorExact,areaNavigatorAsk,updatedAt);

@override
String toString() {
  return 'PersistedDocumentState(version: $version, pathKey: $pathKey, contentHash: $contentHash, pageName: $pageName, camera: $camera, utilities: $utilities, selectedTool: $selectedTool, navigatorEnabled: $navigatorEnabled, navigatorPage: $navigatorPage, currentLayer: $currentLayer, currentCollection: $currentCollection, invisibleLayers: $invisibleLayers, areaNavigatorCreate: $areaNavigatorCreate, areaNavigatorExact: $areaNavigatorExact, areaNavigatorAsk: $areaNavigatorAsk, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PersistedDocumentStateCopyWith<$Res>  {
  factory $PersistedDocumentStateCopyWith(PersistedDocumentState value, $Res Function(PersistedDocumentState) _then) = _$PersistedDocumentStateCopyWithImpl;
@useResult
$Res call({
 int version, String? pathKey, String? contentHash, String? pageName, PersistedCameraState camera, UtilitiesState utilities, PersistedToolSelection selectedTool, bool navigatorEnabled, String navigatorPage, String currentLayer, String currentCollection, Set<String> invisibleLayers, bool areaNavigatorCreate, bool areaNavigatorExact, bool areaNavigatorAsk, DateTime? updatedAt
});


$PersistedCameraStateCopyWith<$Res> get camera;$UtilitiesStateCopyWith<$Res> get utilities;$PersistedToolSelectionCopyWith<$Res> get selectedTool;

}
/// @nodoc
class _$PersistedDocumentStateCopyWithImpl<$Res>
    implements $PersistedDocumentStateCopyWith<$Res> {
  _$PersistedDocumentStateCopyWithImpl(this._self, this._then);

  final PersistedDocumentState _self;
  final $Res Function(PersistedDocumentState) _then;

/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? pathKey = freezed,Object? contentHash = freezed,Object? pageName = freezed,Object? camera = null,Object? utilities = null,Object? selectedTool = null,Object? navigatorEnabled = null,Object? navigatorPage = null,Object? currentLayer = null,Object? currentCollection = null,Object? invisibleLayers = null,Object? areaNavigatorCreate = null,Object? areaNavigatorExact = null,Object? areaNavigatorAsk = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,pathKey: freezed == pathKey ? _self.pathKey : pathKey // ignore: cast_nullable_to_non_nullable
as String?,contentHash: freezed == contentHash ? _self.contentHash : contentHash // ignore: cast_nullable_to_non_nullable
as String?,pageName: freezed == pageName ? _self.pageName : pageName // ignore: cast_nullable_to_non_nullable
as String?,camera: null == camera ? _self.camera : camera // ignore: cast_nullable_to_non_nullable
as PersistedCameraState,utilities: null == utilities ? _self.utilities : utilities // ignore: cast_nullable_to_non_nullable
as UtilitiesState,selectedTool: null == selectedTool ? _self.selectedTool : selectedTool // ignore: cast_nullable_to_non_nullable
as PersistedToolSelection,navigatorEnabled: null == navigatorEnabled ? _self.navigatorEnabled : navigatorEnabled // ignore: cast_nullable_to_non_nullable
as bool,navigatorPage: null == navigatorPage ? _self.navigatorPage : navigatorPage // ignore: cast_nullable_to_non_nullable
as String,currentLayer: null == currentLayer ? _self.currentLayer : currentLayer // ignore: cast_nullable_to_non_nullable
as String,currentCollection: null == currentCollection ? _self.currentCollection : currentCollection // ignore: cast_nullable_to_non_nullable
as String,invisibleLayers: null == invisibleLayers ? _self.invisibleLayers : invisibleLayers // ignore: cast_nullable_to_non_nullable
as Set<String>,areaNavigatorCreate: null == areaNavigatorCreate ? _self.areaNavigatorCreate : areaNavigatorCreate // ignore: cast_nullable_to_non_nullable
as bool,areaNavigatorExact: null == areaNavigatorExact ? _self.areaNavigatorExact : areaNavigatorExact // ignore: cast_nullable_to_non_nullable
as bool,areaNavigatorAsk: null == areaNavigatorAsk ? _self.areaNavigatorAsk : areaNavigatorAsk // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
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
$UtilitiesStateCopyWith<$Res> get utilities {
  
  return $UtilitiesStateCopyWith<$Res>(_self.utilities, (value) {
    return _then(_self.copyWith(utilities: value));
  });
}/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersistedToolSelectionCopyWith<$Res> get selectedTool {
  
  return $PersistedToolSelectionCopyWith<$Res>(_self.selectedTool, (value) {
    return _then(_self.copyWith(selectedTool: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _PersistedDocumentState extends PersistedDocumentState {
  const _PersistedDocumentState({this.version = kPersistedDocumentStateVersion, this.pathKey, this.contentHash, this.pageName, this.camera = const PersistedCameraState(), this.utilities = const UtilitiesState(), this.selectedTool = const PersistedToolSelection(), this.navigatorEnabled = false, this.navigatorPage = 'waypoints', this.currentLayer = '', this.currentCollection = '', final  Set<String> invisibleLayers = const {}, this.areaNavigatorCreate = true, this.areaNavigatorExact = true, this.areaNavigatorAsk = false, this.updatedAt}): _invisibleLayers = invisibleLayers,super._();
  factory _PersistedDocumentState.fromJson(Map<String, dynamic> json) => _$PersistedDocumentStateFromJson(json);

@override@JsonKey() final  int version;
@override final  String? pathKey;
@override final  String? contentHash;
@override final  String? pageName;
@override@JsonKey() final  PersistedCameraState camera;
@override@JsonKey() final  UtilitiesState utilities;
@override@JsonKey() final  PersistedToolSelection selectedTool;
@override@JsonKey() final  bool navigatorEnabled;
@override@JsonKey() final  String navigatorPage;
@override@JsonKey() final  String currentLayer;
@override@JsonKey() final  String currentCollection;
 final  Set<String> _invisibleLayers;
@override@JsonKey() Set<String> get invisibleLayers {
  if (_invisibleLayers is EqualUnmodifiableSetView) return _invisibleLayers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_invisibleLayers);
}

@override@JsonKey() final  bool areaNavigatorCreate;
@override@JsonKey() final  bool areaNavigatorExact;
@override@JsonKey() final  bool areaNavigatorAsk;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersistedDocumentState&&(identical(other.version, version) || other.version == version)&&(identical(other.pathKey, pathKey) || other.pathKey == pathKey)&&(identical(other.contentHash, contentHash) || other.contentHash == contentHash)&&(identical(other.pageName, pageName) || other.pageName == pageName)&&(identical(other.camera, camera) || other.camera == camera)&&(identical(other.utilities, utilities) || other.utilities == utilities)&&(identical(other.selectedTool, selectedTool) || other.selectedTool == selectedTool)&&(identical(other.navigatorEnabled, navigatorEnabled) || other.navigatorEnabled == navigatorEnabled)&&(identical(other.navigatorPage, navigatorPage) || other.navigatorPage == navigatorPage)&&(identical(other.currentLayer, currentLayer) || other.currentLayer == currentLayer)&&(identical(other.currentCollection, currentCollection) || other.currentCollection == currentCollection)&&const DeepCollectionEquality().equals(other._invisibleLayers, _invisibleLayers)&&(identical(other.areaNavigatorCreate, areaNavigatorCreate) || other.areaNavigatorCreate == areaNavigatorCreate)&&(identical(other.areaNavigatorExact, areaNavigatorExact) || other.areaNavigatorExact == areaNavigatorExact)&&(identical(other.areaNavigatorAsk, areaNavigatorAsk) || other.areaNavigatorAsk == areaNavigatorAsk)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,pathKey,contentHash,pageName,camera,utilities,selectedTool,navigatorEnabled,navigatorPage,currentLayer,currentCollection,const DeepCollectionEquality().hash(_invisibleLayers),areaNavigatorCreate,areaNavigatorExact,areaNavigatorAsk,updatedAt);

@override
String toString() {
  return 'PersistedDocumentState(version: $version, pathKey: $pathKey, contentHash: $contentHash, pageName: $pageName, camera: $camera, utilities: $utilities, selectedTool: $selectedTool, navigatorEnabled: $navigatorEnabled, navigatorPage: $navigatorPage, currentLayer: $currentLayer, currentCollection: $currentCollection, invisibleLayers: $invisibleLayers, areaNavigatorCreate: $areaNavigatorCreate, areaNavigatorExact: $areaNavigatorExact, areaNavigatorAsk: $areaNavigatorAsk, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PersistedDocumentStateCopyWith<$Res> implements $PersistedDocumentStateCopyWith<$Res> {
  factory _$PersistedDocumentStateCopyWith(_PersistedDocumentState value, $Res Function(_PersistedDocumentState) _then) = __$PersistedDocumentStateCopyWithImpl;
@override @useResult
$Res call({
 int version, String? pathKey, String? contentHash, String? pageName, PersistedCameraState camera, UtilitiesState utilities, PersistedToolSelection selectedTool, bool navigatorEnabled, String navigatorPage, String currentLayer, String currentCollection, Set<String> invisibleLayers, bool areaNavigatorCreate, bool areaNavigatorExact, bool areaNavigatorAsk, DateTime? updatedAt
});


@override $PersistedCameraStateCopyWith<$Res> get camera;@override $UtilitiesStateCopyWith<$Res> get utilities;@override $PersistedToolSelectionCopyWith<$Res> get selectedTool;

}
/// @nodoc
class __$PersistedDocumentStateCopyWithImpl<$Res>
    implements _$PersistedDocumentStateCopyWith<$Res> {
  __$PersistedDocumentStateCopyWithImpl(this._self, this._then);

  final _PersistedDocumentState _self;
  final $Res Function(_PersistedDocumentState) _then;

/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? pathKey = freezed,Object? contentHash = freezed,Object? pageName = freezed,Object? camera = null,Object? utilities = null,Object? selectedTool = null,Object? navigatorEnabled = null,Object? navigatorPage = null,Object? currentLayer = null,Object? currentCollection = null,Object? invisibleLayers = null,Object? areaNavigatorCreate = null,Object? areaNavigatorExact = null,Object? areaNavigatorAsk = null,Object? updatedAt = freezed,}) {
  return _then(_PersistedDocumentState(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,pathKey: freezed == pathKey ? _self.pathKey : pathKey // ignore: cast_nullable_to_non_nullable
as String?,contentHash: freezed == contentHash ? _self.contentHash : contentHash // ignore: cast_nullable_to_non_nullable
as String?,pageName: freezed == pageName ? _self.pageName : pageName // ignore: cast_nullable_to_non_nullable
as String?,camera: null == camera ? _self.camera : camera // ignore: cast_nullable_to_non_nullable
as PersistedCameraState,utilities: null == utilities ? _self.utilities : utilities // ignore: cast_nullable_to_non_nullable
as UtilitiesState,selectedTool: null == selectedTool ? _self.selectedTool : selectedTool // ignore: cast_nullable_to_non_nullable
as PersistedToolSelection,navigatorEnabled: null == navigatorEnabled ? _self.navigatorEnabled : navigatorEnabled // ignore: cast_nullable_to_non_nullable
as bool,navigatorPage: null == navigatorPage ? _self.navigatorPage : navigatorPage // ignore: cast_nullable_to_non_nullable
as String,currentLayer: null == currentLayer ? _self.currentLayer : currentLayer // ignore: cast_nullable_to_non_nullable
as String,currentCollection: null == currentCollection ? _self.currentCollection : currentCollection // ignore: cast_nullable_to_non_nullable
as String,invisibleLayers: null == invisibleLayers ? _self._invisibleLayers : invisibleLayers // ignore: cast_nullable_to_non_nullable
as Set<String>,areaNavigatorCreate: null == areaNavigatorCreate ? _self.areaNavigatorCreate : areaNavigatorCreate // ignore: cast_nullable_to_non_nullable
as bool,areaNavigatorExact: null == areaNavigatorExact ? _self.areaNavigatorExact : areaNavigatorExact // ignore: cast_nullable_to_non_nullable
as bool,areaNavigatorAsk: null == areaNavigatorAsk ? _self.areaNavigatorAsk : areaNavigatorAsk // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
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
$UtilitiesStateCopyWith<$Res> get utilities {
  
  return $UtilitiesStateCopyWith<$Res>(_self.utilities, (value) {
    return _then(_self.copyWith(utilities: value));
  });
}/// Create a copy of PersistedDocumentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersistedToolSelectionCopyWith<$Res> get selectedTool {
  
  return $PersistedToolSelectionCopyWith<$Res>(_self.selectedTool, (value) {
    return _then(_self.copyWith(selectedTool: value));
  });
}
}

// dart format on
