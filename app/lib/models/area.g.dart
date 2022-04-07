// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Area _$$_AreaFromJson(Map<String, dynamic> json) => _$_Area(
      name: json['name'] as String? ?? '',
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      position: const OffsetJsonConverter()
          .fromJson(json['position'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AreaToJson(_$_Area instance) => <String, dynamic>{
      'name': instance.name,
      'width': instance.width,
      'height': instance.height,
      'position': const OffsetJsonConverter().toJson(instance.position),
    };
