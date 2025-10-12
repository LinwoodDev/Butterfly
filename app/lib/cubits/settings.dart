import 'dart:convert';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

const secureStorage = FlutterSecureStorage();
const kRecentHistorySize = 5;

enum ToolbarSize {
  tiny,
  small,
  compact,
  normal,
  medium,
  large;

  String getLocalizedName(BuildContext context) => switch (this) {
    ToolbarSize.tiny => AppLocalizations.of(context).tiny,
    ToolbarSize.small => AppLocalizations.of(context).small,
    ToolbarSize.compact => AppLocalizations.of(context).compact,
    ToolbarSize.normal => AppLocalizations.of(context).normal,
    ToolbarSize.medium => AppLocalizations.of(context).medium,
    ToolbarSize.large => AppLocalizations.of(context).large,
  };

  double get size => switch (this) {
    ToolbarSize.tiny => 45,
    ToolbarSize.small => 50,
    ToolbarSize.compact => 55,
    ToolbarSize.normal => 60,
    ToolbarSize.medium => 65,
    ToolbarSize.large => 70,
  };
}

enum RenderResolution {
  performance(1),
  normal(1.5),
  high(2);

  final double multiplier;

  const RenderResolution(this.multiplier);

  Rect getRect(Rect rect) {
    final width = (rect.width * multiplier).ceilToDouble();
    final height = (rect.height * multiplier).ceilToDouble();
    return Rect.fromCenter(center: rect.center, width: width, height: height);
  }
}

enum PlatformTheme {
  system,
  mobile,
  desktop;

  bool isMobile(BuildContext context) {
    final platform = Theme.of(context).platform;
    return switch (this) {
      PlatformTheme.mobile => true,
      PlatformTheme.desktop => false,
      PlatformTheme.system =>
        platform == TargetPlatform.iOS || platform == TargetPlatform.android,
    };
  }
}

enum SimpleToolbarVisibility {
  show,
  temporary,
  hide;

  String getLocalizedName(BuildContext context) => switch (this) {
    SimpleToolbarVisibility.show => AppLocalizations.of(context).show,
    SimpleToolbarVisibility.temporary => AppLocalizations.of(context).temporary,
    SimpleToolbarVisibility.hide => AppLocalizations.of(context).hide,
  };
}

enum SyncMode { always, noMobile, manual }

enum StartupBehavior { openHomeScreen, openLastNote, openNewNote }

enum InputMappingCategory { activeTool, handTool, toolOnToolbar }

class InputMappingDefault {
  static const InputMapping leftMouse = InputMapping(
    InputMapping.activeToolValue,
  );
  static const InputMapping middleMouse = InputMapping(
    InputMapping.handToolValue,
  );
  static const InputMapping rightMouse = InputMapping(1);
  static const InputMapping pen = InputMapping(InputMapping.activeToolValue);
  static const InputMapping invertedPen = InputMapping(3);
  static const InputMapping firstPenButton = InputMapping(2);
  static const InputMapping secondPenButton = InputMapping(1);
  static const InputMapping touch = InputMapping(InputMapping.activeToolValue);
}

extension type const InputMapping(int value) {
  static const int activeToolValue = -2;
  static const int handToolValue = -1;

  factory InputMapping.fromUIData(
    InputMappingCategory category, [
    int? toolNumber, // 1-indexed
  ]) {
    switch (category) {
      case InputMappingCategory.activeTool:
        return InputMapping(activeToolValue);
      case InputMappingCategory.handTool:
        return InputMapping(handToolValue);
      case InputMappingCategory.toolOnToolbar:
        return InputMapping(toolNumber?.clamp(1, 99).subtract(1) ?? 0);
    }
  }

  InputMappingCategory getCategory() {
    switch (value) {
      case activeToolValue:
        return InputMappingCategory.activeTool;
      case handToolValue:
        return InputMappingCategory.handTool;
      default:
        return InputMappingCategory.toolOnToolbar;
    }
  }

  // 0-indexed
  int? getToolPositionIndex() {
    return getCategory() == InputMappingCategory.toolOnToolbar ? value : null;
  }

  // 1-indexed, for displaying to the user
  int? getToolDisplayPosition() {
    return getCategory() == InputMappingCategory.toolOnToolbar
        ? value + 1
        : null;
  }

  String getDescription(BuildContext context) {
    switch (value) {
      case activeToolValue:
        return AppLocalizations.of(context).activeTool;
      case handToolValue:
        return AppLocalizations.of(context).handTool;
      default:
        return AppLocalizations.of(context).toolOnToolbarShort(value + 1);
    }
  }

  factory InputMapping.fromJson(int json) {
    return InputMapping(json);
  }

  int toJson() {
    return value;
  }
}

@freezed
sealed class InputConfiguration with _$InputConfiguration {
  const InputConfiguration._();

  const factory InputConfiguration({
    @Default(InputMappingDefault.leftMouse) InputMapping leftMouse,
    @Default(InputMappingDefault.middleMouse) InputMapping middleMouse,
    @Default(InputMappingDefault.rightMouse) InputMapping rightMouse,
    @Default(InputMappingDefault.pen) InputMapping pen,
    @Default(InputMappingDefault.invertedPen) InputMapping invertedPen,
    @Default(InputMappingDefault.firstPenButton) InputMapping firstPenButton,
    @Default(InputMappingDefault.secondPenButton) InputMapping secondPenButton,
    @Default(InputMappingDefault.touch) InputMapping touch,
  }) = _InputConfiguration;

  factory InputConfiguration.fromJson(Map<String, dynamic> json) =>
      _$InputConfigurationFromJson(json);

  Set<InputMapping> getShortcuts() => {
    leftMouse,
    middleMouse,
    rightMouse,
    pen,
    invertedPen,
    firstPenButton,
    secondPenButton,
    touch,
  }.toSet();
}

enum SortBy { name, created, modified }

enum SortOrder { ascending, descending }

enum BannerVisibility { always, never, onlyOnUpdates }

enum NavigatorPosition { left, right }

enum IgnorePressure { never, first, always }

enum ToolbarPosition {
  inline,
  top,
  bottom,
  left,
  right;

  String getLocalizedName(BuildContext context) => switch (this) {
    ToolbarPosition.inline => AppLocalizations.of(context).inline,
    ToolbarPosition.top => AppLocalizations.of(context).top,
    ToolbarPosition.bottom => AppLocalizations.of(context).bottom,
    ToolbarPosition.left => AppLocalizations.of(context).left,
    ToolbarPosition.right => AppLocalizations.of(context).right,
  };

  Axis get axis => switch (this) {
    ToolbarPosition.left => Axis.vertical,
    ToolbarPosition.right => Axis.vertical,
    ToolbarPosition.inline => Axis.horizontal,
    ToolbarPosition.top => Axis.horizontal,
    ToolbarPosition.bottom => Axis.horizontal,
  };
}

enum OptionsPanelPosition {
  top,
  bottom;

  String getLocalizedName(BuildContext context) => switch (this) {
    OptionsPanelPosition.top => AppLocalizations.of(context).top,
    OptionsPanelPosition.bottom => AppLocalizations.of(context).bottom,
  };
}

enum ThemeDensity {
  system,
  maximize,
  desktop,
  compact,
  comfortable,
  standard;

  VisualDensity toFlutter() => switch (this) {
    ThemeDensity.maximize => const VisualDensity(horizontal: -4, vertical: -4),
    ThemeDensity.desktop => const VisualDensity(horizontal: -3, vertical: -3),
    ThemeDensity.compact => VisualDensity.compact,
    ThemeDensity.comfortable => VisualDensity.comfortable,
    ThemeDensity.standard => VisualDensity.standard,
    ThemeDensity.system => VisualDensity.adaptivePlatformDensity,
  };
}

class SRGBConverter extends JsonConverter<SRGBColor, int> {
  const SRGBConverter();

  @override
  SRGBColor fromJson(int json) => SRGBColor(json);

  @override
  int toJson(SRGBColor object) => object.value;
}

enum SaveMethod { manual, autosave, delayedAutosave }

@freezed
sealed class ButterflySettings with _$ButterflySettings, LeapSettings {
  const ButterflySettings._();
  const factory ButterflySettings({
    @Default(ThemeMode.system) ThemeMode theme,
    @Default(ThemeDensity.system) ThemeDensity density,
    @Default('') String localeTag,
    @Default('') String documentPath,
    @Default(1) double gestureSensitivity,
    @Default(1) double touchSensitivity,
    @Default(1) double selectSensitivity,
    @Default(1) double scrollSensitivity,
    @Default(false) bool penOnlyInput,
    @Default(true) bool inputGestures,
    @Default('') String design,
    @Default(BannerVisibility.always) BannerVisibility bannerVisibility,
    @Default([])
    @JsonKey(includeFromJson: false, includeToJson: false)
    List<AssetLocation> history,
    @Default(true) bool zoomEnabled,
    String? lastVersion,
    @Default([])
    @JsonKey(includeFromJson: false, includeToJson: false)
    List<ExternalStorage> connections,
    @Default('') String defaultRemote,
    @Default(false) bool nativeTitleBar,
    @Default(false) bool startInFullScreen,
    @Default(true) bool navigationRail,
    @Default(IgnorePressure.first) IgnorePressure ignorePressure,
    @Default(SyncMode.noMobile) SyncMode syncMode,
    @Default(InputConfiguration()) InputConfiguration inputConfiguration,
    @Default('') String fallbackPack,
    @Default([]) List<String> starred,
    @Default('') String defaultTemplate,
    @Default(NavigatorPosition.left) NavigatorPosition navigatorPosition,
    @Default(ToolbarPosition.inline) ToolbarPosition toolbarPosition,
    @Default(ToolbarSize.normal) ToolbarSize toolbarSize,
    @Default(SortBy.modified) SortBy sortBy,
    @Default(SortOrder.descending) SortOrder sortOrder,
    @Default(0.5) double imageScale,
    @Default(2) double pdfQuality,
    @Default(PlatformTheme.system) PlatformTheme platformTheme,
    @Default([]) @SRGBConverter() List<SRGBColor> recentColors,
    @Default([]) List<String> flags,
    @Default(false) bool spreadPages,
    @Default(false) bool highContrast,
    @Default(false) bool gridView,
    @Default(true) bool autosave,
    @Default(true) bool showSaveButton,
    @Default(1) int toolbarRows,
    @Default(true) bool delayedAutosave,
    @Default(3) int autosaveDelaySeconds,
    @Default(false) bool hideCursorWhileDrawing,
    @Default(UtilitiesState()) UtilitiesState utilities,
    @Default(StartupBehavior.openHomeScreen) StartupBehavior onStartup,
    @Default(SimpleToolbarVisibility.show)
    SimpleToolbarVisibility simpleToolbarVisibility,
    @Default(OptionsPanelPosition.top)
    OptionsPanelPosition optionsPanelPosition,
    @Default(RenderResolution.normal) RenderResolution renderResolution,
    @Default(true) bool moveOnGesture,
    @Default([]) List<String> swamps,
  }) = _ButterflySettings;

  factory ButterflySettings.fromJson(Map<String, dynamic> json) =>
      _$ButterflySettingsFromJson(json);

  factory ButterflySettings.fromPrefs(SharedPreferences prefs) {
    final connections =
        prefs
            .getStringList('connections')
            ?.map((e) => ExternalStorageMapper.fromJson(e))
            .toList() ??
        const [];
    return ButterflySettings(
      localeTag: prefs.getString('locale') ?? '',
      penOnlyInput: prefs.getBool('pen_only_input') ?? false,
      inputGestures: prefs.getBool('input_gestures') ?? true,
      documentPath: prefs.getString('document_path') ?? '',
      theme: prefs.containsKey('theme_mode')
          ? ThemeMode.values.byName(prefs.getString('theme_mode')!)
          : ThemeMode.system,
      density: prefs.containsKey('theme_density')
          ? ThemeDensity.values.byName(prefs.getString('theme_density')!)
          : ThemeDensity.system,
      touchSensitivity: prefs.getDouble('touch_sensitivity') ?? 1,
      gestureSensitivity: prefs.getDouble('gesture_sensitivity') ?? 1,
      scrollSensitivity: prefs.getDouble('scroll_sensitivity') ?? 1,
      selectSensitivity: prefs.getDouble('select_sensitivity') ?? 1,
      design: prefs.getString('design') ?? '',
      bannerVisibility: prefs.containsKey('banner_visibility')
          ? BannerVisibility.values.byName(
              prefs.getString('banner_visibility')!,
            )
          : BannerVisibility.always,
      history:
          prefs
              .getStringList('history')
              ?.map((e) {
                // Try to parse the asset location
                try {
                  return AssetLocationMapper.fromJson(e);
                } catch (e) {
                  return null;
                }
              })
              .whereType<AssetLocation>()
              .toList() ??
          [],
      zoomEnabled: prefs.getBool('zoom_enabled') ?? true,
      lastVersion: prefs.getString('last_version'),
      connections: connections,
      defaultRemote: prefs.getString('default_remote') ?? '',
      nativeTitleBar: prefs.getBool('native_title_bar') ?? false,
      startInFullScreen: prefs.getBool('start_in_full_screen') ?? false,
      syncMode: SyncMode.values.byName(
        prefs.getString('sync_mode') ?? 'noMobile',
      ),
      inputConfiguration: InputConfiguration.fromJson(
        json.decode(prefs.getString('input_configuration') ?? '{}'),
      ),
      fallbackPack: prefs.getString('fallback_pack') ?? '',
      starred: prefs.getStringList('starred') ?? [],
      defaultTemplate: prefs.getString('default_template') ?? '',
      toolbarPosition: prefs.containsKey('toolbar_position')
          ? ToolbarPosition.values.byName(prefs.getString('toolbar_position')!)
          : ToolbarPosition.inline,
      navigationRail: prefs.getBool('navigation_rail') ?? true,
      sortBy: prefs.containsKey('sort_by')
          ? SortBy.values.byName(prefs.getString('sort_by')!)
          : SortBy.name,
      sortOrder: prefs.containsKey('sort_order')
          ? SortOrder.values.byName(prefs.getString('sort_order')!)
          : SortOrder.ascending,
      imageScale: prefs.getDouble('image_scale') ?? 0.5,
      pdfQuality: prefs.getDouble('pdf_quality') ?? 2,
      platformTheme: prefs.containsKey('platform_theme')
          ? PlatformTheme.values.byName(prefs.getString('platform_theme')!)
          : PlatformTheme.system,
      recentColors:
          prefs
              .getStringList('recent_colors')
              ?.map((e) => SRGBColor(int.parse(e)))
              .toList() ??
          [],
      flags: prefs.getStringList('flags') ?? [],
      spreadPages: prefs.getBool('spread_pages') ?? false,
      highContrast: prefs.getBool('high_contrast') ?? false,
      gridView: prefs.getBool('grid_view') ?? false,
      autosave: prefs.getBool('autosave') ?? true,
      delayedAutosave: prefs.getBool('delayed_autosave') ?? false,
      autosaveDelaySeconds: prefs.getInt('autosave_delay_seconds') ?? 5,
      toolbarSize: prefs.containsKey('toolbar_size')
          ? ToolbarSize.values.byName(prefs.getString('toolbar_size')!)
          : ToolbarSize.normal,
      toolbarRows: prefs.getInt('toolbar_rows') ?? 1,
      hideCursorWhileDrawing:
          prefs.getBool('hide_cursor_while_drawing') ?? false,
      navigatorPosition: prefs.containsKey('navigator_position')
          ? NavigatorPosition.values.byName(
              prefs.getString('navigator_position')!,
            )
          : NavigatorPosition.left,
      utilities: prefs.containsKey('utilities')
          ? UtilitiesState.fromJson(json.decode(prefs.getString('utilities')!))
          : const UtilitiesState(),
      onStartup: prefs.containsKey('on_startup')
          ? StartupBehavior.values.byName(prefs.getString('on_startup')!)
          : StartupBehavior.openHomeScreen,
      simpleToolbarVisibility: prefs.containsKey('simple_toolbar_visibility')
          ? SimpleToolbarVisibility.values.byName(
              prefs.getString('simple_toolbar_visibility')!,
            )
          : (prefs.getBool('color_toolbar_enabled') ?? true
                ? SimpleToolbarVisibility.show
                : SimpleToolbarVisibility.hide),
      showSaveButton: prefs.getBool('show_save_button') ?? true,
      optionsPanelPosition: prefs.containsKey('options_panel_position')
          ? OptionsPanelPosition.values.byName(
              prefs.getString('options_panel_position')!,
            )
          : OptionsPanelPosition.top,
      renderResolution: prefs.containsKey('render_resolution')
          ? RenderResolution.values.byName(
              prefs.getString('render_resolution')!,
            )
          : RenderResolution.normal,
      moveOnGesture: prefs.getBool('move_on_gesture') ?? true,
      swamps: prefs.getStringList('swamps') ?? [],
      ignorePressure: prefs.containsKey('ignore_pressure')
          ? IgnorePressure.values.byName(prefs.getString('ignore_pressure')!)
          : IgnorePressure.first,
    );
  }

  Locale? get locale {
    if (localeTag.isEmpty) {
      return null;
    }
    if (localeTag.contains('-')) {
      return Locale(localeTag.split('-')[0], localeTag.split('-')[1]);
    }
    return Locale(localeTag);
  }

  bool get isInline =>
      toolbarPosition == ToolbarPosition.inline && toolbarRows <= 1;

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', theme.name);
    await prefs.setString('theme_density', density.name);
    await prefs.setString('locale', localeTag);
    await prefs.setBool('pen_only_input', penOnlyInput);
    await prefs.setBool('input_gestures', inputGestures);
    await prefs.setString('document_path', documentPath);
    await prefs.setDouble('touch_sensitivity', touchSensitivity);
    await prefs.setDouble('gesture_sensitivity', gestureSensitivity);
    await prefs.setDouble('scroll_sensitivity', scrollSensitivity);
    await prefs.setDouble('select_sensitivity', selectSensitivity);
    await prefs.setString('design', design);
    await prefs.setString('banner_visibility', bannerVisibility.name);
    await prefs.setStringList(
      'history',
      history.map((e) => e.toJson()).toList(),
    );
    await prefs.setBool('zoom_enabled', zoomEnabled);
    if (lastVersion == null && prefs.containsKey('last_version')) {
      await prefs.remove('last_version');
    } else if (lastVersion != null) {
      await prefs.setString('last_version', lastVersion!);
    }
    await prefs.setStringList(
      'connections',
      connections.map((e) => e.toJson()).toList(),
    );
    await prefs.setString('default_remote', defaultRemote);
    await prefs.setBool('native_title_bar', nativeTitleBar);
    await prefs.setBool('start_in_full_screen', startInFullScreen);
    await prefs.setString('sync_mode', syncMode.name);
    await prefs.setString(
      'input_configuration',
      json.encode(inputConfiguration.toJson()),
    );
    await prefs.setString('fallback_pack', fallbackPack);
    await prefs.setStringList('starred', starred);
    await prefs.setInt('version', 0);
    await prefs.setString('default_template', defaultTemplate);
    await prefs.setString('toolbar_position', toolbarPosition.name);
    await prefs.setBool('navigation_rail', navigationRail);
    await prefs.setString('sort_by', sortBy.name);
    await prefs.setString('sort_order', sortOrder.name);
    await prefs.setDouble('image_scale', imageScale);
    await prefs.setDouble('pdf_quality', pdfQuality);
    await prefs.setString('platform_theme', platformTheme.name);
    await prefs.setStringList(
      'recent_colors',
      recentColors.map((e) => e.value.toString()).toList(),
    );
    await prefs.setStringList('flags', flags);
    await prefs.setBool('spread_pages', spreadPages);
    await prefs.setBool('high_contrast', highContrast);
    await prefs.setBool('grid_view', gridView);
    await prefs.setBool('autosave', autosave);
    await prefs.setBool('delayed_autosave', delayedAutosave);
    await prefs.setInt('autosave_delay_seconds', autosaveDelaySeconds);
    await prefs.setString('toolbar_size', toolbarSize.name);
    await prefs.setInt('toolbar_rows', toolbarRows);
    await prefs.setBool('hide_cursor_while_drawing', hideCursorWhileDrawing);
    await prefs.setString('navigator_position', navigatorPosition.name);
    await prefs.setString('utilities', json.encode(utilities.toJson()));
    await prefs.setString('on_startup', onStartup.name);
    await prefs.setString(
      'simple_toolbar_visibility',
      simpleToolbarVisibility.name,
    );
    await prefs.setBool('show_save_button', showSaveButton);
    await prefs.setString('options_panel_position', optionsPanelPosition.name);
    await prefs.setString('render_resolution', renderResolution.name);
    await prefs.setBool('move_on_gesture', moveOnGesture);
    await prefs.setStringList('swamps', swamps);
    await prefs.setString('ignore_pressure', ignorePressure.name);
  }

  ExternalStorage? getRemote(String? identifier) {
    if (identifier?.isEmpty ?? true) {
      return getDefaultRemote();
    }
    return connections.firstWhereOrNull(
      (e) => e.identifier == (identifier ?? defaultRemote),
    );
  }

  bool hasRemote(String identifier) {
    return connections.any((e) => e.identifier == identifier);
  }

  ExternalStorage? getDefaultRemote() {
    return connections.firstWhereOrNull((e) => e.identifier == defaultRemote);
  }

  bool isStarred(AssetLocation location) {
    if (location.remote.isEmpty) {
      return starred.contains(location.path);
    }
    return getRemote(location.remote)?.starred['']?.contains(location.path) ??
        false;
  }

  bool hasFlag(String s) => flags.contains(s);
}

class SettingsCubit extends Cubit<ButterflySettings>
    with LeapSettingsBlocBaseMixin {
  SettingsCubit(SharedPreferences prefs)
    : super(ButterflySettings.fromPrefs(prefs));

  void setTheme(MediaQueryData mediaQuery, [ThemeMode? theme]) {
    if (kIsWeb || !isWindow) return;
    final brightness = switch (theme ?? state.theme) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => mediaQuery.platformBrightness,
    };
    windowManager.setBrightness(brightness);
  }

  Future<void> changeTheme(ThemeMode theme, [MediaQueryData? modify]) async {
    if (modify != null) {
      setTheme(modify, theme);
    }
    emit(state.copyWith(theme: theme));
    return save();
  }

  Future<void> changeDensity(ThemeDensity density) async {
    emit(state.copyWith(density: density));
    return save();
  }

  Future<void> changeDesign(String design) async {
    emit(state.copyWith(design: design));
    return save();
  }

  Future<void> resetDesign() async {
    emit(state.copyWith(design: ''));
    return save();
  }

  Future<void> changeLocale(Locale? locale) {
    emit(state.copyWith(localeTag: locale?.toLanguageTag() ?? ''));
    return save();
  }

  Future<void> resetLocale() {
    emit(state.copyWith(localeTag: ''));
    return save();
  }

  Future<void> changeToolbarPosition(ToolbarPosition pos) {
    emit(state.copyWith(toolbarPosition: pos));
    return save();
  }

  Future<void> resetToolbarPosition() {
    emit(state.copyWith(toolbarPosition: ToolbarPosition.top));
    return save();
  }

  Future<void> changeToolbarSize(ToolbarSize size) {
    emit(state.copyWith(toolbarSize: size));
    return save();
  }

  Future<void> resetToolbarSize() => changeToolbarSize(ToolbarSize.normal);

  Future<void> changeOptionsPanelPosition(OptionsPanelPosition position) {
    emit(state.copyWith(optionsPanelPosition: position));
    return save();
  }

  Future<void> resetOptionsPanelPosition() =>
      changeOptionsPanelPosition(OptionsPanelPosition.top);

  void changeLocaleTemporarily(String locale) {
    emit(state.copyWith(localeTag: locale));
  }

  Future<void> changeDocumentPath(String documentPath) {
    emit(state.copyWith(documentPath: documentPath));
    return save();
  }

  Future<void> resetDocumentPath() {
    emit(state.copyWith(documentPath: ''));
    return save();
  }

  Future<void> changePenOnlyInput(bool penOnlyInput) {
    emit(state.copyWith(penOnlyInput: penOnlyInput));
    return save();
  }

  Future<void> resetPenOnlyInput() {
    emit(state.copyWith(penOnlyInput: false));
    return save();
  }

  Future<void> changeInputGestures(bool inputGestures) {
    emit(state.copyWith(inputGestures: inputGestures));
    return save();
  }

  Future<void> changeTouchSensitivity(double sensitivity) {
    emit(state.copyWith(touchSensitivity: sensitivity));
    return save();
  }

  Future<void> resetTouchSensitivity() => changeTouchSensitivity(1);

  Future<void> changeGestureSensitivity(double sensitivity) {
    emit(state.copyWith(gestureSensitivity: sensitivity));
    return save();
  }

  Future<void> resetGestureSensitivity() => changeGestureSensitivity(1);

  Future<void> changeScrollSensitivity(double sensitivity) {
    emit(state.copyWith(scrollSensitivity: sensitivity));
    return save();
  }

  Future<void> resetScrollSensitivity() => changeScrollSensitivity(1);

  Future<void> changeSelectSensitivity(double sensitivity) {
    emit(state.copyWith(selectSensitivity: sensitivity));
    return save();
  }

  Future<void> resetSelectSensitivity() => changeScrollSensitivity(1);

  Future<void> changeBannerVisibility(BannerVisibility visibility) {
    emit(state.copyWith(bannerVisibility: visibility));
    return save();
  }

  Future<void> addRecentHistory(AssetLocation location) async {
    final history = state.history.toList();
    if (!location.path.startsWith('/')) {
      location = AssetLocation(
        path: '/${location.path}',
        remote: location.remote,
      );
    }
    history.remove(location);
    history.insert(0, location);
    if (history.length > 10) {
      history.removeLast();
    }
    emit(state.copyWith(history: history));
    return save();
  }

  Future<void> removeRecentHistory(AssetLocation location) async {
    final history = state.history.toList();
    history.removeWhere(
      (element) =>
          element.remote == location.remote &&
          element.path.startsWith(location.path),
    );
    emit(state.copyWith(history: history));
    return save();
  }

  Future<void> resetRecentHistory() {
    emit(state.copyWith(history: []));
    return save();
  }

  Future<void> changeZoomEnabled(bool value) {
    emit(state.copyWith(zoomEnabled: value));
    return save();
  }

  Future<void> resetZoomEnabled() => changeZoomEnabled(true);

  Future<void> changeStartInFullScreen(bool value) {
    emit(state.copyWith(startInFullScreen: value));
    return save();
  }

  bool isFirstStart() {
    return state.lastVersion == null;
  }

  Future<bool> hasNewerVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version != state.lastVersion;
  }

  Future<void> updateLastVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    emit(state.copyWith(lastVersion: packageInfo.version));
    return save();
  }

  Future<void> save() => state.save();

  Future<void> addRemote(ExternalStorage storage, {required String password}) {
    emit(
      state.copyWith(
        connections: List.from(state.connections)
          ..removeWhere((element) => element.identifier == storage.identifier)
          ..add(storage),
      ),
    );
    if (storage is RemoteStorage) {
      passwordStorage.write(storage, password);
    }
    return save();
  }

  Future<void> deleteRemote(String identifier) async {
    emit(
      state.copyWith(
        connections: state.connections
            .where((r) => r.identifier != identifier)
            .toList(),
      ),
    );
    const FlutterSecureStorage().delete(key: 'connections/$identifier');
    return save();
  }

  Future<void> setDefaultRemote(String identifier) async {
    emit(state.copyWith(defaultRemote: identifier));
    return save();
  }

  Future<void> addCache(String identifier, String current) async {
    if (current.endsWith('/')) {
      current = current.substring(0, current.length - 1);
    }
    if (!current.startsWith('/')) {
      current = '/$current';
    }
    emit(
      state.copyWith(
        connections: List<ExternalStorage>.from(state.connections).map((e) {
          if (e.identifier == identifier && e is RemoteStorage) {
            final documents = List<String>.from(e.cachedDocuments[''] ?? []);
            return (e as dynamic).copyWith(
                  cachedDocuments: documents
                    ..removeWhere((element) => element == current)
                    ..add(current),
                )
                as ExternalStorage;
          }
          return e;
        }).toList(),
      ),
    );
    return save();
  }

  Future<void> removeCache(String identifier, String current) {
    emit(
      state.copyWith(
        connections: List<ExternalStorage>.from(state.connections).map((e) {
          if (e.identifier == identifier && e is RemoteStorage) {
            return (e as dynamic).copyWith(
                  cachedDocuments: List<String>.from(
                    e.cachedDocuments[''] ?? [],
                  )..remove(current),
                )
                as ExternalStorage;
          }
          return e;
        }).toList(),
      ),
    );
    return save();
  }

  Future<void> updateLastSynced(String identifier) {
    emit(
      state.copyWith(
        connections: List<ExternalStorage>.from(state.connections).map((e) {
          if (e.identifier == identifier && e is RemoteStorage) {
            return (e as dynamic).copyWith(lastSynced: DateTime.now().toUtc())
                as ExternalStorage;
          }
          return e;
        }).toList(),
      ),
    );
    return save();
  }

  Future<void> clearCaches(ExternalStorage storage) {
    emit(
      state.copyWith(
        connections: List<ExternalStorage>.from(state.connections).map((e) {
          if (e.identifier == storage.identifier && e is RemoteStorage) {
            return (e as dynamic).copyWith(cachedDocuments: [])
                as ExternalStorage;
          }
          return e;
        }).toList(),
      ),
    );
    return save();
  }

  void setNativeTitleBar([bool? value]) {
    if (kIsWeb || !isWindow) return;
    windowManager.setTitleBarStyle(
      (value ?? state.nativeTitleBar)
          ? TitleBarStyle.normal
          : TitleBarStyle.hidden,
      windowButtonVisibility: state.nativeTitleBar,
    );
  }

  Future<void> changeNativeTitleBar(bool value, [bool modify = true]) {
    if (modify) setNativeTitleBar(value);
    emit(state.copyWith(nativeTitleBar: value));
    return save();
  }

  Future<void> changeSyncMode(SyncMode syncMode) {
    emit(state.copyWith(syncMode: syncMode));
    return save();
  }

  Future<void> changeInputConfiguration(InputConfiguration inputConfiguration) {
    emit(state.copyWith(inputConfiguration: inputConfiguration));
    return save();
  }

  ExternalStorage? getRemote([String? remote]) {
    return state.connections.firstWhereOrNull(
      (element) => element.identifier == (remote ?? state.defaultRemote),
    );
  }

  Future<void> toggleStarred(AssetLocation location) {
    if (location.remote.isEmpty) {
      final starred = state.starred.toList();
      if (starred.contains(location.path)) {
        starred.remove(location.path);
      } else {
        starred.add(location.path);
      }
      emit(state.copyWith(starred: starred));
    } else {
      final remote = getRemote(location.remote);
      if (remote != null) {
        final starred = remote.starred['']?.toList() ?? [];
        if (starred.contains(location.path)) {
          starred.remove(location.path);
        } else {
          starred.add(location.path);
        }
        emit(
          state.copyWith(
            connections: List<ExternalStorage>.from(state.connections).map((e) {
              if (e.identifier == remote.identifier) {
                return e.copyWith(starred: {'': starred});
              }
              return e;
            }).toList(),
          ),
        );
      }
    }
    return save();
  }

  Future<void> changeDefaultTemplate(String name) {
    emit(state.copyWith(defaultTemplate: name));
    return save();
  }

  Future<void> changeNavigationRail(bool value) {
    emit(state.copyWith(navigationRail: value));
    return save();
  }

  Future<void> changeSortBy(SortBy value) {
    emit(state.copyWith(sortBy: value));
    return save();
  }

  Future<void> changeSortOrder(SortOrder value) {
    emit(state.copyWith(sortOrder: value));
    return save();
  }

  Future<void> changeImageScale(double value) {
    emit(state.copyWith(imageScale: value));
    return save();
  }

  Future<void> changePdfQuality(double value) {
    emit(state.copyWith(pdfQuality: value));
    return save();
  }

  Future<void> changePlatformTheme(PlatformTheme locale) {
    emit(state.copyWith(platformTheme: locale));
    return save();
  }

  Future<void> addRecentColors(SRGBColor color) async {
    final recentColors = state.recentColors.toList();
    recentColors.remove(color);
    recentColors.insert(0, color);
    if (recentColors.length > 5) {
      recentColors.removeLast();
    }
    emit(state.copyWith(recentColors: recentColors));
    return save();
  }

  Future<void> removeRecentColors(SRGBColor color) async {
    final recentColors = state.recentColors.toList();
    recentColors.remove(color);
    emit(state.copyWith(recentColors: recentColors));
    return save();
  }

  Future<void> addFlag(String flag) async {
    final flags = state.flags.toSet();
    flags.add(flag);
    emit(state.copyWith(flags: flags.toList()));
    return save();
  }

  Future<void> removeFlag(String flag) async {
    final flags = state.flags.toList();
    flags.remove(flag);
    emit(state.copyWith(flags: flags));
    return save();
  }

  Future<void> resetFlags() {
    emit(state.copyWith(flags: []));
    return save();
  }

  Future<void> changeSpreadPages(bool value) {
    emit(state.copyWith(spreadPages: value));
    return save();
  }

  Future<void> changeHighContrast(bool value) {
    emit(state.copyWith(highContrast: value));
    return save();
  }

  Future<void> changeGridView(bool value) {
    emit(state.copyWith(gridView: value));
    return save();
  }

  Future<void> toggleGridView() => changeGridView(!state.gridView);

  Future<void> changeAutosave(bool? value, {bool delayed = false}) {
    emit(
      state.copyWith(
        autosave: value ?? true,
        showSaveButton: value == null,
        delayedAutosave: delayed,
      ),
    );
    return save();
  }

  Future<void> changeAutosaveDelaySeconds(int seconds) {
    final normalized = seconds.clamp(1, 3600);
    emit(state.copyWith(autosaveDelaySeconds: normalized));
    return save();
  }

  Future<void> changeToolbarRows(int value) {
    emit(state.copyWith(toolbarRows: value));
    return save();
  }

  Future<void> changeHideCursorWhileDrawing(bool value) {
    emit(state.copyWith(hideCursorWhileDrawing: value));
    return save();
  }

  Future<void> changeNavigatorPosition(NavigatorPosition value) {
    emit(state.copyWith(navigatorPosition: value));
    return save();
  }

  Future<void> changeUtilities(UtilitiesState utilities) {
    emit(state.copyWith(utilities: utilities));
    return save();
  }

  Future<void> changeStartupBehavior(StartupBehavior behavior) {
    emit(state.copyWith(onStartup: behavior));
    return save();
  }

  Future<void> changeSimpleToolbarVisibility(
    SimpleToolbarVisibility visibility,
  ) {
    emit(state.copyWith(simpleToolbarVisibility: visibility));
    return save();
  }

  Future<void> changeRenderResolution(RenderResolution value) {
    emit(state.copyWith(renderResolution: value));
    return save();
  }

  Future<void> changeMoveOnGesture(bool value) {
    emit(state.copyWith(moveOnGesture: value));
    return save();
  }

  Future<void> changeSwamp(String swamp) {
    emit(state.copyWith(swamps: [swamp]));
    return save();
  }

  Future<void> changeIgnorePressure(IgnorePressure value) {
    emit(state.copyWith(ignorePressure: value));
    return save();
  }

  Future<void> importSettings(String data) {
    final settings = ButterflySettings.fromJson(
      json.decode(data),
    ).copyWith(history: state.history, connections: state.connections);
    emit(settings);
    return save();
  }

  Future<String> exportSettings() async {
    return json.encode(state.toJson());
  }
}
