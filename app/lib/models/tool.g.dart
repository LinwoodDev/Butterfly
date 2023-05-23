// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ToolState _$$_ToolStateFromJson(Map json) => _$_ToolState(
      rulerEnabled: json['rulerEnabled'] as bool? ?? false,
      gridEnabled: json['gridEnabled'] as bool? ?? false,
      rulerPosition: json['rulerPosition'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter()
              .fromJson(json['rulerPosition'] as Map),
      rulerAngle: (json['rulerAngle'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$_ToolStateToJson(_$_ToolState instance) =>
    <String, dynamic>{
      'rulerEnabled': instance.rulerEnabled,
      'gridEnabled': instance.gridEnabled,
      'rulerPosition':
          const DoublePointJsonConverter().toJson(instance.rulerPosition),
      'rulerAngle': instance.rulerAngle,
    };
