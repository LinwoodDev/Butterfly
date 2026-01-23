// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FavoriteLocation _$FavoriteLocationFromJson(Map json) => _FavoriteLocation(
  remote: json['remote'] as String?,
  path: json['path'] as String,
);

Map<String, dynamic> _$FavoriteLocationToJson(_FavoriteLocation instance) =>
    <String, dynamic>{'remote': instance.remote, 'path': instance.path};

_InputConfiguration _$InputConfigurationFromJson(Map json) =>
    _InputConfiguration(
      leftMouse: json['leftMouse'] == null
          ? InputMappingDefault.leftMouse
          : InputMapping.fromJson((json['leftMouse'] as num).toInt()),
      middleMouse: json['middleMouse'] == null
          ? InputMappingDefault.middleMouse
          : InputMapping.fromJson((json['middleMouse'] as num).toInt()),
      rightMouse: json['rightMouse'] == null
          ? InputMappingDefault.rightMouse
          : InputMapping.fromJson((json['rightMouse'] as num).toInt()),
      pen: json['pen'] == null
          ? InputMappingDefault.pen
          : InputMapping.fromJson((json['pen'] as num).toInt()),
      invertedPen: json['invertedPen'] == null
          ? InputMappingDefault.invertedPen
          : InputMapping.fromJson((json['invertedPen'] as num).toInt()),
      firstPenButton: json['firstPenButton'] == null
          ? InputMappingDefault.firstPenButton
          : InputMapping.fromJson((json['firstPenButton'] as num).toInt()),
      secondPenButton: json['secondPenButton'] == null
          ? InputMappingDefault.secondPenButton
          : InputMapping.fromJson((json['secondPenButton'] as num).toInt()),
      touch: json['touch'] == null
          ? InputMappingDefault.touch
          : InputMapping.fromJson((json['touch'] as num).toInt()),
    );

Map<String, dynamic> _$InputConfigurationToJson(_InputConfiguration instance) =>
    <String, dynamic>{
      'leftMouse': instance.leftMouse.toJson(),
      'middleMouse': instance.middleMouse.toJson(),
      'rightMouse': instance.rightMouse.toJson(),
      'pen': instance.pen.toJson(),
      'invertedPen': instance.invertedPen.toJson(),
      'firstPenButton': instance.firstPenButton.toJson(),
      'secondPenButton': instance.secondPenButton.toJson(),
      'touch': instance.touch.toJson(),
    };

_ButterflySettings _$ButterflySettingsFromJson(Map json) => _ButterflySettings(
  theme:
      $enumDecodeNullable(_$ThemeModeEnumMap, json['theme']) ??
      ThemeMode.system,
  density:
      $enumDecodeNullable(_$ThemeDensityEnumMap, json['density']) ??
      ThemeDensity.system,
  localeTag: json['localeTag'] as String? ?? '',
  documentPath: json['documentPath'] as String? ?? '',
  gestureSensitivity: (json['gestureSensitivity'] as num?)?.toDouble() ?? 1,
  touchSensitivity: (json['touchSensitivity'] as num?)?.toDouble() ?? 1,
  selectSensitivity: (json['selectSensitivity'] as num?)?.toDouble() ?? 1,
  scrollSensitivity: (json['scrollSensitivity'] as num?)?.toDouble() ?? 1,
  penOnlyInput: json['penOnlyInput'] as bool?,
  showPenOnlyToggle: json['showPenOnlyToggle'] as bool? ?? true,
  inputGestures: json['inputGestures'] as bool? ?? true,
  design: json['design'] as String? ?? '',
  bannerVisibility:
      $enumDecodeNullable(
        _$BannerVisibilityEnumMap,
        json['bannerVisibility'],
      ) ??
      BannerVisibility.always,
  zoomEnabled: json['zoomEnabled'] as bool? ?? true,
  lastVersion: json['lastVersion'] as String?,
  defaultRemote: json['defaultRemote'] as String? ?? '',
  nativeTitleBar: json['nativeTitleBar'] as bool? ?? false,
  startInFullScreen: json['startInFullScreen'] as bool? ?? false,
  navigationRail: json['navigationRail'] as bool? ?? true,
  ignorePressure:
      $enumDecodeNullable(_$IgnorePressureEnumMap, json['ignorePressure']) ??
      IgnorePressure.first,
  syncMode:
      $enumDecodeNullable(_$SyncModeEnumMap, json['syncMode']) ??
      SyncMode.noMobile,
  inputConfiguration: json['inputConfiguration'] == null
      ? const InputConfiguration()
      : InputConfiguration.fromJson(
          Map<String, dynamic>.from(json['inputConfiguration'] as Map),
        ),
  fallbackPack: json['fallbackPack'] as String? ?? '',
  starred:
      (json['starred'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  defaultTemplate: json['defaultTemplate'] as String? ?? '',
  navigatorPosition:
      $enumDecodeNullable(
        _$NavigatorPositionEnumMap,
        json['navigatorPosition'],
      ) ??
      NavigatorPosition.left,
  toolbarPosition:
      $enumDecodeNullable(_$ToolbarPositionEnumMap, json['toolbarPosition']) ??
      ToolbarPosition.inline,
  toolbarSize:
      $enumDecodeNullable(_$ToolbarSizeEnumMap, json['toolbarSize']) ??
      ToolbarSize.normal,
  sortBy:
      $enumDecodeNullable(_$SortByEnumMap, json['sortBy']) ?? SortBy.modified,
  sortOrder:
      $enumDecodeNullable(_$SortOrderEnumMap, json['sortOrder']) ??
      SortOrder.descending,
  imageScale: (json['imageScale'] as num?)?.toDouble() ?? 0.5,
  pdfQuality: (json['pdfQuality'] as num?)?.toDouble() ?? 2,
  platformTheme:
      $enumDecodeNullable(_$PlatformThemeEnumMap, json['platformTheme']) ??
      PlatformTheme.system,
  recentColors:
      (json['recentColors'] as List<dynamic>?)
          ?.map((e) => const SRGBConverter().fromJson((e as num).toInt()))
          .toList() ??
      const [],
  flags:
      (json['flags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  spreadPages: json['spreadPages'] as bool? ?? false,
  highContrast: json['highContrast'] as bool? ?? false,
  gridView: json['gridView'] as bool? ?? false,
  autosave: json['autosave'] as bool? ?? true,
  showSaveButton: json['showSaveButton'] as bool? ?? true,
  toolbarRows: (json['toolbarRows'] as num?)?.toInt() ?? 1,
  delayedAutosave: json['delayedAutosave'] as bool? ?? true,
  autosaveDelaySeconds: (json['autosaveDelaySeconds'] as num?)?.toInt() ?? 3,
  hideCursorWhileDrawing: json['hideCursorWhileDrawing'] as bool? ?? false,
  utilities: json['utilities'] == null
      ? const UtilitiesState()
      : UtilitiesState.fromJson(
          Map<String, dynamic>.from(json['utilities'] as Map),
        ),
  onStartup:
      $enumDecodeNullable(_$StartupBehaviorEnumMap, json['onStartup']) ??
      StartupBehavior.openHomeScreen,
  simpleToolbarVisibility:
      $enumDecodeNullable(
        _$SimpleToolbarVisibilityEnumMap,
        json['simpleToolbarVisibility'],
      ) ??
      SimpleToolbarVisibility.show,
  optionsPanelPosition:
      $enumDecodeNullable(
        _$OptionsPanelPositionEnumMap,
        json['optionsPanelPosition'],
      ) ??
      OptionsPanelPosition.top,
  renderResolution:
      $enumDecodeNullable(
        _$RenderResolutionEnumMap,
        json['renderResolution'],
      ) ??
      RenderResolution.normal,
  moveOnGesture: json['moveOnGesture'] as bool? ?? true,
  swamps:
      (json['swamps'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  selectedPalette: json['selectedPalette'] == null
      ? null
      : PackAssetLocation.fromJson(
          Map<String, dynamic>.from(json['selectedPalette'] as Map),
        ),
  showVerboseLogs: json['showVerboseLogs'] as bool? ?? false,
);

Map<String, dynamic> _$ButterflySettingsToJson(
  _ButterflySettings instance,
) => <String, dynamic>{
  'theme': _$ThemeModeEnumMap[instance.theme]!,
  'density': _$ThemeDensityEnumMap[instance.density]!,
  'localeTag': instance.localeTag,
  'documentPath': instance.documentPath,
  'gestureSensitivity': instance.gestureSensitivity,
  'touchSensitivity': instance.touchSensitivity,
  'selectSensitivity': instance.selectSensitivity,
  'scrollSensitivity': instance.scrollSensitivity,
  'penOnlyInput': instance.penOnlyInput,
  'showPenOnlyToggle': instance.showPenOnlyToggle,
  'inputGestures': instance.inputGestures,
  'design': instance.design,
  'bannerVisibility': _$BannerVisibilityEnumMap[instance.bannerVisibility]!,
  'zoomEnabled': instance.zoomEnabled,
  'lastVersion': instance.lastVersion,
  'defaultRemote': instance.defaultRemote,
  'nativeTitleBar': instance.nativeTitleBar,
  'startInFullScreen': instance.startInFullScreen,
  'navigationRail': instance.navigationRail,
  'ignorePressure': _$IgnorePressureEnumMap[instance.ignorePressure]!,
  'syncMode': _$SyncModeEnumMap[instance.syncMode]!,
  'inputConfiguration': instance.inputConfiguration.toJson(),
  'fallbackPack': instance.fallbackPack,
  'starred': instance.starred,
  'defaultTemplate': instance.defaultTemplate,
  'navigatorPosition': _$NavigatorPositionEnumMap[instance.navigatorPosition]!,
  'toolbarPosition': _$ToolbarPositionEnumMap[instance.toolbarPosition]!,
  'toolbarSize': _$ToolbarSizeEnumMap[instance.toolbarSize]!,
  'sortBy': _$SortByEnumMap[instance.sortBy]!,
  'sortOrder': _$SortOrderEnumMap[instance.sortOrder]!,
  'imageScale': instance.imageScale,
  'pdfQuality': instance.pdfQuality,
  'platformTheme': _$PlatformThemeEnumMap[instance.platformTheme]!,
  'recentColors': instance.recentColors
      .map(const SRGBConverter().toJson)
      .toList(),
  'flags': instance.flags,
  'spreadPages': instance.spreadPages,
  'highContrast': instance.highContrast,
  'gridView': instance.gridView,
  'autosave': instance.autosave,
  'showSaveButton': instance.showSaveButton,
  'toolbarRows': instance.toolbarRows,
  'delayedAutosave': instance.delayedAutosave,
  'autosaveDelaySeconds': instance.autosaveDelaySeconds,
  'hideCursorWhileDrawing': instance.hideCursorWhileDrawing,
  'utilities': instance.utilities.toJson(),
  'onStartup': _$StartupBehaviorEnumMap[instance.onStartup]!,
  'simpleToolbarVisibility':
      _$SimpleToolbarVisibilityEnumMap[instance.simpleToolbarVisibility]!,
  'optionsPanelPosition':
      _$OptionsPanelPositionEnumMap[instance.optionsPanelPosition]!,
  'renderResolution': _$RenderResolutionEnumMap[instance.renderResolution]!,
  'moveOnGesture': instance.moveOnGesture,
  'swamps': instance.swamps,
  'selectedPalette': instance.selectedPalette?.toJson(),
  'showVerboseLogs': instance.showVerboseLogs,
};

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$ThemeDensityEnumMap = {
  ThemeDensity.system: 'system',
  ThemeDensity.maximize: 'maximize',
  ThemeDensity.desktop: 'desktop',
  ThemeDensity.compact: 'compact',
  ThemeDensity.comfortable: 'comfortable',
  ThemeDensity.standard: 'standard',
};

const _$BannerVisibilityEnumMap = {
  BannerVisibility.always: 'always',
  BannerVisibility.never: 'never',
  BannerVisibility.onlyOnUpdates: 'onlyOnUpdates',
};

const _$IgnorePressureEnumMap = {
  IgnorePressure.never: 'never',
  IgnorePressure.first: 'first',
  IgnorePressure.always: 'always',
};

const _$SyncModeEnumMap = {
  SyncMode.always: 'always',
  SyncMode.noMobile: 'noMobile',
  SyncMode.manual: 'manual',
};

const _$NavigatorPositionEnumMap = {
  NavigatorPosition.left: 'left',
  NavigatorPosition.right: 'right',
};

const _$ToolbarPositionEnumMap = {
  ToolbarPosition.inline: 'inline',
  ToolbarPosition.top: 'top',
  ToolbarPosition.bottom: 'bottom',
  ToolbarPosition.left: 'left',
  ToolbarPosition.right: 'right',
};

const _$ToolbarSizeEnumMap = {
  ToolbarSize.tiny: 'tiny',
  ToolbarSize.small: 'small',
  ToolbarSize.compact: 'compact',
  ToolbarSize.normal: 'normal',
  ToolbarSize.medium: 'medium',
  ToolbarSize.large: 'large',
};

const _$SortByEnumMap = {
  SortBy.name: 'name',
  SortBy.created: 'created',
  SortBy.modified: 'modified',
};

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ascending',
  SortOrder.descending: 'descending',
};

const _$PlatformThemeEnumMap = {
  PlatformTheme.system: 'system',
  PlatformTheme.mobile: 'mobile',
  PlatformTheme.desktop: 'desktop',
};

const _$StartupBehaviorEnumMap = {
  StartupBehavior.openHomeScreen: 'openHomeScreen',
  StartupBehavior.openLastNote: 'openLastNote',
  StartupBehavior.openNewNote: 'openNewNote',
};

const _$SimpleToolbarVisibilityEnumMap = {
  SimpleToolbarVisibility.show: 'show',
  SimpleToolbarVisibility.temporary: 'temporary',
  SimpleToolbarVisibility.hide: 'hide',
};

const _$OptionsPanelPositionEnumMap = {
  OptionsPanelPosition.top: 'top',
  OptionsPanelPosition.bottom: 'bottom',
};

const _$RenderResolutionEnumMap = {
  RenderResolution.performance: 'performance',
  RenderResolution.normal: 'normal',
  RenderResolution.high: 'high',
};
