// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppDocument _$$_AppDocumentFromJson(Map<String, dynamic> json) =>
    _$_AppDocument(
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      content: (json['content'] as List<dynamic>?)
              ?.map((e) => PadElement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      background: json['background'] ?? const Background.empty(),
      palettes: (json['palettes'] as List<dynamic>?)
              ?.map((e) => ColorPalette.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      waypoints: (json['waypoints'] as List<dynamic>?)
              ?.map((e) => Waypoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      areas: (json['areas'] as List<dynamic>?)
              ?.map((e) => Area.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      handProperty: json['handProperty'] == null
          ? const HandProperty()
          : HandProperty.fromJson(json['handProperty'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      painters: (json['painters'] as List<dynamic>?)
              ?.map((e) => Painter.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [PenPainter(), PathEraserPainter(), LabelPainter()],
    );

Map<String, dynamic> _$$_AppDocumentToJson(_$_AppDocument instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'content': instance.content,
      'background': instance.background,
      'palettes': instance.palettes,
      'waypoints': instance.waypoints,
      'areas': instance.areas,
      'createdAt': instance.createdAt.toIso8601String(),
      'handProperty': instance.handProperty,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'painters': instance.painters,
    };
