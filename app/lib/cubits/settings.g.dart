// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InputConfiguration _$InputConfigurationFromJson(Map json) =>
    _InputConfiguration(
      leftMouse: (json['leftMouse'] as num?)?.toInt() ?? null,
      middleMouse: (json['middleMouse'] as num?)?.toInt() ?? -1,
      rightMouse: (json['rightMouse'] as num?)?.toInt() ?? 1,
      pen: json['pen'] == null
          ? null
          : InputMapping.fromJson((json['pen'] as num?)?.toInt()),
      firstPenButton: (json['firstPenButton'] as num?)?.toInt() ?? 2,
      secondPenButton: (json['secondPenButton'] as num?)?.toInt() ?? 1,
      touch: (json['touch'] as num?)?.toInt() ?? null,
    );

Map<String, dynamic> _$InputConfigurationToJson(_InputConfiguration instance) =>
    <String, dynamic>{
      'leftMouse': instance.leftMouse,
      'middleMouse': instance.middleMouse,
      'rightMouse': instance.rightMouse,
      'pen': instance.pen?.toJson(),
      'firstPenButton': instance.firstPenButton,
      'secondPenButton': instance.secondPenButton,
      'touch': instance.touch,
    };

_ButterflySettings _$ButterflySettingsFromJson(Map json) => _ButterflySettings(
      theme: $enumDecodeNullable(_$ThemeModeEnumMap, json['theme']) ??
          ThemeMode.system,
      density: $enumDecodeNullable(_$ThemeDensityEnumMap, json['density']) ??
          ThemeDensity.system,
      localeTag: json['localeTag'] as String? ?? '',
      documentPath: json['documentPath'] as String? ?? '',
      gestureSensitivity: (json['gestureSensitivity'] as num?)?.toDouble() ?? 1,
      touchSensitivity: (json['touchSensitivity'] as num?)?.toDouble() ?? 1,
      selectSensitivity: (json['selectSensitivity'] as num?)?.toDouble() ?? 1,
      scrollSensitivity: (json['scrollSensitivity'] as num?)?.toDouble() ?? 1,
      penOnlyInput: json['penOnlyInput'] as bool? ?? false,
      inputGestures: json['inputGestures'] as bool? ?? true,
      design: json['design'] as String? ?? '',
      bannerVisibility: $enumDecodeNullable(
              _$BannerVisibilityEnumMap, json['bannerVisibility']) ??
          BannerVisibility.always,
      zoomEnabled: json['zoomEnabled'] as bool? ?? true,
      lastVersion: json['lastVersion'] as String?,
      defaultRemote: json['defaultRemote'] as String? ?? '',
      nativeTitleBar: json['nativeTitleBar'] as bool? ?? false,
      startInFullScreen: json['startInFullScreen'] as bool? ?? false,
      navigationRail: json['navigationRail'] as bool? ?? true,
      syncMode: $enumDecodeNullable(_$SyncModeEnumMap, json['syncMode']) ??
          SyncMode.noMobile,
      inputConfiguration: json['inputConfiguration'] == null
          ? const InputConfiguration()
          : InputConfiguration.fromJson(
              Map<String, dynamic>.from(json['inputConfiguration'] as Map)),
      fallbackPack: json['fallbackPack'] as String? ?? '',
      starred: (json['starred'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      defaultTemplate: json['defaultTemplate'] as String? ?? '',
      navigatorPosition: $enumDecodeNullable(
              _$NavigatorPositionEnumMap, json['navigatorPosition']) ??
          NavigatorPosition.left,
      toolbarPosition: $enumDecodeNullable(
              _$ToolbarPositionEnumMap, json['toolbarPosition']) ??
          ToolbarPosition.inline,
      toolbarSize:
          $enumDecodeNullable(_$ToolbarSizeEnumMap, json['toolbarSize']) ??
              ToolbarSize.normal,
      sortBy: $enumDecodeNullable(_$SortByEnumMap, json['sortBy']) ??
          SortBy.modified,
      sortOrder: $enumDecodeNullable(_$SortOrderEnumMap, json['sortOrder']) ??
          SortOrder.descending,
      imageScale: (json['imageScale'] as num?)?.toDouble() ?? 0.5,
      pdfQuality: (json['pdfQuality'] as num?)?.toDouble() ?? 2,
      platformTheme:
          $enumDecodeNullable(_$PlatformThemeEnumMap, json['platformTheme']) ??
              PlatformTheme.system,
      recentColors: (json['recentColors'] as List<dynamic>?)
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
      hideCursorWhileDrawing: json['hideCursorWhileDrawing'] as bool? ?? false,
      utilities: json['utilities'] == null
          ? const UtilitiesState()
          : UtilitiesState.fromJson(
              Map<String, dynamic>.from(json['utilities'] as Map)),
      onStartup:
          $enumDecodeNullable(_$StartupBehaviorEnumMap, json['onStartup']) ??
              StartupBehavior.openHomeScreen,
      colorToolbarEnabled: json['colorToolbarEnabled'] as bool? ?? true,
      optionsPanelPosition: $enumDecodeNullable(
              _$OptionsPanelPositionEnumMap, json['optionsPanelPosition']) ??
          OptionsPanelPosition.top,
      renderResolution: $enumDecodeNullable(
              _$RenderResolutionEnumMap, json['renderResolution']) ??
          RenderResolution.normal,
      moveOnGesture: json['moveOnGesture'] as bool? ?? true,
      swamps: (json['swamps'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ButterflySettingsToJson(_ButterflySettings instance) =>
    <String, dynamic>{
      'theme': _$ThemeModeEnumMap[instance.theme]!,
      'density': _$ThemeDensityEnumMap[instance.density]!,
      'localeTag': instance.localeTag,
      'documentPath': instance.documentPath,
      'gestureSensitivity': instance.gestureSensitivity,
      'touchSensitivity': instance.touchSensitivity,
      'selectSensitivity': instance.selectSensitivity,
      'scrollSensitivity': instance.scrollSensitivity,
      'penOnlyInput': instance.penOnlyInput,
      'inputGestures': instance.inputGestures,
      'design': instance.design,
      'bannerVisibility': _$BannerVisibilityEnumMap[instance.bannerVisibility]!,
      'zoomEnabled': instance.zoomEnabled,
      'lastVersion': instance.lastVersion,
      'defaultRemote': instance.defaultRemote,
      'nativeTitleBar': instance.nativeTitleBar,
      'startInFullScreen': instance.startInFullScreen,
      'navigationRail': instance.navigationRail,
      'syncMode': _$SyncModeEnumMap[instance.syncMode]!,
      'inputConfiguration': instance.inputConfiguration.toJson(),
      'fallbackPack': instance.fallbackPack,
      'starred': instance.starred,
      'defaultTemplate': instance.defaultTemplate,
      'navigatorPosition':
          _$NavigatorPositionEnumMap[instance.navigatorPosition]!,
      'toolbarPosition': _$ToolbarPositionEnumMap[instance.toolbarPosition]!,
      'toolbarSize': _$ToolbarSizeEnumMap[instance.toolbarSize]!,
      'sortBy': _$SortByEnumMap[instance.sortBy]!,
      'sortOrder': _$SortOrderEnumMap[instance.sortOrder]!,
      'imageScale': instance.imageScale,
      'pdfQuality': instance.pdfQuality,
      'platformTheme': _$PlatformThemeEnumMap[instance.platformTheme]!,
      'recentColors':
          instance.recentColors.map(const SRGBConverter().toJson).toList(),
      'flags': instance.flags,
      'spreadPages': instance.spreadPages,
      'highContrast': instance.highContrast,
      'gridView': instance.gridView,
      'autosave': instance.autosave,
      'showSaveButton': instance.showSaveButton,
      'toolbarRows': instance.toolbarRows,
      'hideCursorWhileDrawing': instance.hideCursorWhileDrawing,
      'utilities': instance.utilities.toJson(),
      'onStartup': _$StartupBehaviorEnumMap[instance.onStartup]!,
      'colorToolbarEnabled': instance.colorToolbarEnabled,
      'optionsPanelPosition':
          _$OptionsPanelPositionEnumMap[instance.optionsPanelPosition]!,
      'renderResolution': _$RenderResolutionEnumMap[instance.renderResolution]!,
      'moveOnGesture': instance.moveOnGesture,
      'swamps': instance.swamps,
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

const _$OptionsPanelPositionEnumMap = {
  OptionsPanelPosition.top: 'top',
  OptionsPanelPosition.bottom: 'bottom',
};

const _$RenderResolutionEnumMap = {
  RenderResolution.performance: 'performance',
  RenderResolution.normal: 'normal',
  RenderResolution.high: 'high',
};
