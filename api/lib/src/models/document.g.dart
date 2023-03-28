// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppDocument _$$AppDocumentFromJson(Map json) => _$AppDocument(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? '',
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
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AppDocumentToJson(_$AppDocument instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
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
      'type': instance.$type,
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

_$DocumentTemplate _$$DocumentTemplateFromJson(Map json) => _$DocumentTemplate(
      document: AppDocument.fromJson(
          Map<String, dynamic>.from(json['document'] as Map)),
      directory: json['directory'] as String? ?? '/',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DocumentTemplateToJson(_$DocumentTemplate instance) =>
    <String, dynamic>{
      'document': instance.document.toJson(),
      'directory': instance.directory,
      'type': instance.$type,
    };

_$ButterflyPack _$$ButterflyPackFromJson(Map json) => _$ButterflyPack(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      author: json['author'] as String? ?? '',
      components: (json['components'] as List<dynamic>?)
              ?.map((e) => ButterflyComponent.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const <ButterflyComponent>[],
      styles: (json['styles'] as List<dynamic>?)
              ?.map((e) =>
                  TextStyleSheet.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const <TextStyleSheet>[],
      palettes: (json['palettes'] as List<dynamic>?)
              ?.map((e) =>
                  ColorPalette.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const <ColorPalette>[],
      createdAt:
          const DateTimeJsonConverter().fromJson(json['createdAt'] as int),
      updatedAt:
          const DateTimeJsonConverter().fromJson(json['updatedAt'] as int),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ButterflyPackToJson(_$ButterflyPack instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'author': instance.author,
      'components': instance.components.map((e) => e.toJson()).toList(),
      'styles': instance.styles.map((e) => e.toJson()).toList(),
      'palettes': instance.palettes.map((e) => e.toJson()).toList(),
      'createdAt': const DateTimeJsonConverter().toJson(instance.createdAt),
      'updatedAt': const DateTimeJsonConverter().toJson(instance.updatedAt),
      'type': instance.$type,
    };
