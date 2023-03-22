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
  String get packsPath => throw _privateConstructorUsedError;
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
            String packsPath,
            List<String> cachedDocuments,
            @Uint8ListJsonConverter() Uint8List icon,
            DateTime? lastSynced)
        dav,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String username,
            String url,
            String path,
            String documentsPath,
            String templatesPath,
            String packsPath,
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
            String packsPath,
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
    TResult? Function(DavRemoteStorage value)? dav,
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
      _$RemoteStorageCopyWithImpl<$Res, RemoteStorage>;
  @useResult
  $Res call(
      {String username,
      String url,
      String path,
      String documentsPath,
      String templatesPath,
      String packsPath,
      List<String> cachedDocuments,
      @Uint8ListJsonConverter() Uint8List icon,
      DateTime? lastSynced});
}

/// @nodoc
class _$RemoteStorageCopyWithImpl<$Res, $Val extends RemoteStorage>
    implements $RemoteStorageCopyWith<$Res> {
  _$RemoteStorageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? url = null,
    Object? path = null,
    Object? documentsPath = null,
    Object? templatesPath = null,
    Object? packsPath = null,
    Object? cachedDocuments = null,
    Object? icon = null,
    Object? lastSynced = freezed,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      documentsPath: null == documentsPath
          ? _value.documentsPath
          : documentsPath // ignore: cast_nullable_to_non_nullable
              as String,
      templatesPath: null == templatesPath
          ? _value.templatesPath
          : templatesPath // ignore: cast_nullable_to_non_nullable
              as String,
      packsPath: null == packsPath
          ? _value.packsPath
          : packsPath // ignore: cast_nullable_to_non_nullable
              as String,
      cachedDocuments: null == cachedDocuments
          ? _value.cachedDocuments
          : cachedDocuments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      lastSynced: freezed == lastSynced
          ? _value.lastSynced
          : lastSynced // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DavRemoteStorageCopyWith<$Res>
    implements $RemoteStorageCopyWith<$Res> {
  factory _$$DavRemoteStorageCopyWith(
          _$DavRemoteStorage value, $Res Function(_$DavRemoteStorage) then) =
      __$$DavRemoteStorageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String username,
      String url,
      String path,
      String documentsPath,
      String templatesPath,
      String packsPath,
      List<String> cachedDocuments,
      @Uint8ListJsonConverter() Uint8List icon,
      DateTime? lastSynced});
}

/// @nodoc
class __$$DavRemoteStorageCopyWithImpl<$Res>
    extends _$RemoteStorageCopyWithImpl<$Res, _$DavRemoteStorage>
    implements _$$DavRemoteStorageCopyWith<$Res> {
  __$$DavRemoteStorageCopyWithImpl(
      _$DavRemoteStorage _value, $Res Function(_$DavRemoteStorage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? url = null,
    Object? path = null,
    Object? documentsPath = null,
    Object? templatesPath = null,
    Object? packsPath = null,
    Object? cachedDocuments = null,
    Object? icon = null,
    Object? lastSynced = freezed,
  }) {
    return _then(_$DavRemoteStorage(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      documentsPath: null == documentsPath
          ? _value.documentsPath
          : documentsPath // ignore: cast_nullable_to_non_nullable
              as String,
      templatesPath: null == templatesPath
          ? _value.templatesPath
          : templatesPath // ignore: cast_nullable_to_non_nullable
              as String,
      packsPath: null == packsPath
          ? _value.packsPath
          : packsPath // ignore: cast_nullable_to_non_nullable
              as String,
      cachedDocuments: null == cachedDocuments
          ? _value._cachedDocuments
          : cachedDocuments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      lastSynced: freezed == lastSynced
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
      required this.packsPath,
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
  @override
  final String packsPath;
  final List<String> _cachedDocuments;
  @override
  @JsonKey()
  List<String> get cachedDocuments {
    if (_cachedDocuments is EqualUnmodifiableListView) return _cachedDocuments;
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
    return 'RemoteStorage.dav(username: $username, url: $url, path: $path, documentsPath: $documentsPath, templatesPath: $templatesPath, packsPath: $packsPath, cachedDocuments: $cachedDocuments, icon: $icon, lastSynced: $lastSynced)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DavRemoteStorage &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.documentsPath, documentsPath) ||
                other.documentsPath == documentsPath) &&
            (identical(other.templatesPath, templatesPath) ||
                other.templatesPath == templatesPath) &&
            (identical(other.packsPath, packsPath) ||
                other.packsPath == packsPath) &&
            const DeepCollectionEquality()
                .equals(other._cachedDocuments, _cachedDocuments) &&
            const DeepCollectionEquality().equals(other.icon, icon) &&
            (identical(other.lastSynced, lastSynced) ||
                other.lastSynced == lastSynced));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      username,
      url,
      path,
      documentsPath,
      templatesPath,
      packsPath,
      const DeepCollectionEquality().hash(_cachedDocuments),
      const DeepCollectionEquality().hash(icon),
      lastSynced);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
            String packsPath,
            List<String> cachedDocuments,
            @Uint8ListJsonConverter() Uint8List icon,
            DateTime? lastSynced)
        dav,
  }) {
    return dav(username, url, path, documentsPath, templatesPath, packsPath,
        cachedDocuments, icon, lastSynced);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String username,
            String url,
            String path,
            String documentsPath,
            String templatesPath,
            String packsPath,
            List<String> cachedDocuments,
            @Uint8ListJsonConverter() Uint8List icon,
            DateTime? lastSynced)?
        dav,
  }) {
    return dav?.call(username, url, path, documentsPath, templatesPath,
        packsPath, cachedDocuments, icon, lastSynced);
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
            String packsPath,
            List<String> cachedDocuments,
            @Uint8ListJsonConverter() Uint8List icon,
            DateTime? lastSynced)?
        dav,
    required TResult orElse(),
  }) {
    if (dav != null) {
      return dav(username, url, path, documentsPath, templatesPath, packsPath,
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
    TResult? Function(DavRemoteStorage value)? dav,
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
    return _$$DavRemoteStorageToJson(
      this,
    );
  }
}

abstract class DavRemoteStorage extends RemoteStorage {
  const factory DavRemoteStorage(
      {required final String username,
      required final String url,
      required final String path,
      required final String documentsPath,
      required final String templatesPath,
      required final String packsPath,
      final List<String> cachedDocuments,
      @Uint8ListJsonConverter() required final Uint8List icon,
      final DateTime? lastSynced}) = _$DavRemoteStorage;
  const DavRemoteStorage._() : super._();

  factory DavRemoteStorage.fromJson(Map<String, dynamic> json) =
      _$DavRemoteStorage.fromJson;

  @override
  String get username;
  @override
  String get url;
  @override
  String get path;
  @override
  String get documentsPath;
  @override
  String get templatesPath;
  @override
  String get packsPath;
  @override
  List<String> get cachedDocuments;
  @override
  @Uint8ListJsonConverter()
  Uint8List get icon;
  @override
  DateTime? get lastSynced;
  @override
  @JsonKey(ignore: true)
  _$$DavRemoteStorageCopyWith<_$DavRemoteStorage> get copyWith =>
      throw _privateConstructorUsedError;
}

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
abstract class _$$_InputConfigurationCopyWith<$Res>
    implements $InputConfigurationCopyWith<$Res> {
  factory _$$_InputConfigurationCopyWith(_$_InputConfiguration value,
          $Res Function(_$_InputConfiguration) then) =
      __$$_InputConfigurationCopyWithImpl<$Res>;
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
class __$$_InputConfigurationCopyWithImpl<$Res>
    extends _$InputConfigurationCopyWithImpl<$Res, _$_InputConfiguration>
    implements _$$_InputConfigurationCopyWith<$Res> {
  __$$_InputConfigurationCopyWithImpl(
      _$_InputConfiguration _value, $Res Function(_$_InputConfiguration) _then)
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
    return _then(_$_InputConfiguration(
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
class _$_InputConfiguration implements _InputConfiguration {
  const _$_InputConfiguration(
      {this.leftMouse,
      this.middleMouse = -1,
      this.rightMouse = 1,
      this.pen,
      this.firstPenButton = 2,
      this.secondPenButton = 1,
      this.touch});

  factory _$_InputConfiguration.fromJson(Map<String, dynamic> json) =>
      _$$_InputConfigurationFromJson(json);

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
  String toString() {
    return 'InputConfiguration(leftMouse: $leftMouse, middleMouse: $middleMouse, rightMouse: $rightMouse, pen: $pen, firstPenButton: $firstPenButton, secondPenButton: $secondPenButton, touch: $touch)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InputConfiguration &&
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
  _$$_InputConfigurationCopyWith<_$_InputConfiguration> get copyWith =>
      __$$_InputConfigurationCopyWithImpl<_$_InputConfiguration>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InputConfigurationToJson(
      this,
    );
  }
}

abstract class _InputConfiguration implements InputConfiguration {
  const factory _InputConfiguration(
      {final int? leftMouse,
      final int? middleMouse,
      final int? rightMouse,
      final int? pen,
      final int? firstPenButton,
      final int? secondPenButton,
      final int? touch}) = _$_InputConfiguration;

  factory _InputConfiguration.fromJson(Map<String, dynamic> json) =
      _$_InputConfiguration.fromJson;

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
  _$$_InputConfigurationCopyWith<_$_InputConfiguration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ButterflySettings {
  ThemeMode get theme => throw _privateConstructorUsedError;
  String get localeTag => throw _privateConstructorUsedError;
  String get documentPath => throw _privateConstructorUsedError;
  double get touchSensitivity => throw _privateConstructorUsedError;
  double get mouseSensitivity => throw _privateConstructorUsedError;
  double get penSensitivity => throw _privateConstructorUsedError;
  double get selectSensitivity => throw _privateConstructorUsedError;
  bool get penOnlyInput => throw _privateConstructorUsedError;
  bool get inputGestures => throw _privateConstructorUsedError;
  String get design => throw _privateConstructorUsedError;
  List<AssetLocation> get history => throw _privateConstructorUsedError;
  bool get startEnabled => throw _privateConstructorUsedError;
  String? get lastVersion => throw _privateConstructorUsedError;
  List<RemoteStorage> get remotes => throw _privateConstructorUsedError;
  String get defaultRemote => throw _privateConstructorUsedError;
  bool get nativeWindowTitleBar => throw _privateConstructorUsedError;
  bool get startInFullScreen => throw _privateConstructorUsedError;
  SyncMode get syncMode => throw _privateConstructorUsedError;
  InputConfiguration get inputConfiguration =>
      throw _privateConstructorUsedError;
  String get fallbackPack => throw _privateConstructorUsedError;

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
      String localeTag,
      String documentPath,
      double touchSensitivity,
      double mouseSensitivity,
      double penSensitivity,
      double selectSensitivity,
      bool penOnlyInput,
      bool inputGestures,
      String design,
      List<AssetLocation> history,
      bool startEnabled,
      String? lastVersion,
      List<RemoteStorage> remotes,
      String defaultRemote,
      bool nativeWindowTitleBar,
      bool startInFullScreen,
      SyncMode syncMode,
      InputConfiguration inputConfiguration,
      String fallbackPack});

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
    Object? localeTag = null,
    Object? documentPath = null,
    Object? touchSensitivity = null,
    Object? mouseSensitivity = null,
    Object? penSensitivity = null,
    Object? selectSensitivity = null,
    Object? penOnlyInput = null,
    Object? inputGestures = null,
    Object? design = null,
    Object? history = null,
    Object? startEnabled = null,
    Object? lastVersion = freezed,
    Object? remotes = null,
    Object? defaultRemote = null,
    Object? nativeWindowTitleBar = null,
    Object? startInFullScreen = null,
    Object? syncMode = null,
    Object? inputConfiguration = null,
    Object? fallbackPack = null,
  }) {
    return _then(_value.copyWith(
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
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
      history: null == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<AssetLocation>,
      startEnabled: null == startEnabled
          ? _value.startEnabled
          : startEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      lastVersion: freezed == lastVersion
          ? _value.lastVersion
          : lastVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      remotes: null == remotes
          ? _value.remotes
          : remotes // ignore: cast_nullable_to_non_nullable
              as List<RemoteStorage>,
      defaultRemote: null == defaultRemote
          ? _value.defaultRemote
          : defaultRemote // ignore: cast_nullable_to_non_nullable
              as String,
      nativeWindowTitleBar: null == nativeWindowTitleBar
          ? _value.nativeWindowTitleBar
          : nativeWindowTitleBar // ignore: cast_nullable_to_non_nullable
              as bool,
      startInFullScreen: null == startInFullScreen
          ? _value.startInFullScreen
          : startInFullScreen // ignore: cast_nullable_to_non_nullable
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
abstract class _$$_ButterflySettingsCopyWith<$Res>
    implements $ButterflySettingsCopyWith<$Res> {
  factory _$$_ButterflySettingsCopyWith(_$_ButterflySettings value,
          $Res Function(_$_ButterflySettings) then) =
      __$$_ButterflySettingsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ThemeMode theme,
      String localeTag,
      String documentPath,
      double touchSensitivity,
      double mouseSensitivity,
      double penSensitivity,
      double selectSensitivity,
      bool penOnlyInput,
      bool inputGestures,
      String design,
      List<AssetLocation> history,
      bool startEnabled,
      String? lastVersion,
      List<RemoteStorage> remotes,
      String defaultRemote,
      bool nativeWindowTitleBar,
      bool startInFullScreen,
      SyncMode syncMode,
      InputConfiguration inputConfiguration,
      String fallbackPack});

  @override
  $InputConfigurationCopyWith<$Res> get inputConfiguration;
}

/// @nodoc
class __$$_ButterflySettingsCopyWithImpl<$Res>
    extends _$ButterflySettingsCopyWithImpl<$Res, _$_ButterflySettings>
    implements _$$_ButterflySettingsCopyWith<$Res> {
  __$$_ButterflySettingsCopyWithImpl(
      _$_ButterflySettings _value, $Res Function(_$_ButterflySettings) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? localeTag = null,
    Object? documentPath = null,
    Object? touchSensitivity = null,
    Object? mouseSensitivity = null,
    Object? penSensitivity = null,
    Object? selectSensitivity = null,
    Object? penOnlyInput = null,
    Object? inputGestures = null,
    Object? design = null,
    Object? history = null,
    Object? startEnabled = null,
    Object? lastVersion = freezed,
    Object? remotes = null,
    Object? defaultRemote = null,
    Object? nativeWindowTitleBar = null,
    Object? startInFullScreen = null,
    Object? syncMode = null,
    Object? inputConfiguration = null,
    Object? fallbackPack = null,
  }) {
    return _then(_$_ButterflySettings(
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
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
      history: null == history
          ? _value._history
          : history // ignore: cast_nullable_to_non_nullable
              as List<AssetLocation>,
      startEnabled: null == startEnabled
          ? _value.startEnabled
          : startEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      lastVersion: freezed == lastVersion
          ? _value.lastVersion
          : lastVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      remotes: null == remotes
          ? _value._remotes
          : remotes // ignore: cast_nullable_to_non_nullable
              as List<RemoteStorage>,
      defaultRemote: null == defaultRemote
          ? _value.defaultRemote
          : defaultRemote // ignore: cast_nullable_to_non_nullable
              as String,
      nativeWindowTitleBar: null == nativeWindowTitleBar
          ? _value.nativeWindowTitleBar
          : nativeWindowTitleBar // ignore: cast_nullable_to_non_nullable
              as bool,
      startInFullScreen: null == startInFullScreen
          ? _value.startInFullScreen
          : startInFullScreen // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc

class _$_ButterflySettings extends _ButterflySettings {
  const _$_ButterflySettings(
      {this.theme = ThemeMode.system,
      this.localeTag = '',
      this.documentPath = '',
      this.touchSensitivity = 1,
      this.mouseSensitivity = 1,
      this.penSensitivity = 1,
      this.selectSensitivity = 5,
      this.penOnlyInput = false,
      this.inputGestures = true,
      this.design = '',
      final List<AssetLocation> history = const [],
      this.startEnabled = true,
      this.lastVersion,
      final List<RemoteStorage> remotes = const [],
      this.defaultRemote = '',
      this.nativeWindowTitleBar = false,
      this.startInFullScreen = false,
      this.syncMode = SyncMode.noMobile,
      this.inputConfiguration = const InputConfiguration(),
      this.fallbackPack = ''})
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
  final bool startEnabled;
  @override
  final String? lastVersion;
  final List<RemoteStorage> _remotes;
  @override
  @JsonKey()
  List<RemoteStorage> get remotes {
    if (_remotes is EqualUnmodifiableListView) return _remotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_remotes);
  }

  @override
  @JsonKey()
  final String defaultRemote;
  @override
  @JsonKey()
  final bool nativeWindowTitleBar;
  @override
  @JsonKey()
  final bool startInFullScreen;
  @override
  @JsonKey()
  final SyncMode syncMode;
  @override
  @JsonKey()
  final InputConfiguration inputConfiguration;
  @override
  @JsonKey()
  final String fallbackPack;

  @override
  String toString() {
    return 'ButterflySettings(theme: $theme, localeTag: $localeTag, documentPath: $documentPath, touchSensitivity: $touchSensitivity, mouseSensitivity: $mouseSensitivity, penSensitivity: $penSensitivity, selectSensitivity: $selectSensitivity, penOnlyInput: $penOnlyInput, inputGestures: $inputGestures, design: $design, history: $history, startEnabled: $startEnabled, lastVersion: $lastVersion, remotes: $remotes, defaultRemote: $defaultRemote, nativeWindowTitleBar: $nativeWindowTitleBar, startInFullScreen: $startInFullScreen, syncMode: $syncMode, inputConfiguration: $inputConfiguration, fallbackPack: $fallbackPack)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ButterflySettings &&
            (identical(other.theme, theme) || other.theme == theme) &&
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
            const DeepCollectionEquality().equals(other._history, _history) &&
            (identical(other.startEnabled, startEnabled) ||
                other.startEnabled == startEnabled) &&
            (identical(other.lastVersion, lastVersion) ||
                other.lastVersion == lastVersion) &&
            const DeepCollectionEquality().equals(other._remotes, _remotes) &&
            (identical(other.defaultRemote, defaultRemote) ||
                other.defaultRemote == defaultRemote) &&
            (identical(other.nativeWindowTitleBar, nativeWindowTitleBar) ||
                other.nativeWindowTitleBar == nativeWindowTitleBar) &&
            (identical(other.startInFullScreen, startInFullScreen) ||
                other.startInFullScreen == startInFullScreen) &&
            (identical(other.syncMode, syncMode) ||
                other.syncMode == syncMode) &&
            (identical(other.inputConfiguration, inputConfiguration) ||
                other.inputConfiguration == inputConfiguration) &&
            (identical(other.fallbackPack, fallbackPack) ||
                other.fallbackPack == fallbackPack));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        theme,
        localeTag,
        documentPath,
        touchSensitivity,
        mouseSensitivity,
        penSensitivity,
        selectSensitivity,
        penOnlyInput,
        inputGestures,
        design,
        const DeepCollectionEquality().hash(_history),
        startEnabled,
        lastVersion,
        const DeepCollectionEquality().hash(_remotes),
        defaultRemote,
        nativeWindowTitleBar,
        startInFullScreen,
        syncMode,
        inputConfiguration,
        fallbackPack
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ButterflySettingsCopyWith<_$_ButterflySettings> get copyWith =>
      __$$_ButterflySettingsCopyWithImpl<_$_ButterflySettings>(
          this, _$identity);
}

abstract class _ButterflySettings extends ButterflySettings {
  const factory _ButterflySettings(
      {final ThemeMode theme,
      final String localeTag,
      final String documentPath,
      final double touchSensitivity,
      final double mouseSensitivity,
      final double penSensitivity,
      final double selectSensitivity,
      final bool penOnlyInput,
      final bool inputGestures,
      final String design,
      final List<AssetLocation> history,
      final bool startEnabled,
      final String? lastVersion,
      final List<RemoteStorage> remotes,
      final String defaultRemote,
      final bool nativeWindowTitleBar,
      final bool startInFullScreen,
      final SyncMode syncMode,
      final InputConfiguration inputConfiguration,
      final String fallbackPack}) = _$_ButterflySettings;
  const _ButterflySettings._() : super._();

  @override
  ThemeMode get theme;
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
  List<AssetLocation> get history;
  @override
  bool get startEnabled;
  @override
  String? get lastVersion;
  @override
  List<RemoteStorage> get remotes;
  @override
  String get defaultRemote;
  @override
  bool get nativeWindowTitleBar;
  @override
  bool get startInFullScreen;
  @override
  SyncMode get syncMode;
  @override
  InputConfiguration get inputConfiguration;
  @override
  String get fallbackPack;
  @override
  @JsonKey(ignore: true)
  _$$_ButterflySettingsCopyWith<_$_ButterflySettings> get copyWith =>
      throw _privateConstructorUsedError;
}
