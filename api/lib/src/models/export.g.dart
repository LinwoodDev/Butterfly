// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExportPadding _$ExportPaddingFromJson(Map json) => _ExportPadding(
  top: (json['top'] as num?)?.toDouble() ?? 0,
  right: (json['right'] as num?)?.toDouble() ?? 0,
  bottom: (json['bottom'] as num?)?.toDouble() ?? 0,
  left: (json['left'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$ExportPaddingToJson(_ExportPadding instance) =>
    <String, dynamic>{
      'top': instance.top,
      'right': instance.right,
      'bottom': instance.bottom,
      'left': instance.left,
    };

ImageExportOptions _$ImageExportOptionsFromJson(Map json) => ImageExportOptions(
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  x: (json['x'] as num?)?.toDouble() ?? 0,
  y: (json['y'] as num?)?.toDouble() ?? 0,
  scale: (json['scale'] as num?)?.toDouble() ?? 1,
  rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
  padding: json['padding'] == null
      ? const ExportPadding()
      : ExportPadding.fromJson(
          Map<String, dynamic>.from(json['padding'] as Map),
        ),
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
      'rotation': instance.rotation,
      'padding': instance.padding.toJson(),
      'quality': instance.quality,
      'renderBackground': instance.renderBackground,
      'type': instance.$type,
    };

SvgExportOptions _$SvgExportOptionsFromJson(Map json) => SvgExportOptions(
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  x: (json['x'] as num?)?.toDouble() ?? 0,
  y: (json['y'] as num?)?.toDouble() ?? 0,
  scale: (json['scale'] as num?)?.toDouble() ?? 1,
  rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
  padding: json['padding'] == null
      ? const ExportPadding()
      : ExportPadding.fromJson(
          Map<String, dynamic>.from(json['padding'] as Map),
        ),
  renderBackground: json['renderBackground'] as bool? ?? true,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SvgExportOptionsToJson(SvgExportOptions instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'x': instance.x,
      'y': instance.y,
      'scale': instance.scale,
      'rotation': instance.rotation,
      'padding': instance.padding.toJson(),
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
