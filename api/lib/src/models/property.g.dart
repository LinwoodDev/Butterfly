// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PenProperty _$PenPropertyFromJson(Map json) => PenProperty(
  strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
  thinning: (json['thinning'] as num?)?.toDouble() ?? 0.4,
  color: json['color'] == null
      ? SRGBColor.black
      : const ColorJsonConverter().fromJson((json['color'] as num).toInt()),
  fill: json['fill'] == null
      ? SRGBColor.transparent
      : const ColorJsonConverter().fromJson((json['fill'] as num).toInt()),
  smoothing: (json['smoothing'] as num?)?.toDouble() ?? 0.5,
  streamline: (json['streamline'] as num?)?.toDouble() ?? 0.3,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$PenPropertyToJson(PenProperty instance) =>
    <String, dynamic>{
      'strokeWidth': instance.strokeWidth,
      'thinning': instance.thinning,
      'color': const ColorJsonConverter().toJson(instance.color),
      'fill': const ColorJsonConverter().toJson(instance.fill),
      'smoothing': instance.smoothing,
      'streamline': instance.streamline,
      'type': instance.$type,
    };

ShapeProperty _$ShapePropertyFromJson(Map json) => ShapeProperty(
  strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
  shape: PathShape.fromJson(Map<String, dynamic>.from(json['shape'] as Map)),
  color: json['color'] == null
      ? SRGBColor.black
      : const ColorJsonConverter().fromJson((json['color'] as num).toInt()),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ShapePropertyToJson(ShapeProperty instance) =>
    <String, dynamic>{
      'strokeWidth': instance.strokeWidth,
      'shape': instance.shape.toJson(),
      'color': const ColorJsonConverter().toJson(instance.color),
      'type': instance.$type,
    };

PolygonProperty _$PolygonPropertyFromJson(Map json) => PolygonProperty(
  strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
  color: json['color'] == null
      ? SRGBColor.black
      : const ColorJsonConverter().fromJson((json['color'] as num).toInt()),
  fill: json['fill'] == null
      ? SRGBColor.transparent
      : const ColorJsonConverter().fromJson((json['fill'] as num).toInt()),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$PolygonPropertyToJson(PolygonProperty instance) =>
    <String, dynamic>{
      'strokeWidth': instance.strokeWidth,
      'color': const ColorJsonConverter().toJson(instance.color),
      'fill': const ColorJsonConverter().toJson(instance.fill),
      'type': instance.$type,
    };

CircleShape _$CircleShapeFromJson(Map json) => CircleShape(
  fillColor: json['fillColor'] == null
      ? SRGBColor.transparent
      : const ColorJsonConverter().fromJson((json['fillColor'] as num).toInt()),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$CircleShapeToJson(CircleShape instance) =>
    <String, dynamic>{
      'fillColor': const ColorJsonConverter().toJson(instance.fillColor),
      'type': instance.$type,
    };

RectangleShape _$RectangleShapeFromJson(Map json) => RectangleShape(
  fillColor: json['fillColor'] == null
      ? SRGBColor.transparent
      : const ColorJsonConverter().fromJson((json['fillColor'] as num).toInt()),
  topLeftCornerRadius: (json['topLeftCornerRadius'] as num?)?.toDouble() ?? 0,
  topRightCornerRadius: (json['topRightCornerRadius'] as num?)?.toDouble() ?? 0,
  bottomLeftCornerRadius:
      (json['bottomLeftCornerRadius'] as num?)?.toDouble() ?? 0,
  bottomRightCornerRadius:
      (json['bottomRightCornerRadius'] as num?)?.toDouble() ?? 0,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$RectangleShapeToJson(RectangleShape instance) =>
    <String, dynamic>{
      'fillColor': const ColorJsonConverter().toJson(instance.fillColor),
      'topLeftCornerRadius': instance.topLeftCornerRadius,
      'topRightCornerRadius': instance.topRightCornerRadius,
      'bottomLeftCornerRadius': instance.bottomLeftCornerRadius,
      'bottomRightCornerRadius': instance.bottomRightCornerRadius,
      'type': instance.$type,
    };

LineShape _$LineShapeFromJson(Map json) =>
    LineShape($type: json['type'] as String?);

Map<String, dynamic> _$LineShapeToJson(LineShape instance) => <String, dynamic>{
  'type': instance.$type,
};

TriangleShape _$TriangleShapeFromJson(Map json) => TriangleShape(
  fillColor: json['fillColor'] == null
      ? SRGBColor.transparent
      : const ColorJsonConverter().fromJson((json['fillColor'] as num).toInt()),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$TriangleShapeToJson(TriangleShape instance) =>
    <String, dynamic>{
      'fillColor': const ColorJsonConverter().toJson(instance.fillColor),
      'type': instance.$type,
    };
