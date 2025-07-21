// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Area _$AreaFromJson(Map json) => _Area(
  name: json['name'] as String? ?? '',
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  position: const DoublePointJsonConverter().fromJson(json['position'] as Map),
  extra:
      (json['extra'] as Map?)?.map((k, e) => MapEntry(k as String, e)) ??
      const {},
);

Map<String, dynamic> _$AreaToJson(_Area instance) => <String, dynamic>{
  'name': instance.name,
  'width': instance.width,
  'height': instance.height,
  'position': const DoublePointJsonConverter().toJson(instance.position),
  'extra': instance.extra,
};
