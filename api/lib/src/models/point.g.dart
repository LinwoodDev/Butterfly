// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PathPoint _$PathPointFromJson(Map json) => _PathPoint(
  (json['x'] as num).toDouble(),
  (json['y'] as num).toDouble(),
  (json['pressure'] as num?)?.toDouble() ?? 1,
);

Map<String, dynamic> _$PathPointToJson(_PathPoint instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'pressure': instance.pressure,
    };
