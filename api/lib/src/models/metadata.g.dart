// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FileMetadata _$$_FileMetadataFromJson(Map json) => _$_FileMetadata(
      version: json['version'] as int,
      type: json['type'] as String,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? '',
    );

Map<String, dynamic> _$$_FileMetadataToJson(_$_FileMetadata instance) =>
    <String, dynamic>{
      'version': instance.version,
      'type': instance.type,
      'name': instance.name,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
    };
