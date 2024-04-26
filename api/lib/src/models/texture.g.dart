// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'texture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatternTextureImpl _$$PatternTextureImplFromJson(Map json) =>
    _$PatternTextureImpl(
      boxWidth: (json['boxWidth'] as num?)?.toDouble() ?? 0,
      boxHeight: (json['boxHeight'] as num?)?.toDouble() ?? 0,
      boxXCount: (json['boxXCount'] as num?)?.toInt() ?? 1,
      boxYCount: (json['boxYCount'] as num?)?.toInt() ?? 1,
      boxXSpace: (json['boxXSpace'] as num?)?.toDouble() ?? 0,
      boxYSpace: (json['boxYSpace'] as num?)?.toDouble() ?? 0,
      boxXColor: (json['boxXColor'] as num?)?.toInt() ?? BasicColors.blue,
      boxYColor: (json['boxYColor'] as num?)?.toInt() ?? BasicColors.red,
      boxColor: (json['boxColor'] as num?)?.toInt() ?? BasicColors.white,
      boxXStroke: (json['boxXStroke'] as num?)?.toDouble() ?? 0.5,
      boxYStroke: (json['boxYStroke'] as num?)?.toDouble() ?? 0.5,
    );

Map<String, dynamic> _$$PatternTextureImplToJson(
        _$PatternTextureImpl instance) =>
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
