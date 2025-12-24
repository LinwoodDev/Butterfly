// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InputConfiguration implements DiagnosticableTreeMixin {

 InputMapping get leftMouse; InputMapping get middleMouse; InputMapping get rightMouse; InputMapping get pen; InputMapping get invertedPen; InputMapping get firstPenButton; InputMapping get secondPenButton; InputMapping get touch;
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
    ..add(DiagnosticsProperty('leftMouse', leftMouse))..add(DiagnosticsProperty('middleMouse', middleMouse))..add(DiagnosticsProperty('rightMouse', rightMouse))..add(DiagnosticsProperty('pen', pen))..add(DiagnosticsProperty('invertedPen', invertedPen))..add(DiagnosticsProperty('firstPenButton', firstPenButton))..add(DiagnosticsProperty('secondPenButton', secondPenButton))..add(DiagnosticsProperty('touch', touch));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InputConfiguration&&(identical(other.leftMouse, leftMouse) || other.leftMouse == leftMouse)&&(identical(other.middleMouse, middleMouse) || other.middleMouse == middleMouse)&&(identical(other.rightMouse, rightMouse) || other.rightMouse == rightMouse)&&(identical(other.pen, pen) || other.pen == pen)&&(identical(other.invertedPen, invertedPen) || other.invertedPen == invertedPen)&&(identical(other.firstPenButton, firstPenButton) || other.firstPenButton == firstPenButton)&&(identical(other.secondPenButton, secondPenButton) || other.secondPenButton == secondPenButton)&&(identical(other.touch, touch) || other.touch == touch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leftMouse,middleMouse,rightMouse,pen,invertedPen,firstPenButton,secondPenButton,touch);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'InputConfiguration(leftMouse: $leftMouse, middleMouse: $middleMouse, rightMouse: $rightMouse, pen: $pen, invertedPen: $invertedPen, firstPenButton: $firstPenButton, secondPenButton: $secondPenButton, touch: $touch)';
}


}

/// @nodoc
abstract mixin class $InputConfigurationCopyWith<$Res>  {
  factory $InputConfigurationCopyWith(InputConfiguration value, $Res Function(InputConfiguration) _then) = _$InputConfigurationCopyWithImpl;
@useResult
$Res call({
 InputMapping leftMouse, InputMapping middleMouse, InputMapping rightMouse, InputMapping pen, InputMapping invertedPen, InputMapping firstPenButton, InputMapping secondPenButton, InputMapping touch
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
@pragma('vm:prefer-inline') @override $Res call({Object? leftMouse = null,Object? middleMouse = null,Object? rightMouse = null,Object? pen = null,Object? invertedPen = null,Object? firstPenButton = null,Object? secondPenButton = null,Object? touch = null,}) {
  return _then(_self.copyWith(
leftMouse: null == leftMouse ? _self.leftMouse : leftMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,middleMouse: null == middleMouse ? _self.middleMouse : middleMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,rightMouse: null == rightMouse ? _self.rightMouse : rightMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,pen: null == pen ? _self.pen : pen // ignore: cast_nullable_to_non_nullable
as InputMapping,invertedPen: null == invertedPen ? _self.invertedPen : invertedPen // ignore: cast_nullable_to_non_nullable
as InputMapping,firstPenButton: null == firstPenButton ? _self.firstPenButton : firstPenButton // ignore: cast_nullable_to_non_nullable
as InputMapping,secondPenButton: null == secondPenButton ? _self.secondPenButton : secondPenButton // ignore: cast_nullable_to_non_nullable
as InputMapping,touch: null == touch ? _self.touch : touch // ignore: cast_nullable_to_non_nullable
as InputMapping,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _InputConfiguration extends InputConfiguration with DiagnosticableTreeMixin {
  const _InputConfiguration({this.leftMouse = InputMappingDefault.leftMouse, this.middleMouse = InputMappingDefault.middleMouse, this.rightMouse = InputMappingDefault.rightMouse, this.pen = InputMappingDefault.pen, this.invertedPen = InputMappingDefault.invertedPen, this.firstPenButton = InputMappingDefault.firstPenButton, this.secondPenButton = InputMappingDefault.secondPenButton, this.touch = InputMappingDefault.touch}): super._();
  factory _InputConfiguration.fromJson(Map<String, dynamic> json) => _$InputConfigurationFromJson(json);

@override@JsonKey() final  InputMapping leftMouse;
@override@JsonKey() final  InputMapping middleMouse;
@override@JsonKey() final  InputMapping rightMouse;
@override@JsonKey() final  InputMapping pen;
@override@JsonKey() final  InputMapping invertedPen;
@override@JsonKey() final  InputMapping firstPenButton;
@override@JsonKey() final  InputMapping secondPenButton;
@override@JsonKey() final  InputMapping touch;

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
    ..add(DiagnosticsProperty('leftMouse', leftMouse))..add(DiagnosticsProperty('middleMouse', middleMouse))..add(DiagnosticsProperty('rightMouse', rightMouse))..add(DiagnosticsProperty('pen', pen))..add(DiagnosticsProperty('invertedPen', invertedPen))..add(DiagnosticsProperty('firstPenButton', firstPenButton))..add(DiagnosticsProperty('secondPenButton', secondPenButton))..add(DiagnosticsProperty('touch', touch));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InputConfiguration&&(identical(other.leftMouse, leftMouse) || other.leftMouse == leftMouse)&&(identical(other.middleMouse, middleMouse) || other.middleMouse == middleMouse)&&(identical(other.rightMouse, rightMouse) || other.rightMouse == rightMouse)&&(identical(other.pen, pen) || other.pen == pen)&&(identical(other.invertedPen, invertedPen) || other.invertedPen == invertedPen)&&(identical(other.firstPenButton, firstPenButton) || other.firstPenButton == firstPenButton)&&(identical(other.secondPenButton, secondPenButton) || other.secondPenButton == secondPenButton)&&(identical(other.touch, touch) || other.touch == touch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leftMouse,middleMouse,rightMouse,pen,invertedPen,firstPenButton,secondPenButton,touch);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'InputConfiguration(leftMouse: $leftMouse, middleMouse: $middleMouse, rightMouse: $rightMouse, pen: $pen, invertedPen: $invertedPen, firstPenButton: $firstPenButton, secondPenButton: $secondPenButton, touch: $touch)';
}


}

/// @nodoc
abstract mixin class _$InputConfigurationCopyWith<$Res> implements $InputConfigurationCopyWith<$Res> {
  factory _$InputConfigurationCopyWith(_InputConfiguration value, $Res Function(_InputConfiguration) _then) = __$InputConfigurationCopyWithImpl;
@override @useResult
$Res call({
 InputMapping leftMouse, InputMapping middleMouse, InputMapping rightMouse, InputMapping pen, InputMapping invertedPen, InputMapping firstPenButton, InputMapping secondPenButton, InputMapping touch
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
@override @pragma('vm:prefer-inline') $Res call({Object? leftMouse = null,Object? middleMouse = null,Object? rightMouse = null,Object? pen = null,Object? invertedPen = null,Object? firstPenButton = null,Object? secondPenButton = null,Object? touch = null,}) {
  return _then(_InputConfiguration(
leftMouse: null == leftMouse ? _self.leftMouse : leftMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,middleMouse: null == middleMouse ? _self.middleMouse : middleMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,rightMouse: null == rightMouse ? _self.rightMouse : rightMouse // ignore: cast_nullable_to_non_nullable
as InputMapping,pen: null == pen ? _self.pen : pen // ignore: cast_nullable_to_non_nullable
as InputMapping,invertedPen: null == invertedPen ? _self.invertedPen : invertedPen // ignore: cast_nullable_to_non_nullable
as InputMapping,firstPenButton: null == firstPenButton ? _self.firstPenButton : firstPenButton // ignore: cast_nullable_to_non_nullable
as InputMapping,secondPenButton: null == secondPenButton ? _self.secondPenButton : secondPenButton // ignore: cast_nullable_to_non_nullable
as InputMapping,touch: null == touch ? _self.touch : touch // ignore: cast_nullable_to_non_nullable
as InputMapping,
  ));
}


}


/// @nodoc
mixin _$ButterflySettings implements DiagnosticableTreeMixin {

 ThemeMode get theme; ThemeDensity get density; String get localeTag; String get documentPath; double get gestureSensitivity; double get touchSensitivity; double get selectSensitivity; double get scrollSensitivity; bool get penOnlyInput; bool get inputGestures; String get design; BannerVisibility get bannerVisibility;@JsonKey(includeFromJson: false, includeToJson: false) List<AssetLocation> get history; bool get zoomEnabled; String? get lastVersion;@JsonKey(includeFromJson: false, includeToJson: false) List<ExternalStorage> get connections; String get defaultRemote; bool get nativeTitleBar; bool get startInFullScreen; bool get navigationRail; IgnorePressure get ignorePressure; SyncMode get syncMode; InputConfiguration get inputConfiguration; String get fallbackPack; List<String> get starred; String get defaultTemplate; NavigatorPosition get navigatorPosition; ToolbarPosition get toolbarPosition; ToolbarSize get toolbarSize; SortBy get sortBy; SortOrder get sortOrder; double get imageScale; double get pdfQuality; PlatformTheme get platformTheme;@SRGBConverter() List<SRGBColor> get recentColors; List<String> get flags; bool get spreadPages; bool get highContrast; bool get gridView; bool get autosave; bool get showSaveButton; int get toolbarRows; bool get delayedAutosave; int get autosaveDelaySeconds; bool get hideCursorWhileDrawing; UtilitiesState get utilities; StartupBehavior get onStartup; SimpleToolbarVisibility get simpleToolbarVisibility; OptionsPanelPosition get optionsPanelPosition; RenderResolution get renderResolution; bool get moveOnGesture; List<String> get swamps; PackAssetLocation? get selectedPalette; bool get showVerboseLogs;
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
    ..add(DiagnosticsProperty('theme', theme))..add(DiagnosticsProperty('density', density))..add(DiagnosticsProperty('localeTag', localeTag))..add(DiagnosticsProperty('documentPath', documentPath))..add(DiagnosticsProperty('gestureSensitivity', gestureSensitivity))..add(DiagnosticsProperty('touchSensitivity', touchSensitivity))..add(DiagnosticsProperty('selectSensitivity', selectSensitivity))..add(DiagnosticsProperty('scrollSensitivity', scrollSensitivity))..add(DiagnosticsProperty('penOnlyInput', penOnlyInput))..add(DiagnosticsProperty('inputGestures', inputGestures))..add(DiagnosticsProperty('design', design))..add(DiagnosticsProperty('bannerVisibility', bannerVisibility))..add(DiagnosticsProperty('history', history))..add(DiagnosticsProperty('zoomEnabled', zoomEnabled))..add(DiagnosticsProperty('lastVersion', lastVersion))..add(DiagnosticsProperty('connections', connections))..add(DiagnosticsProperty('defaultRemote', defaultRemote))..add(DiagnosticsProperty('nativeTitleBar', nativeTitleBar))..add(DiagnosticsProperty('startInFullScreen', startInFullScreen))..add(DiagnosticsProperty('navigationRail', navigationRail))..add(DiagnosticsProperty('ignorePressure', ignorePressure))..add(DiagnosticsProperty('syncMode', syncMode))..add(DiagnosticsProperty('inputConfiguration', inputConfiguration))..add(DiagnosticsProperty('fallbackPack', fallbackPack))..add(DiagnosticsProperty('starred', starred))..add(DiagnosticsProperty('defaultTemplate', defaultTemplate))..add(DiagnosticsProperty('navigatorPosition', navigatorPosition))..add(DiagnosticsProperty('toolbarPosition', toolbarPosition))..add(DiagnosticsProperty('toolbarSize', toolbarSize))..add(DiagnosticsProperty('sortBy', sortBy))..add(DiagnosticsProperty('sortOrder', sortOrder))..add(DiagnosticsProperty('imageScale', imageScale))..add(DiagnosticsProperty('pdfQuality', pdfQuality))..add(DiagnosticsProperty('platformTheme', platformTheme))..add(DiagnosticsProperty('recentColors', recentColors))..add(DiagnosticsProperty('flags', flags))..add(DiagnosticsProperty('spreadPages', spreadPages))..add(DiagnosticsProperty('highContrast', highContrast))..add(DiagnosticsProperty('gridView', gridView))..add(DiagnosticsProperty('autosave', autosave))..add(DiagnosticsProperty('showSaveButton', showSaveButton))..add(DiagnosticsProperty('toolbarRows', toolbarRows))..add(DiagnosticsProperty('delayedAutosave', delayedAutosave))..add(DiagnosticsProperty('autosaveDelaySeconds', autosaveDelaySeconds))..add(DiagnosticsProperty('hideCursorWhileDrawing', hideCursorWhileDrawing))..add(DiagnosticsProperty('utilities', utilities))..add(DiagnosticsProperty('onStartup', onStartup))..add(DiagnosticsProperty('simpleToolbarVisibility', simpleToolbarVisibility))..add(DiagnosticsProperty('optionsPanelPosition', optionsPanelPosition))..add(DiagnosticsProperty('renderResolution', renderResolution))..add(DiagnosticsProperty('moveOnGesture', moveOnGesture))..add(DiagnosticsProperty('swamps', swamps))..add(DiagnosticsProperty('selectedPalette', selectedPalette))..add(DiagnosticsProperty('showVerboseLogs', showVerboseLogs));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ButterflySettings&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.density, density) || other.density == density)&&(identical(other.localeTag, localeTag) || other.localeTag == localeTag)&&(identical(other.documentPath, documentPath) || other.documentPath == documentPath)&&(identical(other.gestureSensitivity, gestureSensitivity) || other.gestureSensitivity == gestureSensitivity)&&(identical(other.touchSensitivity, touchSensitivity) || other.touchSensitivity == touchSensitivity)&&(identical(other.selectSensitivity, selectSensitivity) || other.selectSensitivity == selectSensitivity)&&(identical(other.scrollSensitivity, scrollSensitivity) || other.scrollSensitivity == scrollSensitivity)&&(identical(other.penOnlyInput, penOnlyInput) || other.penOnlyInput == penOnlyInput)&&(identical(other.inputGestures, inputGestures) || other.inputGestures == inputGestures)&&(identical(other.design, design) || other.design == design)&&(identical(other.bannerVisibility, bannerVisibility) || other.bannerVisibility == bannerVisibility)&&const DeepCollectionEquality().equals(other.history, history)&&(identical(other.zoomEnabled, zoomEnabled) || other.zoomEnabled == zoomEnabled)&&(identical(other.lastVersion, lastVersion) || other.lastVersion == lastVersion)&&const DeepCollectionEquality().equals(other.connections, connections)&&(identical(other.defaultRemote, defaultRemote) || other.defaultRemote == defaultRemote)&&(identical(other.nativeTitleBar, nativeTitleBar) || other.nativeTitleBar == nativeTitleBar)&&(identical(other.startInFullScreen, startInFullScreen) || other.startInFullScreen == startInFullScreen)&&(identical(other.navigationRail, navigationRail) || other.navigationRail == navigationRail)&&(identical(other.ignorePressure, ignorePressure) || other.ignorePressure == ignorePressure)&&(identical(other.syncMode, syncMode) || other.syncMode == syncMode)&&(identical(other.inputConfiguration, inputConfiguration) || other.inputConfiguration == inputConfiguration)&&(identical(other.fallbackPack, fallbackPack) || other.fallbackPack == fallbackPack)&&const DeepCollectionEquality().equals(other.starred, starred)&&(identical(other.defaultTemplate, defaultTemplate) || other.defaultTemplate == defaultTemplate)&&(identical(other.navigatorPosition, navigatorPosition) || other.navigatorPosition == navigatorPosition)&&(identical(other.toolbarPosition, toolbarPosition) || other.toolbarPosition == toolbarPosition)&&(identical(other.toolbarSize, toolbarSize) || other.toolbarSize == toolbarSize)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.imageScale, imageScale) || other.imageScale == imageScale)&&(identical(other.pdfQuality, pdfQuality) || other.pdfQuality == pdfQuality)&&(identical(other.platformTheme, platformTheme) || other.platformTheme == platformTheme)&&const DeepCollectionEquality().equals(other.recentColors, recentColors)&&const DeepCollectionEquality().equals(other.flags, flags)&&(identical(other.spreadPages, spreadPages) || other.spreadPages == spreadPages)&&(identical(other.highContrast, highContrast) || other.highContrast == highContrast)&&(identical(other.gridView, gridView) || other.gridView == gridView)&&(identical(other.autosave, autosave) || other.autosave == autosave)&&(identical(other.showSaveButton, showSaveButton) || other.showSaveButton == showSaveButton)&&(identical(other.toolbarRows, toolbarRows) || other.toolbarRows == toolbarRows)&&(identical(other.delayedAutosave, delayedAutosave) || other.delayedAutosave == delayedAutosave)&&(identical(other.autosaveDelaySeconds, autosaveDelaySeconds) || other.autosaveDelaySeconds == autosaveDelaySeconds)&&(identical(other.hideCursorWhileDrawing, hideCursorWhileDrawing) || other.hideCursorWhileDrawing == hideCursorWhileDrawing)&&(identical(other.utilities, utilities) || other.utilities == utilities)&&(identical(other.onStartup, onStartup) || other.onStartup == onStartup)&&(identical(other.simpleToolbarVisibility, simpleToolbarVisibility) || other.simpleToolbarVisibility == simpleToolbarVisibility)&&(identical(other.optionsPanelPosition, optionsPanelPosition) || other.optionsPanelPosition == optionsPanelPosition)&&(identical(other.renderResolution, renderResolution) || other.renderResolution == renderResolution)&&(identical(other.moveOnGesture, moveOnGesture) || other.moveOnGesture == moveOnGesture)&&const DeepCollectionEquality().equals(other.swamps, swamps)&&(identical(other.selectedPalette, selectedPalette) || other.selectedPalette == selectedPalette)&&(identical(other.showVerboseLogs, showVerboseLogs) || other.showVerboseLogs == showVerboseLogs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,theme,density,localeTag,documentPath,gestureSensitivity,touchSensitivity,selectSensitivity,scrollSensitivity,penOnlyInput,inputGestures,design,bannerVisibility,const DeepCollectionEquality().hash(history),zoomEnabled,lastVersion,const DeepCollectionEquality().hash(connections),defaultRemote,nativeTitleBar,startInFullScreen,navigationRail,ignorePressure,syncMode,inputConfiguration,fallbackPack,const DeepCollectionEquality().hash(starred),defaultTemplate,navigatorPosition,toolbarPosition,toolbarSize,sortBy,sortOrder,imageScale,pdfQuality,platformTheme,const DeepCollectionEquality().hash(recentColors),const DeepCollectionEquality().hash(flags),spreadPages,highContrast,gridView,autosave,showSaveButton,toolbarRows,delayedAutosave,autosaveDelaySeconds,hideCursorWhileDrawing,utilities,onStartup,simpleToolbarVisibility,optionsPanelPosition,renderResolution,moveOnGesture,const DeepCollectionEquality().hash(swamps),selectedPalette,showVerboseLogs]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ButterflySettings(theme: $theme, density: $density, localeTag: $localeTag, documentPath: $documentPath, gestureSensitivity: $gestureSensitivity, touchSensitivity: $touchSensitivity, selectSensitivity: $selectSensitivity, scrollSensitivity: $scrollSensitivity, penOnlyInput: $penOnlyInput, inputGestures: $inputGestures, design: $design, bannerVisibility: $bannerVisibility, history: $history, zoomEnabled: $zoomEnabled, lastVersion: $lastVersion, connections: $connections, defaultRemote: $defaultRemote, nativeTitleBar: $nativeTitleBar, startInFullScreen: $startInFullScreen, navigationRail: $navigationRail, ignorePressure: $ignorePressure, syncMode: $syncMode, inputConfiguration: $inputConfiguration, fallbackPack: $fallbackPack, starred: $starred, defaultTemplate: $defaultTemplate, navigatorPosition: $navigatorPosition, toolbarPosition: $toolbarPosition, toolbarSize: $toolbarSize, sortBy: $sortBy, sortOrder: $sortOrder, imageScale: $imageScale, pdfQuality: $pdfQuality, platformTheme: $platformTheme, recentColors: $recentColors, flags: $flags, spreadPages: $spreadPages, highContrast: $highContrast, gridView: $gridView, autosave: $autosave, showSaveButton: $showSaveButton, toolbarRows: $toolbarRows, delayedAutosave: $delayedAutosave, autosaveDelaySeconds: $autosaveDelaySeconds, hideCursorWhileDrawing: $hideCursorWhileDrawing, utilities: $utilities, onStartup: $onStartup, simpleToolbarVisibility: $simpleToolbarVisibility, optionsPanelPosition: $optionsPanelPosition, renderResolution: $renderResolution, moveOnGesture: $moveOnGesture, swamps: $swamps, selectedPalette: $selectedPalette, showVerboseLogs: $showVerboseLogs)';
}


}

/// @nodoc
abstract mixin class $ButterflySettingsCopyWith<$Res>  {
  factory $ButterflySettingsCopyWith(ButterflySettings value, $Res Function(ButterflySettings) _then) = _$ButterflySettingsCopyWithImpl;
@useResult
$Res call({
 ThemeMode theme, ThemeDensity density, String localeTag, String documentPath, double gestureSensitivity, double touchSensitivity, double selectSensitivity, double scrollSensitivity, bool penOnlyInput, bool inputGestures, String design, BannerVisibility bannerVisibility,@JsonKey(includeFromJson: false, includeToJson: false) List<AssetLocation> history, bool zoomEnabled, String? lastVersion,@JsonKey(includeFromJson: false, includeToJson: false) List<ExternalStorage> connections, String defaultRemote, bool nativeTitleBar, bool startInFullScreen, bool navigationRail, IgnorePressure ignorePressure, SyncMode syncMode, InputConfiguration inputConfiguration, String fallbackPack, List<String> starred, String defaultTemplate, NavigatorPosition navigatorPosition, ToolbarPosition toolbarPosition, ToolbarSize toolbarSize, SortBy sortBy, SortOrder sortOrder, double imageScale, double pdfQuality, PlatformTheme platformTheme,@SRGBConverter() List<SRGBColor> recentColors, List<String> flags, bool spreadPages, bool highContrast, bool gridView, bool autosave, bool showSaveButton, int toolbarRows, bool delayedAutosave, int autosaveDelaySeconds, bool hideCursorWhileDrawing, UtilitiesState utilities, StartupBehavior onStartup, SimpleToolbarVisibility simpleToolbarVisibility, OptionsPanelPosition optionsPanelPosition, RenderResolution renderResolution, bool moveOnGesture, List<String> swamps, PackAssetLocation? selectedPalette, bool showVerboseLogs
});


$InputConfigurationCopyWith<$Res> get inputConfiguration;$UtilitiesStateCopyWith<$Res> get utilities;$PackAssetLocationCopyWith<$Res>? get selectedPalette;

}
/// @nodoc
class _$ButterflySettingsCopyWithImpl<$Res>
    implements $ButterflySettingsCopyWith<$Res> {
  _$ButterflySettingsCopyWithImpl(this._self, this._then);

  final ButterflySettings _self;
  final $Res Function(ButterflySettings) _then;

/// Create a copy of ButterflySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? theme = null,Object? density = null,Object? localeTag = null,Object? documentPath = null,Object? gestureSensitivity = null,Object? touchSensitivity = null,Object? selectSensitivity = null,Object? scrollSensitivity = null,Object? penOnlyInput = null,Object? inputGestures = null,Object? design = null,Object? bannerVisibility = null,Object? history = null,Object? zoomEnabled = null,Object? lastVersion = freezed,Object? connections = null,Object? defaultRemote = null,Object? nativeTitleBar = null,Object? startInFullScreen = null,Object? navigationRail = null,Object? ignorePressure = null,Object? syncMode = null,Object? inputConfiguration = null,Object? fallbackPack = null,Object? starred = null,Object? defaultTemplate = null,Object? navigatorPosition = null,Object? toolbarPosition = null,Object? toolbarSize = null,Object? sortBy = null,Object? sortOrder = null,Object? imageScale = null,Object? pdfQuality = null,Object? platformTheme = null,Object? recentColors = null,Object? flags = null,Object? spreadPages = null,Object? highContrast = null,Object? gridView = null,Object? autosave = null,Object? showSaveButton = null,Object? toolbarRows = null,Object? delayedAutosave = null,Object? autosaveDelaySeconds = null,Object? hideCursorWhileDrawing = null,Object? utilities = null,Object? onStartup = null,Object? simpleToolbarVisibility = null,Object? optionsPanelPosition = null,Object? renderResolution = null,Object? moveOnGesture = null,Object? swamps = null,Object? selectedPalette = freezed,Object? showVerboseLogs = null,}) {
  return _then(_self.copyWith(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemeMode,density: null == density ? _self.density : density // ignore: cast_nullable_to_non_nullable
as ThemeDensity,localeTag: null == localeTag ? _self.localeTag : localeTag // ignore: cast_nullable_to_non_nullable
as String,documentPath: null == documentPath ? _self.documentPath : documentPath // ignore: cast_nullable_to_non_nullable
as String,gestureSensitivity: null == gestureSensitivity ? _self.gestureSensitivity : gestureSensitivity // ignore: cast_nullable_to_non_nullable
as double,touchSensitivity: null == touchSensitivity ? _self.touchSensitivity : touchSensitivity // ignore: cast_nullable_to_non_nullable
as double,selectSensitivity: null == selectSensitivity ? _self.selectSensitivity : selectSensitivity // ignore: cast_nullable_to_non_nullable
as double,scrollSensitivity: null == scrollSensitivity ? _self.scrollSensitivity : scrollSensitivity // ignore: cast_nullable_to_non_nullable
as double,penOnlyInput: null == penOnlyInput ? _self.penOnlyInput : penOnlyInput // ignore: cast_nullable_to_non_nullable
as bool,inputGestures: null == inputGestures ? _self.inputGestures : inputGestures // ignore: cast_nullable_to_non_nullable
as bool,design: null == design ? _self.design : design // ignore: cast_nullable_to_non_nullable
as String,bannerVisibility: null == bannerVisibility ? _self.bannerVisibility : bannerVisibility // ignore: cast_nullable_to_non_nullable
as BannerVisibility,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<AssetLocation>,zoomEnabled: null == zoomEnabled ? _self.zoomEnabled : zoomEnabled // ignore: cast_nullable_to_non_nullable
as bool,lastVersion: freezed == lastVersion ? _self.lastVersion : lastVersion // ignore: cast_nullable_to_non_nullable
as String?,connections: null == connections ? _self.connections : connections // ignore: cast_nullable_to_non_nullable
as List<ExternalStorage>,defaultRemote: null == defaultRemote ? _self.defaultRemote : defaultRemote // ignore: cast_nullable_to_non_nullable
as String,nativeTitleBar: null == nativeTitleBar ? _self.nativeTitleBar : nativeTitleBar // ignore: cast_nullable_to_non_nullable
as bool,startInFullScreen: null == startInFullScreen ? _self.startInFullScreen : startInFullScreen // ignore: cast_nullable_to_non_nullable
as bool,navigationRail: null == navigationRail ? _self.navigationRail : navigationRail // ignore: cast_nullable_to_non_nullable
as bool,ignorePressure: null == ignorePressure ? _self.ignorePressure : ignorePressure // ignore: cast_nullable_to_non_nullable
as IgnorePressure,syncMode: null == syncMode ? _self.syncMode : syncMode // ignore: cast_nullable_to_non_nullable
as SyncMode,inputConfiguration: null == inputConfiguration ? _self.inputConfiguration : inputConfiguration // ignore: cast_nullable_to_non_nullable
as InputConfiguration,fallbackPack: null == fallbackPack ? _self.fallbackPack : fallbackPack // ignore: cast_nullable_to_non_nullable
as String,starred: null == starred ? _self.starred : starred // ignore: cast_nullable_to_non_nullable
as List<String>,defaultTemplate: null == defaultTemplate ? _self.defaultTemplate : defaultTemplate // ignore: cast_nullable_to_non_nullable
as String,navigatorPosition: null == navigatorPosition ? _self.navigatorPosition : navigatorPosition // ignore: cast_nullable_to_non_nullable
as NavigatorPosition,toolbarPosition: null == toolbarPosition ? _self.toolbarPosition : toolbarPosition // ignore: cast_nullable_to_non_nullable
as ToolbarPosition,toolbarSize: null == toolbarSize ? _self.toolbarSize : toolbarSize // ignore: cast_nullable_to_non_nullable
as ToolbarSize,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as SortBy,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder,imageScale: null == imageScale ? _self.imageScale : imageScale // ignore: cast_nullable_to_non_nullable
as double,pdfQuality: null == pdfQuality ? _self.pdfQuality : pdfQuality // ignore: cast_nullable_to_non_nullable
as double,platformTheme: null == platformTheme ? _self.platformTheme : platformTheme // ignore: cast_nullable_to_non_nullable
as PlatformTheme,recentColors: null == recentColors ? _self.recentColors : recentColors // ignore: cast_nullable_to_non_nullable
as List<SRGBColor>,flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as List<String>,spreadPages: null == spreadPages ? _self.spreadPages : spreadPages // ignore: cast_nullable_to_non_nullable
as bool,highContrast: null == highContrast ? _self.highContrast : highContrast // ignore: cast_nullable_to_non_nullable
as bool,gridView: null == gridView ? _self.gridView : gridView // ignore: cast_nullable_to_non_nullable
as bool,autosave: null == autosave ? _self.autosave : autosave // ignore: cast_nullable_to_non_nullable
as bool,showSaveButton: null == showSaveButton ? _self.showSaveButton : showSaveButton // ignore: cast_nullable_to_non_nullable
as bool,toolbarRows: null == toolbarRows ? _self.toolbarRows : toolbarRows // ignore: cast_nullable_to_non_nullable
as int,delayedAutosave: null == delayedAutosave ? _self.delayedAutosave : delayedAutosave // ignore: cast_nullable_to_non_nullable
as bool,autosaveDelaySeconds: null == autosaveDelaySeconds ? _self.autosaveDelaySeconds : autosaveDelaySeconds // ignore: cast_nullable_to_non_nullable
as int,hideCursorWhileDrawing: null == hideCursorWhileDrawing ? _self.hideCursorWhileDrawing : hideCursorWhileDrawing // ignore: cast_nullable_to_non_nullable
as bool,utilities: null == utilities ? _self.utilities : utilities // ignore: cast_nullable_to_non_nullable
as UtilitiesState,onStartup: null == onStartup ? _self.onStartup : onStartup // ignore: cast_nullable_to_non_nullable
as StartupBehavior,simpleToolbarVisibility: null == simpleToolbarVisibility ? _self.simpleToolbarVisibility : simpleToolbarVisibility // ignore: cast_nullable_to_non_nullable
as SimpleToolbarVisibility,optionsPanelPosition: null == optionsPanelPosition ? _self.optionsPanelPosition : optionsPanelPosition // ignore: cast_nullable_to_non_nullable
as OptionsPanelPosition,renderResolution: null == renderResolution ? _self.renderResolution : renderResolution // ignore: cast_nullable_to_non_nullable
as RenderResolution,moveOnGesture: null == moveOnGesture ? _self.moveOnGesture : moveOnGesture // ignore: cast_nullable_to_non_nullable
as bool,swamps: null == swamps ? _self.swamps : swamps // ignore: cast_nullable_to_non_nullable
as List<String>,selectedPalette: freezed == selectedPalette ? _self.selectedPalette : selectedPalette // ignore: cast_nullable_to_non_nullable
as PackAssetLocation?,showVerboseLogs: null == showVerboseLogs ? _self.showVerboseLogs : showVerboseLogs // ignore: cast_nullable_to_non_nullable
as bool,
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
$UtilitiesStateCopyWith<$Res> get utilities {
  
  return $UtilitiesStateCopyWith<$Res>(_self.utilities, (value) {
    return _then(_self.copyWith(utilities: value));
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
  const _ButterflySettings({this.theme = ThemeMode.system, this.density = ThemeDensity.system, this.localeTag = '', this.documentPath = '', this.gestureSensitivity = 1, this.touchSensitivity = 1, this.selectSensitivity = 1, this.scrollSensitivity = 1, this.penOnlyInput = false, this.inputGestures = true, this.design = '', this.bannerVisibility = BannerVisibility.always, @JsonKey(includeFromJson: false, includeToJson: false) final  List<AssetLocation> history = const [], this.zoomEnabled = true, this.lastVersion, @JsonKey(includeFromJson: false, includeToJson: false) final  List<ExternalStorage> connections = const [], this.defaultRemote = '', this.nativeTitleBar = false, this.startInFullScreen = false, this.navigationRail = true, this.ignorePressure = IgnorePressure.first, this.syncMode = SyncMode.noMobile, this.inputConfiguration = const InputConfiguration(), this.fallbackPack = '', final  List<String> starred = const [], this.defaultTemplate = '', this.navigatorPosition = NavigatorPosition.left, this.toolbarPosition = ToolbarPosition.inline, this.toolbarSize = ToolbarSize.normal, this.sortBy = SortBy.modified, this.sortOrder = SortOrder.descending, this.imageScale = 0.5, this.pdfQuality = 2, this.platformTheme = PlatformTheme.system, @SRGBConverter() final  List<SRGBColor> recentColors = const [], final  List<String> flags = const [], this.spreadPages = false, this.highContrast = false, this.gridView = false, this.autosave = true, this.showSaveButton = true, this.toolbarRows = 1, this.delayedAutosave = true, this.autosaveDelaySeconds = 3, this.hideCursorWhileDrawing = false, this.utilities = const UtilitiesState(), this.onStartup = StartupBehavior.openHomeScreen, this.simpleToolbarVisibility = SimpleToolbarVisibility.show, this.optionsPanelPosition = OptionsPanelPosition.top, this.renderResolution = RenderResolution.normal, this.moveOnGesture = true, final  List<String> swamps = const [], this.selectedPalette, this.showVerboseLogs = false}): _history = history,_connections = connections,_starred = starred,_recentColors = recentColors,_flags = flags,_swamps = swamps,super._();
  factory _ButterflySettings.fromJson(Map<String, dynamic> json) => _$ButterflySettingsFromJson(json);

@override@JsonKey() final  ThemeMode theme;
@override@JsonKey() final  ThemeDensity density;
@override@JsonKey() final  String localeTag;
@override@JsonKey() final  String documentPath;
@override@JsonKey() final  double gestureSensitivity;
@override@JsonKey() final  double touchSensitivity;
@override@JsonKey() final  double selectSensitivity;
@override@JsonKey() final  double scrollSensitivity;
@override@JsonKey() final  bool penOnlyInput;
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
@override@JsonKey() final  InputConfiguration inputConfiguration;
@override@JsonKey() final  String fallbackPack;
 final  List<String> _starred;
@override@JsonKey() List<String> get starred {
  if (_starred is EqualUnmodifiableListView) return _starred;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_starred);
}

@override@JsonKey() final  String defaultTemplate;
@override@JsonKey() final  NavigatorPosition navigatorPosition;
@override@JsonKey() final  ToolbarPosition toolbarPosition;
@override@JsonKey() final  ToolbarSize toolbarSize;
@override@JsonKey() final  SortBy sortBy;
@override@JsonKey() final  SortOrder sortOrder;
@override@JsonKey() final  double imageScale;
@override@JsonKey() final  double pdfQuality;
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
@override@JsonKey() final  bool autosave;
@override@JsonKey() final  bool showSaveButton;
@override@JsonKey() final  int toolbarRows;
@override@JsonKey() final  bool delayedAutosave;
@override@JsonKey() final  int autosaveDelaySeconds;
@override@JsonKey() final  bool hideCursorWhileDrawing;
@override@JsonKey() final  UtilitiesState utilities;
@override@JsonKey() final  StartupBehavior onStartup;
@override@JsonKey() final  SimpleToolbarVisibility simpleToolbarVisibility;
@override@JsonKey() final  OptionsPanelPosition optionsPanelPosition;
@override@JsonKey() final  RenderResolution renderResolution;
@override@JsonKey() final  bool moveOnGesture;
 final  List<String> _swamps;
@override@JsonKey() List<String> get swamps {
  if (_swamps is EqualUnmodifiableListView) return _swamps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_swamps);
}

@override final  PackAssetLocation? selectedPalette;
@override@JsonKey() final  bool showVerboseLogs;

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
    ..add(DiagnosticsProperty('theme', theme))..add(DiagnosticsProperty('density', density))..add(DiagnosticsProperty('localeTag', localeTag))..add(DiagnosticsProperty('documentPath', documentPath))..add(DiagnosticsProperty('gestureSensitivity', gestureSensitivity))..add(DiagnosticsProperty('touchSensitivity', touchSensitivity))..add(DiagnosticsProperty('selectSensitivity', selectSensitivity))..add(DiagnosticsProperty('scrollSensitivity', scrollSensitivity))..add(DiagnosticsProperty('penOnlyInput', penOnlyInput))..add(DiagnosticsProperty('inputGestures', inputGestures))..add(DiagnosticsProperty('design', design))..add(DiagnosticsProperty('bannerVisibility', bannerVisibility))..add(DiagnosticsProperty('history', history))..add(DiagnosticsProperty('zoomEnabled', zoomEnabled))..add(DiagnosticsProperty('lastVersion', lastVersion))..add(DiagnosticsProperty('connections', connections))..add(DiagnosticsProperty('defaultRemote', defaultRemote))..add(DiagnosticsProperty('nativeTitleBar', nativeTitleBar))..add(DiagnosticsProperty('startInFullScreen', startInFullScreen))..add(DiagnosticsProperty('navigationRail', navigationRail))..add(DiagnosticsProperty('ignorePressure', ignorePressure))..add(DiagnosticsProperty('syncMode', syncMode))..add(DiagnosticsProperty('inputConfiguration', inputConfiguration))..add(DiagnosticsProperty('fallbackPack', fallbackPack))..add(DiagnosticsProperty('starred', starred))..add(DiagnosticsProperty('defaultTemplate', defaultTemplate))..add(DiagnosticsProperty('navigatorPosition', navigatorPosition))..add(DiagnosticsProperty('toolbarPosition', toolbarPosition))..add(DiagnosticsProperty('toolbarSize', toolbarSize))..add(DiagnosticsProperty('sortBy', sortBy))..add(DiagnosticsProperty('sortOrder', sortOrder))..add(DiagnosticsProperty('imageScale', imageScale))..add(DiagnosticsProperty('pdfQuality', pdfQuality))..add(DiagnosticsProperty('platformTheme', platformTheme))..add(DiagnosticsProperty('recentColors', recentColors))..add(DiagnosticsProperty('flags', flags))..add(DiagnosticsProperty('spreadPages', spreadPages))..add(DiagnosticsProperty('highContrast', highContrast))..add(DiagnosticsProperty('gridView', gridView))..add(DiagnosticsProperty('autosave', autosave))..add(DiagnosticsProperty('showSaveButton', showSaveButton))..add(DiagnosticsProperty('toolbarRows', toolbarRows))..add(DiagnosticsProperty('delayedAutosave', delayedAutosave))..add(DiagnosticsProperty('autosaveDelaySeconds', autosaveDelaySeconds))..add(DiagnosticsProperty('hideCursorWhileDrawing', hideCursorWhileDrawing))..add(DiagnosticsProperty('utilities', utilities))..add(DiagnosticsProperty('onStartup', onStartup))..add(DiagnosticsProperty('simpleToolbarVisibility', simpleToolbarVisibility))..add(DiagnosticsProperty('optionsPanelPosition', optionsPanelPosition))..add(DiagnosticsProperty('renderResolution', renderResolution))..add(DiagnosticsProperty('moveOnGesture', moveOnGesture))..add(DiagnosticsProperty('swamps', swamps))..add(DiagnosticsProperty('selectedPalette', selectedPalette))..add(DiagnosticsProperty('showVerboseLogs', showVerboseLogs));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ButterflySettings&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.density, density) || other.density == density)&&(identical(other.localeTag, localeTag) || other.localeTag == localeTag)&&(identical(other.documentPath, documentPath) || other.documentPath == documentPath)&&(identical(other.gestureSensitivity, gestureSensitivity) || other.gestureSensitivity == gestureSensitivity)&&(identical(other.touchSensitivity, touchSensitivity) || other.touchSensitivity == touchSensitivity)&&(identical(other.selectSensitivity, selectSensitivity) || other.selectSensitivity == selectSensitivity)&&(identical(other.scrollSensitivity, scrollSensitivity) || other.scrollSensitivity == scrollSensitivity)&&(identical(other.penOnlyInput, penOnlyInput) || other.penOnlyInput == penOnlyInput)&&(identical(other.inputGestures, inputGestures) || other.inputGestures == inputGestures)&&(identical(other.design, design) || other.design == design)&&(identical(other.bannerVisibility, bannerVisibility) || other.bannerVisibility == bannerVisibility)&&const DeepCollectionEquality().equals(other._history, _history)&&(identical(other.zoomEnabled, zoomEnabled) || other.zoomEnabled == zoomEnabled)&&(identical(other.lastVersion, lastVersion) || other.lastVersion == lastVersion)&&const DeepCollectionEquality().equals(other._connections, _connections)&&(identical(other.defaultRemote, defaultRemote) || other.defaultRemote == defaultRemote)&&(identical(other.nativeTitleBar, nativeTitleBar) || other.nativeTitleBar == nativeTitleBar)&&(identical(other.startInFullScreen, startInFullScreen) || other.startInFullScreen == startInFullScreen)&&(identical(other.navigationRail, navigationRail) || other.navigationRail == navigationRail)&&(identical(other.ignorePressure, ignorePressure) || other.ignorePressure == ignorePressure)&&(identical(other.syncMode, syncMode) || other.syncMode == syncMode)&&(identical(other.inputConfiguration, inputConfiguration) || other.inputConfiguration == inputConfiguration)&&(identical(other.fallbackPack, fallbackPack) || other.fallbackPack == fallbackPack)&&const DeepCollectionEquality().equals(other._starred, _starred)&&(identical(other.defaultTemplate, defaultTemplate) || other.defaultTemplate == defaultTemplate)&&(identical(other.navigatorPosition, navigatorPosition) || other.navigatorPosition == navigatorPosition)&&(identical(other.toolbarPosition, toolbarPosition) || other.toolbarPosition == toolbarPosition)&&(identical(other.toolbarSize, toolbarSize) || other.toolbarSize == toolbarSize)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.imageScale, imageScale) || other.imageScale == imageScale)&&(identical(other.pdfQuality, pdfQuality) || other.pdfQuality == pdfQuality)&&(identical(other.platformTheme, platformTheme) || other.platformTheme == platformTheme)&&const DeepCollectionEquality().equals(other._recentColors, _recentColors)&&const DeepCollectionEquality().equals(other._flags, _flags)&&(identical(other.spreadPages, spreadPages) || other.spreadPages == spreadPages)&&(identical(other.highContrast, highContrast) || other.highContrast == highContrast)&&(identical(other.gridView, gridView) || other.gridView == gridView)&&(identical(other.autosave, autosave) || other.autosave == autosave)&&(identical(other.showSaveButton, showSaveButton) || other.showSaveButton == showSaveButton)&&(identical(other.toolbarRows, toolbarRows) || other.toolbarRows == toolbarRows)&&(identical(other.delayedAutosave, delayedAutosave) || other.delayedAutosave == delayedAutosave)&&(identical(other.autosaveDelaySeconds, autosaveDelaySeconds) || other.autosaveDelaySeconds == autosaveDelaySeconds)&&(identical(other.hideCursorWhileDrawing, hideCursorWhileDrawing) || other.hideCursorWhileDrawing == hideCursorWhileDrawing)&&(identical(other.utilities, utilities) || other.utilities == utilities)&&(identical(other.onStartup, onStartup) || other.onStartup == onStartup)&&(identical(other.simpleToolbarVisibility, simpleToolbarVisibility) || other.simpleToolbarVisibility == simpleToolbarVisibility)&&(identical(other.optionsPanelPosition, optionsPanelPosition) || other.optionsPanelPosition == optionsPanelPosition)&&(identical(other.renderResolution, renderResolution) || other.renderResolution == renderResolution)&&(identical(other.moveOnGesture, moveOnGesture) || other.moveOnGesture == moveOnGesture)&&const DeepCollectionEquality().equals(other._swamps, _swamps)&&(identical(other.selectedPalette, selectedPalette) || other.selectedPalette == selectedPalette)&&(identical(other.showVerboseLogs, showVerboseLogs) || other.showVerboseLogs == showVerboseLogs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,theme,density,localeTag,documentPath,gestureSensitivity,touchSensitivity,selectSensitivity,scrollSensitivity,penOnlyInput,inputGestures,design,bannerVisibility,const DeepCollectionEquality().hash(_history),zoomEnabled,lastVersion,const DeepCollectionEquality().hash(_connections),defaultRemote,nativeTitleBar,startInFullScreen,navigationRail,ignorePressure,syncMode,inputConfiguration,fallbackPack,const DeepCollectionEquality().hash(_starred),defaultTemplate,navigatorPosition,toolbarPosition,toolbarSize,sortBy,sortOrder,imageScale,pdfQuality,platformTheme,const DeepCollectionEquality().hash(_recentColors),const DeepCollectionEquality().hash(_flags),spreadPages,highContrast,gridView,autosave,showSaveButton,toolbarRows,delayedAutosave,autosaveDelaySeconds,hideCursorWhileDrawing,utilities,onStartup,simpleToolbarVisibility,optionsPanelPosition,renderResolution,moveOnGesture,const DeepCollectionEquality().hash(_swamps),selectedPalette,showVerboseLogs]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ButterflySettings(theme: $theme, density: $density, localeTag: $localeTag, documentPath: $documentPath, gestureSensitivity: $gestureSensitivity, touchSensitivity: $touchSensitivity, selectSensitivity: $selectSensitivity, scrollSensitivity: $scrollSensitivity, penOnlyInput: $penOnlyInput, inputGestures: $inputGestures, design: $design, bannerVisibility: $bannerVisibility, history: $history, zoomEnabled: $zoomEnabled, lastVersion: $lastVersion, connections: $connections, defaultRemote: $defaultRemote, nativeTitleBar: $nativeTitleBar, startInFullScreen: $startInFullScreen, navigationRail: $navigationRail, ignorePressure: $ignorePressure, syncMode: $syncMode, inputConfiguration: $inputConfiguration, fallbackPack: $fallbackPack, starred: $starred, defaultTemplate: $defaultTemplate, navigatorPosition: $navigatorPosition, toolbarPosition: $toolbarPosition, toolbarSize: $toolbarSize, sortBy: $sortBy, sortOrder: $sortOrder, imageScale: $imageScale, pdfQuality: $pdfQuality, platformTheme: $platformTheme, recentColors: $recentColors, flags: $flags, spreadPages: $spreadPages, highContrast: $highContrast, gridView: $gridView, autosave: $autosave, showSaveButton: $showSaveButton, toolbarRows: $toolbarRows, delayedAutosave: $delayedAutosave, autosaveDelaySeconds: $autosaveDelaySeconds, hideCursorWhileDrawing: $hideCursorWhileDrawing, utilities: $utilities, onStartup: $onStartup, simpleToolbarVisibility: $simpleToolbarVisibility, optionsPanelPosition: $optionsPanelPosition, renderResolution: $renderResolution, moveOnGesture: $moveOnGesture, swamps: $swamps, selectedPalette: $selectedPalette, showVerboseLogs: $showVerboseLogs)';
}


}

/// @nodoc
abstract mixin class _$ButterflySettingsCopyWith<$Res> implements $ButterflySettingsCopyWith<$Res> {
  factory _$ButterflySettingsCopyWith(_ButterflySettings value, $Res Function(_ButterflySettings) _then) = __$ButterflySettingsCopyWithImpl;
@override @useResult
$Res call({
 ThemeMode theme, ThemeDensity density, String localeTag, String documentPath, double gestureSensitivity, double touchSensitivity, double selectSensitivity, double scrollSensitivity, bool penOnlyInput, bool inputGestures, String design, BannerVisibility bannerVisibility,@JsonKey(includeFromJson: false, includeToJson: false) List<AssetLocation> history, bool zoomEnabled, String? lastVersion,@JsonKey(includeFromJson: false, includeToJson: false) List<ExternalStorage> connections, String defaultRemote, bool nativeTitleBar, bool startInFullScreen, bool navigationRail, IgnorePressure ignorePressure, SyncMode syncMode, InputConfiguration inputConfiguration, String fallbackPack, List<String> starred, String defaultTemplate, NavigatorPosition navigatorPosition, ToolbarPosition toolbarPosition, ToolbarSize toolbarSize, SortBy sortBy, SortOrder sortOrder, double imageScale, double pdfQuality, PlatformTheme platformTheme,@SRGBConverter() List<SRGBColor> recentColors, List<String> flags, bool spreadPages, bool highContrast, bool gridView, bool autosave, bool showSaveButton, int toolbarRows, bool delayedAutosave, int autosaveDelaySeconds, bool hideCursorWhileDrawing, UtilitiesState utilities, StartupBehavior onStartup, SimpleToolbarVisibility simpleToolbarVisibility, OptionsPanelPosition optionsPanelPosition, RenderResolution renderResolution, bool moveOnGesture, List<String> swamps, PackAssetLocation? selectedPalette, bool showVerboseLogs
});


@override $InputConfigurationCopyWith<$Res> get inputConfiguration;@override $UtilitiesStateCopyWith<$Res> get utilities;@override $PackAssetLocationCopyWith<$Res>? get selectedPalette;

}
/// @nodoc
class __$ButterflySettingsCopyWithImpl<$Res>
    implements _$ButterflySettingsCopyWith<$Res> {
  __$ButterflySettingsCopyWithImpl(this._self, this._then);

  final _ButterflySettings _self;
  final $Res Function(_ButterflySettings) _then;

/// Create a copy of ButterflySettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? theme = null,Object? density = null,Object? localeTag = null,Object? documentPath = null,Object? gestureSensitivity = null,Object? touchSensitivity = null,Object? selectSensitivity = null,Object? scrollSensitivity = null,Object? penOnlyInput = null,Object? inputGestures = null,Object? design = null,Object? bannerVisibility = null,Object? history = null,Object? zoomEnabled = null,Object? lastVersion = freezed,Object? connections = null,Object? defaultRemote = null,Object? nativeTitleBar = null,Object? startInFullScreen = null,Object? navigationRail = null,Object? ignorePressure = null,Object? syncMode = null,Object? inputConfiguration = null,Object? fallbackPack = null,Object? starred = null,Object? defaultTemplate = null,Object? navigatorPosition = null,Object? toolbarPosition = null,Object? toolbarSize = null,Object? sortBy = null,Object? sortOrder = null,Object? imageScale = null,Object? pdfQuality = null,Object? platformTheme = null,Object? recentColors = null,Object? flags = null,Object? spreadPages = null,Object? highContrast = null,Object? gridView = null,Object? autosave = null,Object? showSaveButton = null,Object? toolbarRows = null,Object? delayedAutosave = null,Object? autosaveDelaySeconds = null,Object? hideCursorWhileDrawing = null,Object? utilities = null,Object? onStartup = null,Object? simpleToolbarVisibility = null,Object? optionsPanelPosition = null,Object? renderResolution = null,Object? moveOnGesture = null,Object? swamps = null,Object? selectedPalette = freezed,Object? showVerboseLogs = null,}) {
  return _then(_ButterflySettings(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemeMode,density: null == density ? _self.density : density // ignore: cast_nullable_to_non_nullable
as ThemeDensity,localeTag: null == localeTag ? _self.localeTag : localeTag // ignore: cast_nullable_to_non_nullable
as String,documentPath: null == documentPath ? _self.documentPath : documentPath // ignore: cast_nullable_to_non_nullable
as String,gestureSensitivity: null == gestureSensitivity ? _self.gestureSensitivity : gestureSensitivity // ignore: cast_nullable_to_non_nullable
as double,touchSensitivity: null == touchSensitivity ? _self.touchSensitivity : touchSensitivity // ignore: cast_nullable_to_non_nullable
as double,selectSensitivity: null == selectSensitivity ? _self.selectSensitivity : selectSensitivity // ignore: cast_nullable_to_non_nullable
as double,scrollSensitivity: null == scrollSensitivity ? _self.scrollSensitivity : scrollSensitivity // ignore: cast_nullable_to_non_nullable
as double,penOnlyInput: null == penOnlyInput ? _self.penOnlyInput : penOnlyInput // ignore: cast_nullable_to_non_nullable
as bool,inputGestures: null == inputGestures ? _self.inputGestures : inputGestures // ignore: cast_nullable_to_non_nullable
as bool,design: null == design ? _self.design : design // ignore: cast_nullable_to_non_nullable
as String,bannerVisibility: null == bannerVisibility ? _self.bannerVisibility : bannerVisibility // ignore: cast_nullable_to_non_nullable
as BannerVisibility,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<AssetLocation>,zoomEnabled: null == zoomEnabled ? _self.zoomEnabled : zoomEnabled // ignore: cast_nullable_to_non_nullable
as bool,lastVersion: freezed == lastVersion ? _self.lastVersion : lastVersion // ignore: cast_nullable_to_non_nullable
as String?,connections: null == connections ? _self._connections : connections // ignore: cast_nullable_to_non_nullable
as List<ExternalStorage>,defaultRemote: null == defaultRemote ? _self.defaultRemote : defaultRemote // ignore: cast_nullable_to_non_nullable
as String,nativeTitleBar: null == nativeTitleBar ? _self.nativeTitleBar : nativeTitleBar // ignore: cast_nullable_to_non_nullable
as bool,startInFullScreen: null == startInFullScreen ? _self.startInFullScreen : startInFullScreen // ignore: cast_nullable_to_non_nullable
as bool,navigationRail: null == navigationRail ? _self.navigationRail : navigationRail // ignore: cast_nullable_to_non_nullable
as bool,ignorePressure: null == ignorePressure ? _self.ignorePressure : ignorePressure // ignore: cast_nullable_to_non_nullable
as IgnorePressure,syncMode: null == syncMode ? _self.syncMode : syncMode // ignore: cast_nullable_to_non_nullable
as SyncMode,inputConfiguration: null == inputConfiguration ? _self.inputConfiguration : inputConfiguration // ignore: cast_nullable_to_non_nullable
as InputConfiguration,fallbackPack: null == fallbackPack ? _self.fallbackPack : fallbackPack // ignore: cast_nullable_to_non_nullable
as String,starred: null == starred ? _self._starred : starred // ignore: cast_nullable_to_non_nullable
as List<String>,defaultTemplate: null == defaultTemplate ? _self.defaultTemplate : defaultTemplate // ignore: cast_nullable_to_non_nullable
as String,navigatorPosition: null == navigatorPosition ? _self.navigatorPosition : navigatorPosition // ignore: cast_nullable_to_non_nullable
as NavigatorPosition,toolbarPosition: null == toolbarPosition ? _self.toolbarPosition : toolbarPosition // ignore: cast_nullable_to_non_nullable
as ToolbarPosition,toolbarSize: null == toolbarSize ? _self.toolbarSize : toolbarSize // ignore: cast_nullable_to_non_nullable
as ToolbarSize,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as SortBy,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder,imageScale: null == imageScale ? _self.imageScale : imageScale // ignore: cast_nullable_to_non_nullable
as double,pdfQuality: null == pdfQuality ? _self.pdfQuality : pdfQuality // ignore: cast_nullable_to_non_nullable
as double,platformTheme: null == platformTheme ? _self.platformTheme : platformTheme // ignore: cast_nullable_to_non_nullable
as PlatformTheme,recentColors: null == recentColors ? _self._recentColors : recentColors // ignore: cast_nullable_to_non_nullable
as List<SRGBColor>,flags: null == flags ? _self._flags : flags // ignore: cast_nullable_to_non_nullable
as List<String>,spreadPages: null == spreadPages ? _self.spreadPages : spreadPages // ignore: cast_nullable_to_non_nullable
as bool,highContrast: null == highContrast ? _self.highContrast : highContrast // ignore: cast_nullable_to_non_nullable
as bool,gridView: null == gridView ? _self.gridView : gridView // ignore: cast_nullable_to_non_nullable
as bool,autosave: null == autosave ? _self.autosave : autosave // ignore: cast_nullable_to_non_nullable
as bool,showSaveButton: null == showSaveButton ? _self.showSaveButton : showSaveButton // ignore: cast_nullable_to_non_nullable
as bool,toolbarRows: null == toolbarRows ? _self.toolbarRows : toolbarRows // ignore: cast_nullable_to_non_nullable
as int,delayedAutosave: null == delayedAutosave ? _self.delayedAutosave : delayedAutosave // ignore: cast_nullable_to_non_nullable
as bool,autosaveDelaySeconds: null == autosaveDelaySeconds ? _self.autosaveDelaySeconds : autosaveDelaySeconds // ignore: cast_nullable_to_non_nullable
as int,hideCursorWhileDrawing: null == hideCursorWhileDrawing ? _self.hideCursorWhileDrawing : hideCursorWhileDrawing // ignore: cast_nullable_to_non_nullable
as bool,utilities: null == utilities ? _self.utilities : utilities // ignore: cast_nullable_to_non_nullable
as UtilitiesState,onStartup: null == onStartup ? _self.onStartup : onStartup // ignore: cast_nullable_to_non_nullable
as StartupBehavior,simpleToolbarVisibility: null == simpleToolbarVisibility ? _self.simpleToolbarVisibility : simpleToolbarVisibility // ignore: cast_nullable_to_non_nullable
as SimpleToolbarVisibility,optionsPanelPosition: null == optionsPanelPosition ? _self.optionsPanelPosition : optionsPanelPosition // ignore: cast_nullable_to_non_nullable
as OptionsPanelPosition,renderResolution: null == renderResolution ? _self.renderResolution : renderResolution // ignore: cast_nullable_to_non_nullable
as RenderResolution,moveOnGesture: null == moveOnGesture ? _self.moveOnGesture : moveOnGesture // ignore: cast_nullable_to_non_nullable
as bool,swamps: null == swamps ? _self._swamps : swamps // ignore: cast_nullable_to_non_nullable
as List<String>,selectedPalette: freezed == selectedPalette ? _self.selectedPalette : selectedPalette // ignore: cast_nullable_to_non_nullable
as PackAssetLocation?,showVerboseLogs: null == showVerboseLogs ? _self.showVerboseLogs : showVerboseLogs // ignore: cast_nullable_to_non_nullable
as bool,
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
$UtilitiesStateCopyWith<$Res> get utilities {
  
  return $UtilitiesStateCopyWith<$Res>(_self.utilities, (value) {
    return _then(_self.copyWith(utilities: value));
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
