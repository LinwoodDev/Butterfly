// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AssetLocation _$$_AssetLocationFromJson(Map json) => _$_AssetLocation(
      remote: json['remote'] as String? ?? '',
      path: json['path'] as String,
      absolute: json['absolute'] as bool? ?? false,
    );

Map<String, dynamic> _$$_AssetLocationToJson(_$_AssetLocation instance) =>
    <String, dynamic>{
      'remote': instance.remote,
      'path': instance.path,
      'absolute': instance.absolute,
    };

_$_AppDocument _$$_AppDocumentFromJson(Map json) => _$_AppDocument(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      content: (json['content'] as List<dynamic>?)
              ?.map((e) =>
                  PadElement.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      background: json['background'] == null
          ? const Background.empty()
          : Background.fromJson(
              Map<String, dynamic>.from(json['background'] as Map)),
      animations: (json['animations'] as List<dynamic>?)
              ?.map((e) =>
                  AnimationTrack.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      waypoints: (json['waypoints'] as List<dynamic>?)
              ?.map(
                  (e) => Waypoint.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      areas: (json['areas'] as List<dynamic>?)
              ?.map((e) => Area.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      exportPresets: (json['exportPresets'] as List<dynamic>?)
              ?.map((e) =>
                  ExportPreset.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      packs: (json['packs'] as List<dynamic>?)
              ?.map((e) =>
                  ButterflyPack.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      createdAt:
          const DateTimeJsonConverter().fromJson(json['createdAt'] as int),
      updatedAt: _$JsonConverterFromJson<int, DateTime>(
          json['updatedAt'], const DateTimeJsonConverter().fromJson),
      painters: (json['painters'] as List<dynamic>?)
              ?.map(
                  (e) => Painter.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      tool: json['tool'] == null
          ? const ToolOption()
          : ToolOption.fromJson(Map<String, dynamic>.from(json['tool'] as Map)),
    );

Map<String, dynamic> _$$_AppDocumentToJson(_$_AppDocument instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'content': instance.content.map((e) => e.toJson()).toList(),
      'background': instance.background.toJson(),
      'animations': instance.animations.map((e) => e.toJson()).toList(),
      'waypoints': instance.waypoints.map((e) => e.toJson()).toList(),
      'areas': instance.areas.map((e) => e.toJson()).toList(),
      'exportPresets': instance.exportPresets.map((e) => e.toJson()).toList(),
      'packs': instance.packs.map((e) => e.toJson()).toList(),
      'createdAt': const DateTimeJsonConverter().toJson(instance.createdAt),
      'updatedAt': _$JsonConverterToJson<int, DateTime>(
          instance.updatedAt, const DateTimeJsonConverter().toJson),
      'painters': instance.painters.map((e) => e.toJson()).toList(),
      'tool': instance.tool.toJson(),
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
