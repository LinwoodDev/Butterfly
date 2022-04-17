// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waypoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Waypoint _$$_WaypointFromJson(Map json) => _$_Waypoint(
      json['name'] as String,
      const OffsetJsonConverter()
          .fromJson(json['position'] as Map<String, dynamic>),
      (json['scale'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_WaypointToJson(_$_Waypoint instance) =>
    <String, dynamic>{
      'name': instance.name,
      'position': const OffsetJsonConverter().toJson(instance.position),
      'scale': instance.scale,
    };
