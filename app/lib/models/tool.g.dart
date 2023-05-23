// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ToolState _$$_ToolStateFromJson(Map json) => _$_ToolState(
      rulerEnabled: json['rulerEnabled'] as bool? ?? false,
      gridEnabled: json['gridEnabled'] as bool? ?? false,
      navbarEnabled: json['navbarEnabled'] as bool? ?? true,
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
      'navbarEnabled': instance.navbarEnabled,
      'rulerPosition':
          const DoublePointJsonConverter().toJson(instance.rulerPosition),
      'rulerAngle': instance.rulerAngle,
    };
