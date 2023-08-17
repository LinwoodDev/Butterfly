// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MotifBackground _$$MotifBackgroundFromJson(Map json) => _$MotifBackground(
      motif: Motif.fromJson(Map<String, dynamic>.from(json['motif'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$MotifBackgroundToJson(_$MotifBackground instance) =>
    <String, dynamic>{
      'motif': instance.motif.toJson(),
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
