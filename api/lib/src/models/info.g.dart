// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentInfo _$DocumentInfoFromJson(Map json) => _DocumentInfo(
  tools:
      (json['tools'] as List<dynamic>?)
          ?.map((e) => Tool.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList() ??
      const [],
  exportPresets:
      (json['exportPresets'] as List<dynamic>?)
          ?.map(
            (e) => ExportPreset.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList() ??
      const [],
  view: json['view'] == null
      ? const ViewOption()
      : ViewOption.fromJson(Map<String, dynamic>.from(json['view'] as Map)),
  extra:
      (json['extra'] as Map?)?.map((k, e) => MapEntry(k as String, e)) ??
      const {},
);

Map<String, dynamic> _$DocumentInfoToJson(_DocumentInfo instance) =>
    <String, dynamic>{
      'tools': instance.tools.map((e) => e.toJson()).toList(),
      'exportPresets': instance.exportPresets.map((e) => e.toJson()).toList(),
      'view': instance.view.toJson(),
      'extra': instance.extra,
    };
