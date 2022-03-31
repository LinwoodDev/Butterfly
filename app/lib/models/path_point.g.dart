// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'path_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PathPoint _$$_PathPointFromJson(Map<String, dynamic> json) => _$_PathPoint(
      (json['x'] as num).toDouble(),
      (json['y'] as num).toDouble(),
      (json['pressure'] as num?)?.toDouble() ?? 1,
    );

Map<String, dynamic> _$$_PathPointToJson(_$_PathPoint instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'pressure': instance.pressure,
    };
