// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SimplePoint _$SimplePointFromJson(Map json) =>
    _SimplePoint((json['x'] as num).toDouble(), (json['y'] as num).toDouble());

Map<String, dynamic> _$SimplePointToJson(_SimplePoint instance) =>
    <String, dynamic>{'x': instance.x, 'y': instance.y};

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

_PolygonPoint _$PolygonPointFromJson(Map json) => _PolygonPoint(
  (json['x'] as num).toDouble(),
  (json['y'] as num).toDouble(),
  handleIn: json['handleIn'] == null
      ? null
      : SimplePoint.fromJson(
          Map<String, dynamic>.from(json['handleIn'] as Map),
        ),
  handleOut: json['handleOut'] == null
      ? null
      : SimplePoint.fromJson(
          Map<String, dynamic>.from(json['handleOut'] as Map),
        ),
);

Map<String, dynamic> _$PolygonPointToJson(_PolygonPoint instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'handleIn': instance.handleIn?.toJson(),
      'handleOut': instance.handleOut?.toJson(),
    };
