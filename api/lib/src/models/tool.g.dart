// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ToolOption _$$_ToolOptionFromJson(Map json) => _$_ToolOption(
      gridColor: json['gridColor'] as int? ?? 0,
      gridXSize: (json['gridXSize'] as num?)?.toDouble() ?? 20,
      gridYSize: (json['gridYSize'] as num?)?.toDouble() ?? 20,
    );

Map<String, dynamic> _$$_ToolOptionToJson(_$_ToolOption instance) =>
    <String, dynamic>{
      'gridColor': instance.gridColor,
      'gridXSize': instance.gridXSize,
      'gridYSize': instance.gridYSize,
    };
