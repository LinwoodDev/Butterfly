// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ToolOption _$$_ToolOptionFromJson(Map json) => _$_ToolOption(
      showGrid: json['showGrid'] as bool? ?? false,
      gridColor: json['gridColor'] as int? ?? 0,
      gridXSize: (json['gridXSize'] as num?)?.toDouble() ?? 20,
      gridYSize: (json['gridYSize'] as num?)?.toDouble() ?? 20,
    );

Map<String, dynamic> _$$_ToolOptionToJson(_$_ToolOption instance) =>
    <String, dynamic>{
      'showGrid': instance.showGrid,
      'gridColor': instance.gridColor,
      'gridXSize': instance.gridXSize,
      'gridYSize': instance.gridYSize,
    };

_$_ToolState _$$_ToolStateFromJson(Map json) => _$_ToolState(
      rulerEnabled: json['rulerEnabled'] as bool? ?? false,
      rulerPosition: json['rulerPosition'] == null
          ? Offset.zero
          : const OffsetJsonConverter().fromJson(json['rulerPosition'] as Map),
      rulerAngle: (json['rulerAngle'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$_ToolStateToJson(_$_ToolState instance) =>
    <String, dynamic>{
      'rulerEnabled': instance.rulerEnabled,
      'rulerPosition':
          const OffsetJsonConverter().toJson(instance.rulerPosition),
      'rulerAngle': instance.rulerAngle,
    };
