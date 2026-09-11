// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FileMetadata {


/// Create a copy of FileMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileMetadataCopyWith<FileMetadata> get copyWith => _$FileMetadataCopyWithImpl<FileMetadata>(this as FileMetadata, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FileMetadata;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileMetadata&&(identical(other.fileVersion, _this.fileVersion) || other.fileVersion == _this.fileVersion)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.author, _this.author) || other.author == _this.author)&&(identical(other.directory, _this.directory) || other.directory == _this.directory)&&(identical(other.fileName, _this.fileName) || other.fileName == _this.fileName)&&(identical(other.version, _this.version) || other.version == _this.version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FileMetadata;
  return Object.hash(runtimeType,_this.fileVersion,_this.type,_this.createdAt,_this.updatedAt,_this.name,_this.description,_this.author,_this.directory,_this.fileName,_this.version);
}

@override
String toString() {
  final _this = this as FileMetadata;
  return 'FileMetadata(fileVersion: ${_this.fileVersion}, type: ${_this.type}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, name: ${_this.name}, description: ${_this.description}, author: ${_this.author}, directory: ${_this.directory}, fileName: ${_this.fileName}, version: ${_this.version})';
}


}

/// @nodoc
abstract mixin class $FileMetadataCopyWith<$Res>  {
  factory $FileMetadataCopyWith(FileMetadata value, $Res Function(FileMetadata) _then) = _$FileMetadataCopyWithImpl;
@useResult
$Res call({
 int? fileVersion, NoteFileType type, DateTime? createdAt, DateTime? updatedAt, String name, String description, String author, String directory, String fileName, String version
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
@pragma('vm:prefer-inline') @override $Res call({Object? fileVersion = freezed,Object? type = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? name = null,Object? description = null,Object? author = null,Object? directory = null,Object? fileName = null,Object? version = null,}) {
  return _then(FileMetadata(
fileVersion: freezed == fileVersion ? _self.fileVersion : fileVersion // ignore: cast_nullable_to_non_nullable
as int?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NoteFileType,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,directory: null == directory ? _self.directory : directory // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



// dart format on
