// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextureBackground _$TextureBackgroundFromJson(Map json) => TextureBackground(
  texture: SurfaceTexture.fromJson(
    Map<String, dynamic>.from(json['texture'] as Map),
  ),
  extra:
      (json['extra'] as Map?)?.map((k, e) => MapEntry(k as String, e)) ??
      const {},
  $type: json['type'] as String?,
);

Map<String, dynamic> _$TextureBackgroundToJson(TextureBackground instance) =>
    <String, dynamic>{
      'texture': instance.texture.toJson(),
      'extra': instance.extra,
      'type': instance.$type,
    };

ImageBackground _$ImageBackgroundFromJson(Map json) => ImageBackground(
  source: json['source'] as String,
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  scaleX: (json['scaleX'] as num?)?.toDouble() ?? 1,
  scaleY: (json['scaleY'] as num?)?.toDouble() ?? 1,
  extra:
      (json['extra'] as Map?)?.map((k, e) => MapEntry(k as String, e)) ??
      const {},
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ImageBackgroundToJson(ImageBackground instance) =>
    <String, dynamic>{
      'source': instance.source,
      'width': instance.width,
      'height': instance.height,
      'scaleX': instance.scaleX,
      'scaleY': instance.scaleY,
      'extra': instance.extra,
      'type': instance.$type,
    };

SvgBackground _$SvgBackgroundFromJson(Map json) => SvgBackground(
  source: json['source'] as String,
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  scaleX: (json['scaleX'] as num?)?.toDouble() ?? 1,
  scaleY: (json['scaleY'] as num?)?.toDouble() ?? 1,
  extra:
      (json['extra'] as Map?)?.map((k, e) => MapEntry(k as String, e)) ??
      const {},
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SvgBackgroundToJson(SvgBackground instance) =>
    <String, dynamic>{
      'source': instance.source,
      'width': instance.width,
      'height': instance.height,
      'scaleX': instance.scaleX,
      'scaleY': instance.scaleY,
      'extra': instance.extra,
      'type': instance.$type,
    };
