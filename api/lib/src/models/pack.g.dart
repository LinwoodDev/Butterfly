// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ColorPalette _$ColorPaletteFromJson(Map json) => _ColorPalette(
      colors: (json['colors'] as List<dynamic>?)
              ?.map((e) =>
                  const ColorJsonConverter().fromJson((e as num).toInt()))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ColorPaletteToJson(_ColorPalette instance) =>
    <String, dynamic>{
      'colors': instance.colors.map(const ColorJsonConverter().toJson).toList(),
    };

_ButterflyComponent _$ButterflyComponentFromJson(Map json) =>
    _ButterflyComponent(
      thumbnail: _$JsonConverterFromJson<String, Uint8List>(
          json['thumbnail'], const Uint8ListJsonConverter().fromJson),
      elements: (json['elements'] as List<dynamic>?)
              ?.map((e) =>
                  PadElement.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const <PadElement>[],
    );

Map<String, dynamic> _$ButterflyComponentToJson(_ButterflyComponent instance) =>
    <String, dynamic>{
      'thumbnail': _$JsonConverterToJson<String, Uint8List>(
          instance.thumbnail, const Uint8ListJsonConverter().toJson),
      'elements': instance.elements.map((e) => e.toJson()).toList(),
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

TextParameter _$TextParameterFromJson(Map json) => TextParameter(
      child: (json['child'] as num).toInt(),
      name: json['name'] as String,
      value: json['value'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$TextParameterToJson(TextParameter instance) =>
    <String, dynamic>{
      'child': instance.child,
      'name': instance.name,
      'value': instance.value,
      'type': instance.$type,
    };

ColorParameter _$ColorParameterFromJson(Map json) => ColorParameter(
      child: (json['child'] as num).toInt(),
      name: json['name'] as String,
      value: (json['value'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ColorParameterToJson(ColorParameter instance) =>
    <String, dynamic>{
      'child': instance.child,
      'name': instance.name,
      'value': instance.value,
      'type': instance.$type,
    };

BoolParameter _$BoolParameterFromJson(Map json) => BoolParameter(
      child: (json['child'] as num).toInt(),
      name: json['name'] as String,
      value: json['value'] as bool,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$BoolParameterToJson(BoolParameter instance) =>
    <String, dynamic>{
      'child': instance.child,
      'name': instance.name,
      'value': instance.value,
      'type': instance.$type,
    };

IntParameter _$IntParameterFromJson(Map json) => IntParameter(
      child: (json['child'] as num).toInt(),
      name: json['name'] as String,
      value: (json['value'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$IntParameterToJson(IntParameter instance) =>
    <String, dynamic>{
      'child': instance.child,
      'name': instance.name,
      'value': instance.value,
      'type': instance.$type,
    };

DoubleParameter _$DoubleParameterFromJson(Map json) => DoubleParameter(
      child: (json['child'] as num).toInt(),
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$DoubleParameterToJson(DoubleParameter instance) =>
    <String, dynamic>{
      'child': instance.child,
      'name': instance.name,
      'value': instance.value,
      'type': instance.$type,
    };
