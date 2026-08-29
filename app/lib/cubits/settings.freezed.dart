// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FavoriteLocation implements DiagnosticableTreeMixin {

 String? get remote; String get path;
/// Create a copy of FavoriteLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteLocationCopyWith<FavoriteLocation> get copyWith => _$FavoriteLocationCopyWithImpl<FavoriteLocation>(this as FavoriteLocation, _$identity);

  /// Serializes this FavoriteLocation to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as FavoriteLocation;
  properties
    ..add(DiagnosticsProperty('type', 'FavoriteLocation'))
    ..add(DiagnosticsProperty('remote', _this.remote))..add(DiagnosticsProperty('path', _this.path));
}

@override
bool operator ==(Object other) {
  final _this = this as FavoriteLocation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteLocation&&(identical(other.remote, _this.remote) || other.remote == _this.remote)&&(identical(other.path, _this.path) || other.path == _this.path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FavoriteLocation;
  return Object.hash(runtimeType,_this.remote,_this.path);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as FavoriteLocation;
  return 'FavoriteLocation(remote: ${_this.remote}, path: ${_this.path})';
}


}

/// @nodoc
abstract mixin class $FavoriteLocationCopyWith<$Res>  {
  factory $FavoriteLocationCopyWith(FavoriteLocation value, $Res Function(FavoriteLocation) _then) = _$FavoriteLocationCopyWithImpl;
@useResult
$Res call({
 String? remote, String path
});




}
/// @nodoc
class _$FavoriteLocationCopyWithImpl<$Res>
    implements $FavoriteLocationCopyWith<$Res> {
  _$FavoriteLocationCopyWithImpl(this._self, this._then);

  final FavoriteLocation _self;
  final $Res Function(FavoriteLocation) _then;

/// Create a copy of FavoriteLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? remote = freezed,Object? path = null,}) {
  return _then(FavoriteLocation(
remote: freezed == remote ? _self.remote : remote // ignore: cast_nullable_to_non_nullable
as String?,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _FavoriteLocation extends FavoriteLocation with DiagnosticableTreeMixin {
  const _FavoriteLocation({this.remote, required this.path}): super._();
  factory _FavoriteLocation.fromJson(Map<String, dynamic> json) => _$FavoriteLocationFromJson(json);

@override final  String? remote;
@override final  String path;

/// Create a copy of FavoriteLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteLocationCopyWith<_FavoriteLocation> get copyWith => __$FavoriteLocationCopyWithImpl<_FavoriteLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavoriteLocationToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'FavoriteLocation'))
    ..add(DiagnosticsProperty('remote', remote))..add(DiagnosticsProperty('path', path));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteLocation&&(identical(other.remote, remote) || other.remote == remote)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,remote,path);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'FavoriteLocation(remote: $remote, path: $path)';
}


}

/// @nodoc
abstract mixin class _$FavoriteLocationCopyWith<$Res> implements $FavoriteLocationCopyWith<$Res> {
  factory _$FavoriteLocationCopyWith(_FavoriteLocation value, $Res Function(_FavoriteLocation) _then) = __$FavoriteLocationCopyWithImpl;
@override @useResult
$Res call({
 String? remote, String path
});




}
/// @nodoc
class __$FavoriteLocationCopyWithImpl<$Res>
    implements _$FavoriteLocationCopyWith<$Res> {
  __$FavoriteLocationCopyWithImpl(this._self, this._then);

  final _FavoriteLocation _self;
  final $Res Function(_FavoriteLocation) _then;

/// Create a copy of FavoriteLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? remote = freezed,Object? path = null,}) {
  return _then(_FavoriteLocation(
remote: freezed == remote ? _self.remote : remote // ignore: cast_nullable_to_non_nullable
as String?,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$HoldShortcut implements DiagnosticableTreeMixin {

 int get keyId; InputMapping get mapping;
/// Create a copy of HoldShortcut
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HoldShortcutCopyWith<HoldShortcut> get copyWith => _$HoldShortcutCopyWithImpl<HoldShortcut>(this as HoldShortcut, _$identity);

  /// Serializes this HoldShortcut to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as HoldShortcut;
  properties
    ..add(DiagnosticsProperty('type', 'HoldShortcut'))
    ..add(DiagnosticsProperty('keyId', _this.keyId))..add(DiagnosticsProperty('mapping', _this.mapping));
}

@override
bool operator ==(Object other) {
  final _this = this as HoldShortcut;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HoldShortcut&&(identical(other.keyId, _this.keyId) || other.keyId == _this.keyId)&&(identical(other.mapping, _this.mapping) || other.mapping == _this.mapping));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HoldShortcut;
  return Object.hash(runtimeType,_this.keyId,_this.mapping);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as HoldShortcut;
  return 'HoldShortcut(keyId: ${_this.keyId}, mapping: ${_this.mapping})';
}


}

/// @nodoc
abstract mixin class $HoldShortcutCopyWith<$Res>  {
  factory $HoldShortcutCopyWith(HoldShortcut value, $Res Function(HoldShortcut) _then) = _$HoldShortcutCopyWithImpl;
@useResult
$Res call({
 int keyId, InputMapping mapping
});




}
/// @nodoc
class _$HoldShortcutCopyWithImpl<$Res>
    implements $HoldShortcutCopyWith<$Res> {
  _$HoldShortcutCopyWithImpl(this._self, this._then);

  final HoldShortcut _self;
  final $Res Function(HoldShortcut) _then;

/// Create a copy of HoldShortcut
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? keyId = null,Object? mapping = null,}) {
  return _then(HoldShortcut(
keyId: null == keyId ? _self.keyId : keyId // ignore: cast_nullable_to_non_nullable
as int,mapping: null == mapping ? _self.mapping : mapping // ignore: cast_nullable_to_non_nullable
as InputMapping,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _HoldShortcut with DiagnosticableTreeMixin implements HoldShortcut {
  const _HoldShortcut({required this.keyId, required this.mapping});
  factory _HoldShortcut.fromJson(Map<String, dynamic> json) => _$HoldShortcutFromJson(json);

@override final  int keyId;
@override final  InputMapping mapping;

/// Create a copy of HoldShortcut
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HoldShortcutCopyWith<_HoldShortcut> get copyWith => __$HoldShortcutCopyWithImpl<_HoldShortcut>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HoldShortcutToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'HoldShortcut'))
    ..add(DiagnosticsProperty('keyId', keyId))..add(DiagnosticsProperty('mapping', mapping));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HoldShortcut&&(identical(other.keyId, keyId) || other.keyId == keyId)&&(identical(other.mapping, mapping) || other.mapping == mapping));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,keyId,mapping);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'HoldShortcut(keyId: $keyId, mapping: $mapping)';
}


}

/// @nodoc
abstract mixin class _$HoldShortcutCopyWith<$Res> implements $HoldShortcutCopyWith<$Res> {
  factory _$HoldShortcutCopyWith(_HoldShortcut value, $Res Function(_HoldShortcut) _then) = __$HoldShortcutCopyWithImpl;
@override @useResult
$Res call({
 int keyId, InputMapping mapping
});




}
/// @nodoc
class __$HoldShortcutCopyWithImpl<$Res>
    implements _$HoldShortcutCopyWith<$Res> {
  __$HoldShortcutCopyWithImpl(this._self, this._then);

  final _HoldShortcut _self;
  final $Res Function(_HoldShortcut) _then;

/// Create a copy of HoldShortcut
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? keyId = null,Object? mapping = null,}) {
  return _then(_HoldShortcut(
keyId: null == keyId ? _self.keyId : keyId // ignore: cast_nullable_to_non_nullable
as int,mapping: null == mapping ? _self.mapping : mapping // ignore: cast_nullable_to_non_nullable
as InputMapping,
  ));
}


}


/// @nodoc
mixin _$InputConfiguration implements DiagnosticableTreeMixin {

 InputMapping get leftMouse; InputMapping get middleMouse; InputMapping get rightMouse; InputMapping? get backMouse; InputMapping? get forwardMouse; InputMapping get pen; InputMapping get invertedPen; InputMapping get firstPenButton; InputMapping get secondPenButton; InputMapping get touch; List<HoldShortcut> get holdShortcuts; String? get doubleLeftMouseShortcut; String? get tripleLeftMouseShortcut; String? get doubleMiddleMouseShortcut; String? get tripleMiddleMouseShortcut; String? get doubleRightMouseShortcut; String? get tripleRightMouseShortcut; String? get doubleBackMouseShortcut; String? get tripleBackMouseShortcut; String? get doubleForwardMouseShortcut; String? get tripleForwardMouseShortcut; String? get doublePenShortcut; String? get triplePenShortcut; String? get doubleInvertedPenShortcut; String? get tripleInvertedPenShortcut; String? get doubleFirstPenButtonShortcut; String? get tripleFirstPenButtonShortcut; String? get doubleSecondPenButtonShortcut; String? get tripleSecondPenButtonShortcut; String? get doubleTouchShortcut; String? get tripleTouchShortcut; String? get twoFingerTouchShortcut; String? get threeFingerTouchShortcut;
/// Create a copy of InputConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InputConfigurationCopyWith<InputConfiguration> get copyWith => _$InputConfigurationCopyWithImpl<InputConfiguration>(this as InputConfiguration, _$identity);

  /// Serializes this InputConfiguration to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as InputConfiguration;
  properties
    ..add(DiagnosticsProperty('type', 'InputConfiguration'))
    ..add(DiagnosticsProperty('leftMouse', _this.leftMouse))..add(DiagnosticsProperty('middleMouse', _this.middleMouse))..add(DiagnosticsProperty('rightMouse', _this.rightMouse))..add(DiagnosticsProperty('backMouse', _this.backMouse))..add(DiagnosticsProperty('forwardMouse', _this.forwardMouse))..add(DiagnosticsProperty('pen', _this.pen))..add(DiagnosticsProperty('invertedPen', _this.invertedPen))..add(DiagnosticsProperty('firstPenButton', _this.firstPenButton))..add(DiagnosticsProperty('secondPenButton', _this.secondPenButton))..add(DiagnosticsProperty('touch', _this.touch))..add(DiagnosticsProperty('holdShortcuts', _this.holdShortcuts))..add(DiagnosticsProperty('doubleLeftMouseShortcut', _this.doubleLeftMouseShortcut))..add(DiagnosticsProperty('tripleLeftMouseShortcut', _this.tripleLeftMouseShortcut))..add(DiagnosticsProperty('doubleMiddleMouseShortcut', _this.doubleMiddleMouseShortcut))..add(DiagnosticsProperty('tripleMiddleMouseShortcut', _this.tripleMiddleMouseShortcut))..add(DiagnosticsProperty('doubleRightMouseShortcut', _this.doubleRightMouseShortcut))..add(DiagnosticsProperty('tripleRightMouseShortcut', _this.tripleRightMouseShortcut))..add(DiagnosticsProperty('doubleBackMouseShortcut', _this.doubleBackMouseShortcut))..add(DiagnosticsProperty('tripleBackMouseShortcut', _this.tripleBackMouseShortcut))..add(DiagnosticsProperty('doubleForwardMouseShortcut', _this.doubleForwardMouseShortcut))..add(DiagnosticsProperty('tripleForwardMouseShortcut', _this.tripleForwardMouseShortcut))..add(DiagnosticsProperty('doublePenShortcut', _this.doublePenShortcut))..add(DiagnosticsProperty('triplePenShortcut', _this.triplePenShortcut))..add(DiagnosticsProperty('doubleInvertedPenShortcut', _this.doubleInvertedPenShortcut))..add(DiagnosticsProperty('tripleInvertedPenShortcut', _this.tripleInvertedPenShortcut))..add(DiagnosticsProperty('doubleFirstPenButtonShortcut', _this.doubleFirstPenButtonShortcut))..add(DiagnosticsProperty('tripleFirstPenButtonShortcut', _this.tripleFirstPenButtonShortcut))..add(DiagnosticsProperty('doubleSecondPenButtonShortcut', _this.doubleSecondPenButtonShortcut))..add(DiagnosticsProperty('tripleSecondPenButtonShortcut', _this.tripleSecondPenButtonShortcut))..add(DiagnosticsProperty('doubleTouchShortcut', _this.doubleTouchShortcut))..add(DiagnosticsProperty('tripleTouchShortcut', _this.tripleTouchShortcut))..add(DiagnosticsProperty('twoFingerTouchShortcut', _this.twoFingerTouchShortcut))..add(DiagnosticsProperty('threeFingerTouchShortcut', _this.threeFingerTouchShortcut));
}

@override
bool operator ==(Object other) {
  final _this = this as InputConfiguration;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InputConfiguration&&(identical(other.leftMouse, _this.leftMouse) || other.leftMouse == _this.leftMouse)&&(identical(other.middleMouse, _this.middleMouse) || other.middleMouse == _this.middleMouse)&&(identical(other.rightMouse, _this.rightMouse) || other.rightMouse == _this.rightMouse)&&(identical(other.backMouse, _this.backMouse) || other.backMouse == _this.backMouse)&&(identical(other.forwardMouse, _this.forwardMouse) || other.forwardMouse == _this.forwardMouse)&&(identical(other.pen, _this.pen) || other.pen == _this.pen)&&(identical(other.invertedPen, _this.invertedPen) || other.invertedPen == _this.invertedPen)&&(identical(other.firstPenButton, _this.firstPenButton) || other.firstPenButton == _this.firstPenButton)&&(identical(other.secondPenButton, _this.secondPenButton) || other.secondPenButton == _this.secondPenButton)&&(identical(other.touch, _this.touch) || other.touch == _this.touch)&&const DeepCollectionEquality().equals(other.holdShortcuts, _this.holdShortcuts)&&(identical(other.doubleLeftMouseShortcut, _this.doubleLeftMouseShortcut) || other.doubleLeftMouseShortcut == _this.doubleLeftMouseShortcut)&&(identical(other.tripleLeftMouseShortcut, _this.tripleLeftMouseShortcut) || other.tripleLeftMouseShortcut == _this.tripleLeftMouseShortcut)&&(identical(other.doubleMiddleMouseShortcut, _this.doubleMiddleMouseShortcut) || other.doubleMiddleMouseShortcut == _this.doubleMiddleMouseShortcut)&&(identical(other.tripleMiddleMouseShortcut, _this.tripleMiddleMouseShortcut) || other.tripleMiddleMouseShortcut == _this.tripleMiddleMouseShortcut)&&(identical(other.doubleRightMouseShortcut, _this.doubleRightMouseShortcut) || other.doubleRightMouseShortcut == _this.doubleRightMouseShortcut)&&(identical(other.tripleRightMouseShortcut, _this.tripleRightMouseShortcut) || other.tripleRightMouseShortcut == _this.tripleRightMouseShortcut)&&(identical(other.doubleBackMouseShortcut, _this.doubleBackMouseShortcut) || other.doubleBackMouseShortcut == _this.doubleBackMouseShortcut)&&(identical(other.tripleBackMouseShortcut, _this.tripleBackMouseShortcut) || other.tripleBackMouseShortcut == _this.tripleBackMouseShortcut)&&(identical(other.doubleForwardMouseShortcut, _this.doubleForwardMouseShortcut) || other.doubleForwardMouseShortcut == _this.doubleForwardMouseShortcut)&&(identical(other.tripleForwardMouseShortcut, _this.tripleForwardMouseShortcut) || other.tripleForwardMouseShortcut == _this.tripleForwardMouseShortcut)&&(identical(other.doublePenShortcut, _this.doublePenShortcut) || other.doublePenShortcut == _this.doublePenShortcut)&&(identical(other.triplePenShortcut, _this.triplePenShortcut) || other.triplePenShortcut == _this.triplePenShortcut)&&(identical(other.doubleInvertedPenShortcut, _this.doubleInvertedPenShortcut) || other.doubleInvertedPenShortcut == _this.doubleInvertedPenShortcut)&&(identical(other.tripleInvertedPenShortcut, _this.tripleInvertedPenShortcut) || other.tripleInvertedPenShortcut == _this.tripleInvertedPenShortcut)&&(identical(other.doubleFirstPenButtonShortcut, _this.doubleFirstPenButtonShortcut) || other.doubleFirstPenButtonShortcut == _this.doubleFirstPenButtonShortcut)&&(identical(other.tripleFirstPenButtonShortcut, _this.tripleFirstPenButtonShortcut) || other.tripleFirstPenButtonShortcut == _this.tripleFirstPenButtonShortcut)&&(identical(other.doubleSecondPenButtonShortcut, _this.doubleSecondPenButtonShortcut) || other.doubleSecondPenButtonShortcut == _this.doubleSecondPenButtonShortcut)&&(identical(other.tripleSecondPenButtonShortcut, _this.tripleSecondPenButtonShortcut) || other.tripleSecondPenButtonShortcut == _this.tripleSecondPenButtonShortcut)&&(identical(other.doubleTouchShortcut, _this.doubleTouchShortcut) || other.doubleTouchShortcut == _this.doubleTouchShortcut)&&(identical(other.tripleTouchShortcut, _this.tripleTouchShortcut) || other.tripleTouchShortcut == _this.tripleTouchShortcut)&&(identical(other.twoFingerTouchShortcut, _this.twoFingerTouchShortcut) || other.twoFingerTouchShortcut == _this.twoFingerTouchShortcut)&&(identical(other.threeFingerTouchShortcut, _this.threeFingerTouchShortcut) || other.threeFingerTouchShortcut == _this.threeFingerTouchShortcut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InputConfiguration;
  return Object.hashAll([runtimeType,_this.leftMouse,_this.middleMouse,_this.rightMouse,_this.backMouse,_this.forwardMouse,_this.pen,_this.invertedPen,_this.firstPenButton,_this.secondPenButton,_this.touch,const DeepCollectionEquality().hash(_this.holdShortcuts),_this.doubleLeftMouseShortcut,_this.tripleLeftMouseShortcut,_this.doubleMiddleMouseShortcut,_this.tripleMiddleMouseShortcut,_this.doubleRightMouseShortcut,_this.tripleRightMouseShortcut,_this.doubleBackMouseShortcut,_this.tripleBackMouseShortcut,_this.doubleForwardMouseShortcut,_this.tripleForwardMouseShortcut,_this.doublePenShortcut,_this.triplePenShortcut,_this.doubleInvertedPenShortcut,_this.tripleInvertedPenShortcut,_this.doubleFirstPenButtonShortcut,_this.tripleFirstPenButtonShortcut,_this.doubleSecondPenButtonShortcut,_this.tripleSecondPenButtonShortcut,_this.doubleTouchShortcut,_this.tripleTouchShortcut,_this.twoFingerTouchShortcut,_this.threeFingerTouchShortcut]);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as InputConfiguration;
  return 'InputConfiguration(leftMouse: ${_this.leftMouse}, middleMouse: ${_this.middleMouse}, rightMouse: ${_this.rightMouse}, backMouse: ${_this.backMouse}, forwardMouse: ${_this.forwardMouse}, pen: ${_this.pen}, invertedPen: ${_this.invertedPen}, firstPenButton: ${_this.firstPenButton}, secondPenButton: ${_this.secondPenButton}, touch: ${_this.touch}, holdShortcuts: ${_this.holdShortcuts}, doubleLeftMouseShortcut: ${_this.doubleLeftMouseShortcut}, tripleLeftMouseShortcut: ${_this.tripleLeftMouseShortcut}, doubleMiddleMouseShortcut: ${_this.doubleMiddleMouseShortcut}, tripleMiddleMouseShortcut: ${_this.tripleMiddleMouseShortcut}, doubleRightMouseShortcut: ${_this.doubleRightMouseShortcut}, tripleRightMouseShortcut: ${_this.tripleRightMouseShortcut}, doubleBackMouseShortcut: ${_this.doubleBackMouseShortcut}, tripleBackMouseShortcut: ${_this.tripleBackMouseShortcut}, doubleForwardMouseShortcut: ${_this.doubleForwardMouseShortcut}, tripleForwardMouseShortcut: ${_this.tripleForwardMouseShortcut}, doublePenShortcut: ${_this.doublePenShortcut}, triplePenShortcut: ${_this.triplePenShortcut}, doubleInvertedPenShortcut: ${_this.doubleInvertedPenShortcut}, tripleInvertedPenShortcut: ${_this.tripleInvertedPenShortcut}, doubleFirstPenButtonShortcut: ${_this.doubleFirstPenButtonShortcut}, tripleFirstPenButtonShortcut: ${_this.tripleFirstPenButtonShortcut}, doubleSecondPenButtonShortcut: ${_this.doubleSecondPenButtonShortcut}, tripleSecondPenButtonShortcut: ${_this.tripleSecondPenButtonShortcut}, doubleTouchShortcut: ${_this.doubleTouchShortcut}, tripleTouchShortcut: ${_this.tripleTouchShortcut}, twoFingerTouchShortcut: ${_this.twoFingerTouchShortcut}, threeFingerTouchShortcut: ${_this.threeFingerTouchShortcut})';
}


}

/// @nodoc
abstract mixin class $InputConfigurationCopyWith<$Res>  {
  factory $InputConfigurationCopyWith(InputConfiguration value, $Res Function(InputConfiguration) _then) = _$InputConfigurationCopyWithImpl;
@useResult
$Res call({
 InputMapping leftMouse, InputMapping middleMouse, InputMapping rightMouse, InputMapping? backMouse, InputMapping? forwardMouse, InputMapping pen, InputMapping invertedPen, InputMapping firstPenButton, InputMapping secondPenButton, InputMapping touch, List<HoldShortcut> holdShortcuts, String? doubleLeftMouseShortcut, String? tripleLeftMouseShortcut, String? doubleMiddleMouseShortcut, String? tripleMiddleMouseShortcut, String? doubleRightMouseShortcut, String? tripleRightMouseShortcut, String? doubleBackMouseShortcut, String? tripleBackMouseShortcut, String? doubleForwardMouseShortcut, String? tripleForwardMouseShortcut, String? doublePenShortcut, String? triplePenShortcut, String? doubleInvertedPenShortcut, String? tripleInvertedPenShortcut, String? doubleFirstPenButtonShortcut, String? tripleFirstPenButtonShortcut, String? doubleSecondPenButtonShortcut, String? tripleSecondPenButtonShortcut, String? doubleTouchShortcut, String? tripleTouchShortcut, String? twoFingerTouchShortcut, String? threeFingerTouchShortcut
});




}
/// @nodoc
class _$InputConfigurationCopyWithImpl<$Res>
    implements $InputConfigurationCopyWith<$Res> {
  _$InputConfigurationCopyWithImpl(this._self, this._then);

  final InputConfiguration _self;
  final $Res Function(InputConfiguration) _then;

/// Create a copy of InputConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leftMouse = null,Object? middleMouse = null,Object? rightMouse = null,Object? backMouse = freezed,Object? forwardMouse = freezed,Object? pen = null,Object? invertedPen = null,Object? firstPenButton = null,Object? secondPenButton = null,Object? touch = null,Object? holdShortcuts = null,Object? doubleLeftMouseShortcut = freezed,Object? tripleLeftMouseShortcut = freezed,Object? doubleMiddleMouseShortcut = freezed,Object? tripleMiddleMouseShortcut = freezed,Object? doubleRightMouseShortcut = freezed,Object? tripleRightMouseShortcut = freezed,Object? doubleBackMouseShortcut = freezed,Object? tripleBackMouseShortcut = freezed,Object? doubleForwardMouseShortcut = freezed,Object? tripleForwardMouseShortcut = freezed,Object? doublePenShortcut = freezed,Object? triplePenShortcut = freezed,Object? doubleInvertedPenShortcut = freezed,Object? tripleInvertedPenShortcut = freezed,Object? doubleFirstPenButtonShortcut = freezed,Object? tripleFirstPenButtonShortcut = freezed,Object? doubleSecondPenButtonShortcut = freezed,Object? tripleSecondPenButtonShortcut = freezed,Object? doubleTouchShortcut = freezed,Object? tripleTouchShortcut = freezed,Object? twoFingerTouchShortcut = freezed,Object? threeFingerTouchShortcut = freezed,}) {
  return _then(InputConfiguration(
leftMouse: null == leftMouse ? _self.leftMouse : leftMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,middleMouse: null == middleMouse ? _self.middleMouse : middleMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,rightMouse: null == rightMouse ? _self.rightMouse : rightMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,backMouse: freezed == backMouse ? _self.backMouse : backMouse // ignore: cast_nullable_to_non_nullable
as InputMapping?,forwardMouse: freezed == forwardMouse ? _self.forwardMouse : forwardMouse // ignore: cast_nullable_to_non_nullable
as InputMapping?,pen: null == pen ? _self.pen : pen // ignore: cast_nullable_to_non_nullable
as InputMapping,invertedPen: null == invertedPen ? _self.invertedPen : invertedPen // ignore: cast_nullable_to_non_nullable
as InputMapping,firstPenButton: null == firstPenButton ? _self.firstPenButton : firstPenButton // ignore: cast_nullable_to_non_nullable
as InputMapping,secondPenButton: null == secondPenButton ? _self.secondPenButton : secondPenButton // ignore: cast_nullable_to_non_nullable
as InputMapping,touch: null == touch ? _self.touch : touch // ignore: cast_nullable_to_non_nullable
as InputMapping,holdShortcuts: null == holdShortcuts ? _self.holdShortcuts : holdShortcuts // ignore: cast_nullable_to_non_nullable
as List<HoldShortcut>,doubleLeftMouseShortcut: freezed == doubleLeftMouseShortcut ? _self.doubleLeftMouseShortcut : doubleLeftMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleLeftMouseShortcut: freezed == tripleLeftMouseShortcut ? _self.tripleLeftMouseShortcut : tripleLeftMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleMiddleMouseShortcut: freezed == doubleMiddleMouseShortcut ? _self.doubleMiddleMouseShortcut : doubleMiddleMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleMiddleMouseShortcut: freezed == tripleMiddleMouseShortcut ? _self.tripleMiddleMouseShortcut : tripleMiddleMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleRightMouseShortcut: freezed == doubleRightMouseShortcut ? _self.doubleRightMouseShortcut : doubleRightMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleRightMouseShortcut: freezed == tripleRightMouseShortcut ? _self.tripleRightMouseShortcut : tripleRightMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleBackMouseShortcut: freezed == doubleBackMouseShortcut ? _self.doubleBackMouseShortcut : doubleBackMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleBackMouseShortcut: freezed == tripleBackMouseShortcut ? _self.tripleBackMouseShortcut : tripleBackMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleForwardMouseShortcut: freezed == doubleForwardMouseShortcut ? _self.doubleForwardMouseShortcut : doubleForwardMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleForwardMouseShortcut: freezed == tripleForwardMouseShortcut ? _self.tripleForwardMouseShortcut : tripleForwardMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,doublePenShortcut: freezed == doublePenShortcut ? _self.doublePenShortcut : doublePenShortcut // ignore: cast_nullable_to_non_nullable
as String?,triplePenShortcut: freezed == triplePenShortcut ? _self.triplePenShortcut : triplePenShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleInvertedPenShortcut: freezed == doubleInvertedPenShortcut ? _self.doubleInvertedPenShortcut : doubleInvertedPenShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleInvertedPenShortcut: freezed == tripleInvertedPenShortcut ? _self.tripleInvertedPenShortcut : tripleInvertedPenShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleFirstPenButtonShortcut: freezed == doubleFirstPenButtonShortcut ? _self.doubleFirstPenButtonShortcut : doubleFirstPenButtonShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleFirstPenButtonShortcut: freezed == tripleFirstPenButtonShortcut ? _self.tripleFirstPenButtonShortcut : tripleFirstPenButtonShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleSecondPenButtonShortcut: freezed == doubleSecondPenButtonShortcut ? _self.doubleSecondPenButtonShortcut : doubleSecondPenButtonShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleSecondPenButtonShortcut: freezed == tripleSecondPenButtonShortcut ? _self.tripleSecondPenButtonShortcut : tripleSecondPenButtonShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleTouchShortcut: freezed == doubleTouchShortcut ? _self.doubleTouchShortcut : doubleTouchShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleTouchShortcut: freezed == tripleTouchShortcut ? _self.tripleTouchShortcut : tripleTouchShortcut // ignore: cast_nullable_to_non_nullable
as String?,twoFingerTouchShortcut: freezed == twoFingerTouchShortcut ? _self.twoFingerTouchShortcut : twoFingerTouchShortcut // ignore: cast_nullable_to_non_nullable
as String?,threeFingerTouchShortcut: freezed == threeFingerTouchShortcut ? _self.threeFingerTouchShortcut : threeFingerTouchShortcut // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _InputConfiguration extends InputConfiguration with DiagnosticableTreeMixin {
  const _InputConfiguration({this.leftMouse = InputMappingDefault.leftMouse, this.middleMouse = InputMappingDefault.middleMouse, this.rightMouse = InputMappingDefault.rightMouse, this.backMouse, this.forwardMouse, this.pen = InputMappingDefault.pen, this.invertedPen = InputMappingDefault.invertedPen, this.firstPenButton = InputMappingDefault.firstPenButton, this.secondPenButton = InputMappingDefault.secondPenButton, this.touch = InputMappingDefault.touch,  List<HoldShortcut> holdShortcuts = const [], this.doubleLeftMouseShortcut, this.tripleLeftMouseShortcut, this.doubleMiddleMouseShortcut, this.tripleMiddleMouseShortcut, this.doubleRightMouseShortcut, this.tripleRightMouseShortcut, this.doubleBackMouseShortcut, this.tripleBackMouseShortcut, this.doubleForwardMouseShortcut, this.tripleForwardMouseShortcut, this.doublePenShortcut, this.triplePenShortcut, this.doubleInvertedPenShortcut, this.tripleInvertedPenShortcut, this.doubleFirstPenButtonShortcut, this.tripleFirstPenButtonShortcut, this.doubleSecondPenButtonShortcut, this.tripleSecondPenButtonShortcut, this.doubleTouchShortcut, this.tripleTouchShortcut, this.twoFingerTouchShortcut, this.threeFingerTouchShortcut}): _holdShortcuts = holdShortcuts,super._();
  factory _InputConfiguration.fromJson(Map<String, dynamic> json) => _$InputConfigurationFromJson(json);

@override@JsonKey() final  InputMapping leftMouse;
@override@JsonKey() final  InputMapping middleMouse;
@override@JsonKey() final  InputMapping rightMouse;
@override final  InputMapping? backMouse;
@override final  InputMapping? forwardMouse;
@override@JsonKey() final  InputMapping pen;
@override@JsonKey() final  InputMapping invertedPen;
@override@JsonKey() final  InputMapping firstPenButton;
@override@JsonKey() final  InputMapping secondPenButton;
@override@JsonKey() final  InputMapping touch;
 final  List<HoldShortcut> _holdShortcuts;
@override@JsonKey() List<HoldShortcut> get holdShortcuts {
  if (_holdShortcuts is EqualUnmodifiableListView) return _holdShortcuts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_holdShortcuts);
}

@override final  String? doubleLeftMouseShortcut;
@override final  String? tripleLeftMouseShortcut;
@override final  String? doubleMiddleMouseShortcut;
@override final  String? tripleMiddleMouseShortcut;
@override final  String? doubleRightMouseShortcut;
@override final  String? tripleRightMouseShortcut;
@override final  String? doubleBackMouseShortcut;
@override final  String? tripleBackMouseShortcut;
@override final  String? doubleForwardMouseShortcut;
@override final  String? tripleForwardMouseShortcut;
@override final  String? doublePenShortcut;
@override final  String? triplePenShortcut;
@override final  String? doubleInvertedPenShortcut;
@override final  String? tripleInvertedPenShortcut;
@override final  String? doubleFirstPenButtonShortcut;
@override final  String? tripleFirstPenButtonShortcut;
@override final  String? doubleSecondPenButtonShortcut;
@override final  String? tripleSecondPenButtonShortcut;
@override final  String? doubleTouchShortcut;
@override final  String? tripleTouchShortcut;
@override final  String? twoFingerTouchShortcut;
@override final  String? threeFingerTouchShortcut;

/// Create a copy of InputConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InputConfigurationCopyWith<_InputConfiguration> get copyWith => __$InputConfigurationCopyWithImpl<_InputConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InputConfigurationToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'InputConfiguration'))
    ..add(DiagnosticsProperty('leftMouse', leftMouse))..add(DiagnosticsProperty('middleMouse', middleMouse))..add(DiagnosticsProperty('rightMouse', rightMouse))..add(DiagnosticsProperty('backMouse', backMouse))..add(DiagnosticsProperty('forwardMouse', forwardMouse))..add(DiagnosticsProperty('pen', pen))..add(DiagnosticsProperty('invertedPen', invertedPen))..add(DiagnosticsProperty('firstPenButton', firstPenButton))..add(DiagnosticsProperty('secondPenButton', secondPenButton))..add(DiagnosticsProperty('touch', touch))..add(DiagnosticsProperty('holdShortcuts', holdShortcuts))..add(DiagnosticsProperty('doubleLeftMouseShortcut', doubleLeftMouseShortcut))..add(DiagnosticsProperty('tripleLeftMouseShortcut', tripleLeftMouseShortcut))..add(DiagnosticsProperty('doubleMiddleMouseShortcut', doubleMiddleMouseShortcut))..add(DiagnosticsProperty('tripleMiddleMouseShortcut', tripleMiddleMouseShortcut))..add(DiagnosticsProperty('doubleRightMouseShortcut', doubleRightMouseShortcut))..add(DiagnosticsProperty('tripleRightMouseShortcut', tripleRightMouseShortcut))..add(DiagnosticsProperty('doubleBackMouseShortcut', doubleBackMouseShortcut))..add(DiagnosticsProperty('tripleBackMouseShortcut', tripleBackMouseShortcut))..add(DiagnosticsProperty('doubleForwardMouseShortcut', doubleForwardMouseShortcut))..add(DiagnosticsProperty('tripleForwardMouseShortcut', tripleForwardMouseShortcut))..add(DiagnosticsProperty('doublePenShortcut', doublePenShortcut))..add(DiagnosticsProperty('triplePenShortcut', triplePenShortcut))..add(DiagnosticsProperty('doubleInvertedPenShortcut', doubleInvertedPenShortcut))..add(DiagnosticsProperty('tripleInvertedPenShortcut', tripleInvertedPenShortcut))..add(DiagnosticsProperty('doubleFirstPenButtonShortcut', doubleFirstPenButtonShortcut))..add(DiagnosticsProperty('tripleFirstPenButtonShortcut', tripleFirstPenButtonShortcut))..add(DiagnosticsProperty('doubleSecondPenButtonShortcut', doubleSecondPenButtonShortcut))..add(DiagnosticsProperty('tripleSecondPenButtonShortcut', tripleSecondPenButtonShortcut))..add(DiagnosticsProperty('doubleTouchShortcut', doubleTouchShortcut))..add(DiagnosticsProperty('tripleTouchShortcut', tripleTouchShortcut))..add(DiagnosticsProperty('twoFingerTouchShortcut', twoFingerTouchShortcut))..add(DiagnosticsProperty('threeFingerTouchShortcut', threeFingerTouchShortcut));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InputConfiguration&&(identical(other.leftMouse, leftMouse) || other.leftMouse == leftMouse)&&(identical(other.middleMouse, middleMouse) || other.middleMouse == middleMouse)&&(identical(other.rightMouse, rightMouse) || other.rightMouse == rightMouse)&&(identical(other.backMouse, backMouse) || other.backMouse == backMouse)&&(identical(other.forwardMouse, forwardMouse) || other.forwardMouse == forwardMouse)&&(identical(other.pen, pen) || other.pen == pen)&&(identical(other.invertedPen, invertedPen) || other.invertedPen == invertedPen)&&(identical(other.firstPenButton, firstPenButton) || other.firstPenButton == firstPenButton)&&(identical(other.secondPenButton, secondPenButton) || other.secondPenButton == secondPenButton)&&(identical(other.touch, touch) || other.touch == touch)&&const DeepCollectionEquality().equals(other.holdShortcuts, _holdShortcuts)&&(identical(other.doubleLeftMouseShortcut, doubleLeftMouseShortcut) || other.doubleLeftMouseShortcut == doubleLeftMouseShortcut)&&(identical(other.tripleLeftMouseShortcut, tripleLeftMouseShortcut) || other.tripleLeftMouseShortcut == tripleLeftMouseShortcut)&&(identical(other.doubleMiddleMouseShortcut, doubleMiddleMouseShortcut) || other.doubleMiddleMouseShortcut == doubleMiddleMouseShortcut)&&(identical(other.tripleMiddleMouseShortcut, tripleMiddleMouseShortcut) || other.tripleMiddleMouseShortcut == tripleMiddleMouseShortcut)&&(identical(other.doubleRightMouseShortcut, doubleRightMouseShortcut) || other.doubleRightMouseShortcut == doubleRightMouseShortcut)&&(identical(other.tripleRightMouseShortcut, tripleRightMouseShortcut) || other.tripleRightMouseShortcut == tripleRightMouseShortcut)&&(identical(other.doubleBackMouseShortcut, doubleBackMouseShortcut) || other.doubleBackMouseShortcut == doubleBackMouseShortcut)&&(identical(other.tripleBackMouseShortcut, tripleBackMouseShortcut) || other.tripleBackMouseShortcut == tripleBackMouseShortcut)&&(identical(other.doubleForwardMouseShortcut, doubleForwardMouseShortcut) || other.doubleForwardMouseShortcut == doubleForwardMouseShortcut)&&(identical(other.tripleForwardMouseShortcut, tripleForwardMouseShortcut) || other.tripleForwardMouseShortcut == tripleForwardMouseShortcut)&&(identical(other.doublePenShortcut, doublePenShortcut) || other.doublePenShortcut == doublePenShortcut)&&(identical(other.triplePenShortcut, triplePenShortcut) || other.triplePenShortcut == triplePenShortcut)&&(identical(other.doubleInvertedPenShortcut, doubleInvertedPenShortcut) || other.doubleInvertedPenShortcut == doubleInvertedPenShortcut)&&(identical(other.tripleInvertedPenShortcut, tripleInvertedPenShortcut) || other.tripleInvertedPenShortcut == tripleInvertedPenShortcut)&&(identical(other.doubleFirstPenButtonShortcut, doubleFirstPenButtonShortcut) || other.doubleFirstPenButtonShortcut == doubleFirstPenButtonShortcut)&&(identical(other.tripleFirstPenButtonShortcut, tripleFirstPenButtonShortcut) || other.tripleFirstPenButtonShortcut == tripleFirstPenButtonShortcut)&&(identical(other.doubleSecondPenButtonShortcut, doubleSecondPenButtonShortcut) || other.doubleSecondPenButtonShortcut == doubleSecondPenButtonShortcut)&&(identical(other.tripleSecondPenButtonShortcut, tripleSecondPenButtonShortcut) || other.tripleSecondPenButtonShortcut == tripleSecondPenButtonShortcut)&&(identical(other.doubleTouchShortcut, doubleTouchShortcut) || other.doubleTouchShortcut == doubleTouchShortcut)&&(identical(other.tripleTouchShortcut, tripleTouchShortcut) || other.tripleTouchShortcut == tripleTouchShortcut)&&(identical(other.twoFingerTouchShortcut, twoFingerTouchShortcut) || other.twoFingerTouchShortcut == twoFingerTouchShortcut)&&(identical(other.threeFingerTouchShortcut, threeFingerTouchShortcut) || other.threeFingerTouchShortcut == threeFingerTouchShortcut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,leftMouse,middleMouse,rightMouse,backMouse,forwardMouse,pen,invertedPen,firstPenButton,secondPenButton,touch,const DeepCollectionEquality().hash(_holdShortcuts),doubleLeftMouseShortcut,tripleLeftMouseShortcut,doubleMiddleMouseShortcut,tripleMiddleMouseShortcut,doubleRightMouseShortcut,tripleRightMouseShortcut,doubleBackMouseShortcut,tripleBackMouseShortcut,doubleForwardMouseShortcut,tripleForwardMouseShortcut,doublePenShortcut,triplePenShortcut,doubleInvertedPenShortcut,tripleInvertedPenShortcut,doubleFirstPenButtonShortcut,tripleFirstPenButtonShortcut,doubleSecondPenButtonShortcut,tripleSecondPenButtonShortcut,doubleTouchShortcut,tripleTouchShortcut,twoFingerTouchShortcut,threeFingerTouchShortcut]);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'InputConfiguration(leftMouse: $leftMouse, middleMouse: $middleMouse, rightMouse: $rightMouse, backMouse: $backMouse, forwardMouse: $forwardMouse, pen: $pen, invertedPen: $invertedPen, firstPenButton: $firstPenButton, secondPenButton: $secondPenButton, touch: $touch, holdShortcuts: $holdShortcuts, doubleLeftMouseShortcut: $doubleLeftMouseShortcut, tripleLeftMouseShortcut: $tripleLeftMouseShortcut, doubleMiddleMouseShortcut: $doubleMiddleMouseShortcut, tripleMiddleMouseShortcut: $tripleMiddleMouseShortcut, doubleRightMouseShortcut: $doubleRightMouseShortcut, tripleRightMouseShortcut: $tripleRightMouseShortcut, doubleBackMouseShortcut: $doubleBackMouseShortcut, tripleBackMouseShortcut: $tripleBackMouseShortcut, doubleForwardMouseShortcut: $doubleForwardMouseShortcut, tripleForwardMouseShortcut: $tripleForwardMouseShortcut, doublePenShortcut: $doublePenShortcut, triplePenShortcut: $triplePenShortcut, doubleInvertedPenShortcut: $doubleInvertedPenShortcut, tripleInvertedPenShortcut: $tripleInvertedPenShortcut, doubleFirstPenButtonShortcut: $doubleFirstPenButtonShortcut, tripleFirstPenButtonShortcut: $tripleFirstPenButtonShortcut, doubleSecondPenButtonShortcut: $doubleSecondPenButtonShortcut, tripleSecondPenButtonShortcut: $tripleSecondPenButtonShortcut, doubleTouchShortcut: $doubleTouchShortcut, tripleTouchShortcut: $tripleTouchShortcut, twoFingerTouchShortcut: $twoFingerTouchShortcut, threeFingerTouchShortcut: $threeFingerTouchShortcut)';
}


}

/// @nodoc
abstract mixin class _$InputConfigurationCopyWith<$Res> implements $InputConfigurationCopyWith<$Res> {
  factory _$InputConfigurationCopyWith(_InputConfiguration value, $Res Function(_InputConfiguration) _then) = __$InputConfigurationCopyWithImpl;
@override @useResult
$Res call({
 InputMapping leftMouse, InputMapping middleMouse, InputMapping rightMouse, InputMapping? backMouse, InputMapping? forwardMouse, InputMapping pen, InputMapping invertedPen, InputMapping firstPenButton, InputMapping secondPenButton, InputMapping touch, List<HoldShortcut> holdShortcuts, String? doubleLeftMouseShortcut, String? tripleLeftMouseShortcut, String? doubleMiddleMouseShortcut, String? tripleMiddleMouseShortcut, String? doubleRightMouseShortcut, String? tripleRightMouseShortcut, String? doubleBackMouseShortcut, String? tripleBackMouseShortcut, String? doubleForwardMouseShortcut, String? tripleForwardMouseShortcut, String? doublePenShortcut, String? triplePenShortcut, String? doubleInvertedPenShortcut, String? tripleInvertedPenShortcut, String? doubleFirstPenButtonShortcut, String? tripleFirstPenButtonShortcut, String? doubleSecondPenButtonShortcut, String? tripleSecondPenButtonShortcut, String? doubleTouchShortcut, String? tripleTouchShortcut, String? twoFingerTouchShortcut, String? threeFingerTouchShortcut
});




}
/// @nodoc
class __$InputConfigurationCopyWithImpl<$Res>
    implements _$InputConfigurationCopyWith<$Res> {
  __$InputConfigurationCopyWithImpl(this._self, this._then);

  final _InputConfiguration _self;
  final $Res Function(_InputConfiguration) _then;

/// Create a copy of InputConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leftMouse = null,Object? middleMouse = null,Object? rightMouse = null,Object? backMouse = freezed,Object? forwardMouse = freezed,Object? pen = null,Object? invertedPen = null,Object? firstPenButton = null,Object? secondPenButton = null,Object? touch = null,Object? holdShortcuts = null,Object? doubleLeftMouseShortcut = freezed,Object? tripleLeftMouseShortcut = freezed,Object? doubleMiddleMouseShortcut = freezed,Object? tripleMiddleMouseShortcut = freezed,Object? doubleRightMouseShortcut = freezed,Object? tripleRightMouseShortcut = freezed,Object? doubleBackMouseShortcut = freezed,Object? tripleBackMouseShortcut = freezed,Object? doubleForwardMouseShortcut = freezed,Object? tripleForwardMouseShortcut = freezed,Object? doublePenShortcut = freezed,Object? triplePenShortcut = freezed,Object? doubleInvertedPenShortcut = freezed,Object? tripleInvertedPenShortcut = freezed,Object? doubleFirstPenButtonShortcut = freezed,Object? tripleFirstPenButtonShortcut = freezed,Object? doubleSecondPenButtonShortcut = freezed,Object? tripleSecondPenButtonShortcut = freezed,Object? doubleTouchShortcut = freezed,Object? tripleTouchShortcut = freezed,Object? twoFingerTouchShortcut = freezed,Object? threeFingerTouchShortcut = freezed,}) {
  return _then(_InputConfiguration(
leftMouse: null == leftMouse ? _self.leftMouse : leftMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,middleMouse: null == middleMouse ? _self.middleMouse : middleMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,rightMouse: null == rightMouse ? _self.rightMouse : rightMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,backMouse: freezed == backMouse ? _self.backMouse : backMouse // ignore: cast_nullable_to_non_nullable
as InputMapping?,forwardMouse: freezed == forwardMouse ? _self.forwardMouse : forwardMouse // ignore: cast_nullable_to_non_nullable
as InputMapping?,pen: null == pen ? _self.pen : pen // ignore: cast_nullable_to_non_nullable
as InputMapping,invertedPen: null == invertedPen ? _self.invertedPen : invertedPen // ignore: cast_nullable_to_non_nullable
as InputMapping,firstPenButton: null == firstPenButton ? _self.firstPenButton : firstPenButton // ignore: cast_nullable_to_non_nullable
as InputMapping,secondPenButton: null == secondPenButton ? _self.secondPenButton : secondPenButton // ignore: cast_nullable_to_non_nullable
as InputMapping,touch: null == touch ? _self.touch : touch // ignore: cast_nullable_to_non_nullable
as InputMapping,holdShortcuts: null == holdShortcuts ? _self._holdShortcuts : holdShortcuts // ignore: cast_nullable_to_non_nullable
as List<HoldShortcut>,doubleLeftMouseShortcut: freezed == doubleLeftMouseShortcut ? _self.doubleLeftMouseShortcut : doubleLeftMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleLeftMouseShortcut: freezed == tripleLeftMouseShortcut ? _self.tripleLeftMouseShortcut : tripleLeftMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleMiddleMouseShortcut: freezed == doubleMiddleMouseShortcut ? _self.doubleMiddleMouseShortcut : doubleMiddleMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleMiddleMouseShortcut: freezed == tripleMiddleMouseShortcut ? _self.tripleMiddleMouseShortcut : tripleMiddleMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleRightMouseShortcut: freezed == doubleRightMouseShortcut ? _self.doubleRightMouseShortcut : doubleRightMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleRightMouseShortcut: freezed == tripleRightMouseShortcut ? _self.tripleRightMouseShortcut : tripleRightMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleBackMouseShortcut: freezed == doubleBackMouseShortcut ? _self.doubleBackMouseShortcut : doubleBackMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleBackMouseShortcut: freezed == tripleBackMouseShortcut ? _self.tripleBackMouseShortcut : tripleBackMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleForwardMouseShortcut: freezed == doubleForwardMouseShortcut ? _self.doubleForwardMouseShortcut : doubleForwardMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleForwardMouseShortcut: freezed == tripleForwardMouseShortcut ? _self.tripleForwardMouseShortcut : tripleForwardMouseShortcut // ignore: cast_nullable_to_non_nullable
as String?,doublePenShortcut: freezed == doublePenShortcut ? _self.doublePenShortcut : doublePenShortcut // ignore: cast_nullable_to_non_nullable
as String?,triplePenShortcut: freezed == triplePenShortcut ? _self.triplePenShortcut : triplePenShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleInvertedPenShortcut: freezed == doubleInvertedPenShortcut ? _self.doubleInvertedPenShortcut : doubleInvertedPenShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleInvertedPenShortcut: freezed == tripleInvertedPenShortcut ? _self.tripleInvertedPenShortcut : tripleInvertedPenShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleFirstPenButtonShortcut: freezed == doubleFirstPenButtonShortcut ? _self.doubleFirstPenButtonShortcut : doubleFirstPenButtonShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleFirstPenButtonShortcut: freezed == tripleFirstPenButtonShortcut ? _self.tripleFirstPenButtonShortcut : tripleFirstPenButtonShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleSecondPenButtonShortcut: freezed == doubleSecondPenButtonShortcut ? _self.doubleSecondPenButtonShortcut : doubleSecondPenButtonShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleSecondPenButtonShortcut: freezed == tripleSecondPenButtonShortcut ? _self.tripleSecondPenButtonShortcut : tripleSecondPenButtonShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleTouchShortcut: freezed == doubleTouchShortcut ? _self.doubleTouchShortcut : doubleTouchShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleTouchShortcut: freezed == tripleTouchShortcut ? _self.tripleTouchShortcut : tripleTouchShortcut // ignore: cast_nullable_to_non_nullable
as String?,twoFingerTouchShortcut: freezed == twoFingerTouchShortcut ? _self.twoFingerTouchShortcut : twoFingerTouchShortcut // ignore: cast_nullable_to_non_nullable
as String?,threeFingerTouchShortcut: freezed == threeFingerTouchShortcut ? _self.threeFingerTouchShortcut : threeFingerTouchShortcut // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DocumentStatePersistenceSettings implements DiagnosticableTreeMixin {

 bool get enabled; bool get page; bool get camera; bool get locks; bool get tool; bool get navigator; bool get layers; bool get areas; int get maxEntries; int get maxAgeDays;
/// Create a copy of DocumentStatePersistenceSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentStatePersistenceSettingsCopyWith<DocumentStatePersistenceSettings> get copyWith => _$DocumentStatePersistenceSettingsCopyWithImpl<DocumentStatePersistenceSettings>(this as DocumentStatePersistenceSettings, _$identity);

  /// Serializes this DocumentStatePersistenceSettings to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as DocumentStatePersistenceSettings;
  properties
    ..add(DiagnosticsProperty('type', 'DocumentStatePersistenceSettings'))
    ..add(DiagnosticsProperty('enabled', _this.enabled))..add(DiagnosticsProperty('page', _this.page))..add(DiagnosticsProperty('camera', _this.camera))..add(DiagnosticsProperty('locks', _this.locks))..add(DiagnosticsProperty('tool', _this.tool))..add(DiagnosticsProperty('navigator', _this.navigator))..add(DiagnosticsProperty('layers', _this.layers))..add(DiagnosticsProperty('areas', _this.areas))..add(DiagnosticsProperty('maxEntries', _this.maxEntries))..add(DiagnosticsProperty('maxAgeDays', _this.maxAgeDays));
}

@override
bool operator ==(Object other) {
  final _this = this as DocumentStatePersistenceSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentStatePersistenceSettings&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.camera, _this.camera) || other.camera == _this.camera)&&(identical(other.locks, _this.locks) || other.locks == _this.locks)&&(identical(other.tool, _this.tool) || other.tool == _this.tool)&&(identical(other.navigator, _this.navigator) || other.navigator == _this.navigator)&&(identical(other.layers, _this.layers) || other.layers == _this.layers)&&(identical(other.areas, _this.areas) || other.areas == _this.areas)&&(identical(other.maxEntries, _this.maxEntries) || other.maxEntries == _this.maxEntries)&&(identical(other.maxAgeDays, _this.maxAgeDays) || other.maxAgeDays == _this.maxAgeDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DocumentStatePersistenceSettings;
  return Object.hash(runtimeType,_this.enabled,_this.page,_this.camera,_this.locks,_this.tool,_this.navigator,_this.layers,_this.areas,_this.maxEntries,_this.maxAgeDays);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as DocumentStatePersistenceSettings;
  return 'DocumentStatePersistenceSettings(enabled: ${_this.enabled}, page: ${_this.page}, camera: ${_this.camera}, locks: ${_this.locks}, tool: ${_this.tool}, navigator: ${_this.navigator}, layers: ${_this.layers}, areas: ${_this.areas}, maxEntries: ${_this.maxEntries}, maxAgeDays: ${_this.maxAgeDays})';
}


}

/// @nodoc
abstract mixin class $DocumentStatePersistenceSettingsCopyWith<$Res>  {
  factory $DocumentStatePersistenceSettingsCopyWith(DocumentStatePersistenceSettings value, $Res Function(DocumentStatePersistenceSettings) _then) = _$DocumentStatePersistenceSettingsCopyWithImpl;
@useResult
$Res call({
 bool enabled, bool page, bool camera, bool locks, bool tool, bool navigator, bool layers, bool areas, int maxEntries, int maxAgeDays
});




}
/// @nodoc
class _$DocumentStatePersistenceSettingsCopyWithImpl<$Res>
    implements $DocumentStatePersistenceSettingsCopyWith<$Res> {
  _$DocumentStatePersistenceSettingsCopyWithImpl(this._self, this._then);

  final DocumentStatePersistenceSettings _self;
  final $Res Function(DocumentStatePersistenceSettings) _then;

/// Create a copy of DocumentStatePersistenceSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? page = null,Object? camera = null,Object? locks = null,Object? tool = null,Object? navigator = null,Object? layers = null,Object? areas = null,Object? maxEntries = null,Object? maxAgeDays = null,}) {
  return _then(DocumentStatePersistenceSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as bool,camera: null == camera ? _self.camera : camera // ignore: cast_nullable_to_non_nullable
as bool,locks: null == locks ? _self.locks : locks // ignore: cast_nullable_to_non_nullable
as bool,tool: null == tool ? _self.tool : tool // ignore: cast_nullable_to_non_nullable
as bool,navigator: null == navigator ? _self.navigator : navigator // ignore: cast_nullable_to_non_nullable
as bool,layers: null == layers ? _self.layers : layers // ignore: cast_nullable_to_non_nullable
as bool,areas: null == areas ? _self.areas : areas // ignore: cast_nullable_to_non_nullable
as bool,maxEntries: null == maxEntries ? _self.maxEntries : maxEntries // ignore: cast_nullable_to_non_nullable
as int,maxAgeDays: null == maxAgeDays ? _self.maxAgeDays : maxAgeDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _DocumentStatePersistenceSettings with DiagnosticableTreeMixin implements DocumentStatePersistenceSettings {
  const _DocumentStatePersistenceSettings({this.enabled = true, this.page = true, this.camera = true, this.locks = true, this.tool = true, this.navigator = true, this.layers = true, this.areas = true, this.maxEntries = 400, this.maxAgeDays = 180});
  factory _DocumentStatePersistenceSettings.fromJson(Map<String, dynamic> json) => _$DocumentStatePersistenceSettingsFromJson(json);

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  bool page;
@override@JsonKey() final  bool camera;
@override@JsonKey() final  bool locks;
@override@JsonKey() final  bool tool;
@override@JsonKey() final  bool navigator;
@override@JsonKey() final  bool layers;
@override@JsonKey() final  bool areas;
@override@JsonKey() final  int maxEntries;
@override@JsonKey() final  int maxAgeDays;

/// Create a copy of DocumentStatePersistenceSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentStatePersistenceSettingsCopyWith<_DocumentStatePersistenceSettings> get copyWith => __$DocumentStatePersistenceSettingsCopyWithImpl<_DocumentStatePersistenceSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentStatePersistenceSettingsToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'DocumentStatePersistenceSettings'))
    ..add(DiagnosticsProperty('enabled', enabled))..add(DiagnosticsProperty('page', page))..add(DiagnosticsProperty('camera', camera))..add(DiagnosticsProperty('locks', locks))..add(DiagnosticsProperty('tool', tool))..add(DiagnosticsProperty('navigator', navigator))..add(DiagnosticsProperty('layers', layers))..add(DiagnosticsProperty('areas', areas))..add(DiagnosticsProperty('maxEntries', maxEntries))..add(DiagnosticsProperty('maxAgeDays', maxAgeDays));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentStatePersistenceSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.page, page) || other.page == page)&&(identical(other.camera, camera) || other.camera == camera)&&(identical(other.locks, locks) || other.locks == locks)&&(identical(other.tool, tool) || other.tool == tool)&&(identical(other.navigator, navigator) || other.navigator == navigator)&&(identical(other.layers, layers) || other.layers == layers)&&(identical(other.areas, areas) || other.areas == areas)&&(identical(other.maxEntries, maxEntries) || other.maxEntries == maxEntries)&&(identical(other.maxAgeDays, maxAgeDays) || other.maxAgeDays == maxAgeDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,enabled,page,camera,locks,tool,navigator,layers,areas,maxEntries,maxAgeDays);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'DocumentStatePersistenceSettings(enabled: $enabled, page: $page, camera: $camera, locks: $locks, tool: $tool, navigator: $navigator, layers: $layers, areas: $areas, maxEntries: $maxEntries, maxAgeDays: $maxAgeDays)';
}


}

/// @nodoc
abstract mixin class _$DocumentStatePersistenceSettingsCopyWith<$Res> implements $DocumentStatePersistenceSettingsCopyWith<$Res> {
  factory _$DocumentStatePersistenceSettingsCopyWith(_DocumentStatePersistenceSettings value, $Res Function(_DocumentStatePersistenceSettings) _then) = __$DocumentStatePersistenceSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, bool page, bool camera, bool locks, bool tool, bool navigator, bool layers, bool areas, int maxEntries, int maxAgeDays
});




}
/// @nodoc
class __$DocumentStatePersistenceSettingsCopyWithImpl<$Res>
    implements _$DocumentStatePersistenceSettingsCopyWith<$Res> {
  __$DocumentStatePersistenceSettingsCopyWithImpl(this._self, this._then);

  final _DocumentStatePersistenceSettings _self;
  final $Res Function(_DocumentStatePersistenceSettings) _then;

/// Create a copy of DocumentStatePersistenceSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? page = null,Object? camera = null,Object? locks = null,Object? tool = null,Object? navigator = null,Object? layers = null,Object? areas = null,Object? maxEntries = null,Object? maxAgeDays = null,}) {
  return _then(_DocumentStatePersistenceSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as bool,camera: null == camera ? _self.camera : camera // ignore: cast_nullable_to_non_nullable
as bool,locks: null == locks ? _self.locks : locks // ignore: cast_nullable_to_non_nullable
as bool,tool: null == tool ? _self.tool : tool // ignore: cast_nullable_to_non_nullable
as bool,navigator: null == navigator ? _self.navigator : navigator // ignore: cast_nullable_to_non_nullable
as bool,layers: null == layers ? _self.layers : layers // ignore: cast_nullable_to_non_nullable
as bool,areas: null == areas ? _self.areas : areas // ignore: cast_nullable_to_non_nullable
as bool,maxEntries: null == maxEntries ? _self.maxEntries : maxEntries // ignore: cast_nullable_to_non_nullable
as int,maxAgeDays: null == maxAgeDays ? _self.maxAgeDays : maxAgeDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ButterflySettings implements DiagnosticableTreeMixin {

 ThemeMode get theme; ThemeDensity get density; double? get limitViewportMultiplier; bool get limitViewportPositive; String get localeTag; String get documentPath; double get gestureSensitivity; double get touchSensitivity; double get selectSensitivity; double get scrollSensitivity; double get rotationStep; double get zoomStep; bool? get penOnlyInput; bool get showPenOnlyToggle; bool get inputGestures; String get design; BannerVisibility get bannerVisibility;@JsonKey(includeFromJson: false, includeToJson: false) List<AssetLocation> get history; bool get zoomEnabled; ZoomPosition get zoomPosition; ZoomPosition get propertyPosition; String? get lastVersion;@JsonKey(includeFromJson: false, includeToJson: false) List<ExternalStorage> get connections; String get defaultRemote; bool get nativeTitleBar; bool get startInFullScreen; bool get navigationRail; IgnorePressure get ignorePressure; SyncMode get syncMode; bool get automaticBackup; String get backupRemote; int get backupIntervalMinutes; DateTime? get lastBackup; InputConfiguration get inputConfiguration; String get fallbackPack; List<String> get starred; List<FavoriteLocation> get favoriteTemplates; String get defaultTemplate; String get defaultFileName; NavigatorPosition get navigatorPosition; ToolbarPosition get toolbarPosition; ToolbarSize get toolbarSize; SortBy get sortBy; SortOrder get sortOrder; double get imageScale; PlatformTheme get platformTheme;@SRGBConverter() List<SRGBColor> get recentColors; List<String> get flags; bool get spreadPages; bool get highContrast; bool get gridView; bool get hideExtension; bool get autosave; bool get showSaveButton; int get toolbarRows; bool get delayedAutosave; int get autosaveDelaySeconds; bool get hideCursorWhileDrawing; StartupBehavior get onStartup; DocumentStatePersistenceSettings get documentStatePersistence; SimpleToolbarVisibility get simpleToolbarVisibility; OptionsPanelPosition get optionsPanelPosition; RenderResolution get renderResolution; bool get moveOnGesture; bool get rotateOnGesture; List<String> get swamps; PackAssetLocation? get selectedPalette; bool get showVerboseLogs; bool get showThumbnails; bool get showNavigatorPreviews; bool get bringMovedElementsToFront; List<PackAssetLocation> get favoriteTools;
/// Create a copy of ButterflySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ButterflySettingsCopyWith<ButterflySettings> get copyWith => _$ButterflySettingsCopyWithImpl<ButterflySettings>(this as ButterflySettings, _$identity);

  /// Serializes this ButterflySettings to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as ButterflySettings;
  properties
    ..add(DiagnosticsProperty('type', 'ButterflySettings'))
    ..add(DiagnosticsProperty('theme', _this.theme))..add(DiagnosticsProperty('density', _this.density))..add(DiagnosticsProperty('limitViewportMultiplier', _this.limitViewportMultiplier))..add(DiagnosticsProperty('limitViewportPositive', _this.limitViewportPositive))..add(DiagnosticsProperty('localeTag', _this.localeTag))..add(DiagnosticsProperty('documentPath', _this.documentPath))..add(DiagnosticsProperty('gestureSensitivity', _this.gestureSensitivity))..add(DiagnosticsProperty('touchSensitivity', _this.touchSensitivity))..add(DiagnosticsProperty('selectSensitivity', _this.selectSensitivity))..add(DiagnosticsProperty('scrollSensitivity', _this.scrollSensitivity))..add(DiagnosticsProperty('rotationStep', _this.rotationStep))..add(DiagnosticsProperty('zoomStep', _this.zoomStep))..add(DiagnosticsProperty('penOnlyInput', _this.penOnlyInput))..add(DiagnosticsProperty('showPenOnlyToggle', _this.showPenOnlyToggle))..add(DiagnosticsProperty('inputGestures', _this.inputGestures))..add(DiagnosticsProperty('design', _this.design))..add(DiagnosticsProperty('bannerVisibility', _this.bannerVisibility))..add(DiagnosticsProperty('history', _this.history))..add(DiagnosticsProperty('zoomEnabled', _this.zoomEnabled))..add(DiagnosticsProperty('zoomPosition', _this.zoomPosition))..add(DiagnosticsProperty('propertyPosition', _this.propertyPosition))..add(DiagnosticsProperty('lastVersion', _this.lastVersion))..add(DiagnosticsProperty('connections', _this.connections))..add(DiagnosticsProperty('defaultRemote', _this.defaultRemote))..add(DiagnosticsProperty('nativeTitleBar', _this.nativeTitleBar))..add(DiagnosticsProperty('startInFullScreen', _this.startInFullScreen))..add(DiagnosticsProperty('navigationRail', _this.navigationRail))..add(DiagnosticsProperty('ignorePressure', _this.ignorePressure))..add(DiagnosticsProperty('syncMode', _this.syncMode))..add(DiagnosticsProperty('automaticBackup', _this.automaticBackup))..add(DiagnosticsProperty('backupRemote', _this.backupRemote))..add(DiagnosticsProperty('backupIntervalMinutes', _this.backupIntervalMinutes))..add(DiagnosticsProperty('lastBackup', _this.lastBackup))..add(DiagnosticsProperty('inputConfiguration', _this.inputConfiguration))..add(DiagnosticsProperty('fallbackPack', _this.fallbackPack))..add(DiagnosticsProperty('starred', _this.starred))..add(DiagnosticsProperty('favoriteTemplates', _this.favoriteTemplates))..add(DiagnosticsProperty('defaultTemplate', _this.defaultTemplate))..add(DiagnosticsProperty('defaultFileName', _this.defaultFileName))..add(DiagnosticsProperty('navigatorPosition', _this.navigatorPosition))..add(DiagnosticsProperty('toolbarPosition', _this.toolbarPosition))..add(DiagnosticsProperty('toolbarSize', _this.toolbarSize))..add(DiagnosticsProperty('sortBy', _this.sortBy))..add(DiagnosticsProperty('sortOrder', _this.sortOrder))..add(DiagnosticsProperty('imageScale', _this.imageScale))..add(DiagnosticsProperty('platformTheme', _this.platformTheme))..add(DiagnosticsProperty('recentColors', _this.recentColors))..add(DiagnosticsProperty('flags', _this.flags))..add(DiagnosticsProperty('spreadPages', _this.spreadPages))..add(DiagnosticsProperty('highContrast', _this.highContrast))..add(DiagnosticsProperty('gridView', _this.gridView))..add(DiagnosticsProperty('hideExtension', _this.hideExtension))..add(DiagnosticsProperty('autosave', _this.autosave))..add(DiagnosticsProperty('showSaveButton', _this.showSaveButton))..add(DiagnosticsProperty('toolbarRows', _this.toolbarRows))..add(DiagnosticsProperty('delayedAutosave', _this.delayedAutosave))..add(DiagnosticsProperty('autosaveDelaySeconds', _this.autosaveDelaySeconds))..add(DiagnosticsProperty('hideCursorWhileDrawing', _this.hideCursorWhileDrawing))..add(DiagnosticsProperty('onStartup', _this.onStartup))..add(DiagnosticsProperty('documentStatePersistence', _this.documentStatePersistence))..add(DiagnosticsProperty('simpleToolbarVisibility', _this.simpleToolbarVisibility))..add(DiagnosticsProperty('optionsPanelPosition', _this.optionsPanelPosition))..add(DiagnosticsProperty('renderResolution', _this.renderResolution))..add(DiagnosticsProperty('moveOnGesture', _this.moveOnGesture))..add(DiagnosticsProperty('rotateOnGesture', _this.rotateOnGesture))..add(DiagnosticsProperty('swamps', _this.swamps))..add(DiagnosticsProperty('selectedPalette', _this.selectedPalette))..add(DiagnosticsProperty('showVerboseLogs', _this.showVerboseLogs))..add(DiagnosticsProperty('showThumbnails', _this.showThumbnails))..add(DiagnosticsProperty('showNavigatorPreviews', _this.showNavigatorPreviews))..add(DiagnosticsProperty('bringMovedElementsToFront', _this.bringMovedElementsToFront))..add(DiagnosticsProperty('favoriteTools', _this.favoriteTools));
}

@override
bool operator ==(Object other) {
  final _this = this as ButterflySettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ButterflySettings&&(identical(other.theme, _this.theme) || other.theme == _this.theme)&&(identical(other.density, _this.density) || other.density == _this.density)&&(identical(other.limitViewportMultiplier, _this.limitViewportMultiplier) || other.limitViewportMultiplier == _this.limitViewportMultiplier)&&(identical(other.limitViewportPositive, _this.limitViewportPositive) || other.limitViewportPositive == _this.limitViewportPositive)&&(identical(other.localeTag, _this.localeTag) || other.localeTag == _this.localeTag)&&(identical(other.documentPath, _this.documentPath) || other.documentPath == _this.documentPath)&&(identical(other.gestureSensitivity, _this.gestureSensitivity) || other.gestureSensitivity == _this.gestureSensitivity)&&(identical(other.touchSensitivity, _this.touchSensitivity) || other.touchSensitivity == _this.touchSensitivity)&&(identical(other.selectSensitivity, _this.selectSensitivity) || other.selectSensitivity == _this.selectSensitivity)&&(identical(other.scrollSensitivity, _this.scrollSensitivity) || other.scrollSensitivity == _this.scrollSensitivity)&&(identical(other.rotationStep, _this.rotationStep) || other.rotationStep == _this.rotationStep)&&(identical(other.zoomStep, _this.zoomStep) || other.zoomStep == _this.zoomStep)&&(identical(other.penOnlyInput, _this.penOnlyInput) || other.penOnlyInput == _this.penOnlyInput)&&(identical(other.showPenOnlyToggle, _this.showPenOnlyToggle) || other.showPenOnlyToggle == _this.showPenOnlyToggle)&&(identical(other.inputGestures, _this.inputGestures) || other.inputGestures == _this.inputGestures)&&(identical(other.design, _this.design) || other.design == _this.design)&&(identical(other.bannerVisibility, _this.bannerVisibility) || other.bannerVisibility == _this.bannerVisibility)&&const DeepCollectionEquality().equals(other.history, _this.history)&&(identical(other.zoomEnabled, _this.zoomEnabled) || other.zoomEnabled == _this.zoomEnabled)&&(identical(other.zoomPosition, _this.zoomPosition) || other.zoomPosition == _this.zoomPosition)&&(identical(other.propertyPosition, _this.propertyPosition) || other.propertyPosition == _this.propertyPosition)&&(identical(other.lastVersion, _this.lastVersion) || other.lastVersion == _this.lastVersion)&&const DeepCollectionEquality().equals(other.connections, _this.connections)&&(identical(other.defaultRemote, _this.defaultRemote) || other.defaultRemote == _this.defaultRemote)&&(identical(other.nativeTitleBar, _this.nativeTitleBar) || other.nativeTitleBar == _this.nativeTitleBar)&&(identical(other.startInFullScreen, _this.startInFullScreen) || other.startInFullScreen == _this.startInFullScreen)&&(identical(other.navigationRail, _this.navigationRail) || other.navigationRail == _this.navigationRail)&&(identical(other.ignorePressure, _this.ignorePressure) || other.ignorePressure == _this.ignorePressure)&&(identical(other.syncMode, _this.syncMode) || other.syncMode == _this.syncMode)&&(identical(other.automaticBackup, _this.automaticBackup) || other.automaticBackup == _this.automaticBackup)&&(identical(other.backupRemote, _this.backupRemote) || other.backupRemote == _this.backupRemote)&&(identical(other.backupIntervalMinutes, _this.backupIntervalMinutes) || other.backupIntervalMinutes == _this.backupIntervalMinutes)&&(identical(other.lastBackup, _this.lastBackup) || other.lastBackup == _this.lastBackup)&&(identical(other.inputConfiguration, _this.inputConfiguration) || other.inputConfiguration == _this.inputConfiguration)&&(identical(other.fallbackPack, _this.fallbackPack) || other.fallbackPack == _this.fallbackPack)&&const DeepCollectionEquality().equals(other.starred, _this.starred)&&const DeepCollectionEquality().equals(other.favoriteTemplates, _this.favoriteTemplates)&&(identical(other.defaultTemplate, _this.defaultTemplate) || other.defaultTemplate == _this.defaultTemplate)&&(identical(other.defaultFileName, _this.defaultFileName) || other.defaultFileName == _this.defaultFileName)&&(identical(other.navigatorPosition, _this.navigatorPosition) || other.navigatorPosition == _this.navigatorPosition)&&(identical(other.toolbarPosition, _this.toolbarPosition) || other.toolbarPosition == _this.toolbarPosition)&&(identical(other.toolbarSize, _this.toolbarSize) || other.toolbarSize == _this.toolbarSize)&&(identical(other.sortBy, _this.sortBy) || other.sortBy == _this.sortBy)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder)&&(identical(other.imageScale, _this.imageScale) || other.imageScale == _this.imageScale)&&(identical(other.platformTheme, _this.platformTheme) || other.platformTheme == _this.platformTheme)&&const DeepCollectionEquality().equals(other.recentColors, _this.recentColors)&&const DeepCollectionEquality().equals(other.flags, _this.flags)&&(identical(other.spreadPages, _this.spreadPages) || other.spreadPages == _this.spreadPages)&&(identical(other.highContrast, _this.highContrast) || other.highContrast == _this.highContrast)&&(identical(other.gridView, _this.gridView) || other.gridView == _this.gridView)&&(identical(other.hideExtension, _this.hideExtension) || other.hideExtension == _this.hideExtension)&&(identical(other.autosave, _this.autosave) || other.autosave == _this.autosave)&&(identical(other.showSaveButton, _this.showSaveButton) || other.showSaveButton == _this.showSaveButton)&&(identical(other.toolbarRows, _this.toolbarRows) || other.toolbarRows == _this.toolbarRows)&&(identical(other.delayedAutosave, _this.delayedAutosave) || other.delayedAutosave == _this.delayedAutosave)&&(identical(other.autosaveDelaySeconds, _this.autosaveDelaySeconds) || other.autosaveDelaySeconds == _this.autosaveDelaySeconds)&&(identical(other.hideCursorWhileDrawing, _this.hideCursorWhileDrawing) || other.hideCursorWhileDrawing == _this.hideCursorWhileDrawing)&&(identical(other.onStartup, _this.onStartup) || other.onStartup == _this.onStartup)&&(identical(other.documentStatePersistence, _this.documentStatePersistence) || other.documentStatePersistence == _this.documentStatePersistence)&&(identical(other.simpleToolbarVisibility, _this.simpleToolbarVisibility) || other.simpleToolbarVisibility == _this.simpleToolbarVisibility)&&(identical(other.optionsPanelPosition, _this.optionsPanelPosition) || other.optionsPanelPosition == _this.optionsPanelPosition)&&(identical(other.renderResolution, _this.renderResolution) || other.renderResolution == _this.renderResolution)&&(identical(other.moveOnGesture, _this.moveOnGesture) || other.moveOnGesture == _this.moveOnGesture)&&(identical(other.rotateOnGesture, _this.rotateOnGesture) || other.rotateOnGesture == _this.rotateOnGesture)&&const DeepCollectionEquality().equals(other.swamps, _this.swamps)&&(identical(other.selectedPalette, _this.selectedPalette) || other.selectedPalette == _this.selectedPalette)&&(identical(other.showVerboseLogs, _this.showVerboseLogs) || other.showVerboseLogs == _this.showVerboseLogs)&&(identical(other.showThumbnails, _this.showThumbnails) || other.showThumbnails == _this.showThumbnails)&&(identical(other.showNavigatorPreviews, _this.showNavigatorPreviews) || other.showNavigatorPreviews == _this.showNavigatorPreviews)&&(identical(other.bringMovedElementsToFront, _this.bringMovedElementsToFront) || other.bringMovedElementsToFront == _this.bringMovedElementsToFront)&&const DeepCollectionEquality().equals(other.favoriteTools, _this.favoriteTools));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ButterflySettings;
  return Object.hashAll([runtimeType,_this.theme,_this.density,_this.limitViewportMultiplier,_this.limitViewportPositive,_this.localeTag,_this.documentPath,_this.gestureSensitivity,_this.touchSensitivity,_this.selectSensitivity,_this.scrollSensitivity,_this.rotationStep,_this.zoomStep,_this.penOnlyInput,_this.showPenOnlyToggle,_this.inputGestures,_this.design,_this.bannerVisibility,const DeepCollectionEquality().hash(_this.history),_this.zoomEnabled,_this.zoomPosition,_this.propertyPosition,_this.lastVersion,const DeepCollectionEquality().hash(_this.connections),_this.defaultRemote,_this.nativeTitleBar,_this.startInFullScreen,_this.navigationRail,_this.ignorePressure,_this.syncMode,_this.automaticBackup,_this.backupRemote,_this.backupIntervalMinutes,_this.lastBackup,_this.inputConfiguration,_this.fallbackPack,const DeepCollectionEquality().hash(_this.starred),const DeepCollectionEquality().hash(_this.favoriteTemplates),_this.defaultTemplate,_this.defaultFileName,_this.navigatorPosition,_this.toolbarPosition,_this.toolbarSize,_this.sortBy,_this.sortOrder,_this.imageScale,_this.platformTheme,const DeepCollectionEquality().hash(_this.recentColors),const DeepCollectionEquality().hash(_this.flags),_this.spreadPages,_this.highContrast,_this.gridView,_this.hideExtension,_this.autosave,_this.showSaveButton,_this.toolbarRows,_this.delayedAutosave,_this.autosaveDelaySeconds,_this.hideCursorWhileDrawing,_this.onStartup,_this.documentStatePersistence,_this.simpleToolbarVisibility,_this.optionsPanelPosition,_this.renderResolution,_this.moveOnGesture,_this.rotateOnGesture,const DeepCollectionEquality().hash(_this.swamps),_this.selectedPalette,_this.showVerboseLogs,_this.showThumbnails,_this.showNavigatorPreviews,_this.bringMovedElementsToFront,const DeepCollectionEquality().hash(_this.favoriteTools)]);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as ButterflySettings;
  return 'ButterflySettings(theme: ${_this.theme}, density: ${_this.density}, limitViewportMultiplier: ${_this.limitViewportMultiplier}, limitViewportPositive: ${_this.limitViewportPositive}, localeTag: ${_this.localeTag}, documentPath: ${_this.documentPath}, gestureSensitivity: ${_this.gestureSensitivity}, touchSensitivity: ${_this.touchSensitivity}, selectSensitivity: ${_this.selectSensitivity}, scrollSensitivity: ${_this.scrollSensitivity}, rotationStep: ${_this.rotationStep}, zoomStep: ${_this.zoomStep}, penOnlyInput: ${_this.penOnlyInput}, showPenOnlyToggle: ${_this.showPenOnlyToggle}, inputGestures: ${_this.inputGestures}, design: ${_this.design}, bannerVisibility: ${_this.bannerVisibility}, history: ${_this.history}, zoomEnabled: ${_this.zoomEnabled}, zoomPosition: ${_this.zoomPosition}, propertyPosition: ${_this.propertyPosition}, lastVersion: ${_this.lastVersion}, connections: ${_this.connections}, defaultRemote: ${_this.defaultRemote}, nativeTitleBar: ${_this.nativeTitleBar}, startInFullScreen: ${_this.startInFullScreen}, navigationRail: ${_this.navigationRail}, ignorePressure: ${_this.ignorePressure}, syncMode: ${_this.syncMode}, automaticBackup: ${_this.automaticBackup}, backupRemote: ${_this.backupRemote}, backupIntervalMinutes: ${_this.backupIntervalMinutes}, lastBackup: ${_this.lastBackup}, inputConfiguration: ${_this.inputConfiguration}, fallbackPack: ${_this.fallbackPack}, starred: ${_this.starred}, favoriteTemplates: ${_this.favoriteTemplates}, defaultTemplate: ${_this.defaultTemplate}, defaultFileName: ${_this.defaultFileName}, navigatorPosition: ${_this.navigatorPosition}, toolbarPosition: ${_this.toolbarPosition}, toolbarSize: ${_this.toolbarSize}, sortBy: ${_this.sortBy}, sortOrder: ${_this.sortOrder}, imageScale: ${_this.imageScale}, platformTheme: ${_this.platformTheme}, recentColors: ${_this.recentColors}, flags: ${_this.flags}, spreadPages: ${_this.spreadPages}, highContrast: ${_this.highContrast}, gridView: ${_this.gridView}, hideExtension: ${_this.hideExtension}, autosave: ${_this.autosave}, showSaveButton: ${_this.showSaveButton}, toolbarRows: ${_this.toolbarRows}, delayedAutosave: ${_this.delayedAutosave}, autosaveDelaySeconds: ${_this.autosaveDelaySeconds}, hideCursorWhileDrawing: ${_this.hideCursorWhileDrawing}, onStartup: ${_this.onStartup}, documentStatePersistence: ${_this.documentStatePersistence}, simpleToolbarVisibility: ${_this.simpleToolbarVisibility}, optionsPanelPosition: ${_this.optionsPanelPosition}, renderResolution: ${_this.renderResolution}, moveOnGesture: ${_this.moveOnGesture}, rotateOnGesture: ${_this.rotateOnGesture}, swamps: ${_this.swamps}, selectedPalette: ${_this.selectedPalette}, showVerboseLogs: ${_this.showVerboseLogs}, showThumbnails: ${_this.showThumbnails}, showNavigatorPreviews: ${_this.showNavigatorPreviews}, bringMovedElementsToFront: ${_this.bringMovedElementsToFront}, favoriteTools: ${_this.favoriteTools})';
}


}

/// @nodoc
abstract mixin class $ButterflySettingsCopyWith<$Res>  {
  factory $ButterflySettingsCopyWith(ButterflySettings value, $Res Function(ButterflySettings) _then) = _$ButterflySettingsCopyWithImpl;
@useResult
$Res call({
 ThemeMode theme, ThemeDensity density, double? limitViewportMultiplier, bool limitViewportPositive, String localeTag, String documentPath, double gestureSensitivity, double touchSensitivity, double selectSensitivity, double scrollSensitivity, double rotationStep, double zoomStep, bool? penOnlyInput, bool showPenOnlyToggle, bool inputGestures, String design, BannerVisibility bannerVisibility,@JsonKey(includeFromJson: false, includeToJson: false) List<AssetLocation> history, bool zoomEnabled, ZoomPosition zoomPosition, ZoomPosition propertyPosition, String? lastVersion,@JsonKey(includeFromJson: false, includeToJson: false) List<ExternalStorage> connections, String defaultRemote, bool nativeTitleBar, bool startInFullScreen, bool navigationRail, IgnorePressure ignorePressure, SyncMode syncMode, bool automaticBackup, String backupRemote, int backupIntervalMinutes, DateTime? lastBackup, InputConfiguration inputConfiguration, String fallbackPack, List<String> starred, List<FavoriteLocation> favoriteTemplates, String defaultTemplate, String defaultFileName, NavigatorPosition navigatorPosition, ToolbarPosition toolbarPosition, ToolbarSize toolbarSize, SortBy sortBy, SortOrder sortOrder, double imageScale, PlatformTheme platformTheme,@SRGBConverter() List<SRGBColor> recentColors, List<String> flags, bool spreadPages, bool highContrast, bool gridView, bool hideExtension, bool autosave, bool showSaveButton, int toolbarRows, bool delayedAutosave, int autosaveDelaySeconds, bool hideCursorWhileDrawing, StartupBehavior onStartup, DocumentStatePersistenceSettings documentStatePersistence, SimpleToolbarVisibility simpleToolbarVisibility, OptionsPanelPosition optionsPanelPosition, RenderResolution renderResolution, bool moveOnGesture, bool rotateOnGesture, List<String> swamps, PackAssetLocation? selectedPalette, bool showVerboseLogs, bool showThumbnails, bool showNavigatorPreviews, bool bringMovedElementsToFront, List<PackAssetLocation> favoriteTools
});


$InputConfigurationCopyWith<$Res> get inputConfiguration;$DocumentStatePersistenceSettingsCopyWith<$Res> get documentStatePersistence;$PackAssetLocationCopyWith<$Res>? get selectedPalette;

}
/// @nodoc
class _$ButterflySettingsCopyWithImpl<$Res>
    implements $ButterflySettingsCopyWith<$Res> {
  _$ButterflySettingsCopyWithImpl(this._self, this._then);

  final ButterflySettings _self;
  final $Res Function(ButterflySettings) _then;

/// Create a copy of ButterflySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? theme = null,Object? density = null,Object? limitViewportMultiplier = freezed,Object? limitViewportPositive = null,Object? localeTag = null,Object? documentPath = null,Object? gestureSensitivity = null,Object? touchSensitivity = null,Object? selectSensitivity = null,Object? scrollSensitivity = null,Object? rotationStep = null,Object? zoomStep = null,Object? penOnlyInput = freezed,Object? showPenOnlyToggle = null,Object? inputGestures = null,Object? design = null,Object? bannerVisibility = null,Object? history = null,Object? zoomEnabled = null,Object? zoomPosition = null,Object? propertyPosition = null,Object? lastVersion = freezed,Object? connections = null,Object? defaultRemote = null,Object? nativeTitleBar = null,Object? startInFullScreen = null,Object? navigationRail = null,Object? ignorePressure = null,Object? syncMode = null,Object? automaticBackup = null,Object? backupRemote = null,Object? backupIntervalMinutes = null,Object? lastBackup = freezed,Object? inputConfiguration = null,Object? fallbackPack = null,Object? starred = null,Object? favoriteTemplates = null,Object? defaultTemplate = null,Object? defaultFileName = null,Object? navigatorPosition = null,Object? toolbarPosition = null,Object? toolbarSize = null,Object? sortBy = null,Object? sortOrder = null,Object? imageScale = null,Object? platformTheme = null,Object? recentColors = null,Object? flags = null,Object? spreadPages = null,Object? highContrast = null,Object? gridView = null,Object? hideExtension = null,Object? autosave = null,Object? showSaveButton = null,Object? toolbarRows = null,Object? delayedAutosave = null,Object? autosaveDelaySeconds = null,Object? hideCursorWhileDrawing = null,Object? onStartup = null,Object? documentStatePersistence = null,Object? simpleToolbarVisibility = null,Object? optionsPanelPosition = null,Object? renderResolution = null,Object? moveOnGesture = null,Object? rotateOnGesture = null,Object? swamps = null,Object? selectedPalette = freezed,Object? showVerboseLogs = null,Object? showThumbnails = null,Object? showNavigatorPreviews = null,Object? bringMovedElementsToFront = null,Object? favoriteTools = null,}) {
  return _then(ButterflySettings(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemeMode,density: null == density ? _self.density : density // ignore: cast_nullable_to_non_nullable
as ThemeDensity,limitViewportMultiplier: freezed == limitViewportMultiplier ? _self.limitViewportMultiplier : limitViewportMultiplier // ignore: cast_nullable_to_non_nullable
as double?,limitViewportPositive: null == limitViewportPositive ? _self.limitViewportPositive : limitViewportPositive // ignore: cast_nullable_to_non_nullable
as bool,localeTag: null == localeTag ? _self.localeTag : localeTag // ignore: cast_nullable_to_non_nullable
as String,documentPath: null == documentPath ? _self.documentPath : documentPath // ignore: cast_nullable_to_non_nullable
as String,gestureSensitivity: null == gestureSensitivity ? _self.gestureSensitivity : gestureSensitivity // ignore: cast_nullable_to_non_nullable
as double,touchSensitivity: null == touchSensitivity ? _self.touchSensitivity : touchSensitivity // ignore: cast_nullable_to_non_nullable
as double,selectSensitivity: null == selectSensitivity ? _self.selectSensitivity : selectSensitivity // ignore: cast_nullable_to_non_nullable
as double,scrollSensitivity: null == scrollSensitivity ? _self.scrollSensitivity : scrollSensitivity // ignore: cast_nullable_to_non_nullable
as double,rotationStep: null == rotationStep ? _self.rotationStep : rotationStep // ignore: cast_nullable_to_non_nullable
as double,zoomStep: null == zoomStep ? _self.zoomStep : zoomStep // ignore: cast_nullable_to_non_nullable
as double,penOnlyInput: freezed == penOnlyInput ? _self.penOnlyInput : penOnlyInput // ignore: cast_nullable_to_non_nullable
as bool?,showPenOnlyToggle: null == showPenOnlyToggle ? _self.showPenOnlyToggle : showPenOnlyToggle // ignore: cast_nullable_to_non_nullable
as bool,inputGestures: null == inputGestures ? _self.inputGestures : inputGestures // ignore: cast_nullable_to_non_nullable
as bool,design: null == design ? _self.design : design // ignore: cast_nullable_to_non_nullable
as String,bannerVisibility: null == bannerVisibility ? _self.bannerVisibility : bannerVisibility // ignore: cast_nullable_to_non_nullable
as BannerVisibility,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<AssetLocation>,zoomEnabled: null == zoomEnabled ? _self.zoomEnabled : zoomEnabled // ignore: cast_nullable_to_non_nullable
as bool,zoomPosition: null == zoomPosition ? _self.zoomPosition : zoomPosition // ignore: cast_nullable_to_non_nullable
as ZoomPosition,propertyPosition: null == propertyPosition ? _self.propertyPosition : propertyPosition // ignore: cast_nullable_to_non_nullable
as ZoomPosition,lastVersion: freezed == lastVersion ? _self.lastVersion : lastVersion // ignore: cast_nullable_to_non_nullable
as String?,connections: null == connections ? _self.connections : connections // ignore: cast_nullable_to_non_nullable
as List<ExternalStorage>,defaultRemote: null == defaultRemote ? _self.defaultRemote : defaultRemote // ignore: cast_nullable_to_non_nullable
as String,nativeTitleBar: null == nativeTitleBar ? _self.nativeTitleBar : nativeTitleBar // ignore: cast_nullable_to_non_nullable
as bool,startInFullScreen: null == startInFullScreen ? _self.startInFullScreen : startInFullScreen // ignore: cast_nullable_to_non_nullable
as bool,navigationRail: null == navigationRail ? _self.navigationRail : navigationRail // ignore: cast_nullable_to_non_nullable
as bool,ignorePressure: null == ignorePressure ? _self.ignorePressure : ignorePressure // ignore: cast_nullable_to_non_nullable
as IgnorePressure,syncMode: null == syncMode ? _self.syncMode : syncMode // ignore: cast_nullable_to_non_nullable
as SyncMode,automaticBackup: null == automaticBackup ? _self.automaticBackup : automaticBackup // ignore: cast_nullable_to_non_nullable
as bool,backupRemote: null == backupRemote ? _self.backupRemote : backupRemote // ignore: cast_nullable_to_non_nullable
as String,backupIntervalMinutes: null == backupIntervalMinutes ? _self.backupIntervalMinutes : backupIntervalMinutes // ignore: cast_nullable_to_non_nullable
as int,lastBackup: freezed == lastBackup ? _self.lastBackup : lastBackup // ignore: cast_nullable_to_non_nullable
as DateTime?,inputConfiguration: null == inputConfiguration ? _self.inputConfiguration : inputConfiguration // ignore: cast_nullable_to_non_nullable
as InputConfiguration,fallbackPack: null == fallbackPack ? _self.fallbackPack : fallbackPack // ignore: cast_nullable_to_non_nullable
as String,starred: null == starred ? _self.starred : starred // ignore: cast_nullable_to_non_nullable
as List<String>,favoriteTemplates: null == favoriteTemplates ? _self.favoriteTemplates : favoriteTemplates // ignore: cast_nullable_to_non_nullable
as List<FavoriteLocation>,defaultTemplate: null == defaultTemplate ? _self.defaultTemplate : defaultTemplate // ignore: cast_nullable_to_non_nullable
as String,defaultFileName: null == defaultFileName ? _self.defaultFileName : defaultFileName // ignore: cast_nullable_to_non_nullable
as String,navigatorPosition: null == navigatorPosition ? _self.navigatorPosition : navigatorPosition // ignore: cast_nullable_to_non_nullable
as NavigatorPosition,toolbarPosition: null == toolbarPosition ? _self.toolbarPosition : toolbarPosition // ignore: cast_nullable_to_non_nullable
as ToolbarPosition,toolbarSize: null == toolbarSize ? _self.toolbarSize : toolbarSize // ignore: cast_nullable_to_non_nullable
as ToolbarSize,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as SortBy,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder,imageScale: null == imageScale ? _self.imageScale : imageScale // ignore: cast_nullable_to_non_nullable
as double,platformTheme: null == platformTheme ? _self.platformTheme : platformTheme // ignore: cast_nullable_to_non_nullable
as PlatformTheme,recentColors: null == recentColors ? _self.recentColors : recentColors // ignore: cast_nullable_to_non_nullable
as List<SRGBColor>,flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as List<String>,spreadPages: null == spreadPages ? _self.spreadPages : spreadPages // ignore: cast_nullable_to_non_nullable
as bool,highContrast: null == highContrast ? _self.highContrast : highContrast // ignore: cast_nullable_to_non_nullable
as bool,gridView: null == gridView ? _self.gridView : gridView // ignore: cast_nullable_to_non_nullable
as bool,hideExtension: null == hideExtension ? _self.hideExtension : hideExtension // ignore: cast_nullable_to_non_nullable
as bool,autosave: null == autosave ? _self.autosave : autosave // ignore: cast_nullable_to_non_nullable
as bool,showSaveButton: null == showSaveButton ? _self.showSaveButton : showSaveButton // ignore: cast_nullable_to_non_nullable
as bool,toolbarRows: null == toolbarRows ? _self.toolbarRows : toolbarRows // ignore: cast_nullable_to_non_nullable
as int,delayedAutosave: null == delayedAutosave ? _self.delayedAutosave : delayedAutosave // ignore: cast_nullable_to_non_nullable
as bool,autosaveDelaySeconds: null == autosaveDelaySeconds ? _self.autosaveDelaySeconds : autosaveDelaySeconds // ignore: cast_nullable_to_non_nullable
as int,hideCursorWhileDrawing: null == hideCursorWhileDrawing ? _self.hideCursorWhileDrawing : hideCursorWhileDrawing // ignore: cast_nullable_to_non_nullable
as bool,onStartup: null == onStartup ? _self.onStartup : onStartup // ignore: cast_nullable_to_non_nullable
as StartupBehavior,documentStatePersistence: null == documentStatePersistence ? _self.documentStatePersistence : documentStatePersistence // ignore: cast_nullable_to_non_nullable
as DocumentStatePersistenceSettings,simpleToolbarVisibility: null == simpleToolbarVisibility ? _self.simpleToolbarVisibility : simpleToolbarVisibility // ignore: cast_nullable_to_non_nullable
as SimpleToolbarVisibility,optionsPanelPosition: null == optionsPanelPosition ? _self.optionsPanelPosition : optionsPanelPosition // ignore: cast_nullable_to_non_nullable
as OptionsPanelPosition,renderResolution: null == renderResolution ? _self.renderResolution : renderResolution // ignore: cast_nullable_to_non_nullable
as RenderResolution,moveOnGesture: null == moveOnGesture ? _self.moveOnGesture : moveOnGesture // ignore: cast_nullable_to_non_nullable
as bool,rotateOnGesture: null == rotateOnGesture ? _self.rotateOnGesture : rotateOnGesture // ignore: cast_nullable_to_non_nullable
as bool,swamps: null == swamps ? _self.swamps : swamps // ignore: cast_nullable_to_non_nullable
as List<String>,selectedPalette: freezed == selectedPalette ? _self.selectedPalette : selectedPalette // ignore: cast_nullable_to_non_nullable
as PackAssetLocation?,showVerboseLogs: null == showVerboseLogs ? _self.showVerboseLogs : showVerboseLogs // ignore: cast_nullable_to_non_nullable
as bool,showThumbnails: null == showThumbnails ? _self.showThumbnails : showThumbnails // ignore: cast_nullable_to_non_nullable
as bool,showNavigatorPreviews: null == showNavigatorPreviews ? _self.showNavigatorPreviews : showNavigatorPreviews // ignore: cast_nullable_to_non_nullable
as bool,bringMovedElementsToFront: null == bringMovedElementsToFront ? _self.bringMovedElementsToFront : bringMovedElementsToFront // ignore: cast_nullable_to_non_nullable
as bool,favoriteTools: null == favoriteTools ? _self.favoriteTools : favoriteTools // ignore: cast_nullable_to_non_nullable
as List<PackAssetLocation>,
  ));
}
/// Create a copy of ButterflySettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InputConfigurationCopyWith<$Res> get inputConfiguration {
  
  return $InputConfigurationCopyWith<$Res>(_self.inputConfiguration, (value) {
    return _then(_self.copyWith(inputConfiguration: value));
  });
}/// Create a copy of ButterflySettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DocumentStatePersistenceSettingsCopyWith<$Res> get documentStatePersistence {
  
  return $DocumentStatePersistenceSettingsCopyWith<$Res>(_self.documentStatePersistence, (value) {
    return _then(_self.copyWith(documentStatePersistence: value));
  });
}/// Create a copy of ButterflySettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PackAssetLocationCopyWith<$Res>? get selectedPalette {
    if (_self.selectedPalette == null) {
    return null;
  }

  return $PackAssetLocationCopyWith<$Res>(_self.selectedPalette!, (value) {
    return _then(_self.copyWith(selectedPalette: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _ButterflySettings extends ButterflySettings with DiagnosticableTreeMixin {
  const _ButterflySettings({this.theme = ThemeMode.system, this.density = ThemeDensity.system, this.limitViewportMultiplier, this.limitViewportPositive = false, this.localeTag = '', this.documentPath = '', this.gestureSensitivity = 1, this.touchSensitivity = 1, this.selectSensitivity = 1, this.scrollSensitivity = 1, this.rotationStep = kDefaultRotationStep, this.zoomStep = kDefaultZoomStep, this.penOnlyInput, this.showPenOnlyToggle = true, this.inputGestures = true, this.design = '', this.bannerVisibility = BannerVisibility.always, @JsonKey(includeFromJson: false, includeToJson: false)  List<AssetLocation> history = const [], this.zoomEnabled = true, this.zoomPosition = ZoomPosition.bottomRight, this.propertyPosition = ZoomPosition.topRight, this.lastVersion, @JsonKey(includeFromJson: false, includeToJson: false)  List<ExternalStorage> connections = const [], this.defaultRemote = '', this.nativeTitleBar = false, this.startInFullScreen = false, this.navigationRail = true, this.ignorePressure = IgnorePressure.first, this.syncMode = SyncMode.noMobile, this.automaticBackup = false, this.backupRemote = '', this.backupIntervalMinutes = kDefaultBackupIntervalMinutes, this.lastBackup, this.inputConfiguration = const InputConfiguration(), this.fallbackPack = '',  List<String> starred = const [],  List<FavoriteLocation> favoriteTemplates = const [], this.defaultTemplate = '', this.defaultFileName = kDefaultFileName, this.navigatorPosition = NavigatorPosition.left, this.toolbarPosition = ToolbarPosition.inline, this.toolbarSize = ToolbarSize.normal, this.sortBy = SortBy.modified, this.sortOrder = SortOrder.descending, this.imageScale = 0.5, this.platformTheme = PlatformTheme.system, @SRGBConverter()  List<SRGBColor> recentColors = const [],  List<String> flags = const [], this.spreadPages = false, this.highContrast = false, this.gridView = false, this.hideExtension = true, this.autosave = true, this.showSaveButton = true, this.toolbarRows = 1, this.delayedAutosave = true, this.autosaveDelaySeconds = 3, this.hideCursorWhileDrawing = false, this.onStartup = StartupBehavior.openHomeScreen, this.documentStatePersistence = const DocumentStatePersistenceSettings(), this.simpleToolbarVisibility = SimpleToolbarVisibility.show, this.optionsPanelPosition = OptionsPanelPosition.top, this.renderResolution = RenderResolution.normal, this.moveOnGesture = true, this.rotateOnGesture = true,  List<String> swamps = const [], this.selectedPalette, this.showVerboseLogs = false, this.showThumbnails = true, this.showNavigatorPreviews = true, this.bringMovedElementsToFront = false,  List<PackAssetLocation> favoriteTools = const []}): _history = history,_connections = connections,_starred = starred,_favoriteTemplates = favoriteTemplates,_recentColors = recentColors,_flags = flags,_swamps = swamps,_favoriteTools = favoriteTools,super._();
  factory _ButterflySettings.fromJson(Map<String, dynamic> json) => _$ButterflySettingsFromJson(json);

@override@JsonKey() final  ThemeMode theme;
@override@JsonKey() final  ThemeDensity density;
@override final  double? limitViewportMultiplier;
@override@JsonKey() final  bool limitViewportPositive;
@override@JsonKey() final  String localeTag;
@override@JsonKey() final  String documentPath;
@override@JsonKey() final  double gestureSensitivity;
@override@JsonKey() final  double touchSensitivity;
@override@JsonKey() final  double selectSensitivity;
@override@JsonKey() final  double scrollSensitivity;
@override@JsonKey() final  double rotationStep;
@override@JsonKey() final  double zoomStep;
@override final  bool? penOnlyInput;
@override@JsonKey() final  bool showPenOnlyToggle;
@override@JsonKey() final  bool inputGestures;
@override@JsonKey() final  String design;
@override@JsonKey() final  BannerVisibility bannerVisibility;
 final  List<AssetLocation> _history;
@override@JsonKey(includeFromJson: false, includeToJson: false) List<AssetLocation> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

@override@JsonKey() final  bool zoomEnabled;
@override@JsonKey() final  ZoomPosition zoomPosition;
@override@JsonKey() final  ZoomPosition propertyPosition;
@override final  String? lastVersion;
 final  List<ExternalStorage> _connections;
@override@JsonKey(includeFromJson: false, includeToJson: false) List<ExternalStorage> get connections {
  if (_connections is EqualUnmodifiableListView) return _connections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_connections);
}

@override@JsonKey() final  String defaultRemote;
@override@JsonKey() final  bool nativeTitleBar;
@override@JsonKey() final  bool startInFullScreen;
@override@JsonKey() final  bool navigationRail;
@override@JsonKey() final  IgnorePressure ignorePressure;
@override@JsonKey() final  SyncMode syncMode;
@override@JsonKey() final  bool automaticBackup;
@override@JsonKey() final  String backupRemote;
@override@JsonKey() final  int backupIntervalMinutes;
@override final  DateTime? lastBackup;
@override@JsonKey() final  InputConfiguration inputConfiguration;
@override@JsonKey() final  String fallbackPack;
 final  List<String> _starred;
@override@JsonKey() List<String> get starred {
  if (_starred is EqualUnmodifiableListView) return _starred;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_starred);
}

 final  List<FavoriteLocation> _favoriteTemplates;
@override@JsonKey() List<FavoriteLocation> get favoriteTemplates {
  if (_favoriteTemplates is EqualUnmodifiableListView) return _favoriteTemplates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteTemplates);
}

@override@JsonKey() final  String defaultTemplate;
@override@JsonKey() final  String defaultFileName;
@override@JsonKey() final  NavigatorPosition navigatorPosition;
@override@JsonKey() final  ToolbarPosition toolbarPosition;
@override@JsonKey() final  ToolbarSize toolbarSize;
@override@JsonKey() final  SortBy sortBy;
@override@JsonKey() final  SortOrder sortOrder;
@override@JsonKey() final  double imageScale;
@override@JsonKey() final  PlatformTheme platformTheme;
 final  List<SRGBColor> _recentColors;
@override@JsonKey()@SRGBConverter() List<SRGBColor> get recentColors {
  if (_recentColors is EqualUnmodifiableListView) return _recentColors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentColors);
}

 final  List<String> _flags;
@override@JsonKey() List<String> get flags {
  if (_flags is EqualUnmodifiableListView) return _flags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_flags);
}

@override@JsonKey() final  bool spreadPages;
@override@JsonKey() final  bool highContrast;
@override@JsonKey() final  bool gridView;
@override@JsonKey() final  bool hideExtension;
@override@JsonKey() final  bool autosave;
@override@JsonKey() final  bool showSaveButton;
@override@JsonKey() final  int toolbarRows;
@override@JsonKey() final  bool delayedAutosave;
@override@JsonKey() final  int autosaveDelaySeconds;
@override@JsonKey() final  bool hideCursorWhileDrawing;
@override@JsonKey() final  StartupBehavior onStartup;
@override@JsonKey() final  DocumentStatePersistenceSettings documentStatePersistence;
@override@JsonKey() final  SimpleToolbarVisibility simpleToolbarVisibility;
@override@JsonKey() final  OptionsPanelPosition optionsPanelPosition;
@override@JsonKey() final  RenderResolution renderResolution;
@override@JsonKey() final  bool moveOnGesture;
@override@JsonKey() final  bool rotateOnGesture;
 final  List<String> _swamps;
@override@JsonKey() List<String> get swamps {
  if (_swamps is EqualUnmodifiableListView) return _swamps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_swamps);
}

@override final  PackAssetLocation? selectedPalette;
@override@JsonKey() final  bool showVerboseLogs;
@override@JsonKey() final  bool showThumbnails;
@override@JsonKey() final  bool showNavigatorPreviews;
@override@JsonKey() final  bool bringMovedElementsToFront;
 final  List<PackAssetLocation> _favoriteTools;
@override@JsonKey() List<PackAssetLocation> get favoriteTools {
  if (_favoriteTools is EqualUnmodifiableListView) return _favoriteTools;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteTools);
}


/// Create a copy of ButterflySettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ButterflySettingsCopyWith<_ButterflySettings> get copyWith => __$ButterflySettingsCopyWithImpl<_ButterflySettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ButterflySettingsToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'ButterflySettings'))
    ..add(DiagnosticsProperty('theme', theme))..add(DiagnosticsProperty('density', density))..add(DiagnosticsProperty('limitViewportMultiplier', limitViewportMultiplier))..add(DiagnosticsProperty('limitViewportPositive', limitViewportPositive))..add(DiagnosticsProperty('localeTag', localeTag))..add(DiagnosticsProperty('documentPath', documentPath))..add(DiagnosticsProperty('gestureSensitivity', gestureSensitivity))..add(DiagnosticsProperty('touchSensitivity', touchSensitivity))..add(DiagnosticsProperty('selectSensitivity', selectSensitivity))..add(DiagnosticsProperty('scrollSensitivity', scrollSensitivity))..add(DiagnosticsProperty('rotationStep', rotationStep))..add(DiagnosticsProperty('zoomStep', zoomStep))..add(DiagnosticsProperty('penOnlyInput', penOnlyInput))..add(DiagnosticsProperty('showPenOnlyToggle', showPenOnlyToggle))..add(DiagnosticsProperty('inputGestures', inputGestures))..add(DiagnosticsProperty('design', design))..add(DiagnosticsProperty('bannerVisibility', bannerVisibility))..add(DiagnosticsProperty('history', history))..add(DiagnosticsProperty('zoomEnabled', zoomEnabled))..add(DiagnosticsProperty('zoomPosition', zoomPosition))..add(DiagnosticsProperty('propertyPosition', propertyPosition))..add(DiagnosticsProperty('lastVersion', lastVersion))..add(DiagnosticsProperty('connections', connections))..add(DiagnosticsProperty('defaultRemote', defaultRemote))..add(DiagnosticsProperty('nativeTitleBar', nativeTitleBar))..add(DiagnosticsProperty('startInFullScreen', startInFullScreen))..add(DiagnosticsProperty('navigationRail', navigationRail))..add(DiagnosticsProperty('ignorePressure', ignorePressure))..add(DiagnosticsProperty('syncMode', syncMode))..add(DiagnosticsProperty('automaticBackup', automaticBackup))..add(DiagnosticsProperty('backupRemote', backupRemote))..add(DiagnosticsProperty('backupIntervalMinutes', backupIntervalMinutes))..add(DiagnosticsProperty('lastBackup', lastBackup))..add(DiagnosticsProperty('inputConfiguration', inputConfiguration))..add(DiagnosticsProperty('fallbackPack', fallbackPack))..add(DiagnosticsProperty('starred', starred))..add(DiagnosticsProperty('favoriteTemplates', favoriteTemplates))..add(DiagnosticsProperty('defaultTemplate', defaultTemplate))..add(DiagnosticsProperty('defaultFileName', defaultFileName))..add(DiagnosticsProperty('navigatorPosition', navigatorPosition))..add(DiagnosticsProperty('toolbarPosition', toolbarPosition))..add(DiagnosticsProperty('toolbarSize', toolbarSize))..add(DiagnosticsProperty('sortBy', sortBy))..add(DiagnosticsProperty('sortOrder', sortOrder))..add(DiagnosticsProperty('imageScale', imageScale))..add(DiagnosticsProperty('platformTheme', platformTheme))..add(DiagnosticsProperty('recentColors', recentColors))..add(DiagnosticsProperty('flags', flags))..add(DiagnosticsProperty('spreadPages', spreadPages))..add(DiagnosticsProperty('highContrast', highContrast))..add(DiagnosticsProperty('gridView', gridView))..add(DiagnosticsProperty('hideExtension', hideExtension))..add(DiagnosticsProperty('autosave', autosave))..add(DiagnosticsProperty('showSaveButton', showSaveButton))..add(DiagnosticsProperty('toolbarRows', toolbarRows))..add(DiagnosticsProperty('delayedAutosave', delayedAutosave))..add(DiagnosticsProperty('autosaveDelaySeconds', autosaveDelaySeconds))..add(DiagnosticsProperty('hideCursorWhileDrawing', hideCursorWhileDrawing))..add(DiagnosticsProperty('onStartup', onStartup))..add(DiagnosticsProperty('documentStatePersistence', documentStatePersistence))..add(DiagnosticsProperty('simpleToolbarVisibility', simpleToolbarVisibility))..add(DiagnosticsProperty('optionsPanelPosition', optionsPanelPosition))..add(DiagnosticsProperty('renderResolution', renderResolution))..add(DiagnosticsProperty('moveOnGesture', moveOnGesture))..add(DiagnosticsProperty('rotateOnGesture', rotateOnGesture))..add(DiagnosticsProperty('swamps', swamps))..add(DiagnosticsProperty('selectedPalette', selectedPalette))..add(DiagnosticsProperty('showVerboseLogs', showVerboseLogs))..add(DiagnosticsProperty('showThumbnails', showThumbnails))..add(DiagnosticsProperty('showNavigatorPreviews', showNavigatorPreviews))..add(DiagnosticsProperty('bringMovedElementsToFront', bringMovedElementsToFront))..add(DiagnosticsProperty('favoriteTools', favoriteTools));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ButterflySettings&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.density, density) || other.density == density)&&(identical(other.limitViewportMultiplier, limitViewportMultiplier) || other.limitViewportMultiplier == limitViewportMultiplier)&&(identical(other.limitViewportPositive, limitViewportPositive) || other.limitViewportPositive == limitViewportPositive)&&(identical(other.localeTag, localeTag) || other.localeTag == localeTag)&&(identical(other.documentPath, documentPath) || other.documentPath == documentPath)&&(identical(other.gestureSensitivity, gestureSensitivity) || other.gestureSensitivity == gestureSensitivity)&&(identical(other.touchSensitivity, touchSensitivity) || other.touchSensitivity == touchSensitivity)&&(identical(other.selectSensitivity, selectSensitivity) || other.selectSensitivity == selectSensitivity)&&(identical(other.scrollSensitivity, scrollSensitivity) || other.scrollSensitivity == scrollSensitivity)&&(identical(other.rotationStep, rotationStep) || other.rotationStep == rotationStep)&&(identical(other.zoomStep, zoomStep) || other.zoomStep == zoomStep)&&(identical(other.penOnlyInput, penOnlyInput) || other.penOnlyInput == penOnlyInput)&&(identical(other.showPenOnlyToggle, showPenOnlyToggle) || other.showPenOnlyToggle == showPenOnlyToggle)&&(identical(other.inputGestures, inputGestures) || other.inputGestures == inputGestures)&&(identical(other.design, design) || other.design == design)&&(identical(other.bannerVisibility, bannerVisibility) || other.bannerVisibility == bannerVisibility)&&const DeepCollectionEquality().equals(other.history, _history)&&(identical(other.zoomEnabled, zoomEnabled) || other.zoomEnabled == zoomEnabled)&&(identical(other.zoomPosition, zoomPosition) || other.zoomPosition == zoomPosition)&&(identical(other.propertyPosition, propertyPosition) || other.propertyPosition == propertyPosition)&&(identical(other.lastVersion, lastVersion) || other.lastVersion == lastVersion)&&const DeepCollectionEquality().equals(other.connections, _connections)&&(identical(other.defaultRemote, defaultRemote) || other.defaultRemote == defaultRemote)&&(identical(other.nativeTitleBar, nativeTitleBar) || other.nativeTitleBar == nativeTitleBar)&&(identical(other.startInFullScreen, startInFullScreen) || other.startInFullScreen == startInFullScreen)&&(identical(other.navigationRail, navigationRail) || other.navigationRail == navigationRail)&&(identical(other.ignorePressure, ignorePressure) || other.ignorePressure == ignorePressure)&&(identical(other.syncMode, syncMode) || other.syncMode == syncMode)&&(identical(other.automaticBackup, automaticBackup) || other.automaticBackup == automaticBackup)&&(identical(other.backupRemote, backupRemote) || other.backupRemote == backupRemote)&&(identical(other.backupIntervalMinutes, backupIntervalMinutes) || other.backupIntervalMinutes == backupIntervalMinutes)&&(identical(other.lastBackup, lastBackup) || other.lastBackup == lastBackup)&&(identical(other.inputConfiguration, inputConfiguration) || other.inputConfiguration == inputConfiguration)&&(identical(other.fallbackPack, fallbackPack) || other.fallbackPack == fallbackPack)&&const DeepCollectionEquality().equals(other.starred, _starred)&&const DeepCollectionEquality().equals(other.favoriteTemplates, _favoriteTemplates)&&(identical(other.defaultTemplate, defaultTemplate) || other.defaultTemplate == defaultTemplate)&&(identical(other.defaultFileName, defaultFileName) || other.defaultFileName == defaultFileName)&&(identical(other.navigatorPosition, navigatorPosition) || other.navigatorPosition == navigatorPosition)&&(identical(other.toolbarPosition, toolbarPosition) || other.toolbarPosition == toolbarPosition)&&(identical(other.toolbarSize, toolbarSize) || other.toolbarSize == toolbarSize)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.imageScale, imageScale) || other.imageScale == imageScale)&&(identical(other.platformTheme, platformTheme) || other.platformTheme == platformTheme)&&const DeepCollectionEquality().equals(other.recentColors, _recentColors)&&const DeepCollectionEquality().equals(other.flags, _flags)&&(identical(other.spreadPages, spreadPages) || other.spreadPages == spreadPages)&&(identical(other.highContrast, highContrast) || other.highContrast == highContrast)&&(identical(other.gridView, gridView) || other.gridView == gridView)&&(identical(other.hideExtension, hideExtension) || other.hideExtension == hideExtension)&&(identical(other.autosave, autosave) || other.autosave == autosave)&&(identical(other.showSaveButton, showSaveButton) || other.showSaveButton == showSaveButton)&&(identical(other.toolbarRows, toolbarRows) || other.toolbarRows == toolbarRows)&&(identical(other.delayedAutosave, delayedAutosave) || other.delayedAutosave == delayedAutosave)&&(identical(other.autosaveDelaySeconds, autosaveDelaySeconds) || other.autosaveDelaySeconds == autosaveDelaySeconds)&&(identical(other.hideCursorWhileDrawing, hideCursorWhileDrawing) || other.hideCursorWhileDrawing == hideCursorWhileDrawing)&&(identical(other.onStartup, onStartup) || other.onStartup == onStartup)&&(identical(other.documentStatePersistence, documentStatePersistence) || other.documentStatePersistence == documentStatePersistence)&&(identical(other.simpleToolbarVisibility, simpleToolbarVisibility) || other.simpleToolbarVisibility == simpleToolbarVisibility)&&(identical(other.optionsPanelPosition, optionsPanelPosition) || other.optionsPanelPosition == optionsPanelPosition)&&(identical(other.renderResolution, renderResolution) || other.renderResolution == renderResolution)&&(identical(other.moveOnGesture, moveOnGesture) || other.moveOnGesture == moveOnGesture)&&(identical(other.rotateOnGesture, rotateOnGesture) || other.rotateOnGesture == rotateOnGesture)&&const DeepCollectionEquality().equals(other.swamps, _swamps)&&(identical(other.selectedPalette, selectedPalette) || other.selectedPalette == selectedPalette)&&(identical(other.showVerboseLogs, showVerboseLogs) || other.showVerboseLogs == showVerboseLogs)&&(identical(other.showThumbnails, showThumbnails) || other.showThumbnails == showThumbnails)&&(identical(other.showNavigatorPreviews, showNavigatorPreviews) || other.showNavigatorPreviews == showNavigatorPreviews)&&(identical(other.bringMovedElementsToFront, bringMovedElementsToFront) || other.bringMovedElementsToFront == bringMovedElementsToFront)&&const DeepCollectionEquality().equals(other.favoriteTools, _favoriteTools));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,theme,density,limitViewportMultiplier,limitViewportPositive,localeTag,documentPath,gestureSensitivity,touchSensitivity,selectSensitivity,scrollSensitivity,rotationStep,zoomStep,penOnlyInput,showPenOnlyToggle,inputGestures,design,bannerVisibility,const DeepCollectionEquality().hash(_history),zoomEnabled,zoomPosition,propertyPosition,lastVersion,const DeepCollectionEquality().hash(_connections),defaultRemote,nativeTitleBar,startInFullScreen,navigationRail,ignorePressure,syncMode,automaticBackup,backupRemote,backupIntervalMinutes,lastBackup,inputConfiguration,fallbackPack,const DeepCollectionEquality().hash(_starred),const DeepCollectionEquality().hash(_favoriteTemplates),defaultTemplate,defaultFileName,navigatorPosition,toolbarPosition,toolbarSize,sortBy,sortOrder,imageScale,platformTheme,const DeepCollectionEquality().hash(_recentColors),const DeepCollectionEquality().hash(_flags),spreadPages,highContrast,gridView,hideExtension,autosave,showSaveButton,toolbarRows,delayedAutosave,autosaveDelaySeconds,hideCursorWhileDrawing,onStartup,documentStatePersistence,simpleToolbarVisibility,optionsPanelPosition,renderResolution,moveOnGesture,rotateOnGesture,const DeepCollectionEquality().hash(_swamps),selectedPalette,showVerboseLogs,showThumbnails,showNavigatorPreviews,bringMovedElementsToFront,const DeepCollectionEquality().hash(_favoriteTools)]);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'ButterflySettings(theme: $theme, density: $density, limitViewportMultiplier: $limitViewportMultiplier, limitViewportPositive: $limitViewportPositive, localeTag: $localeTag, documentPath: $documentPath, gestureSensitivity: $gestureSensitivity, touchSensitivity: $touchSensitivity, selectSensitivity: $selectSensitivity, scrollSensitivity: $scrollSensitivity, rotationStep: $rotationStep, zoomStep: $zoomStep, penOnlyInput: $penOnlyInput, showPenOnlyToggle: $showPenOnlyToggle, inputGestures: $inputGestures, design: $design, bannerVisibility: $bannerVisibility, history: $history, zoomEnabled: $zoomEnabled, zoomPosition: $zoomPosition, propertyPosition: $propertyPosition, lastVersion: $lastVersion, connections: $connections, defaultRemote: $defaultRemote, nativeTitleBar: $nativeTitleBar, startInFullScreen: $startInFullScreen, navigationRail: $navigationRail, ignorePressure: $ignorePressure, syncMode: $syncMode, automaticBackup: $automaticBackup, backupRemote: $backupRemote, backupIntervalMinutes: $backupIntervalMinutes, lastBackup: $lastBackup, inputConfiguration: $inputConfiguration, fallbackPack: $fallbackPack, starred: $starred, favoriteTemplates: $favoriteTemplates, defaultTemplate: $defaultTemplate, defaultFileName: $defaultFileName, navigatorPosition: $navigatorPosition, toolbarPosition: $toolbarPosition, toolbarSize: $toolbarSize, sortBy: $sortBy, sortOrder: $sortOrder, imageScale: $imageScale, platformTheme: $platformTheme, recentColors: $recentColors, flags: $flags, spreadPages: $spreadPages, highContrast: $highContrast, gridView: $gridView, hideExtension: $hideExtension, autosave: $autosave, showSaveButton: $showSaveButton, toolbarRows: $toolbarRows, delayedAutosave: $delayedAutosave, autosaveDelaySeconds: $autosaveDelaySeconds, hideCursorWhileDrawing: $hideCursorWhileDrawing, onStartup: $onStartup, documentStatePersistence: $documentStatePersistence, simpleToolbarVisibility: $simpleToolbarVisibility, optionsPanelPosition: $optionsPanelPosition, renderResolution: $renderResolution, moveOnGesture: $moveOnGesture, rotateOnGesture: $rotateOnGesture, swamps: $swamps, selectedPalette: $selectedPalette, showVerboseLogs: $showVerboseLogs, showThumbnails: $showThumbnails, showNavigatorPreviews: $showNavigatorPreviews, bringMovedElementsToFront: $bringMovedElementsToFront, favoriteTools: $favoriteTools)';
}


}

/// @nodoc
abstract mixin class _$ButterflySettingsCopyWith<$Res> implements $ButterflySettingsCopyWith<$Res> {
  factory _$ButterflySettingsCopyWith(_ButterflySettings value, $Res Function(_ButterflySettings) _then) = __$ButterflySettingsCopyWithImpl;
@override @useResult
$Res call({
 ThemeMode theme, ThemeDensity density, double? limitViewportMultiplier, bool limitViewportPositive, String localeTag, String documentPath, double gestureSensitivity, double touchSensitivity, double selectSensitivity, double scrollSensitivity, double rotationStep, double zoomStep, bool? penOnlyInput, bool showPenOnlyToggle, bool inputGestures, String design, BannerVisibility bannerVisibility,@JsonKey(includeFromJson: false, includeToJson: false) List<AssetLocation> history, bool zoomEnabled, ZoomPosition zoomPosition, ZoomPosition propertyPosition, String? lastVersion,@JsonKey(includeFromJson: false, includeToJson: false) List<ExternalStorage> connections, String defaultRemote, bool nativeTitleBar, bool startInFullScreen, bool navigationRail, IgnorePressure ignorePressure, SyncMode syncMode, bool automaticBackup, String backupRemote, int backupIntervalMinutes, DateTime? lastBackup, InputConfiguration inputConfiguration, String fallbackPack, List<String> starred, List<FavoriteLocation> favoriteTemplates, String defaultTemplate, String defaultFileName, NavigatorPosition navigatorPosition, ToolbarPosition toolbarPosition, ToolbarSize toolbarSize, SortBy sortBy, SortOrder sortOrder, double imageScale, PlatformTheme platformTheme,@SRGBConverter() List<SRGBColor> recentColors, List<String> flags, bool spreadPages, bool highContrast, bool gridView, bool hideExtension, bool autosave, bool showSaveButton, int toolbarRows, bool delayedAutosave, int autosaveDelaySeconds, bool hideCursorWhileDrawing, StartupBehavior onStartup, DocumentStatePersistenceSettings documentStatePersistence, SimpleToolbarVisibility simpleToolbarVisibility, OptionsPanelPosition optionsPanelPosition, RenderResolution renderResolution, bool moveOnGesture, bool rotateOnGesture, List<String> swamps, PackAssetLocation? selectedPalette, bool showVerboseLogs, bool showThumbnails, bool showNavigatorPreviews, bool bringMovedElementsToFront, List<PackAssetLocation> favoriteTools
});


@override $InputConfigurationCopyWith<$Res> get inputConfiguration;@override $DocumentStatePersistenceSettingsCopyWith<$Res> get documentStatePersistence;@override $PackAssetLocationCopyWith<$Res>? get selectedPalette;

}
/// @nodoc
class __$ButterflySettingsCopyWithImpl<$Res>
    implements _$ButterflySettingsCopyWith<$Res> {
  __$ButterflySettingsCopyWithImpl(this._self, this._then);

  final _ButterflySettings _self;
  final $Res Function(_ButterflySettings) _then;

/// Create a copy of ButterflySettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? theme = null,Object? density = null,Object? limitViewportMultiplier = freezed,Object? limitViewportPositive = null,Object? localeTag = null,Object? documentPath = null,Object? gestureSensitivity = null,Object? touchSensitivity = null,Object? selectSensitivity = null,Object? scrollSensitivity = null,Object? rotationStep = null,Object? zoomStep = null,Object? penOnlyInput = freezed,Object? showPenOnlyToggle = null,Object? inputGestures = null,Object? design = null,Object? bannerVisibility = null,Object? history = null,Object? zoomEnabled = null,Object? zoomPosition = null,Object? propertyPosition = null,Object? lastVersion = freezed,Object? connections = null,Object? defaultRemote = null,Object? nativeTitleBar = null,Object? startInFullScreen = null,Object? navigationRail = null,Object? ignorePressure = null,Object? syncMode = null,Object? automaticBackup = null,Object? backupRemote = null,Object? backupIntervalMinutes = null,Object? lastBackup = freezed,Object? inputConfiguration = null,Object? fallbackPack = null,Object? starred = null,Object? favoriteTemplates = null,Object? defaultTemplate = null,Object? defaultFileName = null,Object? navigatorPosition = null,Object? toolbarPosition = null,Object? toolbarSize = null,Object? sortBy = null,Object? sortOrder = null,Object? imageScale = null,Object? platformTheme = null,Object? recentColors = null,Object? flags = null,Object? spreadPages = null,Object? highContrast = null,Object? gridView = null,Object? hideExtension = null,Object? autosave = null,Object? showSaveButton = null,Object? toolbarRows = null,Object? delayedAutosave = null,Object? autosaveDelaySeconds = null,Object? hideCursorWhileDrawing = null,Object? onStartup = null,Object? documentStatePersistence = null,Object? simpleToolbarVisibility = null,Object? optionsPanelPosition = null,Object? renderResolution = null,Object? moveOnGesture = null,Object? rotateOnGesture = null,Object? swamps = null,Object? selectedPalette = freezed,Object? showVerboseLogs = null,Object? showThumbnails = null,Object? showNavigatorPreviews = null,Object? bringMovedElementsToFront = null,Object? favoriteTools = null,}) {
  return _then(_ButterflySettings(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemeMode,density: null == density ? _self.density : density // ignore: cast_nullable_to_non_nullable
as ThemeDensity,limitViewportMultiplier: freezed == limitViewportMultiplier ? _self.limitViewportMultiplier : limitViewportMultiplier // ignore: cast_nullable_to_non_nullable
as double?,limitViewportPositive: null == limitViewportPositive ? _self.limitViewportPositive : limitViewportPositive // ignore: cast_nullable_to_non_nullable
as bool,localeTag: null == localeTag ? _self.localeTag : localeTag // ignore: cast_nullable_to_non_nullable
as String,documentPath: null == documentPath ? _self.documentPath : documentPath // ignore: cast_nullable_to_non_nullable
as String,gestureSensitivity: null == gestureSensitivity ? _self.gestureSensitivity : gestureSensitivity // ignore: cast_nullable_to_non_nullable
as double,touchSensitivity: null == touchSensitivity ? _self.touchSensitivity : touchSensitivity // ignore: cast_nullable_to_non_nullable
as double,selectSensitivity: null == selectSensitivity ? _self.selectSensitivity : selectSensitivity // ignore: cast_nullable_to_non_nullable
as double,scrollSensitivity: null == scrollSensitivity ? _self.scrollSensitivity : scrollSensitivity // ignore: cast_nullable_to_non_nullable
as double,rotationStep: null == rotationStep ? _self.rotationStep : rotationStep // ignore: cast_nullable_to_non_nullable
as double,zoomStep: null == zoomStep ? _self.zoomStep : zoomStep // ignore: cast_nullable_to_non_nullable
as double,penOnlyInput: freezed == penOnlyInput ? _self.penOnlyInput : penOnlyInput // ignore: cast_nullable_to_non_nullable
as bool?,showPenOnlyToggle: null == showPenOnlyToggle ? _self.showPenOnlyToggle : showPenOnlyToggle // ignore: cast_nullable_to_non_nullable
as bool,inputGestures: null == inputGestures ? _self.inputGestures : inputGestures // ignore: cast_nullable_to_non_nullable
as bool,design: null == design ? _self.design : design // ignore: cast_nullable_to_non_nullable
as String,bannerVisibility: null == bannerVisibility ? _self.bannerVisibility : bannerVisibility // ignore: cast_nullable_to_non_nullable
as BannerVisibility,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<AssetLocation>,zoomEnabled: null == zoomEnabled ? _self.zoomEnabled : zoomEnabled // ignore: cast_nullable_to_non_nullable
as bool,zoomPosition: null == zoomPosition ? _self.zoomPosition : zoomPosition // ignore: cast_nullable_to_non_nullable
as ZoomPosition,propertyPosition: null == propertyPosition ? _self.propertyPosition : propertyPosition // ignore: cast_nullable_to_non_nullable
as ZoomPosition,lastVersion: freezed == lastVersion ? _self.lastVersion : lastVersion // ignore: cast_nullable_to_non_nullable
as String?,connections: null == connections ? _self._connections : connections // ignore: cast_nullable_to_non_nullable
as List<ExternalStorage>,defaultRemote: null == defaultRemote ? _self.defaultRemote : defaultRemote // ignore: cast_nullable_to_non_nullable
as String,nativeTitleBar: null == nativeTitleBar ? _self.nativeTitleBar : nativeTitleBar // ignore: cast_nullable_to_non_nullable
as bool,startInFullScreen: null == startInFullScreen ? _self.startInFullScreen : startInFullScreen // ignore: cast_nullable_to_non_nullable
as bool,navigationRail: null == navigationRail ? _self.navigationRail : navigationRail // ignore: cast_nullable_to_non_nullable
as bool,ignorePressure: null == ignorePressure ? _self.ignorePressure : ignorePressure // ignore: cast_nullable_to_non_nullable
as IgnorePressure,syncMode: null == syncMode ? _self.syncMode : syncMode // ignore: cast_nullable_to_non_nullable
as SyncMode,automaticBackup: null == automaticBackup ? _self.automaticBackup : automaticBackup // ignore: cast_nullable_to_non_nullable
as bool,backupRemote: null == backupRemote ? _self.backupRemote : backupRemote // ignore: cast_nullable_to_non_nullable
as String,backupIntervalMinutes: null == backupIntervalMinutes ? _self.backupIntervalMinutes : backupIntervalMinutes // ignore: cast_nullable_to_non_nullable
as int,lastBackup: freezed == lastBackup ? _self.lastBackup : lastBackup // ignore: cast_nullable_to_non_nullable
as DateTime?,inputConfiguration: null == inputConfiguration ? _self.inputConfiguration : inputConfiguration // ignore: cast_nullable_to_non_nullable
as InputConfiguration,fallbackPack: null == fallbackPack ? _self.fallbackPack : fallbackPack // ignore: cast_nullable_to_non_nullable
as String,starred: null == starred ? _self._starred : starred // ignore: cast_nullable_to_non_nullable
as List<String>,favoriteTemplates: null == favoriteTemplates ? _self._favoriteTemplates : favoriteTemplates // ignore: cast_nullable_to_non_nullable
as List<FavoriteLocation>,defaultTemplate: null == defaultTemplate ? _self.defaultTemplate : defaultTemplate // ignore: cast_nullable_to_non_nullable
as String,defaultFileName: null == defaultFileName ? _self.defaultFileName : defaultFileName // ignore: cast_nullable_to_non_nullable
as String,navigatorPosition: null == navigatorPosition ? _self.navigatorPosition : navigatorPosition // ignore: cast_nullable_to_non_nullable
as NavigatorPosition,toolbarPosition: null == toolbarPosition ? _self.toolbarPosition : toolbarPosition // ignore: cast_nullable_to_non_nullable
as ToolbarPosition,toolbarSize: null == toolbarSize ? _self.toolbarSize : toolbarSize // ignore: cast_nullable_to_non_nullable
as ToolbarSize,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as SortBy,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder,imageScale: null == imageScale ? _self.imageScale : imageScale // ignore: cast_nullable_to_non_nullable
as double,platformTheme: null == platformTheme ? _self.platformTheme : platformTheme // ignore: cast_nullable_to_non_nullable
as PlatformTheme,recentColors: null == recentColors ? _self._recentColors : recentColors // ignore: cast_nullable_to_non_nullable
as List<SRGBColor>,flags: null == flags ? _self._flags : flags // ignore: cast_nullable_to_non_nullable
as List<String>,spreadPages: null == spreadPages ? _self.spreadPages : spreadPages // ignore: cast_nullable_to_non_nullable
as bool,highContrast: null == highContrast ? _self.highContrast : highContrast // ignore: cast_nullable_to_non_nullable
as bool,gridView: null == gridView ? _self.gridView : gridView // ignore: cast_nullable_to_non_nullable
as bool,hideExtension: null == hideExtension ? _self.hideExtension : hideExtension // ignore: cast_nullable_to_non_nullable
as bool,autosave: null == autosave ? _self.autosave : autosave // ignore: cast_nullable_to_non_nullable
as bool,showSaveButton: null == showSaveButton ? _self.showSaveButton : showSaveButton // ignore: cast_nullable_to_non_nullable
as bool,toolbarRows: null == toolbarRows ? _self.toolbarRows : toolbarRows // ignore: cast_nullable_to_non_nullable
as int,delayedAutosave: null == delayedAutosave ? _self.delayedAutosave : delayedAutosave // ignore: cast_nullable_to_non_nullable
as bool,autosaveDelaySeconds: null == autosaveDelaySeconds ? _self.autosaveDelaySeconds : autosaveDelaySeconds // ignore: cast_nullable_to_non_nullable
as int,hideCursorWhileDrawing: null == hideCursorWhileDrawing ? _self.hideCursorWhileDrawing : hideCursorWhileDrawing // ignore: cast_nullable_to_non_nullable
as bool,onStartup: null == onStartup ? _self.onStartup : onStartup // ignore: cast_nullable_to_non_nullable
as StartupBehavior,documentStatePersistence: null == documentStatePersistence ? _self.documentStatePersistence : documentStatePersistence // ignore: cast_nullable_to_non_nullable
as DocumentStatePersistenceSettings,simpleToolbarVisibility: null == simpleToolbarVisibility ? _self.simpleToolbarVisibility : simpleToolbarVisibility // ignore: cast_nullable_to_non_nullable
as SimpleToolbarVisibility,optionsPanelPosition: null == optionsPanelPosition ? _self.optionsPanelPosition : optionsPanelPosition // ignore: cast_nullable_to_non_nullable
as OptionsPanelPosition,renderResolution: null == renderResolution ? _self.renderResolution : renderResolution // ignore: cast_nullable_to_non_nullable
as RenderResolution,moveOnGesture: null == moveOnGesture ? _self.moveOnGesture : moveOnGesture // ignore: cast_nullable_to_non_nullable
as bool,rotateOnGesture: null == rotateOnGesture ? _self.rotateOnGesture : rotateOnGesture // ignore: cast_nullable_to_non_nullable
as bool,swamps: null == swamps ? _self._swamps : swamps // ignore: cast_nullable_to_non_nullable
as List<String>,selectedPalette: freezed == selectedPalette ? _self.selectedPalette : selectedPalette // ignore: cast_nullable_to_non_nullable
as PackAssetLocation?,showVerboseLogs: null == showVerboseLogs ? _self.showVerboseLogs : showVerboseLogs // ignore: cast_nullable_to_non_nullable
as bool,showThumbnails: null == showThumbnails ? _self.showThumbnails : showThumbnails // ignore: cast_nullable_to_non_nullable
as bool,showNavigatorPreviews: null == showNavigatorPreviews ? _self.showNavigatorPreviews : showNavigatorPreviews // ignore: cast_nullable_to_non_nullable
as bool,bringMovedElementsToFront: null == bringMovedElementsToFront ? _self.bringMovedElementsToFront : bringMovedElementsToFront // ignore: cast_nullable_to_non_nullable
as bool,favoriteTools: null == favoriteTools ? _self._favoriteTools : favoriteTools // ignore: cast_nullable_to_non_nullable
as List<PackAssetLocation>,
  ));
}

/// Create a copy of ButterflySettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InputConfigurationCopyWith<$Res> get inputConfiguration {
  
  return $InputConfigurationCopyWith<$Res>(_self.inputConfiguration, (value) {
    return _then(_self.copyWith(inputConfiguration: value));
  });
}/// Create a copy of ButterflySettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DocumentStatePersistenceSettingsCopyWith<$Res> get documentStatePersistence {
  
  return $DocumentStatePersistenceSettingsCopyWith<$Res>(_self.documentStatePersistence, (value) {
    return _then(_self.copyWith(documentStatePersistence: value));
  });
}/// Create a copy of ButterflySettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PackAssetLocationCopyWith<$Res>? get selectedPalette {
    if (_self.selectedPalette == null) {
    return null;
  }

  return $PackAssetLocationCopyWith<$Res>(_self.selectedPalette!, (value) {
    return _then(_self.copyWith(selectedPalette: value));
  });
}
}

// dart format on
