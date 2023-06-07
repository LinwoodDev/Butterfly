// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DocumentPage _$$_DocumentPageFromJson(Map json) => _$_DocumentPage(
      animations: (json['animations'] as List<dynamic>?)
              ?.map((e) =>
                  AnimationTrack.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      content: (json['content'] as List<dynamic>?)
              ?.map((e) =>
                  PadElement.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      background: json['background'] == null
          ? const Background.empty()
          : Background.fromJson(
              Map<String, dynamic>.from(json['background'] as Map)),
      waypoints: (json['waypoints'] as List<dynamic>?)
              ?.map(
                  (e) => Waypoint.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      areas: (json['areas'] as List<dynamic>?)
              ?.map((e) => Area.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_DocumentPageToJson(_$_DocumentPage instance) =>
    <String, dynamic>{
      'animations': instance.animations.map((e) => e.toJson()).toList(),
      'content': instance.content.map((e) => e.toJson()).toList(),
      'background': instance.background.toJson(),
      'waypoints': instance.waypoints.map((e) => e.toJson()).toList(),
      'areas': instance.areas.map((e) => e.toJson()).toList(),
    };
