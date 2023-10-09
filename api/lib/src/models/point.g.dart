// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PathPointImpl _$$PathPointImplFromJson(Map json) => _$PathPointImpl(
      (json['x'] as num).toDouble(),
      (json['y'] as num).toDouble(),
      (json['pressure'] as num?)?.toDouble() ?? 1,
    );

Map<String, dynamic> _$$PathPointImplToJson(_$PathPointImpl instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'pressure': instance.pressure,
    };
