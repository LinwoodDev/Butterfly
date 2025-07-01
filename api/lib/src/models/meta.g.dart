// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FileMetadata _$FileMetadataFromJson(Map json) => _FileMetadata(
  fileVersion: (json['fileVersion'] as num?)?.toInt(),
  type: $enumDecode(_$NoteFileTypeEnumMap, json['type']),
  createdAt: _$JsonConverterFromJson<int, DateTime>(
    json['createdAt'],
    const DateTimeJsonConverter().fromJson,
  ),
  updatedAt: _$JsonConverterFromJson<int, DateTime>(
    json['updatedAt'],
    const DateTimeJsonConverter().fromJson,
  ),
  name: json['name'] as String? ?? '',
  description: json['description'] as String? ?? '',
  author: json['author'] as String? ?? '',
  directory: json['directory'] as String? ?? '',
  version: json['version'] as String? ?? '',
);

Map<String, dynamic> _$FileMetadataToJson(_FileMetadata instance) =>
    <String, dynamic>{
      'fileVersion': instance.fileVersion,
      'type': _$NoteFileTypeEnumMap[instance.type]!,
      'createdAt': _$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const DateTimeJsonConverter().toJson,
      ),
      'updatedAt': _$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const DateTimeJsonConverter().toJson,
      ),
      'name': instance.name,
      'description': instance.description,
      'author': instance.author,
      'directory': instance.directory,
      'version': instance.version,
    };

const _$NoteFileTypeEnumMap = {
  NoteFileType.document: 'document',
  NoteFileType.template: 'template',
  NoteFileType.pack: 'pack',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
