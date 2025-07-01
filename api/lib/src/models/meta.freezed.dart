// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FileMetadata {

 int? get fileVersion; NoteFileType get type;@DateTimeJsonConverter() DateTime? get createdAt;@DateTimeJsonConverter() DateTime? get updatedAt; String get name; String get description; String get author; String get directory; String get version;
/// Create a copy of FileMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileMetadataCopyWith<FileMetadata> get copyWith => _$FileMetadataCopyWithImpl<FileMetadata>(this as FileMetadata, _$identity);

  /// Serializes this FileMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileMetadata&&(identical(other.fileVersion, fileVersion) || other.fileVersion == fileVersion)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&(identical(other.directory, directory) || other.directory == directory)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileVersion,type,createdAt,updatedAt,name,description,author,directory,version);

@override
String toString() {
  return 'FileMetadata(fileVersion: $fileVersion, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, description: $description, author: $author, directory: $directory, version: $version)';
}


}

/// @nodoc
abstract mixin class $FileMetadataCopyWith<$Res>  {
  factory $FileMetadataCopyWith(FileMetadata value, $Res Function(FileMetadata) _then) = _$FileMetadataCopyWithImpl;
@useResult
$Res call({
 int? fileVersion, NoteFileType type,@DateTimeJsonConverter() DateTime? createdAt,@DateTimeJsonConverter() DateTime? updatedAt, String name, String description, String author, String directory, String version
});




}
/// @nodoc
class _$FileMetadataCopyWithImpl<$Res>
    implements $FileMetadataCopyWith<$Res> {
  _$FileMetadataCopyWithImpl(this._self, this._then);

  final FileMetadata _self;
  final $Res Function(FileMetadata) _then;

/// Create a copy of FileMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fileVersion = freezed,Object? type = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? name = null,Object? description = null,Object? author = null,Object? directory = null,Object? version = null,}) {
  return _then(_self.copyWith(
fileVersion: freezed == fileVersion ? _self.fileVersion : fileVersion // ignore: cast_nullable_to_non_nullable
as int?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NoteFileType,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,directory: null == directory ? _self.directory : directory // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FileMetadata implements FileMetadata {
  const _FileMetadata({this.fileVersion, required this.type, @DateTimeJsonConverter() this.createdAt, @DateTimeJsonConverter() this.updatedAt, this.name = '', this.description = '', this.author = '', this.directory = '', this.version = ''});
  factory _FileMetadata.fromJson(Map<String, dynamic> json) => _$FileMetadataFromJson(json);

@override final  int? fileVersion;
@override final  NoteFileType type;
@override@DateTimeJsonConverter() final  DateTime? createdAt;
@override@DateTimeJsonConverter() final  DateTime? updatedAt;
@override@JsonKey() final  String name;
@override@JsonKey() final  String description;
@override@JsonKey() final  String author;
@override@JsonKey() final  String directory;
@override@JsonKey() final  String version;

/// Create a copy of FileMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileMetadataCopyWith<_FileMetadata> get copyWith => __$FileMetadataCopyWithImpl<_FileMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FileMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileMetadata&&(identical(other.fileVersion, fileVersion) || other.fileVersion == fileVersion)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&(identical(other.directory, directory) || other.directory == directory)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileVersion,type,createdAt,updatedAt,name,description,author,directory,version);

@override
String toString() {
  return 'FileMetadata(fileVersion: $fileVersion, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, description: $description, author: $author, directory: $directory, version: $version)';
}


}

/// @nodoc
abstract mixin class _$FileMetadataCopyWith<$Res> implements $FileMetadataCopyWith<$Res> {
  factory _$FileMetadataCopyWith(_FileMetadata value, $Res Function(_FileMetadata) _then) = __$FileMetadataCopyWithImpl;
@override @useResult
$Res call({
 int? fileVersion, NoteFileType type,@DateTimeJsonConverter() DateTime? createdAt,@DateTimeJsonConverter() DateTime? updatedAt, String name, String description, String author, String directory, String version
});




}
/// @nodoc
class __$FileMetadataCopyWithImpl<$Res>
    implements _$FileMetadataCopyWith<$Res> {
  __$FileMetadataCopyWithImpl(this._self, this._then);

  final _FileMetadata _self;
  final $Res Function(_FileMetadata) _then;

/// Create a copy of FileMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fileVersion = freezed,Object? type = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? name = null,Object? description = null,Object? author = null,Object? directory = null,Object? version = null,}) {
  return _then(_FileMetadata(
fileVersion: freezed == fileVersion ? _self.fileVersion : fileVersion // ignore: cast_nullable_to_non_nullable
as int?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NoteFileType,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,directory: null == directory ? _self.directory : directory // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
