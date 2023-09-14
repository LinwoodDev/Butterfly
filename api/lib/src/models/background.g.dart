// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TextureBackground _$$TextureBackgroundFromJson(Map json) =>
    _$TextureBackground(
      texture: SurfaceTexture.fromJson(
          Map<String, dynamic>.from(json['texture'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TextureBackgroundToJson(_$TextureBackground instance) =>
    <String, dynamic>{
      'texture': instance.texture.toJson(),
      'type': instance.$type,
    };

_$ImageBackground _$$ImageBackgroundFromJson(Map json) => _$ImageBackground(
      source: json['source'] as String,
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      scaleX: (json['scaleX'] as num?)?.toDouble() ?? 1,
      scaleY: (json['scaleY'] as num?)?.toDouble() ?? 1,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ImageBackgroundToJson(_$ImageBackground instance) =>
    <String, dynamic>{
      'source': instance.source,
      'width': instance.width,
      'height': instance.height,
      'scaleX': instance.scaleX,
      'scaleY': instance.scaleY,
      'type': instance.$type,
    };

_$SvgBackground _$$SvgBackgroundFromJson(Map json) => _$SvgBackground(
      source: json['source'] as String,
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      scaleX: (json['scaleX'] as num?)?.toDouble() ?? 1,
      scaleY: (json['scaleY'] as num?)?.toDouble() ?? 1,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$SvgBackgroundToJson(_$SvgBackground instance) =>
    <String, dynamic>{
      'source': instance.source,
      'width': instance.width,
      'height': instance.height,
      'scaleX': instance.scaleX,
      'scaleY': instance.scaleY,
      'type': instance.$type,
    };
