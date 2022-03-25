// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HandProperty _$$HandPropertyFromJson(Map<String, dynamic> json) =>
    _$HandProperty(
      includeEraser: json['includeEraser'] as bool? ?? false,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$HandPropertyToJson(_$HandProperty instance) =>
    <String, dynamic>{
      'includeEraser': instance.includeEraser,
      'type': instance.$type,
    };

_$LabelProperty _$$LabelPropertyFromJson(Map<String, dynamic> json) =>
    _$LabelProperty(
      size: (json['size'] as num?)?.toDouble() ?? 12,
      color: json['color'] as int? ?? kColorBlack,
      fontWeight: json['fontWeight'] as int? ?? 3,
      lineThrough: json['lineThrough'] as bool? ?? false,
      underline: json['underline'] as bool? ?? false,
      overline: json['overline'] as bool? ?? false,
      italic: json['italic'] as bool? ?? false,
      letterSpacing: (json['letterSpacing'] as num?)?.toDouble() ?? 0,
      decorationColor: json['decorationColor'] ?? kColorBlack,
      decorationStyle: $enumDecodeNullable(
              _$TextDecorationStyleEnumMap, json['decorationStyle']) ??
          TextDecorationStyle.solid,
      decorationThickness:
          (json['decorationThickness'] as num?)?.toDouble() ?? 1,
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
      'decorationStyle': _$TextDecorationStyleEnumMap[instance.decorationStyle],
      'decorationThickness': instance.decorationThickness,
      'type': instance.$type,
    };

const _$TextDecorationStyleEnumMap = {
  TextDecorationStyle.solid: 'solid',
  TextDecorationStyle.double: 'double',
  TextDecorationStyle.dotted: 'dotted',
  TextDecorationStyle.dashed: 'dashed',
  TextDecorationStyle.wavy: 'wavy',
};

_$EraserProperty _$$EraserPropertyFromJson(Map<String, dynamic> json) =>
    _$EraserProperty(
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      strokeMultiplier: (json['strokeMultiplier'] as num?)?.toDouble() ?? 10,
      color: json['color'] as int? ?? kColorBlack,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$EraserPropertyToJson(_$EraserProperty instance) =>
    <String, dynamic>{
      'strokeWidth': instance.strokeWidth,
      'strokeMultiplier': instance.strokeMultiplier,
      'color': instance.color,
      'type': instance.$type,
    };

_$PenProperty _$$PenPropertyFromJson(Map<String, dynamic> json) =>
    _$PenProperty(
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
