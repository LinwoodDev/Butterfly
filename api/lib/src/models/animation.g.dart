// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AnimationTrack _$$_AnimationTrackFromJson(Map json) => _$_AnimationTrack(
      name: json['name'] as String? ?? '',
      keys: (json['keys'] as Map?)?.map(
            (k, e) => MapEntry(int.parse(k as String),
                AnimationKey.fromJson(Map<String, dynamic>.from(e as Map))),
          ) ??
          const <int, AnimationKey>{},
      duration: json['duration'] as int? ?? 250,
      fps: json['fps'] as int? ?? 24,
    );

Map<String, dynamic> _$$_AnimationTrackToJson(_$_AnimationTrack instance) =>
    <String, dynamic>{
      'name': instance.name,
      'keys': instance.keys.map((k, e) => MapEntry(k.toString(), e.toJson())),
      'duration': instance.duration,
      'fps': instance.fps,
    };

_$_AnimationKey _$$_AnimationKeyFromJson(Map json) => _$_AnimationKey(
      cameraPosition:
          _$JsonConverterFromJson<Map<dynamic, dynamic>, Point<double>>(
              json['cameraPosition'],
              const DoublePointJsonConverter().fromJson),
      cameraZoom: (json['cameraZoom'] as num?)?.toDouble(),
      breakpoint: json['breakpoint'] as bool? ?? false,
    );

Map<String, dynamic> _$$_AnimationKeyToJson(_$_AnimationKey instance) =>
    <String, dynamic>{
      'cameraPosition':
          _$JsonConverterToJson<Map<dynamic, dynamic>, Point<double>>(
              instance.cameraPosition, const DoublePointJsonConverter().toJson),
      'cameraZoom': instance.cameraZoom,
      'breakpoint': instance.breakpoint,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
