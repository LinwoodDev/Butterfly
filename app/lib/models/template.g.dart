// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DocumentTemplate _$$_DocumentTemplateFromJson(Map json) =>
    _$_DocumentTemplate(
      document: AppDocument.fromJson(
          Map<String, dynamic>.from(json['document'] as Map)),
      folder: json['folder'] as String? ?? '/',
    );

Map<String, dynamic> _$$_DocumentTemplateToJson(_$_DocumentTemplate instance) =>
    <String, dynamic>{
      'document': instance.document.toJson(),
      'folder': instance.folder,
    };
