// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ButterflyComponentImpl _$$ButterflyComponentImplFromJson(Map json) =>
    _$ButterflyComponentImpl(
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String?,
      elements: (json['elements'] as List<dynamic>?)
              ?.map((e) =>
                  PadElement.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const <PadElement>[],
    );

Map<String, dynamic> _$$ButterflyComponentImplToJson(
        _$ButterflyComponentImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'elements': instance.elements.map((e) => e.toJson()).toList(),
    };

_$TextParameterImpl _$$TextParameterImplFromJson(Map json) =>
    _$TextParameterImpl(
      child: (json['child'] as num).toInt(),
      name: json['name'] as String,
      value: json['value'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TextParameterImplToJson(_$TextParameterImpl instance) =>
    <String, dynamic>{
      'child': instance.child,
      'name': instance.name,
      'value': instance.value,
      'type': instance.$type,
    };

_$ColorParameterImpl _$$ColorParameterImplFromJson(Map json) =>
    _$ColorParameterImpl(
      child: (json['child'] as num).toInt(),
      name: json['name'] as String,
      value: (json['value'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ColorParameterImplToJson(
        _$ColorParameterImpl instance) =>
    <String, dynamic>{
      'child': instance.child,
      'name': instance.name,
      'value': instance.value,
      'type': instance.$type,
    };

_$BoolParameterImpl _$$BoolParameterImplFromJson(Map json) =>
    _$BoolParameterImpl(
      child: (json['child'] as num).toInt(),
      name: json['name'] as String,
      value: json['value'] as bool,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$BoolParameterImplToJson(_$BoolParameterImpl instance) =>
    <String, dynamic>{
      'child': instance.child,
      'name': instance.name,
      'value': instance.value,
      'type': instance.$type,
    };

_$IntParameterImpl _$$IntParameterImplFromJson(Map json) => _$IntParameterImpl(
      child: (json['child'] as num).toInt(),
      name: json['name'] as String,
      value: (json['value'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$IntParameterImplToJson(_$IntParameterImpl instance) =>
    <String, dynamic>{
      'child': instance.child,
      'name': instance.name,
      'value': instance.value,
      'type': instance.$type,
    };

_$DoubleParameterImpl _$$DoubleParameterImplFromJson(Map json) =>
    _$DoubleParameterImpl(
      child: (json['child'] as num).toInt(),
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DoubleParameterImplToJson(
        _$DoubleParameterImpl instance) =>
    <String, dynamic>{
      'child': instance.child,
      'name': instance.name,
      'value': instance.value,
      'type': instance.$type,
    };

_$PackAssetLocationImpl _$$PackAssetLocationImplFromJson(Map json) =>
    _$PackAssetLocationImpl(
      json['pack'] as String? ?? '',
      json['name'] as String? ?? '',
    );

Map<String, dynamic> _$$PackAssetLocationImplToJson(
        _$PackAssetLocationImpl instance) =>
    <String, dynamic>{
      'pack': instance.pack,
      'name': instance.name,
    };
