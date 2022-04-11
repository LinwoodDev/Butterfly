// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'palette.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ColorPalette _$$_ColorPaletteFromJson(Map json) => _$_ColorPalette(
      name: json['name'] as String,
      colors:
          (json['colors'] as List<dynamic>?)?.map((e) => e as int).toList() ??
              const [],
    );

Map<String, dynamic> _$$_ColorPaletteToJson(_$_ColorPalette instance) =>
    <String, dynamic>{
      'name': instance.name,
      'colors': instance.colors,
    };
