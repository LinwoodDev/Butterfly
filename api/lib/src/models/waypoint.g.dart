// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waypoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WaypointImpl _$$WaypointImplFromJson(Map json) => _$WaypointImpl(
      json['name'] as String,
      const DoublePointJsonConverter().fromJson(json['position'] as Map),
      (json['scale'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$WaypointImplToJson(_$WaypointImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'position': const DoublePointJsonConverter().toJson(instance.position),
      'scale': instance.scale,
    };
