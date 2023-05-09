// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meta.dart';

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
  int? get fileVersion => throw _privateConstructorUsedError;
  NoteFileType get type => throw _privateConstructorUsedError;
  @DateTimeJsonConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @DateTimeJsonConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  String get directory => throw _privateConstructorUsedError;

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
      {int? fileVersion,
      NoteFileType type,
      @DateTimeJsonConverter() DateTime? createdAt,
      @DateTimeJsonConverter() DateTime? updatedAt,
      String name,
      String description,
      String author,
      String directory});
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
    Object? fileVersion = freezed,
    Object? type = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? name = null,
    Object? description = null,
    Object? author = null,
    Object? directory = null,
  }) {
    return _then(_value.copyWith(
      fileVersion: freezed == fileVersion
          ? _value.fileVersion
          : fileVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoteFileType,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      directory: null == directory
          ? _value.directory
          : directory // ignore: cast_nullable_to_non_nullable
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
      {int? fileVersion,
      NoteFileType type,
      @DateTimeJsonConverter() DateTime? createdAt,
      @DateTimeJsonConverter() DateTime? updatedAt,
      String name,
      String description,
      String author,
      String directory});
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
    Object? fileVersion = freezed,
    Object? type = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? name = null,
    Object? description = null,
    Object? author = null,
    Object? directory = null,
  }) {
    return _then(_$_FileMetadata(
      fileVersion: freezed == fileVersion
          ? _value.fileVersion
          : fileVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoteFileType,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      directory: null == directory
          ? _value.directory
          : directory // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FileMetadata implements _FileMetadata {
  const _$_FileMetadata(
      {this.fileVersion,
      required this.type,
      @DateTimeJsonConverter() this.createdAt,
      @DateTimeJsonConverter() this.updatedAt,
      this.name = '',
      this.description = '',
      this.author = '',
      this.directory = ''});

  factory _$_FileMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_FileMetadataFromJson(json);

  @override
  final int? fileVersion;
  @override
  final NoteFileType type;
  @override
  @DateTimeJsonConverter()
  final DateTime? createdAt;
  @override
  @DateTimeJsonConverter()
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String author;
  @override
  @JsonKey()
  final String directory;

  @override
  String toString() {
    return 'FileMetadata(fileVersion: $fileVersion, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, description: $description, author: $author, directory: $directory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FileMetadata &&
            (identical(other.fileVersion, fileVersion) ||
                other.fileVersion == fileVersion) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.directory, directory) ||
                other.directory == directory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fileVersion, type, createdAt,
      updatedAt, name, description, author, directory);

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
      {final int? fileVersion,
      required final NoteFileType type,
      @DateTimeJsonConverter() final DateTime? createdAt,
      @DateTimeJsonConverter() final DateTime? updatedAt,
      final String name,
      final String description,
      final String author,
      final String directory}) = _$_FileMetadata;

  factory _FileMetadata.fromJson(Map<String, dynamic> json) =
      _$_FileMetadata.fromJson;

  @override
  int? get fileVersion;
  @override
  NoteFileType get type;
  @override
  @DateTimeJsonConverter()
  DateTime? get createdAt;
  @override
  @DateTimeJsonConverter()
  DateTime? get updatedAt;
  @override
  String get name;
  @override
  String get description;
  @override
  String get author;
  @override
  String get directory;
  @override
  @JsonKey(ignore: true)
  _$$_FileMetadataCopyWith<_$_FileMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
