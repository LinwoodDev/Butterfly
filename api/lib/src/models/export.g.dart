// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExportPresetImpl _$$ExportPresetImplFromJson(Map json) => _$ExportPresetImpl(
      name: json['name'] as String? ?? '',
      areas: (json['areas'] as List<dynamic>?)
              ?.map((e) =>
                  AreaPreset.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ExportPresetImplToJson(_$ExportPresetImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'areas': instance.areas.map((e) => e.toJson()).toList(),
    };

_$AreaPresetImpl _$$AreaPresetImplFromJson(Map json) => _$AreaPresetImpl(
      page: json['page'] as String? ?? 'default',
      name: json['name'] as String? ?? '',
      quality: (json['quality'] as num?)?.toDouble() ?? 1,
      area: json['area'] == null
          ? null
          : Area.fromJson(Map<String, dynamic>.from(json['area'] as Map)),
    );

Map<String, dynamic> _$$AreaPresetImplToJson(_$AreaPresetImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'name': instance.name,
      'quality': instance.quality,
      'area': instance.area?.toJson(),
    };
