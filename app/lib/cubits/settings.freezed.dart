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
  properties
    ..add(DiagnosticsProperty('type', 'FavoriteLocation'))
    ..add(DiagnosticsProperty('remote', remote))..add(DiagnosticsProperty('path', path));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteLocation&&(identical(other.remote, remote) || other.remote == remote)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,remote,path);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FavoriteLocation(remote: $remote, path: $path)';
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
int get hashCode => Object.hash(runtimeType,remote,path);

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
  properties
    ..add(DiagnosticsProperty('type', 'HoldShortcut'))
    ..add(DiagnosticsProperty('keyId', keyId))..add(DiagnosticsProperty('mapping', mapping));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HoldShortcut&&(identical(other.keyId, keyId) || other.keyId == keyId)&&(identical(other.mapping, mapping) || other.mapping == mapping));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,keyId,mapping);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'HoldShortcut(keyId: $keyId, mapping: $mapping)';
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
int get hashCode => Object.hash(runtimeType,keyId,mapping);

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

 InputMapping get leftMouse; InputMapping get middleMouse; InputMapping get rightMouse; InputMapping? get backMouse; InputMapping? get forwardMouse; InputMapping get stylus; InputMapping get invertedStylus; InputMapping get firstStylusButton; InputMapping get secondStylusButton; InputMapping get touch; List<HoldShortcut> get holdShortcuts; String? get doubleLeftMouseShortcut; String? get tripleLeftMouseShortcut; String? get doubleMiddleMouseShortcut; String? get tripleMiddleMouseShortcut; String? get doubleRightMouseShortcut; String? get tripleRightMouseShortcut; String? get doubleBackMouseShortcut; String? get tripleBackMouseShortcut; String? get doubleForwardMouseShortcut; String? get tripleForwardMouseShortcut; String? get doubleStylusShortcut; String? get tripleStylusShortcut; String? get doubleInvertedStylusShortcut; String? get tripleInvertedStylusShortcut; String? get doubleFirstStylusButtonShortcut; String? get tripleFirstStylusButtonShortcut; String? get doubleSecondStylusButtonShortcut; String? get tripleSecondStylusButtonShortcut; String? get doubleTouchShortcut; String? get tripleTouchShortcut; String? get twoFingerTouchShortcut; String? get threeFingerTouchShortcut;
/// Create a copy of InputConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InputConfigurationCopyWith<InputConfiguration> get copyWith => _$InputConfigurationCopyWithImpl<InputConfiguration>(this as InputConfiguration, _$identity);

  /// Serializes this InputConfiguration to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'InputConfiguration'))
    ..add(DiagnosticsProperty('leftMouse', leftMouse))..add(DiagnosticsProperty('middleMouse', middleMouse))..add(DiagnosticsProperty('rightMouse', rightMouse))..add(DiagnosticsProperty('backMouse', backMouse))..add(DiagnosticsProperty('forwardMouse', forwardMouse))..add(DiagnosticsProperty('stylus', stylus))..add(DiagnosticsProperty('invertedStylus', invertedStylus))..add(DiagnosticsProperty('firstStylusButton', firstStylusButton))..add(DiagnosticsProperty('secondStylusButton', secondStylusButton))..add(DiagnosticsProperty('touch', touch))..add(DiagnosticsProperty('holdShortcuts', holdShortcuts))..add(DiagnosticsProperty('doubleLeftMouseShortcut', doubleLeftMouseShortcut))..add(DiagnosticsProperty('tripleLeftMouseShortcut', tripleLeftMouseShortcut))..add(DiagnosticsProperty('doubleMiddleMouseShortcut', doubleMiddleMouseShortcut))..add(DiagnosticsProperty('tripleMiddleMouseShortcut', tripleMiddleMouseShortcut))..add(DiagnosticsProperty('doubleRightMouseShortcut', doubleRightMouseShortcut))..add(DiagnosticsProperty('tripleRightMouseShortcut', tripleRightMouseShortcut))..add(DiagnosticsProperty('doubleBackMouseShortcut', doubleBackMouseShortcut))..add(DiagnosticsProperty('tripleBackMouseShortcut', tripleBackMouseShortcut))..add(DiagnosticsProperty('doubleForwardMouseShortcut', doubleForwardMouseShortcut))..add(DiagnosticsProperty('tripleForwardMouseShortcut', tripleForwardMouseShortcut))..add(DiagnosticsProperty('doubleStylusShortcut', doubleStylusShortcut))..add(DiagnosticsProperty('tripleStylusShortcut', tripleStylusShortcut))..add(DiagnosticsProperty('doubleInvertedStylusShortcut', doubleInvertedStylusShortcut))..add(DiagnosticsProperty('tripleInvertedStylusShortcut', tripleInvertedStylusShortcut))..add(DiagnosticsProperty('doubleFirstStylusButtonShortcut', doubleFirstStylusButtonShortcut))..add(DiagnosticsProperty('tripleFirstStylusButtonShortcut', tripleFirstStylusButtonShortcut))..add(DiagnosticsProperty('doubleSecondStylusButtonShortcut', doubleSecondStylusButtonShortcut))..add(DiagnosticsProperty('tripleSecondStylusButtonShortcut', tripleSecondStylusButtonShortcut))..add(DiagnosticsProperty('doubleTouchShortcut', doubleTouchShortcut))..add(DiagnosticsProperty('tripleTouchShortcut', tripleTouchShortcut))..add(DiagnosticsProperty('twoFingerTouchShortcut', twoFingerTouchShortcut))..add(DiagnosticsProperty('threeFingerTouchShortcut', threeFingerTouchShortcut));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InputConfiguration&&(identical(other.leftMouse, leftMouse) || other.leftMouse == leftMouse)&&(identical(other.middleMouse, middleMouse) || other.middleMouse == middleMouse)&&(identical(other.rightMouse, rightMouse) || other.rightMouse == rightMouse)&&(identical(other.backMouse, backMouse) || other.backMouse == backMouse)&&(identical(other.forwardMouse, forwardMouse) || other.forwardMouse == forwardMouse)&&(identical(other.stylus, stylus) || other.stylus == stylus)&&(identical(other.invertedStylus, invertedStylus) || other.invertedStylus == invertedStylus)&&(identical(other.firstStylusButton, firstStylusButton) || other.firstStylusButton == firstStylusButton)&&(identical(other.secondStylusButton, secondStylusButton) || other.secondStylusButton == secondStylusButton)&&(identical(other.touch, touch) || other.touch == touch)&&const DeepCollectionEquality().equals(other.holdShortcuts, holdShortcuts)&&(identical(other.doubleLeftMouseShortcut, doubleLeftMouseShortcut) || other.doubleLeftMouseShortcut == doubleLeftMouseShortcut)&&(identical(other.tripleLeftMouseShortcut, tripleLeftMouseShortcut) || other.tripleLeftMouseShortcut == tripleLeftMouseShortcut)&&(identical(other.doubleMiddleMouseShortcut, doubleMiddleMouseShortcut) || other.doubleMiddleMouseShortcut == doubleMiddleMouseShortcut)&&(identical(other.tripleMiddleMouseShortcut, tripleMiddleMouseShortcut) || other.tripleMiddleMouseShortcut == tripleMiddleMouseShortcut)&&(identical(other.doubleRightMouseShortcut, doubleRightMouseShortcut) || other.doubleRightMouseShortcut == doubleRightMouseShortcut)&&(identical(other.tripleRightMouseShortcut, tripleRightMouseShortcut) || other.tripleRightMouseShortcut == tripleRightMouseShortcut)&&(identical(other.doubleBackMouseShortcut, doubleBackMouseShortcut) || other.doubleBackMouseShortcut == doubleBackMouseShortcut)&&(identical(other.tripleBackMouseShortcut, tripleBackMouseShortcut) || other.tripleBackMouseShortcut == tripleBackMouseShortcut)&&(identical(other.doubleForwardMouseShortcut, doubleForwardMouseShortcut) || other.doubleForwardMouseShortcut == doubleForwardMouseShortcut)&&(identical(other.tripleForwardMouseShortcut, tripleForwardMouseShortcut) || other.tripleForwardMouseShortcut == tripleForwardMouseShortcut)&&(identical(other.doubleStylusShortcut, doubleStylusShortcut) || other.doubleStylusShortcut == doubleStylusShortcut)&&(identical(other.tripleStylusShortcut, tripleStylusShortcut) || other.tripleStylusShortcut == tripleStylusShortcut)&&(identical(other.doubleInvertedStylusShortcut, doubleInvertedStylusShortcut) || other.doubleInvertedStylusShortcut == doubleInvertedStylusShortcut)&&(identical(other.tripleInvertedStylusShortcut, tripleInvertedStylusShortcut) || other.tripleInvertedStylusShortcut == tripleInvertedStylusShortcut)&&(identical(other.doubleFirstStylusButtonShortcut, doubleFirstStylusButtonShortcut) || other.doubleFirstStylusButtonShortcut == doubleFirstStylusButtonShortcut)&&(identical(other.tripleFirstStylusButtonShortcut, tripleFirstStylusButtonShortcut) || other.tripleFirstStylusButtonShortcut == tripleFirstStylusButtonShortcut)&&(identical(other.doubleSecondStylusButtonShortcut, doubleSecondStylusButtonShortcut) || other.doubleSecondStylusButtonShortcut == doubleSecondStylusButtonShortcut)&&(identical(other.tripleSecondStylusButtonShortcut, tripleSecondStylusButtonShortcut) || other.tripleSecondStylusButtonShortcut == tripleSecondStylusButtonShortcut)&&(identical(other.doubleTouchShortcut, doubleTouchShortcut) || other.doubleTouchShortcut == doubleTouchShortcut)&&(identical(other.tripleTouchShortcut, tripleTouchShortcut) || other.tripleTouchShortcut == tripleTouchShortcut)&&(identical(other.twoFingerTouchShortcut, twoFingerTouchShortcut) || other.twoFingerTouchShortcut == twoFingerTouchShortcut)&&(identical(other.threeFingerTouchShortcut, threeFingerTouchShortcut) || other.threeFingerTouchShortcut == threeFingerTouchShortcut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,leftMouse,middleMouse,rightMouse,backMouse,forwardMouse,stylus,invertedStylus,firstStylusButton,secondStylusButton,touch,const DeepCollectionEquality().hash(holdShortcuts),doubleLeftMouseShortcut,tripleLeftMouseShortcut,doubleMiddleMouseShortcut,tripleMiddleMouseShortcut,doubleRightMouseShortcut,tripleRightMouseShortcut,doubleBackMouseShortcut,tripleBackMouseShortcut,doubleForwardMouseShortcut,tripleForwardMouseShortcut,doubleStylusShortcut,tripleStylusShortcut,doubleInvertedStylusShortcut,tripleInvertedStylusShortcut,doubleFirstStylusButtonShortcut,tripleFirstStylusButtonShortcut,doubleSecondStylusButtonShortcut,tripleSecondStylusButtonShortcut,doubleTouchShortcut,tripleTouchShortcut,twoFingerTouchShortcut,threeFingerTouchShortcut]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'InputConfiguration(leftMouse: $leftMouse, middleMouse: $middleMouse, rightMouse: $rightMouse, backMouse: $backMouse, forwardMouse: $forwardMouse, stylus: $stylus, invertedStylus: $invertedStylus, firstStylusButton: $firstStylusButton, secondStylusButton: $secondStylusButton, touch: $touch, holdShortcuts: $holdShortcuts, doubleLeftMouseShortcut: $doubleLeftMouseShortcut, tripleLeftMouseShortcut: $tripleLeftMouseShortcut, doubleMiddleMouseShortcut: $doubleMiddleMouseShortcut, tripleMiddleMouseShortcut: $tripleMiddleMouseShortcut, doubleRightMouseShortcut: $doubleRightMouseShortcut, tripleRightMouseShortcut: $tripleRightMouseShortcut, doubleBackMouseShortcut: $doubleBackMouseShortcut, tripleBackMouseShortcut: $tripleBackMouseShortcut, doubleForwardMouseShortcut: $doubleForwardMouseShortcut, tripleForwardMouseShortcut: $tripleForwardMouseShortcut, doubleStylusShortcut: $doubleStylusShortcut, tripleStylusShortcut: $tripleStylusShortcut, doubleInvertedStylusShortcut: $doubleInvertedStylusShortcut, tripleInvertedStylusShortcut: $tripleInvertedStylusShortcut, doubleFirstStylusButtonShortcut: $doubleFirstStylusButtonShortcut, tripleFirstStylusButtonShortcut: $tripleFirstStylusButtonShortcut, doubleSecondStylusButtonShortcut: $doubleSecondStylusButtonShortcut, tripleSecondStylusButtonShortcut: $tripleSecondStylusButtonShortcut, doubleTouchShortcut: $doubleTouchShortcut, tripleTouchShortcut: $tripleTouchShortcut, twoFingerTouchShortcut: $twoFingerTouchShortcut, threeFingerTouchShortcut: $threeFingerTouchShortcut)';
}


}

/// @nodoc
abstract mixin class $InputConfigurationCopyWith<$Res>  {
  factory $InputConfigurationCopyWith(InputConfiguration value, $Res Function(InputConfiguration) _then) = _$InputConfigurationCopyWithImpl;
@useResult
$Res call({
 InputMapping leftMouse, InputMapping middleMouse, InputMapping rightMouse, InputMapping? backMouse, InputMapping? forwardMouse, InputMapping stylus, InputMapping invertedStylus, InputMapping firstStylusButton, InputMapping secondStylusButton, InputMapping touch, List<HoldShortcut> holdShortcuts, String? doubleLeftMouseShortcut, String? tripleLeftMouseShortcut, String? doubleMiddleMouseShortcut, String? tripleMiddleMouseShortcut, String? doubleRightMouseShortcut, String? tripleRightMouseShortcut, String? doubleBackMouseShortcut, String? tripleBackMouseShortcut, String? doubleForwardMouseShortcut, String? tripleForwardMouseShortcut, String? doubleStylusShortcut, String? tripleStylusShortcut, String? doubleInvertedStylusShortcut, String? tripleInvertedStylusShortcut, String? doubleFirstStylusButtonShortcut, String? tripleFirstStylusButtonShortcut, String? doubleSecondStylusButtonShortcut, String? tripleSecondStylusButtonShortcut, String? doubleTouchShortcut, String? tripleTouchShortcut, String? twoFingerTouchShortcut, String? threeFingerTouchShortcut
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
@pragma('vm:prefer-inline') @override $Res call({Object? leftMouse = null,Object? middleMouse = null,Object? rightMouse = null,Object? backMouse = freezed,Object? forwardMouse = freezed,Object? stylus = null,Object? invertedStylus = null,Object? firstStylusButton = null,Object? secondStylusButton = null,Object? touch = null,Object? holdShortcuts = null,Object? doubleLeftMouseShortcut = freezed,Object? tripleLeftMouseShortcut = freezed,Object? doubleMiddleMouseShortcut = freezed,Object? tripleMiddleMouseShortcut = freezed,Object? doubleRightMouseShortcut = freezed,Object? tripleRightMouseShortcut = freezed,Object? doubleBackMouseShortcut = freezed,Object? tripleBackMouseShortcut = freezed,Object? doubleForwardMouseShortcut = freezed,Object? tripleForwardMouseShortcut = freezed,Object? doubleStylusShortcut = freezed,Object? tripleStylusShortcut = freezed,Object? doubleInvertedStylusShortcut = freezed,Object? tripleInvertedStylusShortcut = freezed,Object? doubleFirstStylusButtonShortcut = freezed,Object? tripleFirstStylusButtonShortcut = freezed,Object? doubleSecondStylusButtonShortcut = freezed,Object? tripleSecondStylusButtonShortcut = freezed,Object? doubleTouchShortcut = freezed,Object? tripleTouchShortcut = freezed,Object? twoFingerTouchShortcut = freezed,Object? threeFingerTouchShortcut = freezed,}) {
  return _then(InputConfiguration(
leftMouse: null == leftMouse ? _self.leftMouse : leftMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,middleMouse: null == middleMouse ? _self.middleMouse : middleMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,rightMouse: null == rightMouse ? _self.rightMouse : rightMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,backMouse: freezed == backMouse ? _self.backMouse : backMouse // ignore: cast_nullable_to_non_nullable
as InputMapping?,forwardMouse: freezed == forwardMouse ? _self.forwardMouse : forwardMouse // ignore: cast_nullable_to_non_nullable
as InputMapping?,stylus: null == stylus ? _self.stylus : stylus // ignore: cast_nullable_to_non_nullable
as InputMapping,invertedStylus: null == invertedStylus ? _self.invertedStylus : invertedStylus // ignore: cast_nullable_to_non_nullable
as InputMapping,firstStylusButton: null == firstStylusButton ? _self.firstStylusButton : firstStylusButton // ignore: cast_nullable_to_non_nullable
as InputMapping,secondStylusButton: null == secondStylusButton ? _self.secondStylusButton : secondStylusButton // ignore: cast_nullable_to_non_nullable
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
as String?,doubleStylusShortcut: freezed == doubleStylusShortcut ? _self.doubleStylusShortcut : doubleStylusShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleStylusShortcut: freezed == tripleStylusShortcut ? _self.tripleStylusShortcut : tripleStylusShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleInvertedStylusShortcut: freezed == doubleInvertedStylusShortcut ? _self.doubleInvertedStylusShortcut : doubleInvertedStylusShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleInvertedStylusShortcut: freezed == tripleInvertedStylusShortcut ? _self.tripleInvertedStylusShortcut : tripleInvertedStylusShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleFirstStylusButtonShortcut: freezed == doubleFirstStylusButtonShortcut ? _self.doubleFirstStylusButtonShortcut : doubleFirstStylusButtonShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleFirstStylusButtonShortcut: freezed == tripleFirstStylusButtonShortcut ? _self.tripleFirstStylusButtonShortcut : tripleFirstStylusButtonShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleSecondStylusButtonShortcut: freezed == doubleSecondStylusButtonShortcut ? _self.doubleSecondStylusButtonShortcut : doubleSecondStylusButtonShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleSecondStylusButtonShortcut: freezed == tripleSecondStylusButtonShortcut ? _self.tripleSecondStylusButtonShortcut : tripleSecondStylusButtonShortcut // ignore: cast_nullable_to_non_nullable
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
  const _InputConfiguration({this.leftMouse = InputMappingDefault.leftMouse, this.middleMouse = InputMappingDefault.middleMouse, this.rightMouse = InputMappingDefault.rightMouse, this.backMouse, this.forwardMouse, this.stylus = InputMappingDefault.stylus, this.invertedStylus = InputMappingDefault.invertedStylus, this.firstStylusButton = InputMappingDefault.firstStylusButton, this.secondStylusButton = InputMappingDefault.secondStylusButton, this.touch = InputMappingDefault.touch,  List<HoldShortcut> holdShortcuts = const [], this.doubleLeftMouseShortcut, this.tripleLeftMouseShortcut, this.doubleMiddleMouseShortcut, this.tripleMiddleMouseShortcut, this.doubleRightMouseShortcut, this.tripleRightMouseShortcut, this.doubleBackMouseShortcut, this.tripleBackMouseShortcut, this.doubleForwardMouseShortcut, this.tripleForwardMouseShortcut, this.doubleStylusShortcut, this.tripleStylusShortcut, this.doubleInvertedStylusShortcut, this.tripleInvertedStylusShortcut, this.doubleFirstStylusButtonShortcut, this.tripleFirstStylusButtonShortcut, this.doubleSecondStylusButtonShortcut, this.tripleSecondStylusButtonShortcut, this.doubleTouchShortcut, this.tripleTouchShortcut, this.twoFingerTouchShortcut, this.threeFingerTouchShortcut}): _holdShortcuts = holdShortcuts,super._();
  factory _InputConfiguration.fromJson(Map<String, dynamic> json) => _$InputConfigurationFromJson(json);

@override@JsonKey() final  InputMapping leftMouse;
@override@JsonKey() final  InputMapping middleMouse;
@override@JsonKey() final  InputMapping rightMouse;
@override final  InputMapping? backMouse;
@override final  InputMapping? forwardMouse;
@override@JsonKey() final  InputMapping stylus;
@override@JsonKey() final  InputMapping invertedStylus;
@override@JsonKey() final  InputMapping firstStylusButton;
@override@JsonKey() final  InputMapping secondStylusButton;
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
@override final  String? doubleStylusShortcut;
@override final  String? tripleStylusShortcut;
@override final  String? doubleInvertedStylusShortcut;
@override final  String? tripleInvertedStylusShortcut;
@override final  String? doubleFirstStylusButtonShortcut;
@override final  String? tripleFirstStylusButtonShortcut;
@override final  String? doubleSecondStylusButtonShortcut;
@override final  String? tripleSecondStylusButtonShortcut;
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
    ..add(DiagnosticsProperty('leftMouse', leftMouse))..add(DiagnosticsProperty('middleMouse', middleMouse))..add(DiagnosticsProperty('rightMouse', rightMouse))..add(DiagnosticsProperty('backMouse', backMouse))..add(DiagnosticsProperty('forwardMouse', forwardMouse))..add(DiagnosticsProperty('stylus', stylus))..add(DiagnosticsProperty('invertedStylus', invertedStylus))..add(DiagnosticsProperty('firstStylusButton', firstStylusButton))..add(DiagnosticsProperty('secondStylusButton', secondStylusButton))..add(DiagnosticsProperty('touch', touch))..add(DiagnosticsProperty('holdShortcuts', holdShortcuts))..add(DiagnosticsProperty('doubleLeftMouseShortcut', doubleLeftMouseShortcut))..add(DiagnosticsProperty('tripleLeftMouseShortcut', tripleLeftMouseShortcut))..add(DiagnosticsProperty('doubleMiddleMouseShortcut', doubleMiddleMouseShortcut))..add(DiagnosticsProperty('tripleMiddleMouseShortcut', tripleMiddleMouseShortcut))..add(DiagnosticsProperty('doubleRightMouseShortcut', doubleRightMouseShortcut))..add(DiagnosticsProperty('tripleRightMouseShortcut', tripleRightMouseShortcut))..add(DiagnosticsProperty('doubleBackMouseShortcut', doubleBackMouseShortcut))..add(DiagnosticsProperty('tripleBackMouseShortcut', tripleBackMouseShortcut))..add(DiagnosticsProperty('doubleForwardMouseShortcut', doubleForwardMouseShortcut))..add(DiagnosticsProperty('tripleForwardMouseShortcut', tripleForwardMouseShortcut))..add(DiagnosticsProperty('doubleStylusShortcut', doubleStylusShortcut))..add(DiagnosticsProperty('tripleStylusShortcut', tripleStylusShortcut))..add(DiagnosticsProperty('doubleInvertedStylusShortcut', doubleInvertedStylusShortcut))..add(DiagnosticsProperty('tripleInvertedStylusShortcut', tripleInvertedStylusShortcut))..add(DiagnosticsProperty('doubleFirstStylusButtonShortcut', doubleFirstStylusButtonShortcut))..add(DiagnosticsProperty('tripleFirstStylusButtonShortcut', tripleFirstStylusButtonShortcut))..add(DiagnosticsProperty('doubleSecondStylusButtonShortcut', doubleSecondStylusButtonShortcut))..add(DiagnosticsProperty('tripleSecondStylusButtonShortcut', tripleSecondStylusButtonShortcut))..add(DiagnosticsProperty('doubleTouchShortcut', doubleTouchShortcut))..add(DiagnosticsProperty('tripleTouchShortcut', tripleTouchShortcut))..add(DiagnosticsProperty('twoFingerTouchShortcut', twoFingerTouchShortcut))..add(DiagnosticsProperty('threeFingerTouchShortcut', threeFingerTouchShortcut));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InputConfiguration&&(identical(other.leftMouse, leftMouse) || other.leftMouse == leftMouse)&&(identical(other.middleMouse, middleMouse) || other.middleMouse == middleMouse)&&(identical(other.rightMouse, rightMouse) || other.rightMouse == rightMouse)&&(identical(other.backMouse, backMouse) || other.backMouse == backMouse)&&(identical(other.forwardMouse, forwardMouse) || other.forwardMouse == forwardMouse)&&(identical(other.stylus, stylus) || other.stylus == stylus)&&(identical(other.invertedStylus, invertedStylus) || other.invertedStylus == invertedStylus)&&(identical(other.firstStylusButton, firstStylusButton) || other.firstStylusButton == firstStylusButton)&&(identical(other.secondStylusButton, secondStylusButton) || other.secondStylusButton == secondStylusButton)&&(identical(other.touch, touch) || other.touch == touch)&&const DeepCollectionEquality().equals(other._holdShortcuts, _holdShortcuts)&&(identical(other.doubleLeftMouseShortcut, doubleLeftMouseShortcut) || other.doubleLeftMouseShortcut == doubleLeftMouseShortcut)&&(identical(other.tripleLeftMouseShortcut, tripleLeftMouseShortcut) || other.tripleLeftMouseShortcut == tripleLeftMouseShortcut)&&(identical(other.doubleMiddleMouseShortcut, doubleMiddleMouseShortcut) || other.doubleMiddleMouseShortcut == doubleMiddleMouseShortcut)&&(identical(other.tripleMiddleMouseShortcut, tripleMiddleMouseShortcut) || other.tripleMiddleMouseShortcut == tripleMiddleMouseShortcut)&&(identical(other.doubleRightMouseShortcut, doubleRightMouseShortcut) || other.doubleRightMouseShortcut == doubleRightMouseShortcut)&&(identical(other.tripleRightMouseShortcut, tripleRightMouseShortcut) || other.tripleRightMouseShortcut == tripleRightMouseShortcut)&&(identical(other.doubleBackMouseShortcut, doubleBackMouseShortcut) || other.doubleBackMouseShortcut == doubleBackMouseShortcut)&&(identical(other.tripleBackMouseShortcut, tripleBackMouseShortcut) || other.tripleBackMouseShortcut == tripleBackMouseShortcut)&&(identical(other.doubleForwardMouseShortcut, doubleForwardMouseShortcut) || other.doubleForwardMouseShortcut == doubleForwardMouseShortcut)&&(identical(other.tripleForwardMouseShortcut, tripleForwardMouseShortcut) || other.tripleForwardMouseShortcut == tripleForwardMouseShortcut)&&(identical(other.doubleStylusShortcut, doubleStylusShortcut) || other.doubleStylusShortcut == doubleStylusShortcut)&&(identical(other.tripleStylusShortcut, tripleStylusShortcut) || other.tripleStylusShortcut == tripleStylusShortcut)&&(identical(other.doubleInvertedStylusShortcut, doubleInvertedStylusShortcut) || other.doubleInvertedStylusShortcut == doubleInvertedStylusShortcut)&&(identical(other.tripleInvertedStylusShortcut, tripleInvertedStylusShortcut) || other.tripleInvertedStylusShortcut == tripleInvertedStylusShortcut)&&(identical(other.doubleFirstStylusButtonShortcut, doubleFirstStylusButtonShortcut) || other.doubleFirstStylusButtonShortcut == doubleFirstStylusButtonShortcut)&&(identical(other.tripleFirstStylusButtonShortcut, tripleFirstStylusButtonShortcut) || other.tripleFirstStylusButtonShortcut == tripleFirstStylusButtonShortcut)&&(identical(other.doubleSecondStylusButtonShortcut, doubleSecondStylusButtonShortcut) || other.doubleSecondStylusButtonShortcut == doubleSecondStylusButtonShortcut)&&(identical(other.tripleSecondStylusButtonShortcut, tripleSecondStylusButtonShortcut) || other.tripleSecondStylusButtonShortcut == tripleSecondStylusButtonShortcut)&&(identical(other.doubleTouchShortcut, doubleTouchShortcut) || other.doubleTouchShortcut == doubleTouchShortcut)&&(identical(other.tripleTouchShortcut, tripleTouchShortcut) || other.tripleTouchShortcut == tripleTouchShortcut)&&(identical(other.twoFingerTouchShortcut, twoFingerTouchShortcut) || other.twoFingerTouchShortcut == twoFingerTouchShortcut)&&(identical(other.threeFingerTouchShortcut, threeFingerTouchShortcut) || other.threeFingerTouchShortcut == threeFingerTouchShortcut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,leftMouse,middleMouse,rightMouse,backMouse,forwardMouse,stylus,invertedStylus,firstStylusButton,secondStylusButton,touch,const DeepCollectionEquality().hash(_holdShortcuts),doubleLeftMouseShortcut,tripleLeftMouseShortcut,doubleMiddleMouseShortcut,tripleMiddleMouseShortcut,doubleRightMouseShortcut,tripleRightMouseShortcut,doubleBackMouseShortcut,tripleBackMouseShortcut,doubleForwardMouseShortcut,tripleForwardMouseShortcut,doubleStylusShortcut,tripleStylusShortcut,doubleInvertedStylusShortcut,tripleInvertedStylusShortcut,doubleFirstStylusButtonShortcut,tripleFirstStylusButtonShortcut,doubleSecondStylusButtonShortcut,tripleSecondStylusButtonShortcut,doubleTouchShortcut,tripleTouchShortcut,twoFingerTouchShortcut,threeFingerTouchShortcut]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'InputConfiguration(leftMouse: $leftMouse, middleMouse: $middleMouse, rightMouse: $rightMouse, backMouse: $backMouse, forwardMouse: $forwardMouse, stylus: $stylus, invertedStylus: $invertedStylus, firstStylusButton: $firstStylusButton, secondStylusButton: $secondStylusButton, touch: $touch, holdShortcuts: $holdShortcuts, doubleLeftMouseShortcut: $doubleLeftMouseShortcut, tripleLeftMouseShortcut: $tripleLeftMouseShortcut, doubleMiddleMouseShortcut: $doubleMiddleMouseShortcut, tripleMiddleMouseShortcut: $tripleMiddleMouseShortcut, doubleRightMouseShortcut: $doubleRightMouseShortcut, tripleRightMouseShortcut: $tripleRightMouseShortcut, doubleBackMouseShortcut: $doubleBackMouseShortcut, tripleBackMouseShortcut: $tripleBackMouseShortcut, doubleForwardMouseShortcut: $doubleForwardMouseShortcut, tripleForwardMouseShortcut: $tripleForwardMouseShortcut, doubleStylusShortcut: $doubleStylusShortcut, tripleStylusShortcut: $tripleStylusShortcut, doubleInvertedStylusShortcut: $doubleInvertedStylusShortcut, tripleInvertedStylusShortcut: $tripleInvertedStylusShortcut, doubleFirstStylusButtonShortcut: $doubleFirstStylusButtonShortcut, tripleFirstStylusButtonShortcut: $tripleFirstStylusButtonShortcut, doubleSecondStylusButtonShortcut: $doubleSecondStylusButtonShortcut, tripleSecondStylusButtonShortcut: $tripleSecondStylusButtonShortcut, doubleTouchShortcut: $doubleTouchShortcut, tripleTouchShortcut: $tripleTouchShortcut, twoFingerTouchShortcut: $twoFingerTouchShortcut, threeFingerTouchShortcut: $threeFingerTouchShortcut)';
}


}

/// @nodoc
abstract mixin class _$InputConfigurationCopyWith<$Res> implements $InputConfigurationCopyWith<$Res> {
  factory _$InputConfigurationCopyWith(_InputConfiguration value, $Res Function(_InputConfiguration) _then) = __$InputConfigurationCopyWithImpl;
@override @useResult
$Res call({
 InputMapping leftMouse, InputMapping middleMouse, InputMapping rightMouse, InputMapping? backMouse, InputMapping? forwardMouse, InputMapping stylus, InputMapping invertedStylus, InputMapping firstStylusButton, InputMapping secondStylusButton, InputMapping touch, List<HoldShortcut> holdShortcuts, String? doubleLeftMouseShortcut, String? tripleLeftMouseShortcut, String? doubleMiddleMouseShortcut, String? tripleMiddleMouseShortcut, String? doubleRightMouseShortcut, String? tripleRightMouseShortcut, String? doubleBackMouseShortcut, String? tripleBackMouseShortcut, String? doubleForwardMouseShortcut, String? tripleForwardMouseShortcut, String? doubleStylusShortcut, String? tripleStylusShortcut, String? doubleInvertedStylusShortcut, String? tripleInvertedStylusShortcut, String? doubleFirstStylusButtonShortcut, String? tripleFirstStylusButtonShortcut, String? doubleSecondStylusButtonShortcut, String? tripleSecondStylusButtonShortcut, String? doubleTouchShortcut, String? tripleTouchShortcut, String? twoFingerTouchShortcut, String? threeFingerTouchShortcut
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
@override @pragma('vm:prefer-inline') $Res call({Object? leftMouse = null,Object? middleMouse = null,Object? rightMouse = null,Object? backMouse = freezed,Object? forwardMouse = freezed,Object? stylus = null,Object? invertedStylus = null,Object? firstStylusButton = null,Object? secondStylusButton = null,Object? touch = null,Object? holdShortcuts = null,Object? doubleLeftMouseShortcut = freezed,Object? tripleLeftMouseShortcut = freezed,Object? doubleMiddleMouseShortcut = freezed,Object? tripleMiddleMouseShortcut = freezed,Object? doubleRightMouseShortcut = freezed,Object? tripleRightMouseShortcut = freezed,Object? doubleBackMouseShortcut = freezed,Object? tripleBackMouseShortcut = freezed,Object? doubleForwardMouseShortcut = freezed,Object? tripleForwardMouseShortcut = freezed,Object? doubleStylusShortcut = freezed,Object? tripleStylusShortcut = freezed,Object? doubleInvertedStylusShortcut = freezed,Object? tripleInvertedStylusShortcut = freezed,Object? doubleFirstStylusButtonShortcut = freezed,Object? tripleFirstStylusButtonShortcut = freezed,Object? doubleSecondStylusButtonShortcut = freezed,Object? tripleSecondStylusButtonShortcut = freezed,Object? doubleTouchShortcut = freezed,Object? tripleTouchShortcut = freezed,Object? twoFingerTouchShortcut = freezed,Object? threeFingerTouchShortcut = freezed,}) {
  return _then(_InputConfiguration(
leftMouse: null == leftMouse ? _self.leftMouse : leftMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,middleMouse: null == middleMouse ? _self.middleMouse : middleMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,rightMouse: null == rightMouse ? _self.rightMouse : rightMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,backMouse: freezed == backMouse ? _self.backMouse : backMouse // ignore: cast_nullable_to_non_nullable
as InputMapping?,forwardMouse: freezed == forwardMouse ? _self.forwardMouse : forwardMouse // ignore: cast_nullable_to_non_nullable
as InputMapping?,stylus: null == stylus ? _self.stylus : stylus // ignore: cast_nullable_to_non_nullable
as InputMapping,invertedStylus: null == invertedStylus ? _self.invertedStylus : invertedStylus // ignore: cast_nullable_to_non_nullable
as InputMapping,firstStylusButton: null == firstStylusButton ? _self.firstStylusButton : firstStylusButton // ignore: cast_nullable_to_non_nullable
as InputMapping,secondStylusButton: null == secondStylusButton ? _self.secondStylusButton : secondStylusButton // ignore: cast_nullable_to_non_nullable
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
as String?,doubleStylusShortcut: freezed == doubleStylusShortcut ? _self.doubleStylusShortcut : doubleStylusShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleStylusShortcut: freezed == tripleStylusShortcut ? _self.tripleStylusShortcut : tripleStylusShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleInvertedStylusShortcut: freezed == doubleInvertedStylusShortcut ? _self.doubleInvertedStylusShortcut : doubleInvertedStylusShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleInvertedStylusShortcut: freezed == tripleInvertedStylusShortcut ? _self.tripleInvertedStylusShortcut : tripleInvertedStylusShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleFirstStylusButtonShortcut: freezed == doubleFirstStylusButtonShortcut ? _self.doubleFirstStylusButtonShortcut : doubleFirstStylusButtonShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleFirstStylusButtonShortcut: freezed == tripleFirstStylusButtonShortcut ? _self.tripleFirstStylusButtonShortcut : tripleFirstStylusButtonShortcut // ignore: cast_nullable_to_non_nullable
as String?,doubleSecondStylusButtonShortcut: freezed == doubleSecondStylusButtonShortcut ? _self.doubleSecondStylusButtonShortcut : doubleSecondStylusButtonShortcut // ignore: cast_nullable_to_non_nullable
as String?,tripleSecondStylusButtonShortcut: freezed == tripleSecondStylusButtonShortcut ? _self.tripleSecondStylusButtonShortcut : tripleSecondStylusButtonShortcut // ignore: cast_nullable_to_non_nullable
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
  properties
    ..add(DiagnosticsProperty('type', 'DocumentStatePersistenceSettings'))
    ..add(DiagnosticsProperty('enabled', enabled))..add(DiagnosticsProperty('page', page))..add(DiagnosticsProperty('camera', camera))..add(DiagnosticsProperty('locks', locks))..add(DiagnosticsProperty('tool', tool))..add(DiagnosticsProperty('navigator', navigator))..add(DiagnosticsProperty('layers', layers))..add(DiagnosticsProperty('areas', areas))..add(DiagnosticsProperty('maxEntries', maxEntries))..add(DiagnosticsProperty('maxAgeDays', maxAgeDays));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentStatePersistenceSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.page, page) || other.page == page)&&(identical(other.camera, camera) || other.camera == camera)&&(identical(other.locks, locks) || other.locks == locks)&&(identical(other.tool, tool) || other.tool == tool)&&(identical(other.navigator, navigator) || other.navigator == navigator)&&(identical(other.layers, layers) || other.layers == layers)&&(identical(other.areas, areas) || other.areas == areas)&&(identical(other.maxEntries, maxEntries) || other.maxEntries == maxEntries)&&(identical(other.maxAgeDays, maxAgeDays) || other.maxAgeDays == maxAgeDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,page,camera,locks,tool,navigator,layers,areas,maxEntries,maxAgeDays);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DocumentStatePersistenceSettings(enabled: $enabled, page: $page, camera: $camera, locks: $locks, tool: $tool, navigator: $navigator, layers: $layers, areas: $areas, maxEntries: $maxEntries, maxAgeDays: $maxAgeDays)';
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
int get hashCode => Object.hash(runtimeType,enabled,page,camera,locks,tool,navigator,layers,areas,maxEntries,maxAgeDays);

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

 ThemeMode get theme; ThemeDensity get density; double? get limitViewportMultiplier; bool get limitViewportPositive; String get localeTag; String get documentPath; double get gestureSensitivity; double get touchSensitivity; double get selectSensitivity; double get scrollSensitivity; double get rotationStep; double get zoomStep; bool? get stylusOnlyInput; bool get showStylusOnlyToggle; bool get inputGestures; String get design; BannerVisibility get bannerVisibility;@JsonKey(includeFromJson: false, includeToJson: false) List<AssetLocation> get history; bool get zoomEnabled; ZoomPosition get zoomPosition; ZoomPosition get propertyPosition; String? get lastVersion;@JsonKey(includeFromJson: false, includeToJson: false) List<ExternalStorage> get connections; String get defaultRemote; bool get nativeTitleBar; bool get startInFullScreen; bool get navigationRail; IgnorePressure get ignorePressure; SyncMode get syncMode; bool get automaticBackup; String get backupRemote; int get backupIntervalMinutes; DateTime? get lastBackup; InputConfiguration get inputConfiguration; String get fallbackPack; List<String> get starred; List<FavoriteLocation> get favoriteTemplates; String get defaultTemplate; String get defaultFileName; NavigatorPosition get navigatorPosition; ToolbarPosition get toolbarPosition; ToolbarSize get toolbarSize; SortBy get sortBy; SortOrder get sortOrder; double get imageScale; PlatformTheme get platformTheme;@SRGBConverter() List<SRGBColor> get recentColors; List<String> get flags; bool get spreadPages; bool get highContrast; bool get gridView; bool get hideExtension; bool get autosave; bool get showSaveButton; int get toolbarRows; bool get delayedAutosave; int get autosaveDelaySeconds; bool get hideCursorWhileDrawing; StartupBehavior get onStartup; DocumentStatePersistenceSettings get documentStatePersistence; SimpleToolbarVisibility get simpleToolbarVisibility; OptionsPanelPosition get optionsPanelPosition; RenderResolution get renderResolution; bool get moveOnGesture; bool get rotateOnGesture; List<String> get swamps; PackAssetLocation? get selectedPalette; bool get showVerboseLogs; bool get showThumbnails; bool get showNavigatorPreviews; bool get bringMovedElementsToFront; List<PackAssetLocation> get favoriteTools;
/// Create a copy of ButterflySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ButterflySettingsCopyWith<ButterflySettings> get copyWith => _$ButterflySettingsCopyWithImpl<ButterflySettings>(this as ButterflySettings, _$identity);

  /// Serializes this ButterflySettings to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ButterflySettings'))
    ..add(DiagnosticsProperty('theme', theme))..add(DiagnosticsProperty('density', density))..add(DiagnosticsProperty('limitViewportMultiplier', limitViewportMultiplier))..add(DiagnosticsProperty('limitViewportPositive', limitViewportPositive))..add(DiagnosticsProperty('localeTag', localeTag))..add(DiagnosticsProperty('documentPath', documentPath))..add(DiagnosticsProperty('gestureSensitivity', gestureSensitivity))..add(DiagnosticsProperty('touchSensitivity', touchSensitivity))..add(DiagnosticsProperty('selectSensitivity', selectSensitivity))..add(DiagnosticsProperty('scrollSensitivity', scrollSensitivity))..add(DiagnosticsProperty('rotationStep', rotationStep))..add(DiagnosticsProperty('zoomStep', zoomStep))..add(DiagnosticsProperty('stylusOnlyInput', stylusOnlyInput))..add(DiagnosticsProperty('showStylusOnlyToggle', showStylusOnlyToggle))..add(DiagnosticsProperty('inputGestures', inputGestures))..add(DiagnosticsProperty('design', design))..add(DiagnosticsProperty('bannerVisibility', bannerVisibility))..add(DiagnosticsProperty('history', history))..add(DiagnosticsProperty('zoomEnabled', zoomEnabled))..add(DiagnosticsProperty('zoomPosition', zoomPosition))..add(DiagnosticsProperty('propertyPosition', propertyPosition))..add(DiagnosticsProperty('lastVersion', lastVersion))..add(DiagnosticsProperty('connections', connections))..add(DiagnosticsProperty('defaultRemote', defaultRemote))..add(DiagnosticsProperty('nativeTitleBar', nativeTitleBar))..add(DiagnosticsProperty('startInFullScreen', startInFullScreen))..add(DiagnosticsProperty('navigationRail', navigationRail))..add(DiagnosticsProperty('ignorePressure', ignorePressure))..add(DiagnosticsProperty('syncMode', syncMode))..add(DiagnosticsProperty('automaticBackup', automaticBackup))..add(DiagnosticsProperty('backupRemote', backupRemote))..add(DiagnosticsProperty('backupIntervalMinutes', backupIntervalMinutes))..add(DiagnosticsProperty('lastBackup', lastBackup))..add(DiagnosticsProperty('inputConfiguration', inputConfiguration))..add(DiagnosticsProperty('fallbackPack', fallbackPack))..add(DiagnosticsProperty('starred', starred))..add(DiagnosticsProperty('favoriteTemplates', favoriteTemplates))..add(DiagnosticsProperty('defaultTemplate', defaultTemplate))..add(DiagnosticsProperty('defaultFileName', defaultFileName))..add(DiagnosticsProperty('navigatorPosition', navigatorPosition))..add(DiagnosticsProperty('toolbarPosition', toolbarPosition))..add(DiagnosticsProperty('toolbarSize', toolbarSize))..add(DiagnosticsProperty('sortBy', sortBy))..add(DiagnosticsProperty('sortOrder', sortOrder))..add(DiagnosticsProperty('imageScale', imageScale))..add(DiagnosticsProperty('platformTheme', platformTheme))..add(DiagnosticsProperty('recentColors', recentColors))..add(DiagnosticsProperty('flags', flags))..add(DiagnosticsProperty('spreadPages', spreadPages))..add(DiagnosticsProperty('highContrast', highContrast))..add(DiagnosticsProperty('gridView', gridView))..add(DiagnosticsProperty('hideExtension', hideExtension))..add(DiagnosticsProperty('autosave', autosave))..add(DiagnosticsProperty('showSaveButton', showSaveButton))..add(DiagnosticsProperty('toolbarRows', toolbarRows))..add(DiagnosticsProperty('delayedAutosave', delayedAutosave))..add(DiagnosticsProperty('autosaveDelaySeconds', autosaveDelaySeconds))..add(DiagnosticsProperty('hideCursorWhileDrawing', hideCursorWhileDrawing))..add(DiagnosticsProperty('onStartup', onStartup))..add(DiagnosticsProperty('documentStatePersistence', documentStatePersistence))..add(DiagnosticsProperty('simpleToolbarVisibility', simpleToolbarVisibility))..add(DiagnosticsProperty('optionsPanelPosition', optionsPanelPosition))..add(DiagnosticsProperty('renderResolution', renderResolution))..add(DiagnosticsProperty('moveOnGesture', moveOnGesture))..add(DiagnosticsProperty('rotateOnGesture', rotateOnGesture))..add(DiagnosticsProperty('swamps', swamps))..add(DiagnosticsProperty('selectedPalette', selectedPalette))..add(DiagnosticsProperty('showVerboseLogs', showVerboseLogs))..add(DiagnosticsProperty('showThumbnails', showThumbnails))..add(DiagnosticsProperty('showNavigatorPreviews', showNavigatorPreviews))..add(DiagnosticsProperty('bringMovedElementsToFront', bringMovedElementsToFront))..add(DiagnosticsProperty('favoriteTools', favoriteTools));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ButterflySettings&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.density, density) || other.density == density)&&(identical(other.limitViewportMultiplier, limitViewportMultiplier) || other.limitViewportMultiplier == limitViewportMultiplier)&&(identical(other.limitViewportPositive, limitViewportPositive) || other.limitViewportPositive == limitViewportPositive)&&(identical(other.localeTag, localeTag) || other.localeTag == localeTag)&&(identical(other.documentPath, documentPath) || other.documentPath == documentPath)&&(identical(other.gestureSensitivity, gestureSensitivity) || other.gestureSensitivity == gestureSensitivity)&&(identical(other.touchSensitivity, touchSensitivity) || other.touchSensitivity == touchSensitivity)&&(identical(other.selectSensitivity, selectSensitivity) || other.selectSensitivity == selectSensitivity)&&(identical(other.scrollSensitivity, scrollSensitivity) || other.scrollSensitivity == scrollSensitivity)&&(identical(other.rotationStep, rotationStep) || other.rotationStep == rotationStep)&&(identical(other.zoomStep, zoomStep) || other.zoomStep == zoomStep)&&(identical(other.stylusOnlyInput, stylusOnlyInput) || other.stylusOnlyInput == stylusOnlyInput)&&(identical(other.showStylusOnlyToggle, showStylusOnlyToggle) || other.showStylusOnlyToggle == showStylusOnlyToggle)&&(identical(other.inputGestures, inputGestures) || other.inputGestures == inputGestures)&&(identical(other.design, design) || other.design == design)&&(identical(other.bannerVisibility, bannerVisibility) || other.bannerVisibility == bannerVisibility)&&const DeepCollectionEquality().equals(other.history, history)&&(identical(other.zoomEnabled, zoomEnabled) || other.zoomEnabled == zoomEnabled)&&(identical(other.zoomPosition, zoomPosition) || other.zoomPosition == zoomPosition)&&(identical(other.propertyPosition, propertyPosition) || other.propertyPosition == propertyPosition)&&(identical(other.lastVersion, lastVersion) || other.lastVersion == lastVersion)&&const DeepCollectionEquality().equals(other.connections, connections)&&(identical(other.defaultRemote, defaultRemote) || other.defaultRemote == defaultRemote)&&(identical(other.nativeTitleBar, nativeTitleBar) || other.nativeTitleBar == nativeTitleBar)&&(identical(other.startInFullScreen, startInFullScreen) || other.startInFullScreen == startInFullScreen)&&(identical(other.navigationRail, navigationRail) || other.navigationRail == navigationRail)&&(identical(other.ignorePressure, ignorePressure) || other.ignorePressure == ignorePressure)&&(identical(other.syncMode, syncMode) || other.syncMode == syncMode)&&(identical(other.automaticBackup, automaticBackup) || other.automaticBackup == automaticBackup)&&(identical(other.backupRemote, backupRemote) || other.backupRemote == backupRemote)&&(identical(other.backupIntervalMinutes, backupIntervalMinutes) || other.backupIntervalMinutes == backupIntervalMinutes)&&(identical(other.lastBackup, lastBackup) || other.lastBackup == lastBackup)&&(identical(other.inputConfiguration, inputConfiguration) || other.inputConfiguration == inputConfiguration)&&(identical(other.fallbackPack, fallbackPack) || other.fallbackPack == fallbackPack)&&const DeepCollectionEquality().equals(other.starred, starred)&&const DeepCollectionEquality().equals(other.favoriteTemplates, favoriteTemplates)&&(identical(other.defaultTemplate, defaultTemplate) || other.defaultTemplate == defaultTemplate)&&(identical(other.defaultFileName, defaultFileName) || other.defaultFileName == defaultFileName)&&(identical(other.navigatorPosition, navigatorPosition) || other.navigatorPosition == navigatorPosition)&&(identical(other.toolbarPosition, toolbarPosition) || other.toolbarPosition == toolbarPosition)&&(identical(other.toolbarSize, toolbarSize) || other.toolbarSize == toolbarSize)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.imageScale, imageScale) || other.imageScale == imageScale)&&(identical(other.platformTheme, platformTheme) || other.platformTheme == platformTheme)&&const DeepCollectionEquality().equals(other.recentColors, recentColors)&&const DeepCollectionEquality().equals(other.flags, flags)&&(identical(other.spreadPages, spreadPages) || other.spreadPages == spreadPages)&&(identical(other.highContrast, highContrast) || other.highContrast == highContrast)&&(identical(other.gridView, gridView) || other.gridView == gridView)&&(identical(other.hideExtension, hideExtension) || other.hideExtension == hideExtension)&&(identical(other.autosave, autosave) || other.autosave == autosave)&&(identical(other.showSaveButton, showSaveButton) || other.showSaveButton == showSaveButton)&&(identical(other.toolbarRows, toolbarRows) || other.toolbarRows == toolbarRows)&&(identical(other.delayedAutosave, delayedAutosave) || other.delayedAutosave == delayedAutosave)&&(identical(other.autosaveDelaySeconds, autosaveDelaySeconds) || other.autosaveDelaySeconds == autosaveDelaySeconds)&&(identical(other.hideCursorWhileDrawing, hideCursorWhileDrawing) || other.hideCursorWhileDrawing == hideCursorWhileDrawing)&&(identical(other.onStartup, onStartup) || other.onStartup == onStartup)&&(identical(other.documentStatePersistence, documentStatePersistence) || other.documentStatePersistence == documentStatePersistence)&&(identical(other.simpleToolbarVisibility, simpleToolbarVisibility) || other.simpleToolbarVisibility == simpleToolbarVisibility)&&(identical(other.optionsPanelPosition, optionsPanelPosition) || other.optionsPanelPosition == optionsPanelPosition)&&(identical(other.renderResolution, renderResolution) || other.renderResolution == renderResolution)&&(identical(other.moveOnGesture, moveOnGesture) || other.moveOnGesture == moveOnGesture)&&(identical(other.rotateOnGesture, rotateOnGesture) || other.rotateOnGesture == rotateOnGesture)&&const DeepCollectionEquality().equals(other.swamps, swamps)&&(identical(other.selectedPalette, selectedPalette) || other.selectedPalette == selectedPalette)&&(identical(other.showVerboseLogs, showVerboseLogs) || other.showVerboseLogs == showVerboseLogs)&&(identical(other.showThumbnails, showThumbnails) || other.showThumbnails == showThumbnails)&&(identical(other.showNavigatorPreviews, showNavigatorPreviews) || other.showNavigatorPreviews == showNavigatorPreviews)&&(identical(other.bringMovedElementsToFront, bringMovedElementsToFront) || other.bringMovedElementsToFront == bringMovedElementsToFront)&&const DeepCollectionEquality().equals(other.favoriteTools, favoriteTools));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,theme,density,limitViewportMultiplier,limitViewportPositive,localeTag,documentPath,gestureSensitivity,touchSensitivity,selectSensitivity,scrollSensitivity,rotationStep,zoomStep,stylusOnlyInput,showStylusOnlyToggle,inputGestures,design,bannerVisibility,const DeepCollectionEquality().hash(history),zoomEnabled,zoomPosition,propertyPosition,lastVersion,const DeepCollectionEquality().hash(connections),defaultRemote,nativeTitleBar,startInFullScreen,navigationRail,ignorePressure,syncMode,automaticBackup,backupRemote,backupIntervalMinutes,lastBackup,inputConfiguration,fallbackPack,const DeepCollectionEquality().hash(starred),const DeepCollectionEquality().hash(favoriteTemplates),defaultTemplate,defaultFileName,navigatorPosition,toolbarPosition,toolbarSize,sortBy,sortOrder,imageScale,platformTheme,const DeepCollectionEquality().hash(recentColors),const DeepCollectionEquality().hash(flags),spreadPages,highContrast,gridView,hideExtension,autosave,showSaveButton,toolbarRows,delayedAutosave,autosaveDelaySeconds,hideCursorWhileDrawing,onStartup,documentStatePersistence,simpleToolbarVisibility,optionsPanelPosition,renderResolution,moveOnGesture,rotateOnGesture,const DeepCollectionEquality().hash(swamps),selectedPalette,showVerboseLogs,showThumbnails,showNavigatorPreviews,bringMovedElementsToFront,const DeepCollectionEquality().hash(favoriteTools)]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ButterflySettings(theme: $theme, density: $density, limitViewportMultiplier: $limitViewportMultiplier, limitViewportPositive: $limitViewportPositive, localeTag: $localeTag, documentPath: $documentPath, gestureSensitivity: $gestureSensitivity, touchSensitivity: $touchSensitivity, selectSensitivity: $selectSensitivity, scrollSensitivity: $scrollSensitivity, rotationStep: $rotationStep, zoomStep: $zoomStep, stylusOnlyInput: $stylusOnlyInput, showStylusOnlyToggle: $showStylusOnlyToggle, inputGestures: $inputGestures, design: $design, bannerVisibility: $bannerVisibility, history: $history, zoomEnabled: $zoomEnabled, zoomPosition: $zoomPosition, propertyPosition: $propertyPosition, lastVersion: $lastVersion, connections: $connections, defaultRemote: $defaultRemote, nativeTitleBar: $nativeTitleBar, startInFullScreen: $startInFullScreen, navigationRail: $navigationRail, ignorePressure: $ignorePressure, syncMode: $syncMode, automaticBackup: $automaticBackup, backupRemote: $backupRemote, backupIntervalMinutes: $backupIntervalMinutes, lastBackup: $lastBackup, inputConfiguration: $inputConfiguration, fallbackPack: $fallbackPack, starred: $starred, favoriteTemplates: $favoriteTemplates, defaultTemplate: $defaultTemplate, defaultFileName: $defaultFileName, navigatorPosition: $navigatorPosition, toolbarPosition: $toolbarPosition, toolbarSize: $toolbarSize, sortBy: $sortBy, sortOrder: $sortOrder, imageScale: $imageScale, platformTheme: $platformTheme, recentColors: $recentColors, flags: $flags, spreadPages: $spreadPages, highContrast: $highContrast, gridView: $gridView, hideExtension: $hideExtension, autosave: $autosave, showSaveButton: $showSaveButton, toolbarRows: $toolbarRows, delayedAutosave: $delayedAutosave, autosaveDelaySeconds: $autosaveDelaySeconds, hideCursorWhileDrawing: $hideCursorWhileDrawing, onStartup: $onStartup, documentStatePersistence: $documentStatePersistence, simpleToolbarVisibility: $simpleToolbarVisibility, optionsPanelPosition: $optionsPanelPosition, renderResolution: $renderResolution, moveOnGesture: $moveOnGesture, rotateOnGesture: $rotateOnGesture, swamps: $swamps, selectedPalette: $selectedPalette, showVerboseLogs: $showVerboseLogs, showThumbnails: $showThumbnails, showNavigatorPreviews: $showNavigatorPreviews, bringMovedElementsToFront: $bringMovedElementsToFront, favoriteTools: $favoriteTools)';
}


}

/// @nodoc
abstract mixin class $ButterflySettingsCopyWith<$Res>  {
  factory $ButterflySettingsCopyWith(ButterflySettings value, $Res Function(ButterflySettings) _then) = _$ButterflySettingsCopyWithImpl;
@useResult
$Res call({
 ThemeMode theme, ThemeDensity density, double? limitViewportMultiplier, bool limitViewportPositive, String localeTag, String documentPath, double gestureSensitivity, double touchSensitivity, double selectSensitivity, double scrollSensitivity, double rotationStep, double zoomStep, bool? stylusOnlyInput, bool showStylusOnlyToggle, bool inputGestures, String design, BannerVisibility bannerVisibility,@JsonKey(includeFromJson: false, includeToJson: false) List<AssetLocation> history, bool zoomEnabled, ZoomPosition zoomPosition, ZoomPosition propertyPosition, String? lastVersion,@JsonKey(includeFromJson: false, includeToJson: false) List<ExternalStorage> connections, String defaultRemote, bool nativeTitleBar, bool startInFullScreen, bool navigationRail, IgnorePressure ignorePressure, SyncMode syncMode, bool automaticBackup, String backupRemote, int backupIntervalMinutes, DateTime? lastBackup, InputConfiguration inputConfiguration, String fallbackPack, List<String> starred, List<FavoriteLocation> favoriteTemplates, String defaultTemplate, String defaultFileName, NavigatorPosition navigatorPosition, ToolbarPosition toolbarPosition, ToolbarSize toolbarSize, SortBy sortBy, SortOrder sortOrder, double imageScale, PlatformTheme platformTheme,@SRGBConverter() List<SRGBColor> recentColors, List<String> flags, bool spreadPages, bool highContrast, bool gridView, bool hideExtension, bool autosave, bool showSaveButton, int toolbarRows, bool delayedAutosave, int autosaveDelaySeconds, bool hideCursorWhileDrawing, StartupBehavior onStartup, DocumentStatePersistenceSettings documentStatePersistence, SimpleToolbarVisibility simpleToolbarVisibility, OptionsPanelPosition optionsPanelPosition, RenderResolution renderResolution, bool moveOnGesture, bool rotateOnGesture, List<String> swamps, PackAssetLocation? selectedPalette, bool showVerboseLogs, bool showThumbnails, bool showNavigatorPreviews, bool bringMovedElementsToFront, List<PackAssetLocation> favoriteTools
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
@pragma('vm:prefer-inline') @override $Res call({Object? theme = null,Object? density = null,Object? limitViewportMultiplier = freezed,Object? limitViewportPositive = null,Object? localeTag = null,Object? documentPath = null,Object? gestureSensitivity = null,Object? touchSensitivity = null,Object? selectSensitivity = null,Object? scrollSensitivity = null,Object? rotationStep = null,Object? zoomStep = null,Object? stylusOnlyInput = freezed,Object? showStylusOnlyToggle = null,Object? inputGestures = null,Object? design = null,Object? bannerVisibility = null,Object? history = null,Object? zoomEnabled = null,Object? zoomPosition = null,Object? propertyPosition = null,Object? lastVersion = freezed,Object? connections = null,Object? defaultRemote = null,Object? nativeTitleBar = null,Object? startInFullScreen = null,Object? navigationRail = null,Object? ignorePressure = null,Object? syncMode = null,Object? automaticBackup = null,Object? backupRemote = null,Object? backupIntervalMinutes = null,Object? lastBackup = freezed,Object? inputConfiguration = null,Object? fallbackPack = null,Object? starred = null,Object? favoriteTemplates = null,Object? defaultTemplate = null,Object? defaultFileName = null,Object? navigatorPosition = null,Object? toolbarPosition = null,Object? toolbarSize = null,Object? sortBy = null,Object? sortOrder = null,Object? imageScale = null,Object? platformTheme = null,Object? recentColors = null,Object? flags = null,Object? spreadPages = null,Object? highContrast = null,Object? gridView = null,Object? hideExtension = null,Object? autosave = null,Object? showSaveButton = null,Object? toolbarRows = null,Object? delayedAutosave = null,Object? autosaveDelaySeconds = null,Object? hideCursorWhileDrawing = null,Object? onStartup = null,Object? documentStatePersistence = null,Object? simpleToolbarVisibility = null,Object? optionsPanelPosition = null,Object? renderResolution = null,Object? moveOnGesture = null,Object? rotateOnGesture = null,Object? swamps = null,Object? selectedPalette = freezed,Object? showVerboseLogs = null,Object? showThumbnails = null,Object? showNavigatorPreviews = null,Object? bringMovedElementsToFront = null,Object? favoriteTools = null,}) {
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
as double,stylusOnlyInput: freezed == stylusOnlyInput ? _self.stylusOnlyInput : stylusOnlyInput // ignore: cast_nullable_to_non_nullable
as bool?,showStylusOnlyToggle: null == showStylusOnlyToggle ? _self.showStylusOnlyToggle : showStylusOnlyToggle // ignore: cast_nullable_to_non_nullable
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
  const _ButterflySettings({this.theme = ThemeMode.system, this.density = ThemeDensity.system, this.limitViewportMultiplier, this.limitViewportPositive = false, this.localeTag = '', this.documentPath = '', this.gestureSensitivity = 1, this.touchSensitivity = 1, this.selectSensitivity = 1, this.scrollSensitivity = 1, this.rotationStep = kDefaultRotationStep, this.zoomStep = kDefaultZoomStep, this.stylusOnlyInput, this.showStylusOnlyToggle = true, this.inputGestures = true, this.design = '', this.bannerVisibility = BannerVisibility.always, @JsonKey(includeFromJson: false, includeToJson: false)  List<AssetLocation> history = const [], this.zoomEnabled = true, this.zoomPosition = ZoomPosition.bottomRight, this.propertyPosition = ZoomPosition.topRight, this.lastVersion, @JsonKey(includeFromJson: false, includeToJson: false)  List<ExternalStorage> connections = const [], this.defaultRemote = '', this.nativeTitleBar = false, this.startInFullScreen = false, this.navigationRail = true, this.ignorePressure = IgnorePressure.first, this.syncMode = SyncMode.noMobile, this.automaticBackup = false, this.backupRemote = '', this.backupIntervalMinutes = kDefaultBackupIntervalMinutes, this.lastBackup, this.inputConfiguration = const InputConfiguration(), this.fallbackPack = '',  List<String> starred = const [],  List<FavoriteLocation> favoriteTemplates = const [], this.defaultTemplate = '', this.defaultFileName = kDefaultFileName, this.navigatorPosition = NavigatorPosition.left, this.toolbarPosition = ToolbarPosition.inline, this.toolbarSize = ToolbarSize.normal, this.sortBy = SortBy.modified, this.sortOrder = SortOrder.descending, this.imageScale = 0.5, this.platformTheme = PlatformTheme.system, @SRGBConverter()  List<SRGBColor> recentColors = const [],  List<String> flags = const [], this.spreadPages = false, this.highContrast = false, this.gridView = false, this.hideExtension = true, this.autosave = true, this.showSaveButton = true, this.toolbarRows = 1, this.delayedAutosave = true, this.autosaveDelaySeconds = 3, this.hideCursorWhileDrawing = false, this.onStartup = StartupBehavior.openHomeScreen, this.documentStatePersistence = const DocumentStatePersistenceSettings(), this.simpleToolbarVisibility = SimpleToolbarVisibility.show, this.optionsPanelPosition = OptionsPanelPosition.top, this.renderResolution = RenderResolution.normal, this.moveOnGesture = true, this.rotateOnGesture = true,  List<String> swamps = const [], this.selectedPalette, this.showVerboseLogs = false, this.showThumbnails = true, this.showNavigatorPreviews = true, this.bringMovedElementsToFront = false,  List<PackAssetLocation> favoriteTools = const []}): _history = history,_connections = connections,_starred = starred,_favoriteTemplates = favoriteTemplates,_recentColors = recentColors,_flags = flags,_swamps = swamps,_favoriteTools = favoriteTools,super._();
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
@override final  bool? stylusOnlyInput;
@override@JsonKey() final  bool showStylusOnlyToggle;
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
    ..add(DiagnosticsProperty('theme', theme))..add(DiagnosticsProperty('density', density))..add(DiagnosticsProperty('limitViewportMultiplier', limitViewportMultiplier))..add(DiagnosticsProperty('limitViewportPositive', limitViewportPositive))..add(DiagnosticsProperty('localeTag', localeTag))..add(DiagnosticsProperty('documentPath', documentPath))..add(DiagnosticsProperty('gestureSensitivity', gestureSensitivity))..add(DiagnosticsProperty('touchSensitivity', touchSensitivity))..add(DiagnosticsProperty('selectSensitivity', selectSensitivity))..add(DiagnosticsProperty('scrollSensitivity', scrollSensitivity))..add(DiagnosticsProperty('rotationStep', rotationStep))..add(DiagnosticsProperty('zoomStep', zoomStep))..add(DiagnosticsProperty('stylusOnlyInput', stylusOnlyInput))..add(DiagnosticsProperty('showStylusOnlyToggle', showStylusOnlyToggle))..add(DiagnosticsProperty('inputGestures', inputGestures))..add(DiagnosticsProperty('design', design))..add(DiagnosticsProperty('bannerVisibility', bannerVisibility))..add(DiagnosticsProperty('history', history))..add(DiagnosticsProperty('zoomEnabled', zoomEnabled))..add(DiagnosticsProperty('zoomPosition', zoomPosition))..add(DiagnosticsProperty('propertyPosition', propertyPosition))..add(DiagnosticsProperty('lastVersion', lastVersion))..add(DiagnosticsProperty('connections', connections))..add(DiagnosticsProperty('defaultRemote', defaultRemote))..add(DiagnosticsProperty('nativeTitleBar', nativeTitleBar))..add(DiagnosticsProperty('startInFullScreen', startInFullScreen))..add(DiagnosticsProperty('navigationRail', navigationRail))..add(DiagnosticsProperty('ignorePressure', ignorePressure))..add(DiagnosticsProperty('syncMode', syncMode))..add(DiagnosticsProperty('automaticBackup', automaticBackup))..add(DiagnosticsProperty('backupRemote', backupRemote))..add(DiagnosticsProperty('backupIntervalMinutes', backupIntervalMinutes))..add(DiagnosticsProperty('lastBackup', lastBackup))..add(DiagnosticsProperty('inputConfiguration', inputConfiguration))..add(DiagnosticsProperty('fallbackPack', fallbackPack))..add(DiagnosticsProperty('starred', starred))..add(DiagnosticsProperty('favoriteTemplates', favoriteTemplates))..add(DiagnosticsProperty('defaultTemplate', defaultTemplate))..add(DiagnosticsProperty('defaultFileName', defaultFileName))..add(DiagnosticsProperty('navigatorPosition', navigatorPosition))..add(DiagnosticsProperty('toolbarPosition', toolbarPosition))..add(DiagnosticsProperty('toolbarSize', toolbarSize))..add(DiagnosticsProperty('sortBy', sortBy))..add(DiagnosticsProperty('sortOrder', sortOrder))..add(DiagnosticsProperty('imageScale', imageScale))..add(DiagnosticsProperty('platformTheme', platformTheme))..add(DiagnosticsProperty('recentColors', recentColors))..add(DiagnosticsProperty('flags', flags))..add(DiagnosticsProperty('spreadPages', spreadPages))..add(DiagnosticsProperty('highContrast', highContrast))..add(DiagnosticsProperty('gridView', gridView))..add(DiagnosticsProperty('hideExtension', hideExtension))..add(DiagnosticsProperty('autosave', autosave))..add(DiagnosticsProperty('showSaveButton', showSaveButton))..add(DiagnosticsProperty('toolbarRows', toolbarRows))..add(DiagnosticsProperty('delayedAutosave', delayedAutosave))..add(DiagnosticsProperty('autosaveDelaySeconds', autosaveDelaySeconds))..add(DiagnosticsProperty('hideCursorWhileDrawing', hideCursorWhileDrawing))..add(DiagnosticsProperty('onStartup', onStartup))..add(DiagnosticsProperty('documentStatePersistence', documentStatePersistence))..add(DiagnosticsProperty('simpleToolbarVisibility', simpleToolbarVisibility))..add(DiagnosticsProperty('optionsPanelPosition', optionsPanelPosition))..add(DiagnosticsProperty('renderResolution', renderResolution))..add(DiagnosticsProperty('moveOnGesture', moveOnGesture))..add(DiagnosticsProperty('rotateOnGesture', rotateOnGesture))..add(DiagnosticsProperty('swamps', swamps))..add(DiagnosticsProperty('selectedPalette', selectedPalette))..add(DiagnosticsProperty('showVerboseLogs', showVerboseLogs))..add(DiagnosticsProperty('showThumbnails', showThumbnails))..add(DiagnosticsProperty('showNavigatorPreviews', showNavigatorPreviews))..add(DiagnosticsProperty('bringMovedElementsToFront', bringMovedElementsToFront))..add(DiagnosticsProperty('favoriteTools', favoriteTools));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ButterflySettings&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.density, density) || other.density == density)&&(identical(other.limitViewportMultiplier, limitViewportMultiplier) || other.limitViewportMultiplier == limitViewportMultiplier)&&(identical(other.limitViewportPositive, limitViewportPositive) || other.limitViewportPositive == limitViewportPositive)&&(identical(other.localeTag, localeTag) || other.localeTag == localeTag)&&(identical(other.documentPath, documentPath) || other.documentPath == documentPath)&&(identical(other.gestureSensitivity, gestureSensitivity) || other.gestureSensitivity == gestureSensitivity)&&(identical(other.touchSensitivity, touchSensitivity) || other.touchSensitivity == touchSensitivity)&&(identical(other.selectSensitivity, selectSensitivity) || other.selectSensitivity == selectSensitivity)&&(identical(other.scrollSensitivity, scrollSensitivity) || other.scrollSensitivity == scrollSensitivity)&&(identical(other.rotationStep, rotationStep) || other.rotationStep == rotationStep)&&(identical(other.zoomStep, zoomStep) || other.zoomStep == zoomStep)&&(identical(other.stylusOnlyInput, stylusOnlyInput) || other.stylusOnlyInput == stylusOnlyInput)&&(identical(other.showStylusOnlyToggle, showStylusOnlyToggle) || other.showStylusOnlyToggle == showStylusOnlyToggle)&&(identical(other.inputGestures, inputGestures) || other.inputGestures == inputGestures)&&(identical(other.design, design) || other.design == design)&&(identical(other.bannerVisibility, bannerVisibility) || other.bannerVisibility == bannerVisibility)&&const DeepCollectionEquality().equals(other._history, _history)&&(identical(other.zoomEnabled, zoomEnabled) || other.zoomEnabled == zoomEnabled)&&(identical(other.zoomPosition, zoomPosition) || other.zoomPosition == zoomPosition)&&(identical(other.propertyPosition, propertyPosition) || other.propertyPosition == propertyPosition)&&(identical(other.lastVersion, lastVersion) || other.lastVersion == lastVersion)&&const DeepCollectionEquality().equals(other._connections, _connections)&&(identical(other.defaultRemote, defaultRemote) || other.defaultRemote == defaultRemote)&&(identical(other.nativeTitleBar, nativeTitleBar) || other.nativeTitleBar == nativeTitleBar)&&(identical(other.startInFullScreen, startInFullScreen) || other.startInFullScreen == startInFullScreen)&&(identical(other.navigationRail, navigationRail) || other.navigationRail == navigationRail)&&(identical(other.ignorePressure, ignorePressure) || other.ignorePressure == ignorePressure)&&(identical(other.syncMode, syncMode) || other.syncMode == syncMode)&&(identical(other.automaticBackup, automaticBackup) || other.automaticBackup == automaticBackup)&&(identical(other.backupRemote, backupRemote) || other.backupRemote == backupRemote)&&(identical(other.backupIntervalMinutes, backupIntervalMinutes) || other.backupIntervalMinutes == backupIntervalMinutes)&&(identical(other.lastBackup, lastBackup) || other.lastBackup == lastBackup)&&(identical(other.inputConfiguration, inputConfiguration) || other.inputConfiguration == inputConfiguration)&&(identical(other.fallbackPack, fallbackPack) || other.fallbackPack == fallbackPack)&&const DeepCollectionEquality().equals(other._starred, _starred)&&const DeepCollectionEquality().equals(other._favoriteTemplates, _favoriteTemplates)&&(identical(other.defaultTemplate, defaultTemplate) || other.defaultTemplate == defaultTemplate)&&(identical(other.defaultFileName, defaultFileName) || other.defaultFileName == defaultFileName)&&(identical(other.navigatorPosition, navigatorPosition) || other.navigatorPosition == navigatorPosition)&&(identical(other.toolbarPosition, toolbarPosition) || other.toolbarPosition == toolbarPosition)&&(identical(other.toolbarSize, toolbarSize) || other.toolbarSize == toolbarSize)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.imageScale, imageScale) || other.imageScale == imageScale)&&(identical(other.platformTheme, platformTheme) || other.platformTheme == platformTheme)&&const DeepCollectionEquality().equals(other._recentColors, _recentColors)&&const DeepCollectionEquality().equals(other._flags, _flags)&&(identical(other.spreadPages, spreadPages) || other.spreadPages == spreadPages)&&(identical(other.highContrast, highContrast) || other.highContrast == highContrast)&&(identical(other.gridView, gridView) || other.gridView == gridView)&&(identical(other.hideExtension, hideExtension) || other.hideExtension == hideExtension)&&(identical(other.autosave, autosave) || other.autosave == autosave)&&(identical(other.showSaveButton, showSaveButton) || other.showSaveButton == showSaveButton)&&(identical(other.toolbarRows, toolbarRows) || other.toolbarRows == toolbarRows)&&(identical(other.delayedAutosave, delayedAutosave) || other.delayedAutosave == delayedAutosave)&&(identical(other.autosaveDelaySeconds, autosaveDelaySeconds) || other.autosaveDelaySeconds == autosaveDelaySeconds)&&(identical(other.hideCursorWhileDrawing, hideCursorWhileDrawing) || other.hideCursorWhileDrawing == hideCursorWhileDrawing)&&(identical(other.onStartup, onStartup) || other.onStartup == onStartup)&&(identical(other.documentStatePersistence, documentStatePersistence) || other.documentStatePersistence == documentStatePersistence)&&(identical(other.simpleToolbarVisibility, simpleToolbarVisibility) || other.simpleToolbarVisibility == simpleToolbarVisibility)&&(identical(other.optionsPanelPosition, optionsPanelPosition) || other.optionsPanelPosition == optionsPanelPosition)&&(identical(other.renderResolution, renderResolution) || other.renderResolution == renderResolution)&&(identical(other.moveOnGesture, moveOnGesture) || other.moveOnGesture == moveOnGesture)&&(identical(other.rotateOnGesture, rotateOnGesture) || other.rotateOnGesture == rotateOnGesture)&&const DeepCollectionEquality().equals(other._swamps, _swamps)&&(identical(other.selectedPalette, selectedPalette) || other.selectedPalette == selectedPalette)&&(identical(other.showVerboseLogs, showVerboseLogs) || other.showVerboseLogs == showVerboseLogs)&&(identical(other.showThumbnails, showThumbnails) || other.showThumbnails == showThumbnails)&&(identical(other.showNavigatorPreviews, showNavigatorPreviews) || other.showNavigatorPreviews == showNavigatorPreviews)&&(identical(other.bringMovedElementsToFront, bringMovedElementsToFront) || other.bringMovedElementsToFront == bringMovedElementsToFront)&&const DeepCollectionEquality().equals(other._favoriteTools, _favoriteTools));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,theme,density,limitViewportMultiplier,limitViewportPositive,localeTag,documentPath,gestureSensitivity,touchSensitivity,selectSensitivity,scrollSensitivity,rotationStep,zoomStep,stylusOnlyInput,showStylusOnlyToggle,inputGestures,design,bannerVisibility,const DeepCollectionEquality().hash(_history),zoomEnabled,zoomPosition,propertyPosition,lastVersion,const DeepCollectionEquality().hash(_connections),defaultRemote,nativeTitleBar,startInFullScreen,navigationRail,ignorePressure,syncMode,automaticBackup,backupRemote,backupIntervalMinutes,lastBackup,inputConfiguration,fallbackPack,const DeepCollectionEquality().hash(_starred),const DeepCollectionEquality().hash(_favoriteTemplates),defaultTemplate,defaultFileName,navigatorPosition,toolbarPosition,toolbarSize,sortBy,sortOrder,imageScale,platformTheme,const DeepCollectionEquality().hash(_recentColors),const DeepCollectionEquality().hash(_flags),spreadPages,highContrast,gridView,hideExtension,autosave,showSaveButton,toolbarRows,delayedAutosave,autosaveDelaySeconds,hideCursorWhileDrawing,onStartup,documentStatePersistence,simpleToolbarVisibility,optionsPanelPosition,renderResolution,moveOnGesture,rotateOnGesture,const DeepCollectionEquality().hash(_swamps),selectedPalette,showVerboseLogs,showThumbnails,showNavigatorPreviews,bringMovedElementsToFront,const DeepCollectionEquality().hash(_favoriteTools)]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ButterflySettings(theme: $theme, density: $density, limitViewportMultiplier: $limitViewportMultiplier, limitViewportPositive: $limitViewportPositive, localeTag: $localeTag, documentPath: $documentPath, gestureSensitivity: $gestureSensitivity, touchSensitivity: $touchSensitivity, selectSensitivity: $selectSensitivity, scrollSensitivity: $scrollSensitivity, rotationStep: $rotationStep, zoomStep: $zoomStep, stylusOnlyInput: $stylusOnlyInput, showStylusOnlyToggle: $showStylusOnlyToggle, inputGestures: $inputGestures, design: $design, bannerVisibility: $bannerVisibility, history: $history, zoomEnabled: $zoomEnabled, zoomPosition: $zoomPosition, propertyPosition: $propertyPosition, lastVersion: $lastVersion, connections: $connections, defaultRemote: $defaultRemote, nativeTitleBar: $nativeTitleBar, startInFullScreen: $startInFullScreen, navigationRail: $navigationRail, ignorePressure: $ignorePressure, syncMode: $syncMode, automaticBackup: $automaticBackup, backupRemote: $backupRemote, backupIntervalMinutes: $backupIntervalMinutes, lastBackup: $lastBackup, inputConfiguration: $inputConfiguration, fallbackPack: $fallbackPack, starred: $starred, favoriteTemplates: $favoriteTemplates, defaultTemplate: $defaultTemplate, defaultFileName: $defaultFileName, navigatorPosition: $navigatorPosition, toolbarPosition: $toolbarPosition, toolbarSize: $toolbarSize, sortBy: $sortBy, sortOrder: $sortOrder, imageScale: $imageScale, platformTheme: $platformTheme, recentColors: $recentColors, flags: $flags, spreadPages: $spreadPages, highContrast: $highContrast, gridView: $gridView, hideExtension: $hideExtension, autosave: $autosave, showSaveButton: $showSaveButton, toolbarRows: $toolbarRows, delayedAutosave: $delayedAutosave, autosaveDelaySeconds: $autosaveDelaySeconds, hideCursorWhileDrawing: $hideCursorWhileDrawing, onStartup: $onStartup, documentStatePersistence: $documentStatePersistence, simpleToolbarVisibility: $simpleToolbarVisibility, optionsPanelPosition: $optionsPanelPosition, renderResolution: $renderResolution, moveOnGesture: $moveOnGesture, rotateOnGesture: $rotateOnGesture, swamps: $swamps, selectedPalette: $selectedPalette, showVerboseLogs: $showVerboseLogs, showThumbnails: $showThumbnails, showNavigatorPreviews: $showNavigatorPreviews, bringMovedElementsToFront: $bringMovedElementsToFront, favoriteTools: $favoriteTools)';
}


}

/// @nodoc
abstract mixin class _$ButterflySettingsCopyWith<$Res> implements $ButterflySettingsCopyWith<$Res> {
  factory _$ButterflySettingsCopyWith(_ButterflySettings value, $Res Function(_ButterflySettings) _then) = __$ButterflySettingsCopyWithImpl;
@override @useResult
$Res call({
 ThemeMode theme, ThemeDensity density, double? limitViewportMultiplier, bool limitViewportPositive, String localeTag, String documentPath, double gestureSensitivity, double touchSensitivity, double selectSensitivity, double scrollSensitivity, double rotationStep, double zoomStep, bool? stylusOnlyInput, bool showStylusOnlyToggle, bool inputGestures, String design, BannerVisibility bannerVisibility,@JsonKey(includeFromJson: false, includeToJson: false) List<AssetLocation> history, bool zoomEnabled, ZoomPosition zoomPosition, ZoomPosition propertyPosition, String? lastVersion,@JsonKey(includeFromJson: false, includeToJson: false) List<ExternalStorage> connections, String defaultRemote, bool nativeTitleBar, bool startInFullScreen, bool navigationRail, IgnorePressure ignorePressure, SyncMode syncMode, bool automaticBackup, String backupRemote, int backupIntervalMinutes, DateTime? lastBackup, InputConfiguration inputConfiguration, String fallbackPack, List<String> starred, List<FavoriteLocation> favoriteTemplates, String defaultTemplate, String defaultFileName, NavigatorPosition navigatorPosition, ToolbarPosition toolbarPosition, ToolbarSize toolbarSize, SortBy sortBy, SortOrder sortOrder, double imageScale, PlatformTheme platformTheme,@SRGBConverter() List<SRGBColor> recentColors, List<String> flags, bool spreadPages, bool highContrast, bool gridView, bool hideExtension, bool autosave, bool showSaveButton, int toolbarRows, bool delayedAutosave, int autosaveDelaySeconds, bool hideCursorWhileDrawing, StartupBehavior onStartup, DocumentStatePersistenceSettings documentStatePersistence, SimpleToolbarVisibility simpleToolbarVisibility, OptionsPanelPosition optionsPanelPosition, RenderResolution renderResolution, bool moveOnGesture, bool rotateOnGesture, List<String> swamps, PackAssetLocation? selectedPalette, bool showVerboseLogs, bool showThumbnails, bool showNavigatorPreviews, bool bringMovedElementsToFront, List<PackAssetLocation> favoriteTools
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
@override @pragma('vm:prefer-inline') $Res call({Object? theme = null,Object? density = null,Object? limitViewportMultiplier = freezed,Object? limitViewportPositive = null,Object? localeTag = null,Object? documentPath = null,Object? gestureSensitivity = null,Object? touchSensitivity = null,Object? selectSensitivity = null,Object? scrollSensitivity = null,Object? rotationStep = null,Object? zoomStep = null,Object? stylusOnlyInput = freezed,Object? showStylusOnlyToggle = null,Object? inputGestures = null,Object? design = null,Object? bannerVisibility = null,Object? history = null,Object? zoomEnabled = null,Object? zoomPosition = null,Object? propertyPosition = null,Object? lastVersion = freezed,Object? connections = null,Object? defaultRemote = null,Object? nativeTitleBar = null,Object? startInFullScreen = null,Object? navigationRail = null,Object? ignorePressure = null,Object? syncMode = null,Object? automaticBackup = null,Object? backupRemote = null,Object? backupIntervalMinutes = null,Object? lastBackup = freezed,Object? inputConfiguration = null,Object? fallbackPack = null,Object? starred = null,Object? favoriteTemplates = null,Object? defaultTemplate = null,Object? defaultFileName = null,Object? navigatorPosition = null,Object? toolbarPosition = null,Object? toolbarSize = null,Object? sortBy = null,Object? sortOrder = null,Object? imageScale = null,Object? platformTheme = null,Object? recentColors = null,Object? flags = null,Object? spreadPages = null,Object? highContrast = null,Object? gridView = null,Object? hideExtension = null,Object? autosave = null,Object? showSaveButton = null,Object? toolbarRows = null,Object? delayedAutosave = null,Object? autosaveDelaySeconds = null,Object? hideCursorWhileDrawing = null,Object? onStartup = null,Object? documentStatePersistence = null,Object? simpleToolbarVisibility = null,Object? optionsPanelPosition = null,Object? renderResolution = null,Object? moveOnGesture = null,Object? rotateOnGesture = null,Object? swamps = null,Object? selectedPalette = freezed,Object? showVerboseLogs = null,Object? showThumbnails = null,Object? showNavigatorPreviews = null,Object? bringMovedElementsToFront = null,Object? favoriteTools = null,}) {
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
as double,stylusOnlyInput: freezed == stylusOnlyInput ? _self.stylusOnlyInput : stylusOnlyInput // ignore: cast_nullable_to_non_nullable
as bool?,showStylusOnlyToggle: null == showStylusOnlyToggle ? _self.showStylusOnlyToggle : showStylusOnlyToggle // ignore: cast_nullable_to_non_nullable
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
