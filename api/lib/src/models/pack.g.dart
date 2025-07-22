// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ButterflyComponent _$ButterflyComponentFromJson(Map json) =>
    _ButterflyComponent(
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String?,
      elements:
          (json['elements'] as List<dynamic>?)
              ?.map(
                (e) => PadElement.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          const <PadElement>[],
    );

Map<String, dynamic> _$ButterflyComponentToJson(_ButterflyComponent instance) =>
    <String, dynamic>{
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'elements': instance.elements.map((e) => e.toJson()).toList(),
    };

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

_PackAssetLocation _$PackAssetLocationFromJson(Map json) => _PackAssetLocation(
  json['pack'] as String? ?? '',
  json['name'] as String? ?? '',
);

Map<String, dynamic> _$PackAssetLocationToJson(_PackAssetLocation instance) =>
    <String, dynamic>{'pack': instance.pack, 'name': instance.name};
