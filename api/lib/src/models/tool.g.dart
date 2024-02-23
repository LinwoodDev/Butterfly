// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SelectToolImpl _$$SelectToolImplFromJson(Map json) => _$SelectToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      mode: $enumDecodeNullable(_$SelectModeEnumMap, json['mode']) ??
          SelectMode.rectangle,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$SelectToolImplToJson(_$SelectToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'mode': _$SelectModeEnumMap[instance.mode]!,
      'type': instance.$type,
    };

const _$SelectModeEnumMap = {
  SelectMode.rectangle: 'rectangle',
  SelectMode.lasso: 'lasso',
};

_$HandToolImpl _$$HandToolImplFromJson(Map json) => _$HandToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$HandToolImplToJson(_$HandToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'type': instance.$type,
    };

_$ImportToolImpl _$$ImportToolImplFromJson(Map json) => _$ImportToolImpl(
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

Map<String, dynamic> _$$ImportToolImplToJson(_$ImportToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'elements': instance.elements.map((e) => e.toJson()).toList(),
      'areas': instance.areas.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

_$UndoToolImpl _$$UndoToolImplFromJson(Map json) => _$UndoToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$UndoToolImplToJson(_$UndoToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'type': instance.$type,
    };

_$RedoToolImpl _$$RedoToolImplFromJson(Map json) => _$RedoToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$RedoToolImplToJson(_$RedoToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'type': instance.$type,
    };

_$LabelToolImpl _$$LabelToolImplFromJson(Map json) => _$LabelToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      mode: $enumDecodeNullable(_$LabelModeEnumMap, json['mode']) ??
          LabelMode.text,
      zoomDependent: json['zoomDependent'] as bool? ?? true,
      foreground: json['foreground'] as int? ?? BasicColors.black,
      styleSheet: json['styleSheet'] == null
          ? const PackAssetLocation()
          : PackAssetLocation.fromJson(
              Map<String, dynamic>.from(json['styleSheet'] as Map)),
      scale: (json['scale'] as num?)?.toDouble() ?? 2.0,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LabelToolImplToJson(_$LabelToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'mode': _$LabelModeEnumMap[instance.mode]!,
      'zoomDependent': instance.zoomDependent,
      'foreground': instance.foreground,
      'styleSheet': instance.styleSheet.toJson(),
      'scale': instance.scale,
      'type': instance.$type,
    };

const _$LabelModeEnumMap = {
  LabelMode.markdown: 'markdown',
  LabelMode.text: 'text',
};

_$PenToolImpl _$$PenToolImplFromJson(Map json) => _$PenToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      zoomDependent: json['zoomDependent'] as bool? ?? true,
      shapeDetectionTime:
          (json['shapeDetectionTime'] as num?)?.toDouble() ?? 0.5,
      shapeDetectionEnabled: json['shapeDetectionEnabled'] as bool? ?? false,
      property: json['property'] == null
          ? const PenProperty()
          : PenProperty.fromJson(
              Map<String, dynamic>.from(json['property'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PenToolImplToJson(_$PenToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'zoomDependent': instance.zoomDependent,
      'shapeDetectionTime': instance.shapeDetectionTime,
      'shapeDetectionEnabled': instance.shapeDetectionEnabled,
      'property': instance.property.toJson(),
      'type': instance.$type,
    };

_$EraserToolImpl _$$EraserToolImplFromJson(Map json) => _$EraserToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$EraserToolImplToJson(_$EraserToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'strokeWidth': instance.strokeWidth,
      'type': instance.$type,
    };

_$PathEraserToolImpl _$$PathEraserToolImplFromJson(Map json) =>
    _$PathEraserToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PathEraserToolImplToJson(
        _$PathEraserToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'strokeWidth': instance.strokeWidth,
      'type': instance.$type,
    };

_$LayerToolImpl _$$LayerToolImplFromJson(Map json) => _$LayerToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LayerToolImplToJson(_$LayerToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'strokeWidth': instance.strokeWidth,
      'type': instance.$type,
    };

_$AreaToolImpl _$$AreaToolImplFromJson(Map json) => _$AreaToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      constrainedWidth: (json['constrainedWidth'] as num?)?.toDouble() ?? 0,
      constrainedHeight: (json['constrainedHeight'] as num?)?.toDouble() ?? 0,
      constrainedAspectRatio:
          (json['constrainedAspectRatio'] as num?)?.toDouble() ?? 0,
      askForName: json['askForName'] as bool? ?? false,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AreaToolImplToJson(_$AreaToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'constrainedWidth': instance.constrainedWidth,
      'constrainedHeight': instance.constrainedHeight,
      'constrainedAspectRatio': instance.constrainedAspectRatio,
      'askForName': instance.askForName,
      'type': instance.$type,
    };

_$LaserToolImpl _$$LaserToolImplFromJson(Map json) => _$LaserToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      duration: (json['duration'] as num?)?.toDouble() ?? 5,
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
      thinning: (json['thinning'] as num?)?.toDouble() ?? 0.4,
      color: json['color'] as int? ?? BasicColors.red,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LaserToolImplToJson(_$LaserToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'duration': instance.duration,
      'strokeWidth': instance.strokeWidth,
      'thinning': instance.thinning,
      'color': instance.color,
      'type': instance.$type,
    };

_$ShapeToolImpl _$$ShapeToolImplFromJson(Map json) => _$ShapeToolImpl(
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

Map<String, dynamic> _$$ShapeToolImplToJson(_$ShapeToolImpl instance) =>
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

_$StampToolImpl _$$StampToolImplFromJson(Map json) => _$StampToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      component: json['component'] == null
          ? const PackAssetLocation()
          : PackAssetLocation.fromJson(
              Map<String, dynamic>.from(json['component'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$StampToolImplToJson(_$StampToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'component': instance.component.toJson(),
      'type': instance.$type,
    };

_$PresentationToolImpl _$$PresentationToolImplFromJson(Map json) =>
    _$PresentationToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PresentationToolImplToJson(
        _$PresentationToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'type': instance.$type,
    };

_$SpacerToolImpl _$$SpacerToolImplFromJson(Map json) => _$SpacerToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      axis: $enumDecodeNullable(_$Axis2DEnumMap, json['axis']) ??
          Axis2D.horizontal,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$SpacerToolImplToJson(_$SpacerToolImpl instance) =>
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

_$FullScreenToolImpl _$$FullScreenToolImplFromJson(Map json) =>
    _$FullScreenToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$FullScreenToolImplToJson(
        _$FullScreenToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'type': instance.$type,
    };

_$AssetToolImpl _$$AssetToolImplFromJson(Map json) => _$AssetToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      importType:
          $enumDecodeNullable(_$ImportTypeEnumMap, json['importType']) ??
              ImportType.document,
      advanced: json['advanced'] as bool? ?? true,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AssetToolImplToJson(_$AssetToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'importType': _$ImportTypeEnumMap[instance.importType]!,
      'advanced': instance.advanced,
      'type': instance.$type,
    };

const _$ImportTypeEnumMap = {
  ImportType.image: 'image',
  ImportType.camera: 'camera',
  ImportType.svg: 'svg',
  ImportType.pdf: 'pdf',
  ImportType.document: 'document',
  ImportType.markdown: 'markdown',
  ImportType.xopp: 'xopp',
};

_$ExportToolImpl _$$ExportToolImplFromJson(Map json) => _$ExportToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      options: ExportOptions.fromJson(
          Map<String, dynamic>.from(json['options'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ExportToolImplToJson(_$ExportToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'options': instance.options.toJson(),
      'type': instance.$type,
    };

_$TextureToolImpl _$$TextureToolImplFromJson(Map json) => _$TextureToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      zoomDependent: json['zoomDependent'] as bool? ?? true,
      constrainedWidth: (json['constrainedWidth'] as num?)?.toDouble() ?? 0,
      constrainedHeight: (json['constrainedHeight'] as num?)?.toDouble() ?? 0,
      constrainedAspectRatio:
          (json['constrainedAspectRatio'] as num?)?.toDouble() ?? 0,
      texture: json['texture'] == null
          ? const SurfaceTexture.pattern()
          : SurfaceTexture.fromJson(
              Map<String, dynamic>.from(json['texture'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TextureToolImplToJson(_$TextureToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'zoomDependent': instance.zoomDependent,
      'constrainedWidth': instance.constrainedWidth,
      'constrainedHeight': instance.constrainedHeight,
      'constrainedAspectRatio': instance.constrainedAspectRatio,
      'texture': instance.texture.toJson(),
      'type': instance.$type,
    };

_$EyeDropperToolImpl _$$EyeDropperToolImplFromJson(Map json) =>
    _$EyeDropperToolImpl(
      name: json['name'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$EyeDropperToolImplToJson(
        _$EyeDropperToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'type': instance.$type,
    };
