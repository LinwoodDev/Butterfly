// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HandProperty _$$HandPropertyFromJson(Map json) => _$HandProperty(
      includeEraser: json['includeEraser'] as bool? ?? false,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$HandPropertyToJson(_$HandProperty instance) =>
    <String, dynamic>{
      'includeEraser': instance.includeEraser,
      'type': instance.$type,
    };

_$LabelProperty _$$LabelPropertyFromJson(Map json) => _$LabelProperty(
      size: (json['size'] as num?)?.toDouble() ?? 12,
      color: json['color'] as int? ?? kColorBlack,
      fontWeight: json['fontWeight'] as int? ?? 3,
      lineThrough: json['lineThrough'] as bool? ?? false,
      underline: json['underline'] as bool? ?? false,
      overline: json['overline'] as bool? ?? false,
      italic: json['italic'] as bool? ?? false,
      letterSpacing: (json['letterSpacing'] as num?)?.toDouble() ?? 0,
      decorationColor: json['decorationColor'] as int? ?? kColorBlack,
      decorationStyle: $enumDecodeNullable(
              _$TextDecorationStyleEnumMap, json['decorationStyle']) ??
          TextDecorationStyle.solid,
      decorationThickness:
          (json['decorationThickness'] as num?)?.toDouble() ?? 1,
      horizontalAlignment: $enumDecodeNullable(
              _$HorizontalAlignmentEnumMap, json['horizontalAlignment']) ??
          HorizontalAlignment.left,
      verticalAlignment: $enumDecodeNullable(
              _$VerticalAlignmentEnumMap, json['verticalAlignment']) ??
          VerticalAlignment.top,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LabelPropertyToJson(_$LabelProperty instance) =>
    <String, dynamic>{
      'size': instance.size,
      'color': instance.color,
      'fontWeight': instance.fontWeight,
      'lineThrough': instance.lineThrough,
      'underline': instance.underline,
      'overline': instance.overline,
      'italic': instance.italic,
      'letterSpacing': instance.letterSpacing,
      'decorationColor': instance.decorationColor,
      'decorationStyle':
          _$TextDecorationStyleEnumMap[instance.decorationStyle]!,
      'decorationThickness': instance.decorationThickness,
      'horizontalAlignment':
          _$HorizontalAlignmentEnumMap[instance.horizontalAlignment]!,
      'verticalAlignment':
          _$VerticalAlignmentEnumMap[instance.verticalAlignment]!,
      'type': instance.$type,
    };

const _$TextDecorationStyleEnumMap = {
  TextDecorationStyle.solid: 'solid',
  TextDecorationStyle.double: 'double',
  TextDecorationStyle.dotted: 'dotted',
  TextDecorationStyle.dashed: 'dashed',
  TextDecorationStyle.wavy: 'wavy',
};

const _$HorizontalAlignmentEnumMap = {
  HorizontalAlignment.left: 'left',
  HorizontalAlignment.center: 'center',
  HorizontalAlignment.right: 'right',
  HorizontalAlignment.justify: 'justify',
};

const _$VerticalAlignmentEnumMap = {
  VerticalAlignment.top: 'top',
  VerticalAlignment.center: 'center',
  VerticalAlignment.bottom: 'bottom',
};

_$EraserProperty _$$EraserPropertyFromJson(Map json) => _$EraserProperty(
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      strokeMultiplier: (json['strokeMultiplier'] as num?)?.toDouble() ?? 10,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$EraserPropertyToJson(_$EraserProperty instance) =>
    <String, dynamic>{
      'strokeWidth': instance.strokeWidth,
      'strokeMultiplier': instance.strokeMultiplier,
      'type': instance.$type,
    };

_$PenProperty _$$PenPropertyFromJson(Map json) => _$PenProperty(
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      strokeMultiplier: (json['strokeMultiplier'] as num?)?.toDouble() ?? 10,
      color: json['color'] as int? ?? kColorBlack,
      fill: json['fill'] as bool? ?? false,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PenPropertyToJson(_$PenProperty instance) =>
    <String, dynamic>{
      'strokeWidth': instance.strokeWidth,
      'strokeMultiplier': instance.strokeMultiplier,
      'color': instance.color,
      'fill': instance.fill,
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
