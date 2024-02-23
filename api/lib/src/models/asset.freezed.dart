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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$AssetLocationImplCopyWith<$Res>
    implements $AssetLocationCopyWith<$Res> {
  factory _$$AssetLocationImplCopyWith(
          _$AssetLocationImpl value, $Res Function(_$AssetLocationImpl) then) =
      __$$AssetLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String remote, String path, bool absolute});
}

/// @nodoc
class __$$AssetLocationImplCopyWithImpl<$Res>
    extends _$AssetLocationCopyWithImpl<$Res, _$AssetLocationImpl>
    implements _$$AssetLocationImplCopyWith<$Res> {
  __$$AssetLocationImplCopyWithImpl(
      _$AssetLocationImpl _value, $Res Function(_$AssetLocationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remote = null,
    Object? path = null,
    Object? absolute = null,
  }) {
    return _then(_$AssetLocationImpl(
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
class _$AssetLocationImpl extends _AssetLocation {
  const _$AssetLocationImpl(
      {this.remote = '', required this.path, this.absolute = false})
      : super._();

  factory _$AssetLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssetLocationImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssetLocationImpl &&
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
  _$$AssetLocationImplCopyWith<_$AssetLocationImpl> get copyWith =>
      __$$AssetLocationImplCopyWithImpl<_$AssetLocationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssetLocationImplToJson(
      this,
    );
  }
}

abstract class _AssetLocation extends AssetLocation {
  const factory _AssetLocation(
      {final String remote,
      required final String path,
      final bool absolute}) = _$AssetLocationImpl;
  const _AssetLocation._() : super._();

  factory _AssetLocation.fromJson(Map<String, dynamic> json) =
      _$AssetLocationImpl.fromJson;

  @override
  String get remote;
  @override
  String get path;
  @override
  bool get absolute;
  @override
  @JsonKey(ignore: true)
  _$$AssetLocationImplCopyWith<_$AssetLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AppDocumentEntity {
  AssetLocation get location => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AssetLocation location, List<int> data,
            bool cached, FileMetadata? metadata, Uint8List? thumbnail)
        file,
    required TResult Function(
            AssetLocation location, List<AppDocumentEntity> assets)
        directory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AssetLocation location, List<int> data, bool cached,
            FileMetadata? metadata, Uint8List? thumbnail)?
        file,
    TResult? Function(AssetLocation location, List<AppDocumentEntity> assets)?
        directory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AssetLocation location, List<int> data, bool cached,
            FileMetadata? metadata, Uint8List? thumbnail)?
        file,
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
abstract class _$$AppDocumentFileImplCopyWith<$Res>
    implements $AppDocumentEntityCopyWith<$Res> {
  factory _$$AppDocumentFileImplCopyWith(_$AppDocumentFileImpl value,
          $Res Function(_$AppDocumentFileImpl) then) =
      __$$AppDocumentFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AssetLocation location,
      List<int> data,
      bool cached,
      FileMetadata? metadata,
      Uint8List? thumbnail});

  @override
  $AssetLocationCopyWith<$Res> get location;
  $FileMetadataCopyWith<$Res>? get metadata;
}

/// @nodoc
class __$$AppDocumentFileImplCopyWithImpl<$Res>
    extends _$AppDocumentEntityCopyWithImpl<$Res, _$AppDocumentFileImpl>
    implements _$$AppDocumentFileImplCopyWith<$Res> {
  __$$AppDocumentFileImplCopyWithImpl(
      _$AppDocumentFileImpl _value, $Res Function(_$AppDocumentFileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? data = null,
    Object? cached = null,
    Object? metadata = freezed,
    Object? thumbnail = freezed,
  }) {
    return _then(_$AppDocumentFileImpl(
      null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as AssetLocation,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<int>,
      cached: null == cached
          ? _value.cached
          : cached // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as FileMetadata?,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $FileMetadataCopyWith<$Res>? get metadata {
    if (_value.metadata == null) {
      return null;
    }

    return $FileMetadataCopyWith<$Res>(_value.metadata!, (value) {
      return _then(_value.copyWith(metadata: value));
    });
  }
}

/// @nodoc

class _$AppDocumentFileImpl extends AppDocumentFile {
  const _$AppDocumentFileImpl(this.location,
      {final List<int> data = const [],
      this.cached = false,
      this.metadata,
      this.thumbnail})
      : _data = data,
        super._();

  @override
  final AssetLocation location;
  final List<int> _data;
  @override
  @JsonKey()
  List<int> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey()
  final bool cached;
  @override
  final FileMetadata? metadata;
  @override
  final Uint8List? thumbnail;

  @override
  String toString() {
    return 'AppDocumentEntity.file(location: $location, data: $data, cached: $cached, metadata: $metadata, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppDocumentFileImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.cached, cached) || other.cached == cached) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            const DeepCollectionEquality().equals(other.thumbnail, thumbnail));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      location,
      const DeepCollectionEquality().hash(_data),
      cached,
      metadata,
      const DeepCollectionEquality().hash(thumbnail));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppDocumentFileImplCopyWith<_$AppDocumentFileImpl> get copyWith =>
      __$$AppDocumentFileImplCopyWithImpl<_$AppDocumentFileImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AssetLocation location, List<int> data,
            bool cached, FileMetadata? metadata, Uint8List? thumbnail)
        file,
    required TResult Function(
            AssetLocation location, List<AppDocumentEntity> assets)
        directory,
  }) {
    return file(location, data, cached, metadata, thumbnail);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AssetLocation location, List<int> data, bool cached,
            FileMetadata? metadata, Uint8List? thumbnail)?
        file,
    TResult? Function(AssetLocation location, List<AppDocumentEntity> assets)?
        directory,
  }) {
    return file?.call(location, data, cached, metadata, thumbnail);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AssetLocation location, List<int> data, bool cached,
            FileMetadata? metadata, Uint8List? thumbnail)?
        file,
    TResult Function(AssetLocation location, List<AppDocumentEntity> assets)?
        directory,
    required TResult orElse(),
  }) {
    if (file != null) {
      return file(location, data, cached, metadata, thumbnail);
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
  const factory AppDocumentFile(final AssetLocation location,
      {final List<int> data,
      final bool cached,
      final FileMetadata? metadata,
      final Uint8List? thumbnail}) = _$AppDocumentFileImpl;
  const AppDocumentFile._() : super._();

  @override
  AssetLocation get location;
  List<int> get data;
  bool get cached;
  FileMetadata? get metadata;
  Uint8List? get thumbnail;
  @override
  @JsonKey(ignore: true)
  _$$AppDocumentFileImplCopyWith<_$AppDocumentFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppDocumentDirectoryImplCopyWith<$Res>
    implements $AppDocumentEntityCopyWith<$Res> {
  factory _$$AppDocumentDirectoryImplCopyWith(_$AppDocumentDirectoryImpl value,
          $Res Function(_$AppDocumentDirectoryImpl) then) =
      __$$AppDocumentDirectoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AssetLocation location, List<AppDocumentEntity> assets});

  @override
  $AssetLocationCopyWith<$Res> get location;
}

/// @nodoc
class __$$AppDocumentDirectoryImplCopyWithImpl<$Res>
    extends _$AppDocumentEntityCopyWithImpl<$Res, _$AppDocumentDirectoryImpl>
    implements _$$AppDocumentDirectoryImplCopyWith<$Res> {
  __$$AppDocumentDirectoryImplCopyWithImpl(_$AppDocumentDirectoryImpl _value,
      $Res Function(_$AppDocumentDirectoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? assets = null,
  }) {
    return _then(_$AppDocumentDirectoryImpl(
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

class _$AppDocumentDirectoryImpl extends AppDocumentDirectory {
  const _$AppDocumentDirectoryImpl(this.location,
      [final List<AppDocumentEntity> assets = const []])
      : _assets = assets,
        super._();

  @override
  final AssetLocation location;
  final List<AppDocumentEntity> _assets;
  @override
  @JsonKey()
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppDocumentDirectoryImpl &&
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
  _$$AppDocumentDirectoryImplCopyWith<_$AppDocumentDirectoryImpl>
      get copyWith =>
          __$$AppDocumentDirectoryImplCopyWithImpl<_$AppDocumentDirectoryImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AssetLocation location, List<int> data,
            bool cached, FileMetadata? metadata, Uint8List? thumbnail)
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
    TResult? Function(AssetLocation location, List<int> data, bool cached,
            FileMetadata? metadata, Uint8List? thumbnail)?
        file,
    TResult? Function(AssetLocation location, List<AppDocumentEntity> assets)?
        directory,
  }) {
    return directory?.call(location, assets);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AssetLocation location, List<int> data, bool cached,
            FileMetadata? metadata, Uint8List? thumbnail)?
        file,
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
  const factory AppDocumentDirectory(final AssetLocation location,
      [final List<AppDocumentEntity> assets]) = _$AppDocumentDirectoryImpl;
  const AppDocumentDirectory._() : super._();

  @override
  AssetLocation get location;
  List<AppDocumentEntity> get assets;
  @override
  @JsonKey(ignore: true)
  _$$AppDocumentDirectoryImplCopyWith<_$AppDocumentDirectoryImpl>
      get copyWith => throw _privateConstructorUsedError;
}
