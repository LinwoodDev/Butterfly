// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waypoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Waypoint _$WaypointFromJson(Map json) => Waypoint(
  json['name'] as String?,
  const DoublePointJsonConverter().fromJson(json['position'] as Map),
  (json['scale'] as num?)?.toDouble(),
);

Map<String, dynamic> _$WaypointToJson(Waypoint instance) => <String, dynamic>{
  'name': instance.name,
  'position': const DoublePointJsonConverter().toJson(instance.position),
  'scale': instance.scale,
};
