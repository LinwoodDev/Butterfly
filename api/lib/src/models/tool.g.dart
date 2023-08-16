// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SelectTool _$$SelectToolFromJson(Map json) => _$SelectTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$SelectToolToJson(_$SelectTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'type': instance.$type,
    };

_$HandTool _$$HandToolFromJson(Map json) => _$HandTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$HandToolToJson(_$HandTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'type': instance.$type,
    };

_$ImportTool _$$ImportToolFromJson(Map json) => _$ImportTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      elements: (json['elements'] as List<dynamic>)
          .map((e) => PadElement.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      areas: (json['areas'] as List<dynamic>)
          .map((e) => Area.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ImportToolToJson(_$ImportTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'elements': instance.elements.map((e) => e.toJson()).toList(),
      'areas': instance.areas.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

_$UndoTool _$$UndoToolFromJson(Map json) => _$UndoTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$UndoToolToJson(_$UndoTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'type': instance.$type,
    };

_$RedoTool _$$RedoToolFromJson(Map json) => _$RedoTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$RedoToolToJson(_$RedoTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'type': instance.$type,
    };

_$LabelTool _$$LabelToolFromJson(Map json) => _$LabelTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      mode: $enumDecodeNullable(_$LabelModeEnumMap, json['mode']) ??
          LabelMode.text,
      zoomDependent: json['zoomDependent'] as bool? ?? true,
      foreground: json['foreground'] as int? ?? kColorBlack,
      styleSheet: json['styleSheet'] == null
          ? const PackAssetLocation()
          : PackAssetLocation.fromJson(
              Map<String, dynamic>.from(json['styleSheet'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LabelToolToJson(_$LabelTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'mode': _$LabelModeEnumMap[instance.mode]!,
      'zoomDependent': instance.zoomDependent,
      'foreground': instance.foreground,
      'styleSheet': instance.styleSheet.toJson(),
      'type': instance.$type,
    };

const _$LabelModeEnumMap = {
  LabelMode.markdown: 'markdown',
  LabelMode.text: 'text',
};

_$PenTool _$$PenToolFromJson(Map json) => _$PenTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      zoomDependent: json['zoomDependent'] as bool? ?? true,
      property: json['property'] == null
          ? const PenProperty()
          : PenProperty.fromJson(
              Map<String, dynamic>.from(json['property'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PenToolToJson(_$PenTool instance) => <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'zoomDependent': instance.zoomDependent,
      'property': instance.property.toJson(),
      'type': instance.$type,
    };

_$EraserTool _$$EraserToolFromJson(Map json) => _$EraserTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$EraserToolToJson(_$EraserTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'strokeWidth': instance.strokeWidth,
      'type': instance.$type,
    };

_$PathEraserTool _$$PathEraserToolFromJson(Map json) => _$PathEraserTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PathEraserToolToJson(_$PathEraserTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'strokeWidth': instance.strokeWidth,
      'type': instance.$type,
    };

_$LayerTool _$$LayerToolFromJson(Map json) => _$LayerTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LayerToolToJson(_$LayerTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'strokeWidth': instance.strokeWidth,
      'type': instance.$type,
    };

_$AreaTool _$$AreaToolFromJson(Map json) => _$AreaTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      constrainedWidth: (json['constrainedWidth'] as num?)?.toDouble() ?? 0,
      constrainedHeight: (json['constrainedHeight'] as num?)?.toDouble() ?? 0,
      constrainedAspectRatio:
          (json['constrainedAspectRatio'] as num?)?.toDouble() ?? 0,
      askForName: json['askForName'] as bool? ?? false,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AreaToolToJson(_$AreaTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'constrainedWidth': instance.constrainedWidth,
      'constrainedHeight': instance.constrainedHeight,
      'constrainedAspectRatio': instance.constrainedAspectRatio,
      'askForName': instance.askForName,
      'type': instance.$type,
    };

_$LaserTool _$$LaserToolFromJson(Map json) => _$LaserTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      duration: (json['duration'] as num?)?.toDouble() ?? 5,
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      thinning: (json['thinning'] as num?)?.toDouble() ?? 0.4,
      color: json['color'] as int? ?? kColorRed,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LaserToolToJson(_$LaserTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'duration': instance.duration,
      'strokeWidth': instance.strokeWidth,
      'thinning': instance.thinning,
      'color': instance.color,
      'type': instance.$type,
    };

_$ShapeTool _$$ShapeToolFromJson(Map json) => _$ShapeTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
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

Map<String, dynamic> _$$ShapeToolToJson(_$ShapeTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'zoomDependent': instance.zoomDependent,
      'constrainedWidth': instance.constrainedWidth,
      'constrainedHeight': instance.constrainedHeight,
      'constrainedAspectRatio': instance.constrainedAspectRatio,
      'property': instance.property.toJson(),
      'type': instance.$type,
    };

_$StampTool _$$StampToolFromJson(Map json) => _$StampTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      component: json['component'] == null
          ? const PackAssetLocation()
          : PackAssetLocation.fromJson(
              Map<String, dynamic>.from(json['component'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$StampToolToJson(_$StampTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'component': instance.component.toJson(),
      'type': instance.$type,
    };

_$PresentationTool _$$PresentationToolFromJson(Map json) => _$PresentationTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PresentationToolToJson(_$PresentationTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'type': instance.$type,
    };

_$SpacerTool _$$SpacerToolFromJson(Map json) => _$SpacerTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      axis: $enumDecodeNullable(_$Axis2DEnumMap, json['axis']) ??
          Axis2D.horizontal,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$SpacerToolToJson(_$SpacerTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'axis': _$Axis2DEnumMap[instance.axis]!,
      'type': instance.$type,
    };

const _$Axis2DEnumMap = {
  Axis2D.horizontal: 'horizontal',
  Axis2D.vertical: 'vertical',
};

_$FullScreenTool _$$FullScreenToolFromJson(Map json) => _$FullScreenTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$FullScreenToolToJson(_$FullScreenTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'type': instance.$type,
    };

_$AssetTool _$$AssetToolFromJson(Map json) => _$AssetTool(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      importType:
          $enumDecodeNullable(_$ImportTypeEnumMap, json['importType']) ??
              ImportType.document,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AssetToolToJson(_$AssetTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'importType': _$ImportTypeEnumMap[instance.importType]!,
      'type': instance.$type,
    };

const _$ImportTypeEnumMap = {
  ImportType.image: 'image',
  ImportType.camera: 'camera',
  ImportType.svg: 'svg',
  ImportType.pdf: 'pdf',
  ImportType.document: 'document',
};
