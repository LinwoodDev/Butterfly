// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AssetLocation _$AssetLocationFromJson(Map<String, dynamic> json) {
  return _AssetLocation.fromJson(json);
}

/// @nodoc
mixin _$AssetLocation {
  String get remote => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  bool get absolute => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssetLocationCopyWith<AssetLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetLocationCopyWith<$Res> {
  factory $AssetLocationCopyWith(
          AssetLocation value, $Res Function(AssetLocation) then) =
      _$AssetLocationCopyWithImpl<$Res, AssetLocation>;
  @useResult
  $Res call({String remote, String path, bool absolute});
}

/// @nodoc
class _$AssetLocationCopyWithImpl<$Res, $Val extends AssetLocation>
    implements $AssetLocationCopyWith<$Res> {
  _$AssetLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remote = null,
    Object? path = null,
    Object? absolute = null,
  }) {
    return _then(_value.copyWith(
      remote: null == remote
          ? _value.remote
          : remote // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      absolute: null == absolute
          ? _value.absolute
          : absolute // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AssetLocationCopyWith<$Res>
    implements $AssetLocationCopyWith<$Res> {
  factory _$$_AssetLocationCopyWith(
          _$_AssetLocation value, $Res Function(_$_AssetLocation) then) =
      __$$_AssetLocationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String remote, String path, bool absolute});
}

/// @nodoc
class __$$_AssetLocationCopyWithImpl<$Res>
    extends _$AssetLocationCopyWithImpl<$Res, _$_AssetLocation>
    implements _$$_AssetLocationCopyWith<$Res> {
  __$$_AssetLocationCopyWithImpl(
      _$_AssetLocation _value, $Res Function(_$_AssetLocation) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remote = null,
    Object? path = null,
    Object? absolute = null,
  }) {
    return _then(_$_AssetLocation(
      remote: null == remote
          ? _value.remote
          : remote // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      absolute: null == absolute
          ? _value.absolute
          : absolute // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AssetLocation extends _AssetLocation {
  const _$_AssetLocation(
      {this.remote = '', required this.path, this.absolute = false})
      : super._();

  factory _$_AssetLocation.fromJson(Map<String, dynamic> json) =>
      _$$_AssetLocationFromJson(json);

  @override
  @JsonKey()
  final String remote;
  @override
  final String path;
  @override
  @JsonKey()
  final bool absolute;

  @override
  String toString() {
    return 'AssetLocation(remote: $remote, path: $path, absolute: $absolute)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AssetLocation &&
            (identical(other.remote, remote) || other.remote == remote) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.absolute, absolute) ||
                other.absolute == absolute));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, remote, path, absolute);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AssetLocationCopyWith<_$_AssetLocation> get copyWith =>
      __$$_AssetLocationCopyWithImpl<_$_AssetLocation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AssetLocationToJson(
      this,
    );
  }
}

abstract class _AssetLocation extends AssetLocation {
  const factory _AssetLocation(
      {final String remote,
      required final String path,
      final bool absolute}) = _$_AssetLocation;
  const _AssetLocation._() : super._();

  factory _AssetLocation.fromJson(Map<String, dynamic> json) =
      _$_AssetLocation.fromJson;

  @override
  String get remote;
  @override
  String get path;
  @override
  bool get absolute;
  @override
  @JsonKey(ignore: true)
  _$$_AssetLocationCopyWith<_$_AssetLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AppDocumentEntity {
  AssetLocation get location => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            AssetLocation location, List<int> data, bool cached)
        file,
    required TResult Function(
            AssetLocation location, List<AppDocumentEntity> assets)
        directory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AssetLocation location, List<int> data, bool cached)?
        file,
    TResult? Function(AssetLocation location, List<AppDocumentEntity> assets)?
        directory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AssetLocation location, List<int> data, bool cached)? file,
    TResult Function(AssetLocation location, List<AppDocumentEntity> assets)?
        directory,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppDocumentFile value) file,
    required TResult Function(AppDocumentDirectory value) directory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppDocumentFile value)? file,
    TResult? Function(AppDocumentDirectory value)? directory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppDocumentFile value)? file,
    TResult Function(AppDocumentDirectory value)? directory,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppDocumentEntityCopyWith<AppDocumentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppDocumentEntityCopyWith<$Res> {
  factory $AppDocumentEntityCopyWith(
          AppDocumentEntity value, $Res Function(AppDocumentEntity) then) =
      _$AppDocumentEntityCopyWithImpl<$Res, AppDocumentEntity>;
  @useResult
  $Res call({AssetLocation location});

  $AssetLocationCopyWith<$Res> get location;
}

/// @nodoc
class _$AppDocumentEntityCopyWithImpl<$Res, $Val extends AppDocumentEntity>
    implements $AppDocumentEntityCopyWith<$Res> {
  _$AppDocumentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
  }) {
    return _then(_value.copyWith(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as AssetLocation,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AssetLocationCopyWith<$Res> get location {
    return $AssetLocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppDocumentFileCopyWith<$Res>
    implements $AppDocumentEntityCopyWith<$Res> {
  factory _$$AppDocumentFileCopyWith(
          _$AppDocumentFile value, $Res Function(_$AppDocumentFile) then) =
      __$$AppDocumentFileCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AssetLocation location, List<int> data, bool cached});

  @override
  $AssetLocationCopyWith<$Res> get location;
}

/// @nodoc
class __$$AppDocumentFileCopyWithImpl<$Res>
    extends _$AppDocumentEntityCopyWithImpl<$Res, _$AppDocumentFile>
    implements _$$AppDocumentFileCopyWith<$Res> {
  __$$AppDocumentFileCopyWithImpl(
      _$AppDocumentFile _value, $Res Function(_$AppDocumentFile) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? data = null,
    Object? cached = null,
  }) {
    return _then(_$AppDocumentFile(
      null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as AssetLocation,
      null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<int>,
      cached: null == cached
          ? _value.cached
          : cached // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AppDocumentFile extends AppDocumentFile {
  const _$AppDocumentFile(this.location, final List<int> data,
      {this.cached = false})
      : _data = data,
        super._();

  @override
  final AssetLocation location;
  final List<int> _data;
  @override
  List<int> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey()
  final bool cached;

  @override
  String toString() {
    return 'AppDocumentEntity.file(location: $location, data: $data, cached: $cached)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppDocumentFile &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.cached, cached) || other.cached == cached));
  }

  @override
  int get hashCode => Object.hash(runtimeType, location,
      const DeepCollectionEquality().hash(_data), cached);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppDocumentFileCopyWith<_$AppDocumentFile> get copyWith =>
      __$$AppDocumentFileCopyWithImpl<_$AppDocumentFile>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            AssetLocation location, List<int> data, bool cached)
        file,
    required TResult Function(
            AssetLocation location, List<AppDocumentEntity> assets)
        directory,
  }) {
    return file(location, data, cached);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AssetLocation location, List<int> data, bool cached)?
        file,
    TResult? Function(AssetLocation location, List<AppDocumentEntity> assets)?
        directory,
  }) {
    return file?.call(location, data, cached);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AssetLocation location, List<int> data, bool cached)? file,
    TResult Function(AssetLocation location, List<AppDocumentEntity> assets)?
        directory,
    required TResult orElse(),
  }) {
    if (file != null) {
      return file(location, data, cached);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppDocumentFile value) file,
    required TResult Function(AppDocumentDirectory value) directory,
  }) {
    return file(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppDocumentFile value)? file,
    TResult? Function(AppDocumentDirectory value)? directory,
  }) {
    return file?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppDocumentFile value)? file,
    TResult Function(AppDocumentDirectory value)? directory,
    required TResult orElse(),
  }) {
    if (file != null) {
      return file(this);
    }
    return orElse();
  }
}

abstract class AppDocumentFile extends AppDocumentEntity {
  const factory AppDocumentFile(
      final AssetLocation location, final List<int> data,
      {final bool cached}) = _$AppDocumentFile;
  const AppDocumentFile._() : super._();

  @override
  AssetLocation get location;
  List<int> get data;
  bool get cached;
  @override
  @JsonKey(ignore: true)
  _$$AppDocumentFileCopyWith<_$AppDocumentFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppDocumentDirectoryCopyWith<$Res>
    implements $AppDocumentEntityCopyWith<$Res> {
  factory _$$AppDocumentDirectoryCopyWith(_$AppDocumentDirectory value,
          $Res Function(_$AppDocumentDirectory) then) =
      __$$AppDocumentDirectoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AssetLocation location, List<AppDocumentEntity> assets});

  @override
  $AssetLocationCopyWith<$Res> get location;
}

/// @nodoc
class __$$AppDocumentDirectoryCopyWithImpl<$Res>
    extends _$AppDocumentEntityCopyWithImpl<$Res, _$AppDocumentDirectory>
    implements _$$AppDocumentDirectoryCopyWith<$Res> {
  __$$AppDocumentDirectoryCopyWithImpl(_$AppDocumentDirectory _value,
      $Res Function(_$AppDocumentDirectory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? assets = null,
  }) {
    return _then(_$AppDocumentDirectory(
      null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as AssetLocation,
      null == assets
          ? _value._assets
          : assets // ignore: cast_nullable_to_non_nullable
              as List<AppDocumentEntity>,
    ));
  }
}

/// @nodoc

class _$AppDocumentDirectory extends AppDocumentDirectory {
  const _$AppDocumentDirectory(
      this.location, final List<AppDocumentEntity> assets)
      : _assets = assets,
        super._();

  @override
  final AssetLocation location;
  final List<AppDocumentEntity> _assets;
  @override
  List<AppDocumentEntity> get assets {
    if (_assets is EqualUnmodifiableListView) return _assets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assets);
  }

  @override
  String toString() {
    return 'AppDocumentEntity.directory(location: $location, assets: $assets)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppDocumentDirectory &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other._assets, _assets));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, location, const DeepCollectionEquality().hash(_assets));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppDocumentDirectoryCopyWith<_$AppDocumentDirectory> get copyWith =>
      __$$AppDocumentDirectoryCopyWithImpl<_$AppDocumentDirectory>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            AssetLocation location, List<int> data, bool cached)
        file,
    required TResult Function(
            AssetLocation location, List<AppDocumentEntity> assets)
        directory,
  }) {
    return directory(location, assets);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AssetLocation location, List<int> data, bool cached)?
        file,
    TResult? Function(AssetLocation location, List<AppDocumentEntity> assets)?
        directory,
  }) {
    return directory?.call(location, assets);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AssetLocation location, List<int> data, bool cached)? file,
    TResult Function(AssetLocation location, List<AppDocumentEntity> assets)?
        directory,
    required TResult orElse(),
  }) {
    if (directory != null) {
      return directory(location, assets);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppDocumentFile value) file,
    required TResult Function(AppDocumentDirectory value) directory,
  }) {
    return directory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppDocumentFile value)? file,
    TResult? Function(AppDocumentDirectory value)? directory,
  }) {
    return directory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppDocumentFile value)? file,
    TResult Function(AppDocumentDirectory value)? directory,
    required TResult orElse(),
  }) {
    if (directory != null) {
      return directory(this);
    }
    return orElse();
  }
}

abstract class AppDocumentDirectory extends AppDocumentEntity {
  const factory AppDocumentDirectory(
          final AssetLocation location, final List<AppDocumentEntity> assets) =
      _$AppDocumentDirectory;
  const AppDocumentDirectory._() : super._();

  @override
  AssetLocation get location;
  List<AppDocumentEntity> get assets;
  @override
  @JsonKey(ignore: true)
  _$$AppDocumentDirectoryCopyWith<_$AppDocumentDirectory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DocumentInfo {
  String get fileName => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DocumentInfoCopyWith<DocumentInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentInfoCopyWith<$Res> {
  factory $DocumentInfoCopyWith(
          DocumentInfo value, $Res Function(DocumentInfo) then) =
      _$DocumentInfoCopyWithImpl<$Res, DocumentInfo>;
  @useResult
  $Res call({String fileName, Map<String, dynamic> data});
}

/// @nodoc
class _$DocumentInfoCopyWithImpl<$Res, $Val extends DocumentInfo>
    implements $DocumentInfoCopyWith<$Res> {
  _$DocumentInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileName = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DocumentInfoCopyWith<$Res>
    implements $DocumentInfoCopyWith<$Res> {
  factory _$$_DocumentInfoCopyWith(
          _$_DocumentInfo value, $Res Function(_$_DocumentInfo) then) =
      __$$_DocumentInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String fileName, Map<String, dynamic> data});
}

/// @nodoc
class __$$_DocumentInfoCopyWithImpl<$Res>
    extends _$DocumentInfoCopyWithImpl<$Res, _$_DocumentInfo>
    implements _$$_DocumentInfoCopyWith<$Res> {
  __$$_DocumentInfoCopyWithImpl(
      _$_DocumentInfo _value, $Res Function(_$_DocumentInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileName = null,
    Object? data = null,
  }) {
    return _then(_$_DocumentInfo(
      null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$_DocumentInfo extends _DocumentInfo {
  const _$_DocumentInfo(this.fileName, final Map<String, dynamic> data)
      : _data = data,
        super._();

  @override
  final String fileName;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'DocumentInfo(fileName: $fileName, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DocumentInfo &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, fileName, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DocumentInfoCopyWith<_$_DocumentInfo> get copyWith =>
      __$$_DocumentInfoCopyWithImpl<_$_DocumentInfo>(this, _$identity);
}

abstract class _DocumentInfo extends DocumentInfo {
  const factory _DocumentInfo(
      final String fileName, final Map<String, dynamic> data) = _$_DocumentInfo;
  const _DocumentInfo._() : super._();

  @override
  String get fileName;
  @override
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$_DocumentInfoCopyWith<_$_DocumentInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
