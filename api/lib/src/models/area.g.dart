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
  isInitial: json['isInitial'] as bool? ?? false,
  color: _$JsonConverterFromJson<int, SRGBColor>(
    json['color'],
    const ColorJsonConverter().fromJson,
  ),
);

Map<String, dynamic> _$AreaToJson(_Area instance) => <String, dynamic>{
  'name': instance.name,
  'width': instance.width,
  'height': instance.height,
  'position': const DoublePointJsonConverter().toJson(instance.position),
  'isInitial': instance.isInitial,
  'color': _$JsonConverterToJson<int, SRGBColor>(
    instance.color,
    const ColorJsonConverter().toJson,
  ),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
