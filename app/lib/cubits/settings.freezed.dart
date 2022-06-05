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

/// @nodoc
mixin _$RemoteStorage {
  String get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get documentsPath => throw _privateConstructorUsedError;
  String get templatesPath => throw _privateConstructorUsedError;
  Uint8List? get icon => throw _privateConstructorUsedError;

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
      {String name,
      String url,
      String documentsPath,
      String templatesPath,
      Uint8List? icon});
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
    Object? name = freezed,
    Object? url = freezed,
    Object? documentsPath = freezed,
    Object? templatesPath = freezed,
    Object? icon = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      documentsPath: documentsPath == freezed
          ? _value.documentsPath
          : documentsPath // ignore: cast_nullable_to_non_nullable
              as String,
      templatesPath: templatesPath == freezed
          ? _value.templatesPath
          : templatesPath // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc
abstract class _$$_RemoteStorageCopyWith<$Res>
    implements $RemoteStorageCopyWith<$Res> {
  factory _$$_RemoteStorageCopyWith(
          _$_RemoteStorage value, $Res Function(_$_RemoteStorage) then) =
      __$$_RemoteStorageCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String url,
      String documentsPath,
      String templatesPath,
      Uint8List? icon});
}

/// @nodoc
class __$$_RemoteStorageCopyWithImpl<$Res>
    extends _$RemoteStorageCopyWithImpl<$Res>
    implements _$$_RemoteStorageCopyWith<$Res> {
  __$$_RemoteStorageCopyWithImpl(
      _$_RemoteStorage _value, $Res Function(_$_RemoteStorage) _then)
      : super(_value, (v) => _then(v as _$_RemoteStorage));

  @override
  _$_RemoteStorage get _value => super._value as _$_RemoteStorage;

  @override
  $Res call({
    Object? name = freezed,
    Object? url = freezed,
    Object? documentsPath = freezed,
    Object? templatesPath = freezed,
    Object? icon = freezed,
  }) {
    return _then(_$_RemoteStorage(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      documentsPath: documentsPath == freezed
          ? _value.documentsPath
          : documentsPath // ignore: cast_nullable_to_non_nullable
              as String,
      templatesPath: templatesPath == freezed
          ? _value.templatesPath
          : templatesPath // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc

class _$_RemoteStorage implements _RemoteStorage {
  const _$_RemoteStorage(
      {required this.name,
      required this.url,
      required this.documentsPath,
      required this.templatesPath,
      this.icon});

  @override
  final String name;
  @override
  final String url;
  @override
  final String documentsPath;
  @override
  final String templatesPath;
  @override
  final Uint8List? icon;

  @override
  String toString() {
    return 'RemoteStorage(name: $name, url: $url, documentsPath: $documentsPath, templatesPath: $templatesPath, icon: $icon)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RemoteStorage &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality()
                .equals(other.documentsPath, documentsPath) &&
            const DeepCollectionEquality()
                .equals(other.templatesPath, templatesPath) &&
            const DeepCollectionEquality().equals(other.icon, icon));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(documentsPath),
      const DeepCollectionEquality().hash(templatesPath),
      const DeepCollectionEquality().hash(icon));

  @JsonKey(ignore: true)
  @override
  _$$_RemoteStorageCopyWith<_$_RemoteStorage> get copyWith =>
      __$$_RemoteStorageCopyWithImpl<_$_RemoteStorage>(this, _$identity);
}

abstract class _RemoteStorage implements RemoteStorage {
  const factory _RemoteStorage(
      {required final String name,
      required final String url,
      required final String documentsPath,
      required final String templatesPath,
      final Uint8List? icon}) = _$_RemoteStorage;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get url => throw _privateConstructorUsedError;
  @override
  String get documentsPath => throw _privateConstructorUsedError;
  @override
  String get templatesPath => throw _privateConstructorUsedError;
  @override
  Uint8List? get icon => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RemoteStorageCopyWith<_$_RemoteStorage> get copyWith =>
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
  List<String> get recentHistory => throw _privateConstructorUsedError;
  bool get startEnabled => throw _privateConstructorUsedError;
  bool get colorEnabled => throw _privateConstructorUsedError;
  String? get lastVersion => throw _privateConstructorUsedError;
  List<RemoteStorage> get remotes => throw _privateConstructorUsedError;

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
      List<String> recentHistory,
      bool startEnabled,
      bool colorEnabled,
      String? lastVersion,
      List<RemoteStorage> remotes});
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
    Object? recentHistory = freezed,
    Object? startEnabled = freezed,
    Object? colorEnabled = freezed,
    Object? lastVersion = freezed,
    Object? remotes = freezed,
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
      recentHistory: recentHistory == freezed
          ? _value.recentHistory
          : recentHistory // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      List<String> recentHistory,
      bool startEnabled,
      bool colorEnabled,
      String? lastVersion,
      List<RemoteStorage> remotes});
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
    Object? recentHistory = freezed,
    Object? startEnabled = freezed,
    Object? colorEnabled = freezed,
    Object? lastVersion = freezed,
    Object? remotes = freezed,
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
      recentHistory: recentHistory == freezed
          ? _value._recentHistory
          : recentHistory // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      final List<String> recentHistory = const [],
      this.startEnabled = true,
      this.colorEnabled = true,
      this.lastVersion,
      final List<RemoteStorage> remotes = const []})
      : _recentHistory = recentHistory,
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
  final List<String> _recentHistory;
  @override
  @JsonKey()
  List<String> get recentHistory {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentHistory);
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
  String toString() {
    return 'ButterflySettings(theme: $theme, localeTag: $localeTag, documentPath: $documentPath, dateFormat: $dateFormat, touchSensitivity: $touchSensitivity, mouseSensitivity: $mouseSensitivity, penSensitivity: $penSensitivity, selectSensitivity: $selectSensitivity, inputType: $inputType, design: $design, recentHistory: $recentHistory, startEnabled: $startEnabled, colorEnabled: $colorEnabled, lastVersion: $lastVersion, remotes: $remotes)';
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
            const DeepCollectionEquality()
                .equals(other._recentHistory, _recentHistory) &&
            const DeepCollectionEquality()
                .equals(other.startEnabled, startEnabled) &&
            const DeepCollectionEquality()
                .equals(other.colorEnabled, colorEnabled) &&
            const DeepCollectionEquality()
                .equals(other.lastVersion, lastVersion) &&
            const DeepCollectionEquality().equals(other._remotes, _remotes));
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
      const DeepCollectionEquality().hash(_recentHistory),
      const DeepCollectionEquality().hash(startEnabled),
      const DeepCollectionEquality().hash(colorEnabled),
      const DeepCollectionEquality().hash(lastVersion),
      const DeepCollectionEquality().hash(_remotes));

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
      final List<String> recentHistory,
      final bool startEnabled,
      final bool colorEnabled,
      final String? lastVersion,
      final List<RemoteStorage> remotes}) = _$_ButterflySettings;
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
  List<String> get recentHistory => throw _privateConstructorUsedError;
  @override
  bool get startEnabled => throw _privateConstructorUsedError;
  @override
  bool get colorEnabled => throw _privateConstructorUsedError;
  @override
  String? get lastVersion => throw _privateConstructorUsedError;
  @override
  List<RemoteStorage> get remotes => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ButterflySettingsCopyWith<_$_ButterflySettings> get copyWith =>
      throw _privateConstructorUsedError;
}
