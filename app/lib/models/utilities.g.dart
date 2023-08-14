// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utilities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UtilitiesState _$$_UtilitiesStateFromJson(Map json) => _$_UtilitiesState(
      lockZoom: json['lockZoom'] as bool? ?? false,
      lockHorizontal: json['lockHorizontal'] as bool? ?? false,
      lockVertical: json['lockVertical'] as bool? ?? false,
      rulerEnabled: json['rulerEnabled'] as bool? ?? false,
      gridEnabled: json['gridEnabled'] as bool? ?? false,
      rulerPosition: json['rulerPosition'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter()
              .fromJson(json['rulerPosition'] as Map),
      rulerAngle: (json['rulerAngle'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$_UtilitiesStateToJson(_$_UtilitiesState instance) =>
    <String, dynamic>{
      'lockZoom': instance.lockZoom,
      'lockHorizontal': instance.lockHorizontal,
      'lockVertical': instance.lockVertical,
      'rulerEnabled': instance.rulerEnabled,
      'gridEnabled': instance.gridEnabled,
      'rulerPosition':
          const DoublePointJsonConverter().toJson(instance.rulerPosition),
      'rulerAngle': instance.rulerAngle,
    };
