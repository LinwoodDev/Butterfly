import 'dart:convert';
import 'dart:typed_data';

import 'package:butterfly/models/converter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

const kRecentHistorySize = 5;

@freezed
class RemoteStorage with _$RemoteStorage {
  const factory RemoteStorage.dav({
    required String name,
    required String username,
    required String password,
    required String url,
    required String path,
    required String documentsPath,
    required String templatesPath,
    @Uint8ListJsonConverter() required Uint8List icon,
  }) = DavRemoteStorage;

  factory RemoteStorage.fromJson(Map<String, dynamic> json) =>
      _$RemoteStorageFromJson(json);

  RemoteStorage._();

  Uri get uri => Uri.parse(url);

  Uri buildUri({
    List<String> path = const [],
    Map<String, String> query = const {},
  }) {
    final currentUri = uri;
    return Uri(
      scheme: currentUri.scheme,
      port: currentUri.port,
      queryParameters: {
        ...currentUri.queryParameters,
        ...query,
      },
      pathSegments: {
        ...currentUri.pathSegments,
        ...path,
      },
    );
  }

  Uri buildDocumentsUri({
    List<String> path = const [],
    Map<String, String> query = const {},
  }) {
    return buildUri(
      path: [documentsPath, ...path],
      query: query,
    );
  }

  Uri buildTemplatesUri({
    List<String> path = const [],
    Map<String, String> query = const {},
  }) {
    return buildUri(
      path: [templatesPath, ...path],
      query: query,
    );
  }
}

@freezed
class ButterflySettings with _$ButterflySettings {
  const ButterflySettings._();
  const factory ButterflySettings(
      {@Default(ThemeMode.system) ThemeMode theme,
      @Default('') String localeTag,
      @Default('') String documentPath,
      @Default('') String dateFormat,
      @Default(1) double touchSensitivity,
      @Default(1) double mouseSensitivity,
      @Default(1) double penSensitivity,
      @Default(5) double selectSensitivity,
      @Default(InputType.multiDraw) InputType inputType,
      @Default('') String design,
      @Default([]) List<String> recentHistory,
      @Default(true) bool startEnabled,
      @Default(true) bool colorEnabled,
      String? lastVersion,
      @Default([]) List<RemoteStorage> remotes}) = _ButterflySettings;

  factory ButterflySettings.fromPrefs(SharedPreferences prefs) {
    final remotes = prefs.getStringList('remotes')?.map((e) {
          return RemoteStorage.fromJson(json.decode(e));
        }).toList() ??
        const [];
    return ButterflySettings(
      localeTag: prefs.getString('locale') ?? '',
      inputType: prefs.containsKey('input_type')
          ? InputType.values.byName(prefs.getString('input_type')!)
          : InputType.multiDraw,
      documentPath: prefs.getString('document_path') ?? '',
      theme: prefs.containsKey('theme_mode')
          ? ThemeMode.values.byName(prefs.getString('theme_mode')!)
          : ThemeMode.system,
      dateFormat: prefs.getString('date_format') ?? '',
      touchSensitivity: prefs.getDouble('touch_sensitivity') ?? 1,
      mouseSensitivity: prefs.getDouble('mouse_sensitivity') ?? 1,
      penSensitivity: prefs.getDouble('pen_sensitivity') ?? 1,
      selectSensitivity: prefs.getDouble('select_sensitivity') ?? 5,
      design: prefs.getString('design') ?? '',
      recentHistory: prefs.getStringList('recent_history')?.map((e) {
            if (e.startsWith('/')) {
              return e;
            }
            return '/$e';
          }).toList() ??
          [],
      startEnabled: prefs.getBool('start_enabled') ?? true,
      lastVersion: prefs.getString('last_version'),
      colorEnabled: prefs.getBool('color_enabled') ?? true,
      remotes: remotes,
    );
  }

  Locale? get locale => localeTag.isEmpty ? null : Locale(localeTag);

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', theme.name);
    await prefs.setString('locale', localeTag);
    await prefs.setString('input_type', inputType.name);
    await prefs.setString('date_format', dateFormat);
    await prefs.setString('document_path', documentPath);
    await prefs.setDouble('touch_sensitivity', touchSensitivity);
    await prefs.setDouble('mouse_sensitivity', mouseSensitivity);
    await prefs.setDouble('pen_sensitivity', penSensitivity);
    await prefs.setDouble('select_sensitivity', selectSensitivity);
    await prefs.setString('design', design);
    await prefs.setStringList('recent_history', recentHistory);
    await prefs.setBool('start_enabled', startEnabled);
    await prefs.setBool('color_enabled', colorEnabled);
    if (lastVersion == null && prefs.containsKey('last_version')) {
      await prefs.remove('last_version');
    } else if (lastVersion != null) {
      await prefs.setString('last_version', lastVersion!);
    }
    await prefs.setStringList(
        'remotes', remotes.map((e) => json.encode(e.toJson())).toList());
  }
}

enum InputType { multiDraw, moveFirst, moveLast, onlyStylus }

extension InputTypeExtension on InputType {
  String toLocalizedString(BuildContext context) {
    switch (this) {
      case InputType.multiDraw:
        return AppLocalizations.of(context)!.multiDraw;
      case InputType.moveFirst:
        return AppLocalizations.of(context)!.moveFirst;
      case InputType.moveLast:
        return AppLocalizations.of(context)!.moveLast;
      case InputType.onlyStylus:
        return AppLocalizations.of(context)!.onlyStylus;
    }
  }

  bool canCreate(int pointer, int? first, PointerDeviceKind kind) =>
      this == InputType.onlyStylus && kind == PointerDeviceKind.stylus ||
      this == InputType.moveFirst && (pointer != first || first != null) ||
      this == InputType.moveLast && (pointer == first || first == null) ||
      this == InputType.multiDraw;
}

class SettingsCubit extends Cubit<ButterflySettings> {
  SettingsCubit() : super(const ButterflySettings());

  SettingsCubit.fromPrefs(SharedPreferences prefs)
      : super(ButterflySettings.fromPrefs(prefs));

  Future<void> changeTheme(ThemeMode theme) async {
    emit(state.copyWith(theme: theme));
  }

  Future<void> changeDesign(String design) async {
    emit(state.copyWith(design: design));
  }

  Future<void> resetDesign() async {
    emit(state.copyWith(design: ''));
  }

  Future<void> changeLocale(Locale? locale) {
    emit(state.copyWith(localeTag: locale?.toString() ?? ''));
    return save();
  }

  Future<void> resetLocale() {
    emit(state.copyWith(localeTag: ''));
    return save();
  }

  Future<void> changeDocumentPath(String documentPath) {
    emit(state.copyWith(documentPath: documentPath));
    return save();
  }

  Future<void> resetDocumentPath() {
    emit(state.copyWith(documentPath: ''));
    return save();
  }

  Future<void> changeDateFormat(String dateFormat) {
    emit(state.copyWith(dateFormat: dateFormat));
    return save();
  }

  Future<void> resetDateFormat() {
    emit(state.copyWith(dateFormat: ''));
    return save();
  }

  Future<void> changeInput(InputType inputType) {
    emit(state.copyWith(inputType: inputType));
    return save();
  }

  Future<void> resetInput() {
    emit(state.copyWith(inputType: InputType.multiDraw));
    return save();
  }

  Future<void> changeTouchSensitivity(double sensitivity) {
    emit(state.copyWith(touchSensitivity: sensitivity));
    return save();
  }

  Future<void> resetTouchSensitivity() {
    emit(state.copyWith(touchSensitivity: 1));
    return save();
  }

  Future<void> changeMouseSensitivity(double sensitivity) {
    emit(state.copyWith(mouseSensitivity: sensitivity));
    return save();
  }

  Future<void> resetMouseSensitivity() {
    emit(state.copyWith(mouseSensitivity: 1));
    return save();
  }

  Future<void> changePenSensitivity(double sensitivity) {
    emit(state.copyWith(penSensitivity: sensitivity));
    return save();
  }

  Future<void> resetPenSensitivity() {
    emit(state.copyWith(penSensitivity: 1));
    return save();
  }

  Future<void> changeSelectSensitivity(double sensitivity) {
    emit(state.copyWith(selectSensitivity: sensitivity));
    return save();
  }

  Future<void> resetSelectSensitivity() {
    emit(state.copyWith(selectSensitivity: 1));
    return save();
  }

  Future<void> addRecentHistory(String path) async {
    final recentHistory = state.recentHistory.toList();
    recentHistory.remove(path);
    recentHistory.insert(0, path);
    if (!path.startsWith('/')) {
      path = '/$path';
    }
    if (recentHistory.length > 10) {
      recentHistory.removeLast();
    }
    emit(state.copyWith(recentHistory: recentHistory));
    return save();
  }

  Future<void> removeRecentHistory(String path) async {
    final recentHistory = state.recentHistory.toList();
    recentHistory.remove(path);
    emit(state.copyWith(recentHistory: recentHistory));
    return save();
  }

  Future<void> resetRecentHistory() {
    emit(state.copyWith(recentHistory: []));
    return save();
  }

  Future<void> changeStartEnabled(bool value) {
    emit(state.copyWith(startEnabled: value));
    return save();
  }

  Future<void> resetStartEnabled() => changeStartEnabled(true);

  Future<void> changeColorEnabled(bool value) {
    emit(state.copyWith(colorEnabled: value));
    return save();
  }

  Future<void> resetColorEnabled() => changeColorEnabled(true);

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
}
