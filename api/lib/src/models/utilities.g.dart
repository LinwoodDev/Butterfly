// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utilities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UtilitiesStateImpl _$$UtilitiesStateImplFromJson(Map json) =>
    _$UtilitiesStateImpl(
      lockLayer: json['lockLayer'] as bool? ?? false,
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

Map<String, dynamic> _$$UtilitiesStateImplToJson(
        _$UtilitiesStateImpl instance) =>
    <String, dynamic>{
      'lockLayer': instance.lockLayer,
      'lockZoom': instance.lockZoom,
      'lockHorizontal': instance.lockHorizontal,
      'lockVertical': instance.lockVertical,
      'rulerEnabled': instance.rulerEnabled,
      'gridEnabled': instance.gridEnabled,
      'rulerPosition':
          const DoublePointJsonConverter().toJson(instance.rulerPosition),
      'rulerAngle': instance.rulerAngle,
    };
