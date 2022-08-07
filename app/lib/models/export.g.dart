// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExportPreset _$$_ExportPresetFromJson(Map json) => _$_ExportPreset(
      name: json['name'] as String? ?? '',
      areas:
          (json['areas'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      quality: (json['quality'] as num?)?.toDouble() ?? 1,
    );

Map<String, dynamic> _$$_ExportPresetToJson(_$_ExportPreset instance) =>
    <String, dynamic>{
      'name': instance.name,
      'areas': instance.areas,
      'quality': instance.quality,
    };
