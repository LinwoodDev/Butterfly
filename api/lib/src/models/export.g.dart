// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageExportOptionsImpl _$$ImageExportOptionsImplFromJson(Map json) =>
    _$ImageExportOptionsImpl(
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      x: (json['x'] as num?)?.toDouble() ?? 0,
      y: (json['y'] as num?)?.toDouble() ?? 0,
      scale: (json['scale'] as num?)?.toDouble() ?? 1,
      quality: (json['quality'] as num?)?.toDouble() ?? 1,
      renderBackground: json['renderBackground'] as bool? ?? true,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ImageExportOptionsImplToJson(
        _$ImageExportOptionsImpl instance) =>
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

_$SVGExportOptionsImpl _$$SVGExportOptionsImplFromJson(Map json) =>
    _$SVGExportOptionsImpl(
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      x: (json['x'] as num?)?.toDouble() ?? 0,
      y: (json['y'] as num?)?.toDouble() ?? 0,
      renderBackground: json['renderBackground'] as bool? ?? true,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$SVGExportOptionsImplToJson(
        _$SVGExportOptionsImpl instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'x': instance.x,
      'y': instance.y,
      'renderBackground': instance.renderBackground,
      'type': instance.$type,
    };

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
