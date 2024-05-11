// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'palette.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ColorPaletteImpl _$$ColorPaletteImplFromJson(Map json) => _$ColorPaletteImpl(
      name: json['name'] as String,
      colors: (json['colors'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ColorPaletteImplToJson(_$ColorPaletteImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'colors': instance.colors,
    };
