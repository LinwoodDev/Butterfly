// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PenPropertyImpl _$$PenPropertyImplFromJson(Map json) => _$PenPropertyImpl(
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      thinning: (json['thinning'] as num?)?.toDouble() ?? 0.4,
      color: (json['color'] as num?)?.toInt() ?? BasicColors.black,
      fill: json['fill'] as bool? ?? false,
      smoothing: (json['smoothing'] as num?)?.toDouble() ?? 0.5,
      streamline: (json['streamline'] as num?)?.toDouble() ?? 0.3,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PenPropertyImplToJson(_$PenPropertyImpl instance) =>
    <String, dynamic>{
      'strokeWidth': instance.strokeWidth,
      'thinning': instance.thinning,
      'color': instance.color,
      'fill': instance.fill,
      'smoothing': instance.smoothing,
      'streamline': instance.streamline,
      'type': instance.$type,
    };

_$ShapePropertyImpl _$$ShapePropertyImplFromJson(Map json) =>
    _$ShapePropertyImpl(
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      shape:
          PathShape.fromJson(Map<String, dynamic>.from(json['shape'] as Map)),
      color: (json['color'] as num?)?.toInt() ?? BasicColors.black,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ShapePropertyImplToJson(_$ShapePropertyImpl instance) =>
    <String, dynamic>{
      'strokeWidth': instance.strokeWidth,
      'shape': instance.shape.toJson(),
      'color': instance.color,
      'type': instance.$type,
    };

_$CircleShapeImpl _$$CircleShapeImplFromJson(Map json) => _$CircleShapeImpl(
      fillColor:
          (json['fillColor'] as num?)?.toInt() ?? BasicColors.transparent,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$CircleShapeImplToJson(_$CircleShapeImpl instance) =>
    <String, dynamic>{
      'fillColor': instance.fillColor,
      'type': instance.$type,
    };

_$RectangleShapeImpl _$$RectangleShapeImplFromJson(Map json) =>
    _$RectangleShapeImpl(
      fillColor:
          (json['fillColor'] as num?)?.toInt() ?? BasicColors.transparent,
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

Map<String, dynamic> _$$RectangleShapeImplToJson(
        _$RectangleShapeImpl instance) =>
    <String, dynamic>{
      'fillColor': instance.fillColor,
      'topLeftCornerRadius': instance.topLeftCornerRadius,
      'topRightCornerRadius': instance.topRightCornerRadius,
      'bottomLeftCornerRadius': instance.bottomLeftCornerRadius,
      'bottomRightCornerRadius': instance.bottomRightCornerRadius,
      'type': instance.$type,
    };

_$LineShapeImpl _$$LineShapeImplFromJson(Map json) => _$LineShapeImpl(
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LineShapeImplToJson(_$LineShapeImpl instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$TriangleShapeImpl _$$TriangleShapeImplFromJson(Map json) =>
    _$TriangleShapeImpl(
      fillColor:
          (json['fillColor'] as num?)?.toInt() ?? BasicColors.transparent,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TriangleShapeImplToJson(_$TriangleShapeImpl instance) =>
    <String, dynamic>{
      'fillColor': instance.fillColor,
      'type': instance.$type,
    };
