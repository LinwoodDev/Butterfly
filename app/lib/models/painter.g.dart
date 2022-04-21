// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'painter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LabelPainter _$$LabelPainterFromJson(Map json) => _$LabelPainter(
      name: json['name'] as String? ?? '',
      property: json['property'] == null
          ? const LabelProperty()
          : LabelProperty.fromJson(
              Map<String, dynamic>.from(json['property'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LabelPainterToJson(_$LabelPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'property': instance.property.toJson(),
      'type': instance.$type,
    };

_$PenPainter _$$PenPainterFromJson(Map json) => _$PenPainter(
      name: json['name'] as String? ?? '',
      zoomDependent: json['zoomDependent'] as bool? ?? false,
      property: json['property'] == null
          ? const PenProperty()
          : PenProperty.fromJson(
              Map<String, dynamic>.from(json['property'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PenPainterToJson(_$PenPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'zoomDependent': instance.zoomDependent,
      'property': instance.property.toJson(),
      'type': instance.$type,
    };

_$EraserPainter _$$EraserPainterFromJson(Map json) => _$EraserPainter(
      name: json['name'] as String? ?? '',
      property: json['property'] == null
          ? const EraserProperty()
          : EraserProperty.fromJson(
              Map<String, dynamic>.from(json['property'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$EraserPainterToJson(_$EraserPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'property': instance.property.toJson(),
      'type': instance.$type,
    };

_$PathEraserPainter _$$PathEraserPainterFromJson(Map json) =>
    _$PathEraserPainter(
      name: json['name'] as String? ?? '',
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      includeEraser: json['includeEraser'] as bool? ?? false,
      deleteWholeStroke: json['deleteWholeStroke'] as bool? ?? false,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PathEraserPainterToJson(_$PathEraserPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'strokeWidth': instance.strokeWidth,
      'includeEraser': instance.includeEraser,
      'deleteWholeStroke': instance.deleteWholeStroke,
      'type': instance.$type,
    };

_$LayerPainter _$$LayerPainterFromJson(Map json) => _$LayerPainter(
      name: json['name'] as String? ?? '',
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      layer: json['layer'] as String? ?? '',
      includeEraser: json['includeEraser'] as bool? ?? false,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LayerPainterToJson(_$LayerPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'strokeWidth': instance.strokeWidth,
      'layer': instance.layer,
      'includeEraser': instance.includeEraser,
      'type': instance.$type,
    };

_$AreaPainter _$$AreaPainterFromJson(Map json) => _$AreaPainter(
      name: json['name'] as String? ?? '',
      constrainedWidth: (json['constrainedWidth'] as num?)?.toDouble() ?? 0,
      constrainedHeight: (json['constrainedHeight'] as num?)?.toDouble() ?? 0,
      constrainedAspectRatio:
          (json['constrainedAspectRatio'] as num?)?.toDouble() ?? 0,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AreaPainterToJson(_$AreaPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'constrainedWidth': instance.constrainedWidth,
      'constrainedHeight': instance.constrainedHeight,
      'constrainedAspectRatio': instance.constrainedAspectRatio,
      'type': instance.$type,
    };
