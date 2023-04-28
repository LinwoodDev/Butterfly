// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FileMetadata _$FileMetadataFromJson(Map<String, dynamic> json) {
  return _FileMetadata.fromJson(json);
}

/// @nodoc
mixin _$FileMetadata {
  int get version => throw _privateConstructorUsedError;
  NoteFileType get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get thumbnail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FileMetadataCopyWith<FileMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileMetadataCopyWith<$Res> {
  factory $FileMetadataCopyWith(
          FileMetadata value, $Res Function(FileMetadata) then) =
      _$FileMetadataCopyWithImpl<$Res, FileMetadata>;
  @useResult
  $Res call(
      {int version,
      NoteFileType type,
      String name,
      String description,
      String thumbnail});
}

/// @nodoc
class _$FileMetadataCopyWithImpl<$Res, $Val extends FileMetadata>
    implements $FileMetadataCopyWith<$Res> {
  _$FileMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? type = null,
    Object? name = null,
    Object? description = null,
    Object? thumbnail = null,
  }) {
    return _then(_value.copyWith(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoteFileType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FileMetadataCopyWith<$Res>
    implements $FileMetadataCopyWith<$Res> {
  factory _$$_FileMetadataCopyWith(
          _$_FileMetadata value, $Res Function(_$_FileMetadata) then) =
      __$$_FileMetadataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int version,
      NoteFileType type,
      String name,
      String description,
      String thumbnail});
}

/// @nodoc
class __$$_FileMetadataCopyWithImpl<$Res>
    extends _$FileMetadataCopyWithImpl<$Res, _$_FileMetadata>
    implements _$$_FileMetadataCopyWith<$Res> {
  __$$_FileMetadataCopyWithImpl(
      _$_FileMetadata _value, $Res Function(_$_FileMetadata) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? type = null,
    Object? name = null,
    Object? description = null,
    Object? thumbnail = null,
  }) {
    return _then(_$_FileMetadata(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoteFileType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FileMetadata implements _FileMetadata {
  const _$_FileMetadata(
      {required this.version,
      required this.type,
      this.name = '',
      this.description = '',
      this.thumbnail = ''});

  factory _$_FileMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_FileMetadataFromJson(json);

  @override
  final int version;
  @override
  final NoteFileType type;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String thumbnail;

  @override
  String toString() {
    return 'FileMetadata(version: $version, type: $type, name: $name, description: $description, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FileMetadata &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, version, type, name, description, thumbnail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FileMetadataCopyWith<_$_FileMetadata> get copyWith =>
      __$$_FileMetadataCopyWithImpl<_$_FileMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FileMetadataToJson(
      this,
    );
  }
}

abstract class _FileMetadata implements FileMetadata {
  const factory _FileMetadata(
      {required final int version,
      required final NoteFileType type,
      final String name,
      final String description,
      final String thumbnail}) = _$_FileMetadata;

  factory _FileMetadata.fromJson(Map<String, dynamic> json) =
      _$_FileMetadata.fromJson;

  @override
  int get version;
  @override
  NoteFileType get type;
  @override
  String get name;
  @override
  String get description;
  @override
  String get thumbnail;
  @override
  @JsonKey(ignore: true)
  _$$_FileMetadataCopyWith<_$_FileMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
