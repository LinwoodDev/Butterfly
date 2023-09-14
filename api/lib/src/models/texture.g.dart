// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'texture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatternTexture _$$PatternTextureFromJson(Map json) => _$PatternTexture(
      boxWidth: (json['boxWidth'] as num?)?.toDouble() ?? 0,
      boxHeight: (json['boxHeight'] as num?)?.toDouble() ?? 0,
      boxXCount: json['boxXCount'] as int? ?? 1,
      boxYCount: json['boxYCount'] as int? ?? 1,
      boxXSpace: (json['boxXSpace'] as num?)?.toDouble() ?? 0,
      boxYSpace: (json['boxYSpace'] as num?)?.toDouble() ?? 0,
      boxXColor: json['boxXColor'] as int? ?? kColorBlue,
      boxYColor: json['boxYColor'] as int? ?? kColorRed,
      boxColor: json['boxColor'] as int? ?? kColorWhite,
      boxXStroke: (json['boxXStroke'] as num?)?.toDouble() ?? 0.5,
      boxYStroke: (json['boxYStroke'] as num?)?.toDouble() ?? 0.5,
    );

Map<String, dynamic> _$$PatternTextureToJson(_$PatternTexture instance) =>
    <String, dynamic>{
      'boxWidth': instance.boxWidth,
      'boxHeight': instance.boxHeight,
      'boxXCount': instance.boxXCount,
      'boxYCount': instance.boxYCount,
      'boxXSpace': instance.boxXSpace,
      'boxYSpace': instance.boxYSpace,
      'boxXColor': instance.boxXColor,
      'boxYColor': instance.boxYColor,
      'boxColor': instance.boxColor,
      'boxXStroke': instance.boxXStroke,
      'boxYStroke': instance.boxYStroke,
    };
