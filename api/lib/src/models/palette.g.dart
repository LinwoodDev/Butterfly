// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'palette.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ColorPalette _$ColorPaletteFromJson(Map json) => _ColorPalette(
  name: json['name'] as String,
  colors:
      (json['colors'] as List<dynamic>?)
          ?.map((e) => const ColorJsonConverter().fromJson((e as num).toInt()))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ColorPaletteToJson(_ColorPalette instance) =>
    <String, dynamic>{
      'name': instance.name,
      'colors': instance.colors.map(const ColorJsonConverter().toJson).toList(),
    };
