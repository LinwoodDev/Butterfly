// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentPage _$DocumentPageFromJson(Map json) => _DocumentPage(
  animations:
      (json['animations'] as List<dynamic>?)
          ?.map(
            (e) => AnimationTrack.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList() ??
      const [],
  layers:
      (json['layers'] as List<dynamic>?)
          ?.map(
            (e) => DocumentLayer.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList() ??
      const [],
  backgrounds:
      (json['backgrounds'] as List<dynamic>?)
          ?.map((e) => Background.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList() ??
      const [],
  waypoints:
      (json['waypoints'] as List<dynamic>?)
          ?.map((e) => Waypoint.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList() ??
      const [],
  areas:
      (json['areas'] as List<dynamic>?)
          ?.map((e) => Area.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList() ??
      const [],
  extra:
      (json['extra'] as Map?)?.map((k, e) => MapEntry(k as String, e)) ??
      const {},
);

Map<String, dynamic> _$DocumentPageToJson(_DocumentPage instance) =>
    <String, dynamic>{
      'animations': instance.animations.map((e) => e.toJson()).toList(),
      'layers': instance.layers.map((e) => e.toJson()).toList(),
      'backgrounds': instance.backgrounds.map((e) => e.toJson()).toList(),
      'waypoints': instance.waypoints.map((e) => e.toJson()).toList(),
      'areas': instance.areas.map((e) => e.toJson()).toList(),
      'extra': instance.extra,
    };

_DocumentLayer _$DocumentLayerFromJson(Map json) => _DocumentLayer(
  id: json['id'] as String?,
  name: json['name'] as String? ?? '',
  content:
      (json['content'] as List<dynamic>?)
          ?.map((e) => PadElement.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList() ??
      const [],
);

Map<String, dynamic> _$DocumentLayerToJson(_DocumentLayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'content': instance.content.map((e) => e.toJson()).toList(),
    };
