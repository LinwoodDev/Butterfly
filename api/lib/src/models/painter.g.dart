// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'painter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HandPainter _$$HandPainterFromJson(Map json) => _$HandPainter(
      name: json['name'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$HandPainterToJson(_$HandPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$ImportPainter _$$ImportPainterFromJson(Map json) => _$ImportPainter(
      name: json['name'] as String? ?? '',
      elements: (json['elements'] as List<dynamic>)
          .map((e) => PadElement.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      areas: (json['areas'] as List<dynamic>)
          .map((e) => Area.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ImportPainterToJson(_$ImportPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'elements': instance.elements.map((e) => e.toJson()).toList(),
      'areas': instance.areas.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

_$UndoPainter _$$UndoPainterFromJson(Map json) => _$UndoPainter(
      name: json['name'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$UndoPainterToJson(_$UndoPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$RedoPainter _$$RedoPainterFromJson(Map json) => _$RedoPainter(
      name: json['name'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$RedoPainterToJson(_$RedoPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$LabelPainter _$$LabelPainterFromJson(Map json) => _$LabelPainter(
      name: json['name'] as String? ?? '',
      mode: $enumDecodeNullable(_$LabelModeEnumMap, json['mode']) ??
          LabelMode.text,
      zoomDependent: json['zoomDependent'] as bool? ?? true,
      styleSheet: json['styleSheet'] == null
          ? const PackAssetLocation()
          : PackAssetLocation.fromJson(
              Map<String, dynamic>.from(json['styleSheet'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LabelPainterToJson(_$LabelPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mode': _$LabelModeEnumMap[instance.mode]!,
      'zoomDependent': instance.zoomDependent,
      'styleSheet': instance.styleSheet.toJson(),
      'type': instance.$type,
    };

const _$LabelModeEnumMap = {
  LabelMode.markdown: 'markdown',
  LabelMode.text: 'text',
};

_$PenPainter _$$PenPainterFromJson(Map json) => _$PenPainter(
      name: json['name'] as String? ?? '',
      zoomDependent: json['zoomDependent'] as bool? ?? true,
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
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$EraserPainterToJson(_$EraserPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'strokeWidth': instance.strokeWidth,
      'type': instance.$type,
    };

_$PathEraserPainter _$$PathEraserPainterFromJson(Map json) =>
    _$PathEraserPainter(
      name: json['name'] as String? ?? '',
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PathEraserPainterToJson(_$PathEraserPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'strokeWidth': instance.strokeWidth,
      'type': instance.$type,
    };

_$LayerPainter _$$LayerPainterFromJson(Map json) => _$LayerPainter(
      name: json['name'] as String? ?? '',
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LayerPainterToJson(_$LayerPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'strokeWidth': instance.strokeWidth,
      'type': instance.$type,
    };

_$AreaPainter _$$AreaPainterFromJson(Map json) => _$AreaPainter(
      name: json['name'] as String? ?? '',
      constrainedWidth: (json['constrainedWidth'] as num?)?.toDouble() ?? 0,
      constrainedHeight: (json['constrainedHeight'] as num?)?.toDouble() ?? 0,
      constrainedAspectRatio:
          (json['constrainedAspectRatio'] as num?)?.toDouble() ?? 0,
      askForName: json['askForName'] as bool? ?? false,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AreaPainterToJson(_$AreaPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'constrainedWidth': instance.constrainedWidth,
      'constrainedHeight': instance.constrainedHeight,
      'constrainedAspectRatio': instance.constrainedAspectRatio,
      'askForName': instance.askForName,
      'type': instance.$type,
    };

_$WaypointPainter _$$WaypointPainterFromJson(Map json) => _$WaypointPainter(
      name: json['name'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$WaypointPainterToJson(_$WaypointPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$LaserPainter _$$LaserPainterFromJson(Map json) => _$LaserPainter(
      name: json['name'] as String? ?? '',
      duration: (json['duration'] as num?)?.toDouble() ?? 5,
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      thinning: (json['thinning'] as num?)?.toDouble() ?? 0.4,
      color: json['color'] as int? ?? kColorRed,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LaserPainterToJson(_$LaserPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'duration': instance.duration,
      'strokeWidth': instance.strokeWidth,
      'thinning': instance.thinning,
      'color': instance.color,
      'type': instance.$type,
    };

_$ShapePainter _$$ShapePainterFromJson(Map json) => _$ShapePainter(
      name: json['name'] as String? ?? '',
      zoomDependent: json['zoomDependent'] as bool? ?? true,
      constrainedWidth: (json['constrainedWidth'] as num?)?.toDouble() ?? 0,
      constrainedHeight: (json['constrainedHeight'] as num?)?.toDouble() ?? 0,
      constrainedAspectRatio:
          (json['constrainedAspectRatio'] as num?)?.toDouble() ?? 0,
      property: json['property'] == null
          ? const ShapeProperty(shape: RectangleShape())
          : ShapeProperty.fromJson(
              Map<String, dynamic>.from(json['property'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ShapePainterToJson(_$ShapePainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'zoomDependent': instance.zoomDependent,
      'constrainedWidth': instance.constrainedWidth,
      'constrainedHeight': instance.constrainedHeight,
      'constrainedAspectRatio': instance.constrainedAspectRatio,
      'property': instance.property.toJson(),
      'type': instance.$type,
    };

_$StampPainter _$$StampPainterFromJson(Map json) => _$StampPainter(
      name: json['name'] as String? ?? '',
      component: json['component'] == null
          ? const PackAssetLocation()
          : PackAssetLocation.fromJson(
              Map<String, dynamic>.from(json['component'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$StampPainterToJson(_$StampPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'component': instance.component.toJson(),
      'type': instance.$type,
    };

_$PresentationPainter _$$PresentationPainterFromJson(Map json) =>
    _$PresentationPainter(
      name: json['name'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PresentationPainterToJson(
        _$PresentationPainter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };
