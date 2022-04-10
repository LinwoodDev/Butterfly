// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DocumentTemplate _$$_DocumentTemplateFromJson(Map<String, dynamic> json) =>
    _$_DocumentTemplate(
      document: AppDocument.fromJson(json['document'] as Map<String, dynamic>),
      folder: json['folder'] as String? ?? '/',
    );

Map<String, dynamic> _$$_DocumentTemplateToJson(_$_DocumentTemplate instance) =>
    <String, dynamic>{
      'document': instance.document,
      'folder': instance.folder,
    };
