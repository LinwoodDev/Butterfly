// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'texture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatternTexture _$PatternTextureFromJson(Map json) => PatternTexture(
  boxWidth: (json['boxWidth'] as num?)?.toDouble() ?? 0,
  boxHeight: (json['boxHeight'] as num?)?.toDouble() ?? 0,
  boxXCount: (json['boxXCount'] as num?)?.toInt() ?? 1,
  boxYCount: (json['boxYCount'] as num?)?.toInt() ?? 1,
  boxXSpace: (json['boxXSpace'] as num?)?.toDouble() ?? 0,
  boxYSpace: (json['boxYSpace'] as num?)?.toDouble() ?? 0,
  boxXColor: json['boxXColor'] == null
      ? BasicColors.blue
      : const ColorJsonConverter().fromJson((json['boxXColor'] as num).toInt()),
  boxYColor: json['boxYColor'] == null
      ? BasicColors.red
      : const ColorJsonConverter().fromJson((json['boxYColor'] as num).toInt()),
  boxColor: json['boxColor'] == null
      ? SRGBColor.white
      : const ColorJsonConverter().fromJson((json['boxColor'] as num).toInt()),
  boxXStroke: (json['boxXStroke'] as num?)?.toDouble() ?? 0.5,
  boxYStroke: (json['boxYStroke'] as num?)?.toDouble() ?? 0.5,
);

Map<String, dynamic> _$PatternTextureToJson(PatternTexture instance) =>
    <String, dynamic>{
      'boxWidth': instance.boxWidth,
      'boxHeight': instance.boxHeight,
      'boxXCount': instance.boxXCount,
      'boxYCount': instance.boxYCount,
      'boxXSpace': instance.boxXSpace,
      'boxYSpace': instance.boxYSpace,
      'boxXColor': const ColorJsonConverter().toJson(instance.boxXColor),
      'boxYColor': const ColorJsonConverter().toJson(instance.boxYColor),
      'boxColor': const ColorJsonConverter().toJson(instance.boxColor),
      'boxXStroke': instance.boxXStroke,
      'boxYStroke': instance.boxYStroke,
    };
