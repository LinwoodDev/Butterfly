import 'dart:convert';
import 'dart:typed_data';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/models/converter.dart';
import 'package:butterfly/models/document.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

const kRecentHistorySize = 5;

@freezed
class RemoteStorage with _$RemoteStorage {
  const factory RemoteStorage.dav({
    required String username,
    required String url,
    required String path,
    required String documentsPath,
    required String templatesPath,
    @Default([]) List<String> cachedDocuments,
    @Uint8ListJsonConverter() required Uint8List icon,
    DateTime? lastSynced,
  }) = DavRemoteStorage;

  factory RemoteStorage.fromJson(Map<String, dynamic> json) =>
      _$RemoteStorageFromJson(json);

  const RemoteStorage._();

  Uri get uri => Uri.parse(url);

  Uri buildUri({
    List<String> path = const [],
    Map<String, String> query = const {},
  }) {
    final currentUri = uri;
    final paths = List<String>.from(currentUri.pathSegments);
    if (paths.lastOrNull == '') {
      paths.removeLast();
    }
    return Uri(
      scheme: currentUri.scheme,
      port: currentUri.port,
      host: currentUri.host,
      queryParameters: {
        ...currentUri.queryParameters,
        ...query,
      },
      pathSegments: {
        ...paths,
        ...path,
      },
    );
  }

  Uri buildDocumentsUri({
    List<String> path = const [],
    Map<String, String> query = const {},
  }) {
    return buildUri(
      path: [...documentsPath.split('/'), ...path],
      query: query,
    );
  }

  Uri buildTemplatesUri({
    List<String> path = const [],
    Map<String, String> query = const {},
  }) {
    return buildUri(
      path: [...templatesPath.split('/'), ...path],
      query: query,
    );
  }

  String get identifier => '$username@${uri.host}/$path';

  Future<String> getPassword() async =>
      (await const FlutterSecureStorage().read(key: 'remotes/$identifier')) ??
      '';
  DocumentFileSystem get documentFileSystem =>
      DocumentFileSystem.fromPlatform(remote: this);

  TemplateFileSystem get templateFileSystem =>
      TemplateFileSystem.fromPlatform(remote: this);

  bool hasDocumentCached(String name) {
    if (!name.startsWith('/')) {
      name = '/$name';
    }
    return cachedDocuments.any((doc) {
      if (doc == name) {
        return true;
      }
      if (name.startsWith(doc)) {
        return !name.substring(doc.length + 1).contains('/');
      }
      return false;
    });
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
      @Default([]) List<AssetLocation> history,
      @Default(true) bool startEnabled,
      @Default(true) bool colorEnabled,
      String? lastVersion,
      @Default([]) List<RemoteStorage> remotes,
      @Default('') String defaultRemote}) = _ButterflySettings;

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
      history: prefs
              .getStringList('history')
              ?.map((e) {
                // Try to parse the asset location
                try {
                  return AssetLocation.fromJson(json.decode(e));
                } catch (e) {
                  return null;
                }
              })
              .whereType<AssetLocation>()
              .toList() ??
          [],
      startEnabled: prefs.getBool('start_enabled') ?? true,
      lastVersion: prefs.getString('last_version'),
      colorEnabled: prefs.getBool('color_enabled') ?? true,
      remotes: remotes,
      defaultRemote: prefs.getString('default_remote') ?? '',
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
    await prefs.setStringList(
        'history', history.map((e) => json.encode(e.toJson())).toList());
    await prefs.setBool('start_enabled', startEnabled);
    await prefs.setBool('color_enabled', colorEnabled);
    if (lastVersion == null && prefs.containsKey('last_version')) {
      await prefs.remove('last_version');
    } else if (lastVersion != null) {
      await prefs.setString('last_version', lastVersion!);
    }
    await prefs.setStringList(
        'remotes', remotes.map((e) => json.encode(e.toJson())).toList());
    await prefs.setString('default_remote', defaultRemote);
  }

  RemoteStorage? getRemote(String identifier) {
    return remotes.firstWhereOrNull((e) => e.identifier == identifier);
  }

  bool hasRemote(String identifier) {
    return remotes.any((e) => e.identifier == identifier);
  }

  RemoteStorage? getDefaultRemote() {
    return remotes.firstWhereOrNull((e) => e.identifier == defaultRemote);
  }

  DocumentFileSystem getDefaultDocumentFileSystem() =>
      DocumentFileSystem.fromPlatform(remote: getDefaultRemote());

  TemplateFileSystem getDefaultTemplateFileSystem() =>
      TemplateFileSystem.fromPlatform(remote: getDefaultRemote());
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
    history.remove(location);
    emit(state.copyWith(history: history));
    return save();
  }

  Future<void> resetRecentHistory() {
    emit(state.copyWith(history: []));
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

  Future<void> addRemote(RemoteStorage storage, {required String password}) {
    emit(state.copyWith(
        remotes: List.from(state.remotes)
          ..removeWhere((element) => element.identifier == storage.identifier)
          ..add(storage)));
    const FlutterSecureStorage()
        .write(key: 'remotes/${storage.identifier}', value: password);
    return save();
  }

  Future<void> deleteRemote(String identifier) async {
    emit(state.copyWith(
        remotes:
            state.remotes.where((r) => r.identifier != identifier).toList()));
    const FlutterSecureStorage().delete(key: 'remotes/$identifier');
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
    emit(state.copyWith(
        remotes: List<RemoteStorage>.from(state.remotes).map((e) {
      if (e.identifier == identifier) {
        final documents = List<String>.from(e.cachedDocuments);
        return e.copyWith(
            cachedDocuments: documents
              ..removeWhere((element) => element == current)
              ..add(current));
      }
      return e;
    }).toList()));
    return save();
  }

  Future<void> removeCache(String identifier, String current) {
    emit(state.copyWith(
        remotes: List<RemoteStorage>.from(state.remotes).map((e) {
      if (e.identifier == identifier) {
        return e.copyWith(
            cachedDocuments: List<String>.from(e.cachedDocuments)
              ..remove(current));
      }
      return e;
    }).toList()));
    return save();
  }

  Future<void> updateLastSynced(String identifier) {
    emit(state.copyWith(
        remotes: List<RemoteStorage>.from(state.remotes).map((e) {
      if (e.identifier == identifier) {
        return e.copyWith(lastSynced: DateTime.now());
      }
      return e;
    }).toList()));
    return save();
  }

  Future<void> clearCaches(RemoteStorage storage) {
    emit(state.copyWith(
        remotes: List<RemoteStorage>.from(state.remotes).map((e) {
      if (e.identifier == storage.identifier) {
        return e.copyWith(cachedDocuments: []);
      }
      return e;
    }).toList()));
    return save();
  }
}
