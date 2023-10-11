// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentInfoImpl _$$DocumentInfoImplFromJson(Map json) => _$DocumentInfoImpl(
      tools: (json['tools'] as List<dynamic>?)
              ?.map((e) => Tool.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      exportPresets: (json['exportPresets'] as List<dynamic>?)
              ?.map((e) =>
                  ExportPreset.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      view: json['view'] == null
          ? const ViewOption()
          : ViewOption.fromJson(Map<String, dynamic>.from(json['view'] as Map)),
    );

Map<String, dynamic> _$$DocumentInfoImplToJson(_$DocumentInfoImpl instance) =>
    <String, dynamic>{
      'tools': instance.tools.map((e) => e.toJson()).toList(),
      'exportPresets': instance.exportPresets.map((e) => e.toJson()).toList(),
      'view': instance.view.toJson(),
    };
