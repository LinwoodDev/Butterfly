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
      name: json['name'] as String,
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
      palettes: (json['palettes'] as List<dynamic>?)
              ?.map((e) =>
                  ColorPalette.fromJson(Map<String, dynamic>.from(e as Map)))
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
      createdAt: DateTime.parse(json['createdAt'] as String),
      handProperty: json['handProperty'] == null
          ? const HandProperty()
          : HandProperty.fromJson(
              Map<String, dynamic>.from(json['handProperty'] as Map)),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      painters: (json['painters'] as List<dynamic>?)
              ?.map(
                  (e) => Painter.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_AppDocumentToJson(_$_AppDocument instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'content': instance.content.map((e) => e.toJson()).toList(),
      'background': instance.background.toJson(),
      'palettes': instance.palettes.map((e) => e.toJson()).toList(),
      'waypoints': instance.waypoints.map((e) => e.toJson()).toList(),
      'areas': instance.areas.map((e) => e.toJson()).toList(),
      'exportPresets': instance.exportPresets.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt.toIso8601String(),
      'handProperty': instance.handProperty.toJson(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'painters': instance.painters.map((e) => e.toJson()).toList(),
    };
