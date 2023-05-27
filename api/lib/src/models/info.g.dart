// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DocumentInfo _$$_DocumentInfoFromJson(Map json) => _$_DocumentInfo(
      painters: (json['painters'] as List<dynamic>?)
              ?.map(
                  (e) => Painter.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      tool: json['tool'] == null
          ? const ToolOption()
          : ToolOption.fromJson(Map<String, dynamic>.from(json['tool'] as Map)),
    );

Map<String, dynamic> _$$_DocumentInfoToJson(_$_DocumentInfo instance) =>
    <String, dynamic>{
      'painters': instance.painters.map((e) => e.toJson()).toList(),
      'tool': instance.tool.toJson(),
    };
