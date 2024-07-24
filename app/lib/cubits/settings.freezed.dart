// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InputConfiguration _$InputConfigurationFromJson(Map<String, dynamic> json) {
  return _InputConfiguration.fromJson(json);
}

/// @nodoc
mixin _$InputConfiguration {
  int? get leftMouse => throw _privateConstructorUsedError;
  int? get middleMouse => throw _privateConstructorUsedError;
  int? get rightMouse => throw _privateConstructorUsedError;
  int? get pen => throw _privateConstructorUsedError;
  int? get firstPenButton => throw _privateConstructorUsedError;
  int? get secondPenButton => throw _privateConstructorUsedError;
  int? get touch => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InputConfigurationCopyWith<InputConfiguration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputConfigurationCopyWith<$Res> {
  factory $InputConfigurationCopyWith(
          InputConfiguration value, $Res Function(InputConfiguration) then) =
      _$InputConfigurationCopyWithImpl<$Res, InputConfiguration>;
  @useResult
  $Res call(
      {int? leftMouse,
      int? middleMouse,
      int? rightMouse,
      int? pen,
      int? firstPenButton,
      int? secondPenButton,
      int? touch});
}

/// @nodoc
class _$InputConfigurationCopyWithImpl<$Res, $Val extends InputConfiguration>
    implements $InputConfigurationCopyWith<$Res> {
  _$InputConfigurationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leftMouse = freezed,
    Object? middleMouse = freezed,
    Object? rightMouse = freezed,
    Object? pen = freezed,
    Object? firstPenButton = freezed,
    Object? secondPenButton = freezed,
    Object? touch = freezed,
  }) {
    return _then(_value.copyWith(
      leftMouse: freezed == leftMouse
          ? _value.leftMouse
          : leftMouse // ignore: cast_nullable_to_non_nullable
              as int?,
      middleMouse: freezed == middleMouse
          ? _value.middleMouse
          : middleMouse // ignore: cast_nullable_to_non_nullable
              as int?,
      rightMouse: freezed == rightMouse
          ? _value.rightMouse
          : rightMouse // ignore: cast_nullable_to_non_nullable
              as int?,
      pen: freezed == pen
          ? _value.pen
          : pen // ignore: cast_nullable_to_non_nullable
              as int?,
      firstPenButton: freezed == firstPenButton
          ? _value.firstPenButton
          : firstPenButton // ignore: cast_nullable_to_non_nullable
              as int?,
      secondPenButton: freezed == secondPenButton
          ? _value.secondPenButton
          : secondPenButton // ignore: cast_nullable_to_non_nullable
              as int?,
      touch: freezed == touch
          ? _value.touch
          : touch // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InputConfigurationImplCopyWith<$Res>
    implements $InputConfigurationCopyWith<$Res> {
  factory _$$InputConfigurationImplCopyWith(_$InputConfigurationImpl value,
          $Res Function(_$InputConfigurationImpl) then) =
      __$$InputConfigurationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? leftMouse,
      int? middleMouse,
      int? rightMouse,
      int? pen,
      int? firstPenButton,
      int? secondPenButton,
      int? touch});
}

/// @nodoc
class __$$InputConfigurationImplCopyWithImpl<$Res>
    extends _$InputConfigurationCopyWithImpl<$Res, _$InputConfigurationImpl>
    implements _$$InputConfigurationImplCopyWith<$Res> {
  __$$InputConfigurationImplCopyWithImpl(_$InputConfigurationImpl _value,
      $Res Function(_$InputConfigurationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leftMouse = freezed,
    Object? middleMouse = freezed,
    Object? rightMouse = freezed,
    Object? pen = freezed,
    Object? firstPenButton = freezed,
    Object? secondPenButton = freezed,
    Object? touch = freezed,
  }) {
    return _then(_$InputConfigurationImpl(
      leftMouse: freezed == leftMouse
          ? _value.leftMouse
          : leftMouse // ignore: cast_nullable_to_non_nullable
              as int?,
      middleMouse: freezed == middleMouse
          ? _value.middleMouse
          : middleMouse // ignore: cast_nullable_to_non_nullable
              as int?,
      rightMouse: freezed == rightMouse
          ? _value.rightMouse
          : rightMouse // ignore: cast_nullable_to_non_nullable
              as int?,
      pen: freezed == pen
          ? _value.pen
          : pen // ignore: cast_nullable_to_non_nullable
              as int?,
      firstPenButton: freezed == firstPenButton
          ? _value.firstPenButton
          : firstPenButton // ignore: cast_nullable_to_non_nullable
              as int?,
      secondPenButton: freezed == secondPenButton
          ? _value.secondPenButton
          : secondPenButton // ignore: cast_nullable_to_non_nullable
              as int?,
      touch: freezed == touch
          ? _value.touch
          : touch // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InputConfigurationImpl extends _InputConfiguration
    with DiagnosticableTreeMixin {
  const _$InputConfigurationImpl(
      {this.leftMouse,
      this.middleMouse = -1,
      this.rightMouse = 1,
      this.pen,
      this.firstPenButton = 2,
      this.secondPenButton = 1,
      this.touch})
      : super._();

  factory _$InputConfigurationImpl.fromJson(Map<String, dynamic> json) =>
      _$$InputConfigurationImplFromJson(json);

  @override
  final int? leftMouse;
  @override
  @JsonKey()
  final int? middleMouse;
  @override
  @JsonKey()
  final int? rightMouse;
  @override
  final int? pen;
  @override
  @JsonKey()
  final int? firstPenButton;
  @override
  @JsonKey()
  final int? secondPenButton;
  @override
  final int? touch;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'InputConfiguration(leftMouse: $leftMouse, middleMouse: $middleMouse, rightMouse: $rightMouse, pen: $pen, firstPenButton: $firstPenButton, secondPenButton: $secondPenButton, touch: $touch)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'InputConfiguration'))
      ..add(DiagnosticsProperty('leftMouse', leftMouse))
      ..add(DiagnosticsProperty('middleMouse', middleMouse))
      ..add(DiagnosticsProperty('rightMouse', rightMouse))
      ..add(DiagnosticsProperty('pen', pen))
      ..add(DiagnosticsProperty('firstPenButton', firstPenButton))
      ..add(DiagnosticsProperty('secondPenButton', secondPenButton))
      ..add(DiagnosticsProperty('touch', touch));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InputConfigurationImpl &&
            (identical(other.leftMouse, leftMouse) ||
                other.leftMouse == leftMouse) &&
            (identical(other.middleMouse, middleMouse) ||
                other.middleMouse == middleMouse) &&
            (identical(other.rightMouse, rightMouse) ||
                other.rightMouse == rightMouse) &&
            (identical(other.pen, pen) || other.pen == pen) &&
            (identical(other.firstPenButton, firstPenButton) ||
                other.firstPenButton == firstPenButton) &&
            (identical(other.secondPenButton, secondPenButton) ||
                other.secondPenButton == secondPenButton) &&
            (identical(other.touch, touch) || other.touch == touch));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, leftMouse, middleMouse,
      rightMouse, pen, firstPenButton, secondPenButton, touch);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InputConfigurationImplCopyWith<_$InputConfigurationImpl> get copyWith =>
      __$$InputConfigurationImplCopyWithImpl<_$InputConfigurationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InputConfigurationImplToJson(
      this,
    );
  }
}

abstract class _InputConfiguration extends InputConfiguration {
  const factory _InputConfiguration(
      {final int? leftMouse,
      final int? middleMouse,
      final int? rightMouse,
      final int? pen,
      final int? firstPenButton,
      final int? secondPenButton,
      final int? touch}) = _$InputConfigurationImpl;
  const _InputConfiguration._() : super._();

  factory _InputConfiguration.fromJson(Map<String, dynamic> json) =
      _$InputConfigurationImpl.fromJson;

  @override
  int? get leftMouse;
  @override
  int? get middleMouse;
  @override
  int? get rightMouse;
  @override
  int? get pen;
  @override
  int? get firstPenButton;
  @override
  int? get secondPenButton;
  @override
  int? get touch;
  @override
  @JsonKey(ignore: true)
  _$$InputConfigurationImplCopyWith<_$InputConfigurationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ButterflySettings {
  ThemeMode get theme => throw _privateConstructorUsedError;
  ThemeDensity get density => throw _privateConstructorUsedError;
  String get localeTag => throw _privateConstructorUsedError;
  String get documentPath => throw _privateConstructorUsedError;
  double get touchSensitivity => throw _privateConstructorUsedError;
  double get mouseSensitivity => throw _privateConstructorUsedError;
  double get penSensitivity => throw _privateConstructorUsedError;
  double get selectSensitivity => throw _privateConstructorUsedError;
  bool get penOnlyInput => throw _privateConstructorUsedError;
  bool get inputGestures => throw _privateConstructorUsedError;
  String get design => throw _privateConstructorUsedError;
  BannerVisibility get bannerVisibility => throw _privateConstructorUsedError;
  List<AssetLocation> get history => throw _privateConstructorUsedError;
  bool get navigatorEnabled => throw _privateConstructorUsedError;
  bool get zoomEnabled => throw _privateConstructorUsedError;
  String? get lastVersion => throw _privateConstructorUsedError;
  List<ExternalStorage> get connections => throw _privateConstructorUsedError;
  String get defaultRemote => throw _privateConstructorUsedError;
  bool get nativeTitleBar => throw _privateConstructorUsedError;
  bool get startInFullScreen => throw _privateConstructorUsedError;
  bool get navigationRail => throw _privateConstructorUsedError;
  SyncMode get syncMode => throw _privateConstructorUsedError;
  InputConfiguration get inputConfiguration =>
      throw _privateConstructorUsedError;
  String get fallbackPack => throw _privateConstructorUsedError;
  List<String> get starred => throw _privateConstructorUsedError;
  String get defaultTemplate => throw _privateConstructorUsedError;
  NavigatorPage get navigatorPage => throw _privateConstructorUsedError;
  NavigatorPosition get navigatorPosition => throw _privateConstructorUsedError;
  ToolbarPosition get toolbarPosition => throw _privateConstructorUsedError;
  ToolbarSize get toolbarSize => throw _privateConstructorUsedError;
  SortBy get sortBy => throw _privateConstructorUsedError;
  SortOrder get sortOrder => throw _privateConstructorUsedError;
  double get imageScale => throw _privateConstructorUsedError;
  double get pdfQuality => throw _privateConstructorUsedError;
  PlatformTheme get platformTheme => throw _privateConstructorUsedError;
  List<int> get recentColors => throw _privateConstructorUsedError;
  List<String> get flags => throw _privateConstructorUsedError;
  bool get spreadPages => throw _privateConstructorUsedError;
  bool get highContrast => throw _privateConstructorUsedError;
  bool get gridView => throw _privateConstructorUsedError;
  bool get autosave => throw _privateConstructorUsedError;
  int get toolbarRows => throw _privateConstructorUsedError;
  bool get hideCursorWhileDrawing => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ButterflySettingsCopyWith<ButterflySettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ButterflySettingsCopyWith<$Res> {
  factory $ButterflySettingsCopyWith(
          ButterflySettings value, $Res Function(ButterflySettings) then) =
      _$ButterflySettingsCopyWithImpl<$Res, ButterflySettings>;
  @useResult
  $Res call(
      {ThemeMode theme,
      ThemeDensity density,
      String localeTag,
      String documentPath,
      double touchSensitivity,
      double mouseSensitivity,
      double penSensitivity,
      double selectSensitivity,
      bool penOnlyInput,
      bool inputGestures,
      String design,
      BannerVisibility bannerVisibility,
      List<AssetLocation> history,
      bool navigatorEnabled,
      bool zoomEnabled,
      String? lastVersion,
      List<ExternalStorage> connections,
      String defaultRemote,
      bool nativeTitleBar,
      bool startInFullScreen,
      bool navigationRail,
      SyncMode syncMode,
      InputConfiguration inputConfiguration,
      String fallbackPack,
      List<String> starred,
      String defaultTemplate,
      NavigatorPage navigatorPage,
      NavigatorPosition navigatorPosition,
      ToolbarPosition toolbarPosition,
      ToolbarSize toolbarSize,
      SortBy sortBy,
      SortOrder sortOrder,
      double imageScale,
      double pdfQuality,
      PlatformTheme platformTheme,
      List<int> recentColors,
      List<String> flags,
      bool spreadPages,
      bool highContrast,
      bool gridView,
      bool autosave,
      int toolbarRows,
      bool hideCursorWhileDrawing});

  $InputConfigurationCopyWith<$Res> get inputConfiguration;
}

/// @nodoc
class _$ButterflySettingsCopyWithImpl<$Res, $Val extends ButterflySettings>
    implements $ButterflySettingsCopyWith<$Res> {
  _$ButterflySettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? density = null,
    Object? localeTag = null,
    Object? documentPath = null,
    Object? touchSensitivity = null,
    Object? mouseSensitivity = null,
    Object? penSensitivity = null,
    Object? selectSensitivity = null,
    Object? penOnlyInput = null,
    Object? inputGestures = null,
    Object? design = null,
    Object? bannerVisibility = null,
    Object? history = null,
    Object? navigatorEnabled = null,
    Object? zoomEnabled = null,
    Object? lastVersion = freezed,
    Object? connections = null,
    Object? defaultRemote = null,
    Object? nativeTitleBar = null,
    Object? startInFullScreen = null,
    Object? navigationRail = null,
    Object? syncMode = null,
    Object? inputConfiguration = null,
    Object? fallbackPack = null,
    Object? starred = null,
    Object? defaultTemplate = null,
    Object? navigatorPage = null,
    Object? navigatorPosition = null,
    Object? toolbarPosition = null,
    Object? toolbarSize = null,
    Object? sortBy = null,
    Object? sortOrder = null,
    Object? imageScale = null,
    Object? pdfQuality = null,
    Object? platformTheme = null,
    Object? recentColors = null,
    Object? flags = null,
    Object? spreadPages = null,
    Object? highContrast = null,
    Object? gridView = null,
    Object? autosave = null,
    Object? toolbarRows = null,
    Object? hideCursorWhileDrawing = null,
  }) {
    return _then(_value.copyWith(
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      density: null == density
          ? _value.density
          : density // ignore: cast_nullable_to_non_nullable
              as ThemeDensity,
      localeTag: null == localeTag
          ? _value.localeTag
          : localeTag // ignore: cast_nullable_to_non_nullable
              as String,
      documentPath: null == documentPath
          ? _value.documentPath
          : documentPath // ignore: cast_nullable_to_non_nullable
              as String,
      touchSensitivity: null == touchSensitivity
          ? _value.touchSensitivity
          : touchSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      mouseSensitivity: null == mouseSensitivity
          ? _value.mouseSensitivity
          : mouseSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      penSensitivity: null == penSensitivity
          ? _value.penSensitivity
          : penSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      selectSensitivity: null == selectSensitivity
          ? _value.selectSensitivity
          : selectSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      penOnlyInput: null == penOnlyInput
          ? _value.penOnlyInput
          : penOnlyInput // ignore: cast_nullable_to_non_nullable
              as bool,
      inputGestures: null == inputGestures
          ? _value.inputGestures
          : inputGestures // ignore: cast_nullable_to_non_nullable
              as bool,
      design: null == design
          ? _value.design
          : design // ignore: cast_nullable_to_non_nullable
              as String,
      bannerVisibility: null == bannerVisibility
          ? _value.bannerVisibility
          : bannerVisibility // ignore: cast_nullable_to_non_nullable
              as BannerVisibility,
      history: null == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<AssetLocation>,
      navigatorEnabled: null == navigatorEnabled
          ? _value.navigatorEnabled
          : navigatorEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      zoomEnabled: null == zoomEnabled
          ? _value.zoomEnabled
          : zoomEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      lastVersion: freezed == lastVersion
          ? _value.lastVersion
          : lastVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      connections: null == connections
          ? _value.connections
          : connections // ignore: cast_nullable_to_non_nullable
              as List<ExternalStorage>,
      defaultRemote: null == defaultRemote
          ? _value.defaultRemote
          : defaultRemote // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTitleBar: null == nativeTitleBar
          ? _value.nativeTitleBar
          : nativeTitleBar // ignore: cast_nullable_to_non_nullable
              as bool,
      startInFullScreen: null == startInFullScreen
          ? _value.startInFullScreen
          : startInFullScreen // ignore: cast_nullable_to_non_nullable
              as bool,
      navigationRail: null == navigationRail
          ? _value.navigationRail
          : navigationRail // ignore: cast_nullable_to_non_nullable
              as bool,
      syncMode: null == syncMode
          ? _value.syncMode
          : syncMode // ignore: cast_nullable_to_non_nullable
              as SyncMode,
      inputConfiguration: null == inputConfiguration
          ? _value.inputConfiguration
          : inputConfiguration // ignore: cast_nullable_to_non_nullable
              as InputConfiguration,
      fallbackPack: null == fallbackPack
          ? _value.fallbackPack
          : fallbackPack // ignore: cast_nullable_to_non_nullable
              as String,
      starred: null == starred
          ? _value.starred
          : starred // ignore: cast_nullable_to_non_nullable
              as List<String>,
      defaultTemplate: null == defaultTemplate
          ? _value.defaultTemplate
          : defaultTemplate // ignore: cast_nullable_to_non_nullable
              as String,
      navigatorPage: null == navigatorPage
          ? _value.navigatorPage
          : navigatorPage // ignore: cast_nullable_to_non_nullable
              as NavigatorPage,
      navigatorPosition: null == navigatorPosition
          ? _value.navigatorPosition
          : navigatorPosition // ignore: cast_nullable_to_non_nullable
              as NavigatorPosition,
      toolbarPosition: null == toolbarPosition
          ? _value.toolbarPosition
          : toolbarPosition // ignore: cast_nullable_to_non_nullable
              as ToolbarPosition,
      toolbarSize: null == toolbarSize
          ? _value.toolbarSize
          : toolbarSize // ignore: cast_nullable_to_non_nullable
              as ToolbarSize,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as SortBy,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as SortOrder,
      imageScale: null == imageScale
          ? _value.imageScale
          : imageScale // ignore: cast_nullable_to_non_nullable
              as double,
      pdfQuality: null == pdfQuality
          ? _value.pdfQuality
          : pdfQuality // ignore: cast_nullable_to_non_nullable
              as double,
      platformTheme: null == platformTheme
          ? _value.platformTheme
          : platformTheme // ignore: cast_nullable_to_non_nullable
              as PlatformTheme,
      recentColors: null == recentColors
          ? _value.recentColors
          : recentColors // ignore: cast_nullable_to_non_nullable
              as List<int>,
      flags: null == flags
          ? _value.flags
          : flags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spreadPages: null == spreadPages
          ? _value.spreadPages
          : spreadPages // ignore: cast_nullable_to_non_nullable
              as bool,
      highContrast: null == highContrast
          ? _value.highContrast
          : highContrast // ignore: cast_nullable_to_non_nullable
              as bool,
      gridView: null == gridView
          ? _value.gridView
          : gridView // ignore: cast_nullable_to_non_nullable
              as bool,
      autosave: null == autosave
          ? _value.autosave
          : autosave // ignore: cast_nullable_to_non_nullable
              as bool,
      toolbarRows: null == toolbarRows
          ? _value.toolbarRows
          : toolbarRows // ignore: cast_nullable_to_non_nullable
              as int,
      hideCursorWhileDrawing: null == hideCursorWhileDrawing
          ? _value.hideCursorWhileDrawing
          : hideCursorWhileDrawing // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $InputConfigurationCopyWith<$Res> get inputConfiguration {
    return $InputConfigurationCopyWith<$Res>(_value.inputConfiguration,
        (value) {
      return _then(_value.copyWith(inputConfiguration: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ButterflySettingsImplCopyWith<$Res>
    implements $ButterflySettingsCopyWith<$Res> {
  factory _$$ButterflySettingsImplCopyWith(_$ButterflySettingsImpl value,
          $Res Function(_$ButterflySettingsImpl) then) =
      __$$ButterflySettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ThemeMode theme,
      ThemeDensity density,
      String localeTag,
      String documentPath,
      double touchSensitivity,
      double mouseSensitivity,
      double penSensitivity,
      double selectSensitivity,
      bool penOnlyInput,
      bool inputGestures,
      String design,
      BannerVisibility bannerVisibility,
      List<AssetLocation> history,
      bool navigatorEnabled,
      bool zoomEnabled,
      String? lastVersion,
      List<ExternalStorage> connections,
      String defaultRemote,
      bool nativeTitleBar,
      bool startInFullScreen,
      bool navigationRail,
      SyncMode syncMode,
      InputConfiguration inputConfiguration,
      String fallbackPack,
      List<String> starred,
      String defaultTemplate,
      NavigatorPage navigatorPage,
      NavigatorPosition navigatorPosition,
      ToolbarPosition toolbarPosition,
      ToolbarSize toolbarSize,
      SortBy sortBy,
      SortOrder sortOrder,
      double imageScale,
      double pdfQuality,
      PlatformTheme platformTheme,
      List<int> recentColors,
      List<String> flags,
      bool spreadPages,
      bool highContrast,
      bool gridView,
      bool autosave,
      int toolbarRows,
      bool hideCursorWhileDrawing});

  @override
  $InputConfigurationCopyWith<$Res> get inputConfiguration;
}

/// @nodoc
class __$$ButterflySettingsImplCopyWithImpl<$Res>
    extends _$ButterflySettingsCopyWithImpl<$Res, _$ButterflySettingsImpl>
    implements _$$ButterflySettingsImplCopyWith<$Res> {
  __$$ButterflySettingsImplCopyWithImpl(_$ButterflySettingsImpl _value,
      $Res Function(_$ButterflySettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? density = null,
    Object? localeTag = null,
    Object? documentPath = null,
    Object? touchSensitivity = null,
    Object? mouseSensitivity = null,
    Object? penSensitivity = null,
    Object? selectSensitivity = null,
    Object? penOnlyInput = null,
    Object? inputGestures = null,
    Object? design = null,
    Object? bannerVisibility = null,
    Object? history = null,
    Object? navigatorEnabled = null,
    Object? zoomEnabled = null,
    Object? lastVersion = freezed,
    Object? connections = null,
    Object? defaultRemote = null,
    Object? nativeTitleBar = null,
    Object? startInFullScreen = null,
    Object? navigationRail = null,
    Object? syncMode = null,
    Object? inputConfiguration = null,
    Object? fallbackPack = null,
    Object? starred = null,
    Object? defaultTemplate = null,
    Object? navigatorPage = null,
    Object? navigatorPosition = null,
    Object? toolbarPosition = null,
    Object? toolbarSize = null,
    Object? sortBy = null,
    Object? sortOrder = null,
    Object? imageScale = null,
    Object? pdfQuality = null,
    Object? platformTheme = null,
    Object? recentColors = null,
    Object? flags = null,
    Object? spreadPages = null,
    Object? highContrast = null,
    Object? gridView = null,
    Object? autosave = null,
    Object? toolbarRows = null,
    Object? hideCursorWhileDrawing = null,
  }) {
    return _then(_$ButterflySettingsImpl(
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      density: null == density
          ? _value.density
          : density // ignore: cast_nullable_to_non_nullable
              as ThemeDensity,
      localeTag: null == localeTag
          ? _value.localeTag
          : localeTag // ignore: cast_nullable_to_non_nullable
              as String,
      documentPath: null == documentPath
          ? _value.documentPath
          : documentPath // ignore: cast_nullable_to_non_nullable
              as String,
      touchSensitivity: null == touchSensitivity
          ? _value.touchSensitivity
          : touchSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      mouseSensitivity: null == mouseSensitivity
          ? _value.mouseSensitivity
          : mouseSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      penSensitivity: null == penSensitivity
          ? _value.penSensitivity
          : penSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      selectSensitivity: null == selectSensitivity
          ? _value.selectSensitivity
          : selectSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      penOnlyInput: null == penOnlyInput
          ? _value.penOnlyInput
          : penOnlyInput // ignore: cast_nullable_to_non_nullable
              as bool,
      inputGestures: null == inputGestures
          ? _value.inputGestures
          : inputGestures // ignore: cast_nullable_to_non_nullable
              as bool,
      design: null == design
          ? _value.design
          : design // ignore: cast_nullable_to_non_nullable
              as String,
      bannerVisibility: null == bannerVisibility
          ? _value.bannerVisibility
          : bannerVisibility // ignore: cast_nullable_to_non_nullable
              as BannerVisibility,
      history: null == history
          ? _value._history
          : history // ignore: cast_nullable_to_non_nullable
              as List<AssetLocation>,
      navigatorEnabled: null == navigatorEnabled
          ? _value.navigatorEnabled
          : navigatorEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      zoomEnabled: null == zoomEnabled
          ? _value.zoomEnabled
          : zoomEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      lastVersion: freezed == lastVersion
          ? _value.lastVersion
          : lastVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      connections: null == connections
          ? _value._connections
          : connections // ignore: cast_nullable_to_non_nullable
              as List<ExternalStorage>,
      defaultRemote: null == defaultRemote
          ? _value.defaultRemote
          : defaultRemote // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTitleBar: null == nativeTitleBar
          ? _value.nativeTitleBar
          : nativeTitleBar // ignore: cast_nullable_to_non_nullable
              as bool,
      startInFullScreen: null == startInFullScreen
          ? _value.startInFullScreen
          : startInFullScreen // ignore: cast_nullable_to_non_nullable
              as bool,
      navigationRail: null == navigationRail
          ? _value.navigationRail
          : navigationRail // ignore: cast_nullable_to_non_nullable
              as bool,
      syncMode: null == syncMode
          ? _value.syncMode
          : syncMode // ignore: cast_nullable_to_non_nullable
              as SyncMode,
      inputConfiguration: null == inputConfiguration
          ? _value.inputConfiguration
          : inputConfiguration // ignore: cast_nullable_to_non_nullable
              as InputConfiguration,
      fallbackPack: null == fallbackPack
          ? _value.fallbackPack
          : fallbackPack // ignore: cast_nullable_to_non_nullable
              as String,
      starred: null == starred
          ? _value._starred
          : starred // ignore: cast_nullable_to_non_nullable
              as List<String>,
      defaultTemplate: null == defaultTemplate
          ? _value.defaultTemplate
          : defaultTemplate // ignore: cast_nullable_to_non_nullable
              as String,
      navigatorPage: null == navigatorPage
          ? _value.navigatorPage
          : navigatorPage // ignore: cast_nullable_to_non_nullable
              as NavigatorPage,
      navigatorPosition: null == navigatorPosition
          ? _value.navigatorPosition
          : navigatorPosition // ignore: cast_nullable_to_non_nullable
              as NavigatorPosition,
      toolbarPosition: null == toolbarPosition
          ? _value.toolbarPosition
          : toolbarPosition // ignore: cast_nullable_to_non_nullable
              as ToolbarPosition,
      toolbarSize: null == toolbarSize
          ? _value.toolbarSize
          : toolbarSize // ignore: cast_nullable_to_non_nullable
              as ToolbarSize,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as SortBy,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as SortOrder,
      imageScale: null == imageScale
          ? _value.imageScale
          : imageScale // ignore: cast_nullable_to_non_nullable
              as double,
      pdfQuality: null == pdfQuality
          ? _value.pdfQuality
          : pdfQuality // ignore: cast_nullable_to_non_nullable
              as double,
      platformTheme: null == platformTheme
          ? _value.platformTheme
          : platformTheme // ignore: cast_nullable_to_non_nullable
              as PlatformTheme,
      recentColors: null == recentColors
          ? _value._recentColors
          : recentColors // ignore: cast_nullable_to_non_nullable
              as List<int>,
      flags: null == flags
          ? _value._flags
          : flags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spreadPages: null == spreadPages
          ? _value.spreadPages
          : spreadPages // ignore: cast_nullable_to_non_nullable
              as bool,
      highContrast: null == highContrast
          ? _value.highContrast
          : highContrast // ignore: cast_nullable_to_non_nullable
              as bool,
      gridView: null == gridView
          ? _value.gridView
          : gridView // ignore: cast_nullable_to_non_nullable
              as bool,
      autosave: null == autosave
          ? _value.autosave
          : autosave // ignore: cast_nullable_to_non_nullable
              as bool,
      toolbarRows: null == toolbarRows
          ? _value.toolbarRows
          : toolbarRows // ignore: cast_nullable_to_non_nullable
              as int,
      hideCursorWhileDrawing: null == hideCursorWhileDrawing
          ? _value.hideCursorWhileDrawing
          : hideCursorWhileDrawing // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ButterflySettingsImpl extends _ButterflySettings
    with DiagnosticableTreeMixin {
  const _$ButterflySettingsImpl(
      {this.theme = ThemeMode.system,
      this.density = ThemeDensity.system,
      this.localeTag = '',
      this.documentPath = '',
      this.touchSensitivity = 1,
      this.mouseSensitivity = 1,
      this.penSensitivity = 1,
      this.selectSensitivity = 5,
      this.penOnlyInput = false,
      this.inputGestures = true,
      this.design = '',
      this.bannerVisibility = BannerVisibility.always,
      final List<AssetLocation> history = const [],
      this.navigatorEnabled = false,
      this.zoomEnabled = true,
      this.lastVersion,
      final List<ExternalStorage> connections = const [],
      this.defaultRemote = '',
      this.nativeTitleBar = false,
      this.startInFullScreen = false,
      this.navigationRail = true,
      this.syncMode = SyncMode.noMobile,
      this.inputConfiguration = const InputConfiguration(),
      this.fallbackPack = '',
      final List<String> starred = const [],
      this.defaultTemplate = '',
      this.navigatorPage = NavigatorPage.waypoints,
      this.navigatorPosition = NavigatorPosition.left,
      this.toolbarPosition = ToolbarPosition.inline,
      this.toolbarSize = ToolbarSize.normal,
      this.sortBy = SortBy.name,
      this.sortOrder = SortOrder.ascending,
      this.imageScale = 0.5,
      this.pdfQuality = 2,
      this.platformTheme = PlatformTheme.system,
      final List<int> recentColors = const [],
      final List<String> flags = const [],
      this.spreadPages = false,
      this.highContrast = false,
      this.gridView = false,
      this.autosave = true,
      this.toolbarRows = 1,
      this.hideCursorWhileDrawing = false})
      : _history = history,
        _connections = connections,
        _starred = starred,
        _recentColors = recentColors,
        _flags = flags,
        super._();

  @override
  @JsonKey()
  final ThemeMode theme;
  @override
  @JsonKey()
  final ThemeDensity density;
  @override
  @JsonKey()
  final String localeTag;
  @override
  @JsonKey()
  final String documentPath;
  @override
  @JsonKey()
  final double touchSensitivity;
  @override
  @JsonKey()
  final double mouseSensitivity;
  @override
  @JsonKey()
  final double penSensitivity;
  @override
  @JsonKey()
  final double selectSensitivity;
  @override
  @JsonKey()
  final bool penOnlyInput;
  @override
  @JsonKey()
  final bool inputGestures;
  @override
  @JsonKey()
  final String design;
  @override
  @JsonKey()
  final BannerVisibility bannerVisibility;
  final List<AssetLocation> _history;
  @override
  @JsonKey()
  List<AssetLocation> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  @JsonKey()
  final bool navigatorEnabled;
  @override
  @JsonKey()
  final bool zoomEnabled;
  @override
  final String? lastVersion;
  final List<ExternalStorage> _connections;
  @override
  @JsonKey()
  List<ExternalStorage> get connections {
    if (_connections is EqualUnmodifiableListView) return _connections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_connections);
  }

  @override
  @JsonKey()
  final String defaultRemote;
  @override
  @JsonKey()
  final bool nativeTitleBar;
  @override
  @JsonKey()
  final bool startInFullScreen;
  @override
  @JsonKey()
  final bool navigationRail;
  @override
  @JsonKey()
  final SyncMode syncMode;
  @override
  @JsonKey()
  final InputConfiguration inputConfiguration;
  @override
  @JsonKey()
  final String fallbackPack;
  final List<String> _starred;
  @override
  @JsonKey()
  List<String> get starred {
    if (_starred is EqualUnmodifiableListView) return _starred;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_starred);
  }

  @override
  @JsonKey()
  final String defaultTemplate;
  @override
  @JsonKey()
  final NavigatorPage navigatorPage;
  @override
  @JsonKey()
  final NavigatorPosition navigatorPosition;
  @override
  @JsonKey()
  final ToolbarPosition toolbarPosition;
  @override
  @JsonKey()
  final ToolbarSize toolbarSize;
  @override
  @JsonKey()
  final SortBy sortBy;
  @override
  @JsonKey()
  final SortOrder sortOrder;
  @override
  @JsonKey()
  final double imageScale;
  @override
  @JsonKey()
  final double pdfQuality;
  @override
  @JsonKey()
  final PlatformTheme platformTheme;
  final List<int> _recentColors;
  @override
  @JsonKey()
  List<int> get recentColors {
    if (_recentColors is EqualUnmodifiableListView) return _recentColors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentColors);
  }

  final List<String> _flags;
  @override
  @JsonKey()
  List<String> get flags {
    if (_flags is EqualUnmodifiableListView) return _flags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_flags);
  }

  @override
  @JsonKey()
  final bool spreadPages;
  @override
  @JsonKey()
  final bool highContrast;
  @override
  @JsonKey()
  final bool gridView;
  @override
  @JsonKey()
  final bool autosave;
  @override
  @JsonKey()
  final int toolbarRows;
  @override
  @JsonKey()
  final bool hideCursorWhileDrawing;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ButterflySettings(theme: $theme, density: $density, localeTag: $localeTag, documentPath: $documentPath, touchSensitivity: $touchSensitivity, mouseSensitivity: $mouseSensitivity, penSensitivity: $penSensitivity, selectSensitivity: $selectSensitivity, penOnlyInput: $penOnlyInput, inputGestures: $inputGestures, design: $design, bannerVisibility: $bannerVisibility, history: $history, navigatorEnabled: $navigatorEnabled, zoomEnabled: $zoomEnabled, lastVersion: $lastVersion, connections: $connections, defaultRemote: $defaultRemote, nativeTitleBar: $nativeTitleBar, startInFullScreen: $startInFullScreen, navigationRail: $navigationRail, syncMode: $syncMode, inputConfiguration: $inputConfiguration, fallbackPack: $fallbackPack, starred: $starred, defaultTemplate: $defaultTemplate, navigatorPage: $navigatorPage, navigatorPosition: $navigatorPosition, toolbarPosition: $toolbarPosition, toolbarSize: $toolbarSize, sortBy: $sortBy, sortOrder: $sortOrder, imageScale: $imageScale, pdfQuality: $pdfQuality, platformTheme: $platformTheme, recentColors: $recentColors, flags: $flags, spreadPages: $spreadPages, highContrast: $highContrast, gridView: $gridView, autosave: $autosave, toolbarRows: $toolbarRows, hideCursorWhileDrawing: $hideCursorWhileDrawing)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ButterflySettings'))
      ..add(DiagnosticsProperty('theme', theme))
      ..add(DiagnosticsProperty('density', density))
      ..add(DiagnosticsProperty('localeTag', localeTag))
      ..add(DiagnosticsProperty('documentPath', documentPath))
      ..add(DiagnosticsProperty('touchSensitivity', touchSensitivity))
      ..add(DiagnosticsProperty('mouseSensitivity', mouseSensitivity))
      ..add(DiagnosticsProperty('penSensitivity', penSensitivity))
      ..add(DiagnosticsProperty('selectSensitivity', selectSensitivity))
      ..add(DiagnosticsProperty('penOnlyInput', penOnlyInput))
      ..add(DiagnosticsProperty('inputGestures', inputGestures))
      ..add(DiagnosticsProperty('design', design))
      ..add(DiagnosticsProperty('bannerVisibility', bannerVisibility))
      ..add(DiagnosticsProperty('history', history))
      ..add(DiagnosticsProperty('navigatorEnabled', navigatorEnabled))
      ..add(DiagnosticsProperty('zoomEnabled', zoomEnabled))
      ..add(DiagnosticsProperty('lastVersion', lastVersion))
      ..add(DiagnosticsProperty('connections', connections))
      ..add(DiagnosticsProperty('defaultRemote', defaultRemote))
      ..add(DiagnosticsProperty('nativeTitleBar', nativeTitleBar))
      ..add(DiagnosticsProperty('startInFullScreen', startInFullScreen))
      ..add(DiagnosticsProperty('navigationRail', navigationRail))
      ..add(DiagnosticsProperty('syncMode', syncMode))
      ..add(DiagnosticsProperty('inputConfiguration', inputConfiguration))
      ..add(DiagnosticsProperty('fallbackPack', fallbackPack))
      ..add(DiagnosticsProperty('starred', starred))
      ..add(DiagnosticsProperty('defaultTemplate', defaultTemplate))
      ..add(DiagnosticsProperty('navigatorPage', navigatorPage))
      ..add(DiagnosticsProperty('navigatorPosition', navigatorPosition))
      ..add(DiagnosticsProperty('toolbarPosition', toolbarPosition))
      ..add(DiagnosticsProperty('toolbarSize', toolbarSize))
      ..add(DiagnosticsProperty('sortBy', sortBy))
      ..add(DiagnosticsProperty('sortOrder', sortOrder))
      ..add(DiagnosticsProperty('imageScale', imageScale))
      ..add(DiagnosticsProperty('pdfQuality', pdfQuality))
      ..add(DiagnosticsProperty('platformTheme', platformTheme))
      ..add(DiagnosticsProperty('recentColors', recentColors))
      ..add(DiagnosticsProperty('flags', flags))
      ..add(DiagnosticsProperty('spreadPages', spreadPages))
      ..add(DiagnosticsProperty('highContrast', highContrast))
      ..add(DiagnosticsProperty('gridView', gridView))
      ..add(DiagnosticsProperty('autosave', autosave))
      ..add(DiagnosticsProperty('toolbarRows', toolbarRows))
      ..add(DiagnosticsProperty(
          'hideCursorWhileDrawing', hideCursorWhileDrawing));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ButterflySettingsImpl &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.density, density) || other.density == density) &&
            (identical(other.localeTag, localeTag) ||
                other.localeTag == localeTag) &&
            (identical(other.documentPath, documentPath) ||
                other.documentPath == documentPath) &&
            (identical(other.touchSensitivity, touchSensitivity) ||
                other.touchSensitivity == touchSensitivity) &&
            (identical(other.mouseSensitivity, mouseSensitivity) ||
                other.mouseSensitivity == mouseSensitivity) &&
            (identical(other.penSensitivity, penSensitivity) ||
                other.penSensitivity == penSensitivity) &&
            (identical(other.selectSensitivity, selectSensitivity) ||
                other.selectSensitivity == selectSensitivity) &&
            (identical(other.penOnlyInput, penOnlyInput) ||
                other.penOnlyInput == penOnlyInput) &&
            (identical(other.inputGestures, inputGestures) ||
                other.inputGestures == inputGestures) &&
            (identical(other.design, design) || other.design == design) &&
            (identical(other.bannerVisibility, bannerVisibility) ||
                other.bannerVisibility == bannerVisibility) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            (identical(other.navigatorEnabled, navigatorEnabled) ||
                other.navigatorEnabled == navigatorEnabled) &&
            (identical(other.zoomEnabled, zoomEnabled) ||
                other.zoomEnabled == zoomEnabled) &&
            (identical(other.lastVersion, lastVersion) ||
                other.lastVersion == lastVersion) &&
            const DeepCollectionEquality()
                .equals(other._connections, _connections) &&
            (identical(other.defaultRemote, defaultRemote) ||
                other.defaultRemote == defaultRemote) &&
            (identical(other.nativeTitleBar, nativeTitleBar) ||
                other.nativeTitleBar == nativeTitleBar) &&
            (identical(other.startInFullScreen, startInFullScreen) ||
                other.startInFullScreen == startInFullScreen) &&
            (identical(other.navigationRail, navigationRail) ||
                other.navigationRail == navigationRail) &&
            (identical(other.syncMode, syncMode) ||
                other.syncMode == syncMode) &&
            (identical(other.inputConfiguration, inputConfiguration) ||
                other.inputConfiguration == inputConfiguration) &&
            (identical(other.fallbackPack, fallbackPack) ||
                other.fallbackPack == fallbackPack) &&
            const DeepCollectionEquality().equals(other._starred, _starred) &&
            (identical(other.defaultTemplate, defaultTemplate) ||
                other.defaultTemplate == defaultTemplate) &&
            (identical(other.navigatorPage, navigatorPage) ||
                other.navigatorPage == navigatorPage) &&
            (identical(other.navigatorPosition, navigatorPosition) ||
                other.navigatorPosition == navigatorPosition) &&
            (identical(other.toolbarPosition, toolbarPosition) ||
                other.toolbarPosition == toolbarPosition) &&
            (identical(other.toolbarSize, toolbarSize) ||
                other.toolbarSize == toolbarSize) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.imageScale, imageScale) ||
                other.imageScale == imageScale) &&
            (identical(other.pdfQuality, pdfQuality) ||
                other.pdfQuality == pdfQuality) &&
            (identical(other.platformTheme, platformTheme) ||
                other.platformTheme == platformTheme) &&
            const DeepCollectionEquality()
                .equals(other._recentColors, _recentColors) &&
            const DeepCollectionEquality().equals(other._flags, _flags) &&
            (identical(other.spreadPages, spreadPages) ||
                other.spreadPages == spreadPages) &&
            (identical(other.highContrast, highContrast) ||
                other.highContrast == highContrast) &&
            (identical(other.gridView, gridView) ||
                other.gridView == gridView) &&
            (identical(other.autosave, autosave) ||
                other.autosave == autosave) &&
            (identical(other.toolbarRows, toolbarRows) ||
                other.toolbarRows == toolbarRows) &&
            (identical(other.hideCursorWhileDrawing, hideCursorWhileDrawing) ||
                other.hideCursorWhileDrawing == hideCursorWhileDrawing));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        theme,
        density,
        localeTag,
        documentPath,
        touchSensitivity,
        mouseSensitivity,
        penSensitivity,
        selectSensitivity,
        penOnlyInput,
        inputGestures,
        design,
        bannerVisibility,
        const DeepCollectionEquality().hash(_history),
        navigatorEnabled,
        zoomEnabled,
        lastVersion,
        const DeepCollectionEquality().hash(_connections),
        defaultRemote,
        nativeTitleBar,
        startInFullScreen,
        navigationRail,
        syncMode,
        inputConfiguration,
        fallbackPack,
        const DeepCollectionEquality().hash(_starred),
        defaultTemplate,
        navigatorPage,
        navigatorPosition,
        toolbarPosition,
        toolbarSize,
        sortBy,
        sortOrder,
        imageScale,
        pdfQuality,
        platformTheme,
        const DeepCollectionEquality().hash(_recentColors),
        const DeepCollectionEquality().hash(_flags),
        spreadPages,
        highContrast,
        gridView,
        autosave,
        toolbarRows,
        hideCursorWhileDrawing
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ButterflySettingsImplCopyWith<_$ButterflySettingsImpl> get copyWith =>
      __$$ButterflySettingsImplCopyWithImpl<_$ButterflySettingsImpl>(
          this, _$identity);
}

abstract class _ButterflySettings extends ButterflySettings {
  const factory _ButterflySettings(
      {final ThemeMode theme,
      final ThemeDensity density,
      final String localeTag,
      final String documentPath,
      final double touchSensitivity,
      final double mouseSensitivity,
      final double penSensitivity,
      final double selectSensitivity,
      final bool penOnlyInput,
      final bool inputGestures,
      final String design,
      final BannerVisibility bannerVisibility,
      final List<AssetLocation> history,
      final bool navigatorEnabled,
      final bool zoomEnabled,
      final String? lastVersion,
      final List<ExternalStorage> connections,
      final String defaultRemote,
      final bool nativeTitleBar,
      final bool startInFullScreen,
      final bool navigationRail,
      final SyncMode syncMode,
      final InputConfiguration inputConfiguration,
      final String fallbackPack,
      final List<String> starred,
      final String defaultTemplate,
      final NavigatorPage navigatorPage,
      final NavigatorPosition navigatorPosition,
      final ToolbarPosition toolbarPosition,
      final ToolbarSize toolbarSize,
      final SortBy sortBy,
      final SortOrder sortOrder,
      final double imageScale,
      final double pdfQuality,
      final PlatformTheme platformTheme,
      final List<int> recentColors,
      final List<String> flags,
      final bool spreadPages,
      final bool highContrast,
      final bool gridView,
      final bool autosave,
      final int toolbarRows,
      final bool hideCursorWhileDrawing}) = _$ButterflySettingsImpl;
  const _ButterflySettings._() : super._();

  @override
  ThemeMode get theme;
  @override
  ThemeDensity get density;
  @override
  String get localeTag;
  @override
  String get documentPath;
  @override
  double get touchSensitivity;
  @override
  double get mouseSensitivity;
  @override
  double get penSensitivity;
  @override
  double get selectSensitivity;
  @override
  bool get penOnlyInput;
  @override
  bool get inputGestures;
  @override
  String get design;
  @override
  BannerVisibility get bannerVisibility;
  @override
  List<AssetLocation> get history;
  @override
  bool get navigatorEnabled;
  @override
  bool get zoomEnabled;
  @override
  String? get lastVersion;
  @override
  List<ExternalStorage> get connections;
  @override
  String get defaultRemote;
  @override
  bool get nativeTitleBar;
  @override
  bool get startInFullScreen;
  @override
  bool get navigationRail;
  @override
  SyncMode get syncMode;
  @override
  InputConfiguration get inputConfiguration;
  @override
  String get fallbackPack;
  @override
  List<String> get starred;
  @override
  String get defaultTemplate;
  @override
  NavigatorPage get navigatorPage;
  @override
  NavigatorPosition get navigatorPosition;
  @override
  ToolbarPosition get toolbarPosition;
  @override
  ToolbarSize get toolbarSize;
  @override
  SortBy get sortBy;
  @override
  SortOrder get sortOrder;
  @override
  double get imageScale;
  @override
  double get pdfQuality;
  @override
  PlatformTheme get platformTheme;
  @override
  List<int> get recentColors;
  @override
  List<String> get flags;
  @override
  bool get spreadPages;
  @override
  bool get highContrast;
  @override
  bool get gridView;
  @override
  bool get autosave;
  @override
  int get toolbarRows;
  @override
  bool get hideCursorWhileDrawing;
  @override
  @JsonKey(ignore: true)
  _$$ButterflySettingsImplCopyWith<_$ButterflySettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
