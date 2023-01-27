// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PenProperty _$$PenPropertyFromJson(Map json) => _$PenProperty(
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      strokeMultiplier: (json['strokeMultiplier'] as num?)?.toDouble() ?? 0.5,
      color: json['color'] as int? ?? kColorBlack,
      fill: json['fill'] as bool? ?? false,
      smoothing: (json['smoothing'] as num?)?.toDouble() ?? 0.5,
      streamline: (json['streamline'] as num?)?.toDouble() ?? 0.3,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PenPropertyToJson(_$PenProperty instance) =>
    <String, dynamic>{
      'strokeWidth': instance.strokeWidth,
      'strokeMultiplier': instance.strokeMultiplier,
      'color': instance.color,
      'fill': instance.fill,
      'smoothing': instance.smoothing,
      'streamline': instance.streamline,
      'type': instance.$type,
    };

_$ShapeProperty _$$ShapePropertyFromJson(Map json) => _$ShapeProperty(
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      shape:
          PathShape.fromJson(Map<String, dynamic>.from(json['shape'] as Map)),
      color: json['color'] as int? ?? kColorBlack,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ShapePropertyToJson(_$ShapeProperty instance) =>
    <String, dynamic>{
      'strokeWidth': instance.strokeWidth,
      'shape': instance.shape.toJson(),
      'color': instance.color,
      'type': instance.$type,
    };

_$CircleShape _$$CircleShapeFromJson(Map json) => _$CircleShape(
      fillColor: json['fillColor'] as int? ?? kColorTransparent,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$CircleShapeToJson(_$CircleShape instance) =>
    <String, dynamic>{
      'fillColor': instance.fillColor,
      'type': instance.$type,
    };

_$RectangleShape _$$RectangleShapeFromJson(Map json) => _$RectangleShape(
      fillColor: json['fillColor'] as int? ?? kColorTransparent,
      topLeftCornerRadius:
          (json['topLeftCornerRadius'] as num?)?.toDouble() ?? 0,
      topRightCornerRadius:
          (json['topRightCornerRadius'] as num?)?.toDouble() ?? 0,
      bottomLeftCornerRadius:
          (json['bottomLeftCornerRadius'] as num?)?.toDouble() ?? 0,
      bottomRightCornerRadius:
          (json['bottomRightCornerRadius'] as num?)?.toDouble() ?? 0,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$RectangleShapeToJson(_$RectangleShape instance) =>
    <String, dynamic>{
      'fillColor': instance.fillColor,
      'topLeftCornerRadius': instance.topLeftCornerRadius,
      'topRightCornerRadius': instance.topRightCornerRadius,
      'bottomLeftCornerRadius': instance.bottomLeftCornerRadius,
      'bottomRightCornerRadius': instance.bottomRightCornerRadius,
      'type': instance.$type,
    };

_$LineShape _$$LineShapeFromJson(Map json) => _$LineShape(
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LineShapeToJson(_$LineShape instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };
