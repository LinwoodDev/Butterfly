// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageExportOptions _$ImageExportOptionsFromJson(Map json) => ImageExportOptions(
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  x: (json['x'] as num?)?.toDouble() ?? 0,
  y: (json['y'] as num?)?.toDouble() ?? 0,
  scale: (json['scale'] as num?)?.toDouble() ?? 1,
  quality: (json['quality'] as num?)?.toDouble() ?? 1,
  renderBackground: json['renderBackground'] as bool? ?? true,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ImageExportOptionsToJson(ImageExportOptions instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'x': instance.x,
      'y': instance.y,
      'scale': instance.scale,
      'quality': instance.quality,
      'renderBackground': instance.renderBackground,
      'type': instance.$type,
    };

SvgExportOptions _$SvgExportOptionsFromJson(Map json) => SvgExportOptions(
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  x: (json['x'] as num?)?.toDouble() ?? 0,
  y: (json['y'] as num?)?.toDouble() ?? 0,
  renderBackground: json['renderBackground'] as bool? ?? true,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SvgExportOptionsToJson(SvgExportOptions instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'x': instance.x,
      'y': instance.y,
      'renderBackground': instance.renderBackground,
      'type': instance.$type,
    };

_ExportPreset _$ExportPresetFromJson(Map json) => _ExportPreset(
  name: json['name'] as String? ?? '',
  areas:
      (json['areas'] as List<dynamic>?)
          ?.map((e) => AreaPreset.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ExportPresetToJson(_ExportPreset instance) =>
    <String, dynamic>{
      'name': instance.name,
      'areas': instance.areas.map((e) => e.toJson()).toList(),
    };

_AreaPreset _$AreaPresetFromJson(Map json) => _AreaPreset(
  page: json['page'] as String? ?? '',
  name: json['name'] as String? ?? '',
  quality: (json['quality'] as num?)?.toDouble() ?? 1,
  area: json['area'] == null
      ? null
      : Area.fromJson(Map<String, dynamic>.from(json['area'] as Map)),
);

Map<String, dynamic> _$AreaPresetToJson(_AreaPreset instance) =>
    <String, dynamic>{
      'page': instance.page,
      'name': instance.name,
      'quality': instance.quality,
      'area': instance.area?.toJson(),
    };
