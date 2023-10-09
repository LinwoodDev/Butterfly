// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TextureBackgroundImpl _$$TextureBackgroundImplFromJson(Map json) =>
    _$TextureBackgroundImpl(
      texture: SurfaceTexture.fromJson(
          Map<String, dynamic>.from(json['texture'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TextureBackgroundImplToJson(
        _$TextureBackgroundImpl instance) =>
    <String, dynamic>{
      'texture': instance.texture.toJson(),
      'type': instance.$type,
    };

_$ImageBackgroundImpl _$$ImageBackgroundImplFromJson(Map json) =>
    _$ImageBackgroundImpl(
      source: json['source'] as String,
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      scaleX: (json['scaleX'] as num?)?.toDouble() ?? 1,
      scaleY: (json['scaleY'] as num?)?.toDouble() ?? 1,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ImageBackgroundImplToJson(
        _$ImageBackgroundImpl instance) =>
    <String, dynamic>{
      'source': instance.source,
      'width': instance.width,
      'height': instance.height,
      'scaleX': instance.scaleX,
      'scaleY': instance.scaleY,
      'type': instance.$type,
    };

_$SvgBackgroundImpl _$$SvgBackgroundImplFromJson(Map json) =>
    _$SvgBackgroundImpl(
      source: json['source'] as String,
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      scaleX: (json['scaleX'] as num?)?.toDouble() ?? 1,
      scaleY: (json['scaleY'] as num?)?.toDouble() ?? 1,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$SvgBackgroundImplToJson(_$SvgBackgroundImpl instance) =>
    <String, dynamic>{
      'source': instance.source,
      'width': instance.width,
      'height': instance.height,
      'scaleX': instance.scaleX,
      'scaleY': instance.scaleY,
      'type': instance.$type,
    };
