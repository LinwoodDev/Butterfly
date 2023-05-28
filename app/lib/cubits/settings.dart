import 'dart:convert';
import 'dart:typed_data';

import 'package:butterfly/api/file_system/file_system.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

const secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),
);
const kRecentHistorySize = 5;

@freezed
class RemoteStorage with _$RemoteStorage {
  const factory RemoteStorage.dav({
    required String username,
    required String url,
    required String path,
    required String documentsPath,
    required String templatesPath,
    required String packsPath,
    @Default([]) List<String> cachedDocuments,
    @Default([]) List<String> starred,
    @Uint8ListJsonConverter() required Uint8List icon,
    DateTime? lastSynced,
  }) = DavRemoteStorage;

  factory RemoteStorage.fromJson(Map<String, dynamic> json) =>
      _$RemoteStorageFromJson(json);

  const RemoteStorage._();

  Uri get uri => Uri.parse(url);

  String get displayName => '$username@${uri.host}';

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

  Uri buildPacksUri({
    List<String> path = const [],
    Map<String, String> query = const {},
  }) {
    return buildUri(
      path: [...packsPath.split('/'), ...path],
      query: query,
    );
  }

  String get identifier => '$username@${uri.host}/$path';

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

  String encodeIdentifier() => base64Encode(utf8.encode(identifier));

  Future<String?> getRemotePassword() =>
      secureStorage.read(key: 'remote ${encodeIdentifier()}');

  Future<void> writeRemotePassword(String password) =>
      secureStorage.write(key: 'remote ${encodeIdentifier()}', value: password);
}

enum SyncMode { always, noMobile, manual }

@freezed
class InputConfiguration with _$InputConfiguration {
  const InputConfiguration._();

  const factory InputConfiguration({
    int? leftMouse,
    @Default(-1) int? middleMouse,
    @Default(1) int? rightMouse,
    int? pen,
    @Default(2) int? firstPenButton,
    @Default(1) int? secondPenButton,
    int? touch,
  }) = _InputConfiguration;

  factory InputConfiguration.fromJson(Map<String, dynamic> json) =>
      _$InputConfigurationFromJson(json);

  Set<int> getShortcuts() => {
        leftMouse,
        middleMouse,
        rightMouse,
        pen,
        firstPenButton,
        secondPenButton,
        touch
      }.whereNotNull().toSet();
}

enum BannerVisibility { always, never, onlyOnUpdates }

@freezed
class ButterflySettings with _$ButterflySettings {
  const ButterflySettings._();
  const factory ButterflySettings({
    @Default(ThemeMode.system) ThemeMode theme,
    @Default('') String localeTag,
    @Default('') String documentPath,
    @Default(1) double touchSensitivity,
    @Default(1) double mouseSensitivity,
    @Default(1) double penSensitivity,
    @Default(5) double selectSensitivity,
    @Default(false) bool penOnlyInput,
    @Default(true) bool inputGestures,
    @Default('') String design,
    @Default(BannerVisibility.always) BannerVisibility bannerVisibility,
    @Default([]) List<AssetLocation> history,
    @Default(true) bool navigatorEnabled,
    @Default(true) bool zoomEnabled,
    String? lastVersion,
    @Default([]) List<RemoteStorage> remotes,
    @Default('') String defaultRemote,
    @Default(false) bool nativeWindowTitleBar,
    @Default(false) bool startInFullScreen,
    @Default(SyncMode.noMobile) SyncMode syncMode,
    @Default(InputConfiguration()) InputConfiguration inputConfiguration,
    @Default('') String fallbackPack,
    @Default([]) List<String> starred,
  }) = _ButterflySettings;

  factory ButterflySettings.fromPrefs(SharedPreferences prefs) {
    final remotes = prefs.getStringList('remotes')?.map((e) {
          final data = json.decode(e) as Map<String, dynamic>;
          if (!data.containsKey('packsPath')) {
            data['packsPath'] = data['path'] + '/Packs';
          }
          return RemoteStorage.fromJson(data);
        }).toList() ??
        const [];
    return ButterflySettings(
      localeTag: prefs.getString('locale') ?? '',
      penOnlyInput: prefs.getBool('pen_only_input') ?? false,
      inputGestures: prefs.getBool('input_gestures') ?? true,
      documentPath: prefs.getString('document_path') ?? '',
      theme: prefs.containsKey('theme_mode')
          ? ThemeMode.values.byName(prefs.getString('theme_mode')!)
          : ThemeMode.system,
      touchSensitivity: prefs.getDouble('touch_sensitivity') ?? 1,
      mouseSensitivity: prefs.getDouble('mouse_sensitivity') ?? 1,
      penSensitivity: prefs.getDouble('pen_sensitivity') ?? 1,
      selectSensitivity: prefs.getDouble('select_sensitivity') ?? 5,
      design: prefs.getString('design') ?? '',
      bannerVisibility: prefs.containsKey('banner_visibility')
          ? BannerVisibility.values
              .byName(prefs.getString('banner_visibility')!)
          : BannerVisibility.always,
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
      navigatorEnabled: prefs.getBool('navigator_enabled') ?? true,
      zoomEnabled: prefs.getBool('zoom_enabled') ?? true,
      lastVersion: prefs.getString('last_version'),
      remotes: remotes,
      defaultRemote: prefs.getString('default_remote') ?? '',
      nativeWindowTitleBar: prefs.getBool('native_window_title_bar') ?? false,
      startInFullScreen: prefs.getBool('start_in_full_screen') ?? false,
      syncMode:
          SyncMode.values.byName(prefs.getString('sync_mode') ?? 'noMobile'),
      inputConfiguration: InputConfiguration.fromJson(
        json.decode(prefs.getString('input_configuration') ?? '{}'),
      ),
      fallbackPack: prefs.getString('fallback_pack') ?? '',
      starred: prefs.getStringList('starred') ?? [],
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

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', theme.name);
    await prefs.setString('locale', localeTag);
    await prefs.setBool('input_pen_only', penOnlyInput);
    await prefs.setBool('move_with_two_fingers', inputGestures);
    await prefs.setString('document_path', documentPath);
    await prefs.setDouble('touch_sensitivity', touchSensitivity);
    await prefs.setDouble('mouse_sensitivity', mouseSensitivity);
    await prefs.setDouble('pen_sensitivity', penSensitivity);
    await prefs.setDouble('select_sensitivity', selectSensitivity);
    await prefs.setString('design', design);
    await prefs.setString('banner_visibility', bannerVisibility.name);
    await prefs.setStringList(
        'history', history.map((e) => json.encode(e.toJson())).toList());
    await prefs.setBool('navigator_enabled', navigatorEnabled);
    await prefs.setBool('zoom_enabled', zoomEnabled);
    if (lastVersion == null && prefs.containsKey('last_version')) {
      await prefs.remove('last_version');
    } else if (lastVersion != null) {
      await prefs.setString('last_version', lastVersion!);
    }
    await prefs.setStringList(
        'remotes', remotes.map((e) => json.encode(e.toJson())).toList());
    await prefs.setString('default_remote', defaultRemote);
    await prefs.setBool('native_window_title_bar', nativeWindowTitleBar);
    await prefs.setBool('start_in_full_screen', startInFullScreen);
    await prefs.setString('sync_mode', syncMode.name);
    await prefs.setString(
        'input_configuration', json.encode(inputConfiguration.toJson()));
    await prefs.setString('fallback_pack', fallbackPack);
    await prefs.setStringList('starred', starred);
    await prefs.setInt('version', 0);
  }

  RemoteStorage? getRemote(String? identifier) {
    return remotes
        .firstWhereOrNull((e) => e.identifier == (identifier ?? defaultRemote));
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

  bool isStarred(AssetLocation location) {
    if (location.remote.isEmpty) {
      return starred.contains(location.path);
    }
    return getRemote(location.remote)?.starred.contains(location.path) ?? false;
  }
}

class SettingsCubit extends Cubit<ButterflySettings> {
  SettingsCubit() : super(const ButterflySettings());

  SettingsCubit.fromPrefs(SharedPreferences prefs)
      : super(ButterflySettings.fromPrefs(prefs));

  Future<void> changeTheme(ThemeMode theme) async {
    emit(state.copyWith(theme: theme));
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

  Future<void> changepenOnlyInput(bool penOnlyInput) {
    emit(state.copyWith(penOnlyInput: penOnlyInput));
    return save();
  }

  Future<void> resetpenOnlyInput() {
    emit(state.copyWith(penOnlyInput: false));
    return save();
  }

  Future<void> changeinputGestures(bool inputGestures) {
    emit(state.copyWith(inputGestures: inputGestures));
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
    history.remove(location);
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

  Future<void> addRemote(RemoteStorage storage, {required String password}) {
    emit(state.copyWith(
        remotes: List.from(state.remotes)
          ..removeWhere((element) => element.identifier == storage.identifier)
          ..add(storage)));
    storage.writeRemotePassword(password);
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
        return e.copyWith(lastSynced: DateTime.now().toUtc());
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

  Future<void> changeNativeWindowTitleBar(bool value) {
    emit(state.copyWith(nativeWindowTitleBar: value));
    return save();
  }

  Future<void> resetNativeWindowTitleBar() => changeNativeWindowTitleBar(false);

  Future<void> changeSyncMode(SyncMode syncMode) {
    emit(state.copyWith(syncMode: syncMode));
    return save();
  }

  Future<void> changeInputConfiguration(InputConfiguration inputConfiguration) {
    emit(state.copyWith(inputConfiguration: inputConfiguration));
    return save();
  }

  RemoteStorage? getRemote([String? remote]) {
    return state.remotes.firstWhereOrNull(
        (element) => element.identifier == (remote ?? state.defaultRemote));
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
        final starred = remote.starred.toList();
        if (starred.contains(location.path)) {
          starred.remove(location.path);
        } else {
          starred.add(location.path);
        }
        emit(state.copyWith(
            remotes: List<RemoteStorage>.from(state.remotes).map((e) {
          if (e.identifier == remote.identifier) {
            return e.copyWith(starred: starred);
          }
          return e;
        }).toList()));
      }
    }
    return save();
  }

  Future<void> changeNavigatorEnabled(bool value) {
    emit(state.copyWith(navigatorEnabled: value));
    return save();
  }
}
