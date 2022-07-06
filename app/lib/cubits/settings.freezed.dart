// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RemoteStorage _$RemoteStorageFromJson(Map<String, dynamic> json) {
  return DavRemoteStorage.fromJson(json);
}

/// @nodoc
mixin _$RemoteStorage {
  String get username => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  String get documentsPath => throw _privateConstructorUsedError;
  String get templatesPath => throw _privateConstructorUsedError;
  List<String> get cachedDocuments => throw _privateConstructorUsedError;
  @Uint8ListJsonConverter()
  Uint8List get icon => throw _privateConstructorUsedError;
  DateTime? get lastSynced => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String username,
            String url,
            String path,
            String documentsPath,
            String templatesPath,
            List<String> cachedDocuments,
            @Uint8ListJsonConverter() Uint8List icon,
            DateTime? lastSynced)
        dav,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            String username,
            String url,
            String path,
            String documentsPath,
            String templatesPath,
            List<String> cachedDocuments,
            @Uint8ListJsonConverter() Uint8List icon,
            DateTime? lastSynced)?
        dav,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String username,
            String url,
            String path,
            String documentsPath,
            String templatesPath,
            List<String> cachedDocuments,
            @Uint8ListJsonConverter() Uint8List icon,
            DateTime? lastSynced)?
        dav,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DavRemoteStorage value) dav,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(DavRemoteStorage value)? dav,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DavRemoteStorage value)? dav,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RemoteStorageCopyWith<RemoteStorage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoteStorageCopyWith<$Res> {
  factory $RemoteStorageCopyWith(
          RemoteStorage value, $Res Function(RemoteStorage) then) =
      _$RemoteStorageCopyWithImpl<$Res>;
  $Res call(
      {String username,
      String url,
      String path,
      String documentsPath,
      String templatesPath,
      List<String> cachedDocuments,
      @Uint8ListJsonConverter() Uint8List icon,
      DateTime? lastSynced});
}

/// @nodoc
class _$RemoteStorageCopyWithImpl<$Res>
    implements $RemoteStorageCopyWith<$Res> {
  _$RemoteStorageCopyWithImpl(this._value, this._then);

  final RemoteStorage _value;
  // ignore: unused_field
  final $Res Function(RemoteStorage) _then;

  @override
  $Res call({
    Object? username = freezed,
    Object? url = freezed,
    Object? path = freezed,
    Object? documentsPath = freezed,
    Object? templatesPath = freezed,
    Object? cachedDocuments = freezed,
    Object? icon = freezed,
    Object? lastSynced = freezed,
  }) {
    return _then(_value.copyWith(
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      documentsPath: documentsPath == freezed
          ? _value.documentsPath
          : documentsPath // ignore: cast_nullable_to_non_nullable
              as String,
      templatesPath: templatesPath == freezed
          ? _value.templatesPath
          : templatesPath // ignore: cast_nullable_to_non_nullable
              as String,
      cachedDocuments: cachedDocuments == freezed
          ? _value.cachedDocuments
          : cachedDocuments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      lastSynced: lastSynced == freezed
          ? _value.lastSynced
          : lastSynced // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$$DavRemoteStorageCopyWith<$Res>
    implements $RemoteStorageCopyWith<$Res> {
  factory _$$DavRemoteStorageCopyWith(
          _$DavRemoteStorage value, $Res Function(_$DavRemoteStorage) then) =
      __$$DavRemoteStorageCopyWithImpl<$Res>;
  @override
  $Res call(
      {String username,
      String url,
      String path,
      String documentsPath,
      String templatesPath,
      List<String> cachedDocuments,
      @Uint8ListJsonConverter() Uint8List icon,
      DateTime? lastSynced});
}

/// @nodoc
class __$$DavRemoteStorageCopyWithImpl<$Res>
    extends _$RemoteStorageCopyWithImpl<$Res>
    implements _$$DavRemoteStorageCopyWith<$Res> {
  __$$DavRemoteStorageCopyWithImpl(
      _$DavRemoteStorage _value, $Res Function(_$DavRemoteStorage) _then)
      : super(_value, (v) => _then(v as _$DavRemoteStorage));

  @override
  _$DavRemoteStorage get _value => super._value as _$DavRemoteStorage;

  @override
  $Res call({
    Object? username = freezed,
    Object? url = freezed,
    Object? path = freezed,
    Object? documentsPath = freezed,
    Object? templatesPath = freezed,
    Object? cachedDocuments = freezed,
    Object? icon = freezed,
    Object? lastSynced = freezed,
  }) {
    return _then(_$DavRemoteStorage(
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      documentsPath: documentsPath == freezed
          ? _value.documentsPath
          : documentsPath // ignore: cast_nullable_to_non_nullable
              as String,
      templatesPath: templatesPath == freezed
          ? _value.templatesPath
          : templatesPath // ignore: cast_nullable_to_non_nullable
              as String,
      cachedDocuments: cachedDocuments == freezed
          ? _value._cachedDocuments
          : cachedDocuments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      lastSynced: lastSynced == freezed
          ? _value.lastSynced
          : lastSynced // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DavRemoteStorage extends DavRemoteStorage {
  const _$DavRemoteStorage(
      {required this.username,
      required this.url,
      required this.path,
      required this.documentsPath,
      required this.templatesPath,
      final List<String> cachedDocuments = const [],
      @Uint8ListJsonConverter() required this.icon,
      this.lastSynced})
      : _cachedDocuments = cachedDocuments,
        super._();

  factory _$DavRemoteStorage.fromJson(Map<String, dynamic> json) =>
      _$$DavRemoteStorageFromJson(json);

  @override
  final String username;
  @override
  final String url;
  @override
  final String path;
  @override
  final String documentsPath;
  @override
  final String templatesPath;
  final List<String> _cachedDocuments;
  @override
  @JsonKey()
  List<String> get cachedDocuments {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cachedDocuments);
  }

  @override
  @Uint8ListJsonConverter()
  final Uint8List icon;
  @override
  final DateTime? lastSynced;

  @override
  String toString() {
    return 'RemoteStorage.dav(username: $username, url: $url, path: $path, documentsPath: $documentsPath, templatesPath: $templatesPath, cachedDocuments: $cachedDocuments, icon: $icon, lastSynced: $lastSynced)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DavRemoteStorage &&
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality()
                .equals(other.documentsPath, documentsPath) &&
            const DeepCollectionEquality()
                .equals(other.templatesPath, templatesPath) &&
            const DeepCollectionEquality()
                .equals(other._cachedDocuments, _cachedDocuments) &&
            const DeepCollectionEquality().equals(other.icon, icon) &&
            const DeepCollectionEquality()
                .equals(other.lastSynced, lastSynced));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(path),
      const DeepCollectionEquality().hash(documentsPath),
      const DeepCollectionEquality().hash(templatesPath),
      const DeepCollectionEquality().hash(_cachedDocuments),
      const DeepCollectionEquality().hash(icon),
      const DeepCollectionEquality().hash(lastSynced));

  @JsonKey(ignore: true)
  @override
  _$$DavRemoteStorageCopyWith<_$DavRemoteStorage> get copyWith =>
      __$$DavRemoteStorageCopyWithImpl<_$DavRemoteStorage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String username,
            String url,
            String path,
            String documentsPath,
            String templatesPath,
            List<String> cachedDocuments,
            @Uint8ListJsonConverter() Uint8List icon,
            DateTime? lastSynced)
        dav,
  }) {
    return dav(username, url, path, documentsPath, templatesPath,
        cachedDocuments, icon, lastSynced);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            String username,
            String url,
            String path,
            String documentsPath,
            String templatesPath,
            List<String> cachedDocuments,
            @Uint8ListJsonConverter() Uint8List icon,
            DateTime? lastSynced)?
        dav,
  }) {
    return dav?.call(username, url, path, documentsPath, templatesPath,
        cachedDocuments, icon, lastSynced);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String username,
            String url,
            String path,
            String documentsPath,
            String templatesPath,
            List<String> cachedDocuments,
            @Uint8ListJsonConverter() Uint8List icon,
            DateTime? lastSynced)?
        dav,
    required TResult orElse(),
  }) {
    if (dav != null) {
      return dav(username, url, path, documentsPath, templatesPath,
          cachedDocuments, icon, lastSynced);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DavRemoteStorage value) dav,
  }) {
    return dav(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(DavRemoteStorage value)? dav,
  }) {
    return dav?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DavRemoteStorage value)? dav,
    required TResult orElse(),
  }) {
    if (dav != null) {
      return dav(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DavRemoteStorageToJson(this);
  }
}

abstract class DavRemoteStorage extends RemoteStorage {
  const factory DavRemoteStorage(
      {required final String username,
      required final String url,
      required final String path,
      required final String documentsPath,
      required final String templatesPath,
      final List<String> cachedDocuments,
      @Uint8ListJsonConverter() required final Uint8List icon,
      final DateTime? lastSynced}) = _$DavRemoteStorage;
  const DavRemoteStorage._() : super._();

  factory DavRemoteStorage.fromJson(Map<String, dynamic> json) =
      _$DavRemoteStorage.fromJson;

  @override
  String get username => throw _privateConstructorUsedError;
  @override
  String get url => throw _privateConstructorUsedError;
  @override
  String get path => throw _privateConstructorUsedError;
  @override
  String get documentsPath => throw _privateConstructorUsedError;
  @override
  String get templatesPath => throw _privateConstructorUsedError;
  @override
  List<String> get cachedDocuments => throw _privateConstructorUsedError;
  @override
  @Uint8ListJsonConverter()
  Uint8List get icon => throw _privateConstructorUsedError;
  @override
  DateTime? get lastSynced => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$DavRemoteStorageCopyWith<_$DavRemoteStorage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ButterflySettings {
  ThemeMode get theme => throw _privateConstructorUsedError;
  String get localeTag => throw _privateConstructorUsedError;
  String get documentPath => throw _privateConstructorUsedError;
  String get dateFormat => throw _privateConstructorUsedError;
  double get touchSensitivity => throw _privateConstructorUsedError;
  double get mouseSensitivity => throw _privateConstructorUsedError;
  double get penSensitivity => throw _privateConstructorUsedError;
  double get selectSensitivity => throw _privateConstructorUsedError;
  InputType get inputType => throw _privateConstructorUsedError;
  String get design => throw _privateConstructorUsedError;
  List<AssetLocation> get history => throw _privateConstructorUsedError;
  bool get startEnabled => throw _privateConstructorUsedError;
  bool get colorEnabled => throw _privateConstructorUsedError;
  String? get lastVersion => throw _privateConstructorUsedError;
  List<RemoteStorage> get remotes => throw _privateConstructorUsedError;
  String get defaultRemote => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ButterflySettingsCopyWith<ButterflySettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ButterflySettingsCopyWith<$Res> {
  factory $ButterflySettingsCopyWith(
          ButterflySettings value, $Res Function(ButterflySettings) then) =
      _$ButterflySettingsCopyWithImpl<$Res>;
  $Res call(
      {ThemeMode theme,
      String localeTag,
      String documentPath,
      String dateFormat,
      double touchSensitivity,
      double mouseSensitivity,
      double penSensitivity,
      double selectSensitivity,
      InputType inputType,
      String design,
      List<AssetLocation> history,
      bool startEnabled,
      bool colorEnabled,
      String? lastVersion,
      List<RemoteStorage> remotes,
      String defaultRemote});
}

/// @nodoc
class _$ButterflySettingsCopyWithImpl<$Res>
    implements $ButterflySettingsCopyWith<$Res> {
  _$ButterflySettingsCopyWithImpl(this._value, this._then);

  final ButterflySettings _value;
  // ignore: unused_field
  final $Res Function(ButterflySettings) _then;

  @override
  $Res call({
    Object? theme = freezed,
    Object? localeTag = freezed,
    Object? documentPath = freezed,
    Object? dateFormat = freezed,
    Object? touchSensitivity = freezed,
    Object? mouseSensitivity = freezed,
    Object? penSensitivity = freezed,
    Object? selectSensitivity = freezed,
    Object? inputType = freezed,
    Object? design = freezed,
    Object? history = freezed,
    Object? startEnabled = freezed,
    Object? colorEnabled = freezed,
    Object? lastVersion = freezed,
    Object? remotes = freezed,
    Object? defaultRemote = freezed,
  }) {
    return _then(_value.copyWith(
      theme: theme == freezed
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      localeTag: localeTag == freezed
          ? _value.localeTag
          : localeTag // ignore: cast_nullable_to_non_nullable
              as String,
      documentPath: documentPath == freezed
          ? _value.documentPath
          : documentPath // ignore: cast_nullable_to_non_nullable
              as String,
      dateFormat: dateFormat == freezed
          ? _value.dateFormat
          : dateFormat // ignore: cast_nullable_to_non_nullable
              as String,
      touchSensitivity: touchSensitivity == freezed
          ? _value.touchSensitivity
          : touchSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      mouseSensitivity: mouseSensitivity == freezed
          ? _value.mouseSensitivity
          : mouseSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      penSensitivity: penSensitivity == freezed
          ? _value.penSensitivity
          : penSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      selectSensitivity: selectSensitivity == freezed
          ? _value.selectSensitivity
          : selectSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      inputType: inputType == freezed
          ? _value.inputType
          : inputType // ignore: cast_nullable_to_non_nullable
              as InputType,
      design: design == freezed
          ? _value.design
          : design // ignore: cast_nullable_to_non_nullable
              as String,
      history: history == freezed
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<AssetLocation>,
      startEnabled: startEnabled == freezed
          ? _value.startEnabled
          : startEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      colorEnabled: colorEnabled == freezed
          ? _value.colorEnabled
          : colorEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      lastVersion: lastVersion == freezed
          ? _value.lastVersion
          : lastVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      remotes: remotes == freezed
          ? _value.remotes
          : remotes // ignore: cast_nullable_to_non_nullable
              as List<RemoteStorage>,
      defaultRemote: defaultRemote == freezed
          ? _value.defaultRemote
          : defaultRemote // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ButterflySettingsCopyWith<$Res>
    implements $ButterflySettingsCopyWith<$Res> {
  factory _$$_ButterflySettingsCopyWith(_$_ButterflySettings value,
          $Res Function(_$_ButterflySettings) then) =
      __$$_ButterflySettingsCopyWithImpl<$Res>;
  @override
  $Res call(
      {ThemeMode theme,
      String localeTag,
      String documentPath,
      String dateFormat,
      double touchSensitivity,
      double mouseSensitivity,
      double penSensitivity,
      double selectSensitivity,
      InputType inputType,
      String design,
      List<AssetLocation> history,
      bool startEnabled,
      bool colorEnabled,
      String? lastVersion,
      List<RemoteStorage> remotes,
      String defaultRemote});
}

/// @nodoc
class __$$_ButterflySettingsCopyWithImpl<$Res>
    extends _$ButterflySettingsCopyWithImpl<$Res>
    implements _$$_ButterflySettingsCopyWith<$Res> {
  __$$_ButterflySettingsCopyWithImpl(
      _$_ButterflySettings _value, $Res Function(_$_ButterflySettings) _then)
      : super(_value, (v) => _then(v as _$_ButterflySettings));

  @override
  _$_ButterflySettings get _value => super._value as _$_ButterflySettings;

  @override
  $Res call({
    Object? theme = freezed,
    Object? localeTag = freezed,
    Object? documentPath = freezed,
    Object? dateFormat = freezed,
    Object? touchSensitivity = freezed,
    Object? mouseSensitivity = freezed,
    Object? penSensitivity = freezed,
    Object? selectSensitivity = freezed,
    Object? inputType = freezed,
    Object? design = freezed,
    Object? history = freezed,
    Object? startEnabled = freezed,
    Object? colorEnabled = freezed,
    Object? lastVersion = freezed,
    Object? remotes = freezed,
    Object? defaultRemote = freezed,
  }) {
    return _then(_$_ButterflySettings(
      theme: theme == freezed
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      localeTag: localeTag == freezed
          ? _value.localeTag
          : localeTag // ignore: cast_nullable_to_non_nullable
              as String,
      documentPath: documentPath == freezed
          ? _value.documentPath
          : documentPath // ignore: cast_nullable_to_non_nullable
              as String,
      dateFormat: dateFormat == freezed
          ? _value.dateFormat
          : dateFormat // ignore: cast_nullable_to_non_nullable
              as String,
      touchSensitivity: touchSensitivity == freezed
          ? _value.touchSensitivity
          : touchSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      mouseSensitivity: mouseSensitivity == freezed
          ? _value.mouseSensitivity
          : mouseSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      penSensitivity: penSensitivity == freezed
          ? _value.penSensitivity
          : penSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      selectSensitivity: selectSensitivity == freezed
          ? _value.selectSensitivity
          : selectSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      inputType: inputType == freezed
          ? _value.inputType
          : inputType // ignore: cast_nullable_to_non_nullable
              as InputType,
      design: design == freezed
          ? _value.design
          : design // ignore: cast_nullable_to_non_nullable
              as String,
      history: history == freezed
          ? _value._history
          : history // ignore: cast_nullable_to_non_nullable
              as List<AssetLocation>,
      startEnabled: startEnabled == freezed
          ? _value.startEnabled
          : startEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      colorEnabled: colorEnabled == freezed
          ? _value.colorEnabled
          : colorEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      lastVersion: lastVersion == freezed
          ? _value.lastVersion
          : lastVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      remotes: remotes == freezed
          ? _value._remotes
          : remotes // ignore: cast_nullable_to_non_nullable
              as List<RemoteStorage>,
      defaultRemote: defaultRemote == freezed
          ? _value.defaultRemote
          : defaultRemote // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ButterflySettings extends _ButterflySettings {
  const _$_ButterflySettings(
      {this.theme = ThemeMode.system,
      this.localeTag = '',
      this.documentPath = '',
      this.dateFormat = '',
      this.touchSensitivity = 1,
      this.mouseSensitivity = 1,
      this.penSensitivity = 1,
      this.selectSensitivity = 5,
      this.inputType = InputType.multiDraw,
      this.design = '',
      final List<AssetLocation> history = const [],
      this.startEnabled = true,
      this.colorEnabled = true,
      this.lastVersion,
      final List<RemoteStorage> remotes = const [],
      this.defaultRemote = ''})
      : _history = history,
        _remotes = remotes,
        super._();

  @override
  @JsonKey()
  final ThemeMode theme;
  @override
  @JsonKey()
  final String localeTag;
  @override
  @JsonKey()
  final String documentPath;
  @override
  @JsonKey()
  final String dateFormat;
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
  final InputType inputType;
  @override
  @JsonKey()
  final String design;
  final List<AssetLocation> _history;
  @override
  @JsonKey()
  List<AssetLocation> get history {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  @JsonKey()
  final bool startEnabled;
  @override
  @JsonKey()
  final bool colorEnabled;
  @override
  final String? lastVersion;
  final List<RemoteStorage> _remotes;
  @override
  @JsonKey()
  List<RemoteStorage> get remotes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_remotes);
  }

  @override
  @JsonKey()
  final String defaultRemote;

  @override
  String toString() {
    return 'ButterflySettings(theme: $theme, localeTag: $localeTag, documentPath: $documentPath, dateFormat: $dateFormat, touchSensitivity: $touchSensitivity, mouseSensitivity: $mouseSensitivity, penSensitivity: $penSensitivity, selectSensitivity: $selectSensitivity, inputType: $inputType, design: $design, history: $history, startEnabled: $startEnabled, colorEnabled: $colorEnabled, lastVersion: $lastVersion, remotes: $remotes, defaultRemote: $defaultRemote)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ButterflySettings &&
            const DeepCollectionEquality().equals(other.theme, theme) &&
            const DeepCollectionEquality().equals(other.localeTag, localeTag) &&
            const DeepCollectionEquality()
                .equals(other.documentPath, documentPath) &&
            const DeepCollectionEquality()
                .equals(other.dateFormat, dateFormat) &&
            const DeepCollectionEquality()
                .equals(other.touchSensitivity, touchSensitivity) &&
            const DeepCollectionEquality()
                .equals(other.mouseSensitivity, mouseSensitivity) &&
            const DeepCollectionEquality()
                .equals(other.penSensitivity, penSensitivity) &&
            const DeepCollectionEquality()
                .equals(other.selectSensitivity, selectSensitivity) &&
            const DeepCollectionEquality().equals(other.inputType, inputType) &&
            const DeepCollectionEquality().equals(other.design, design) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            const DeepCollectionEquality()
                .equals(other.startEnabled, startEnabled) &&
            const DeepCollectionEquality()
                .equals(other.colorEnabled, colorEnabled) &&
            const DeepCollectionEquality()
                .equals(other.lastVersion, lastVersion) &&
            const DeepCollectionEquality().equals(other._remotes, _remotes) &&
            const DeepCollectionEquality()
                .equals(other.defaultRemote, defaultRemote));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(theme),
      const DeepCollectionEquality().hash(localeTag),
      const DeepCollectionEquality().hash(documentPath),
      const DeepCollectionEquality().hash(dateFormat),
      const DeepCollectionEquality().hash(touchSensitivity),
      const DeepCollectionEquality().hash(mouseSensitivity),
      const DeepCollectionEquality().hash(penSensitivity),
      const DeepCollectionEquality().hash(selectSensitivity),
      const DeepCollectionEquality().hash(inputType),
      const DeepCollectionEquality().hash(design),
      const DeepCollectionEquality().hash(_history),
      const DeepCollectionEquality().hash(startEnabled),
      const DeepCollectionEquality().hash(colorEnabled),
      const DeepCollectionEquality().hash(lastVersion),
      const DeepCollectionEquality().hash(_remotes),
      const DeepCollectionEquality().hash(defaultRemote));

  @JsonKey(ignore: true)
  @override
  _$$_ButterflySettingsCopyWith<_$_ButterflySettings> get copyWith =>
      __$$_ButterflySettingsCopyWithImpl<_$_ButterflySettings>(
          this, _$identity);
}

abstract class _ButterflySettings extends ButterflySettings {
  const factory _ButterflySettings(
      {final ThemeMode theme,
      final String localeTag,
      final String documentPath,
      final String dateFormat,
      final double touchSensitivity,
      final double mouseSensitivity,
      final double penSensitivity,
      final double selectSensitivity,
      final InputType inputType,
      final String design,
      final List<AssetLocation> history,
      final bool startEnabled,
      final bool colorEnabled,
      final String? lastVersion,
      final List<RemoteStorage> remotes,
      final String defaultRemote}) = _$_ButterflySettings;
  const _ButterflySettings._() : super._();

  @override
  ThemeMode get theme => throw _privateConstructorUsedError;
  @override
  String get localeTag => throw _privateConstructorUsedError;
  @override
  String get documentPath => throw _privateConstructorUsedError;
  @override
  String get dateFormat => throw _privateConstructorUsedError;
  @override
  double get touchSensitivity => throw _privateConstructorUsedError;
  @override
  double get mouseSensitivity => throw _privateConstructorUsedError;
  @override
  double get penSensitivity => throw _privateConstructorUsedError;
  @override
  double get selectSensitivity => throw _privateConstructorUsedError;
  @override
  InputType get inputType => throw _privateConstructorUsedError;
  @override
  String get design => throw _privateConstructorUsedError;
  @override
  List<AssetLocation> get history => throw _privateConstructorUsedError;
  @override
  bool get startEnabled => throw _privateConstructorUsedError;
  @override
  bool get colorEnabled => throw _privateConstructorUsedError;
  @override
  String? get lastVersion => throw _privateConstructorUsedError;
  @override
  List<RemoteStorage> get remotes => throw _privateConstructorUsedError;
  @override
  String get defaultRemote => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ButterflySettingsCopyWith<_$_ButterflySettings> get copyWith =>
      throw _privateConstructorUsedError;
}
