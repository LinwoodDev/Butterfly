// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectTool _$SelectToolFromJson(Map json) => SelectTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  mode:
      $enumDecodeNullable(_$SelectModeEnumMap, json['mode']) ??
      SelectMode.rectangle,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SelectToolToJson(SelectTool instance) =>
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

HandTool _$HandToolFromJson(Map json) => HandTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  $type: json['type'] as String?,
);

Map<String, dynamic> _$HandToolToJson(HandTool instance) => <String, dynamic>{
  'name': instance.name,
  'displayIcon': instance.displayIcon,
  'type': instance.$type,
};

ImportTool _$ImportToolFromJson(Map json) => ImportTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  elements: (json['elements'] as List<dynamic>)
      .map((e) => PadElement.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList(),
  areas: (json['areas'] as List<dynamic>)
      .map((e) => Area.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList(),
  assets:
      (json['assets'] as Map?)?.map(
        (k, e) => MapEntry(
          k as String,
          const Uint8ListJsonConverter().fromJson(e as String),
        ),
      ) ??
      const {},
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ImportToolToJson(ImportTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'elements': instance.elements.map((e) => e.toJson()).toList(),
      'areas': instance.areas.map((e) => e.toJson()).toList(),
      'assets': instance.assets.map(
        (k, e) => MapEntry(k, const Uint8ListJsonConverter().toJson(e)),
      ),
      'type': instance.$type,
    };

UndoTool _$UndoToolFromJson(Map json) => UndoTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  $type: json['type'] as String?,
);

Map<String, dynamic> _$UndoToolToJson(UndoTool instance) => <String, dynamic>{
  'name': instance.name,
  'displayIcon': instance.displayIcon,
  'type': instance.$type,
};

RedoTool _$RedoToolFromJson(Map json) => RedoTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  $type: json['type'] as String?,
);

Map<String, dynamic> _$RedoToolToJson(RedoTool instance) => <String, dynamic>{
  'name': instance.name,
  'displayIcon': instance.displayIcon,
  'type': instance.$type,
};

LabelTool _$LabelToolFromJson(Map json) => LabelTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  mode: $enumDecodeNullable(_$LabelModeEnumMap, json['mode']) ?? LabelMode.text,
  zoomDependent: json['zoomDependent'] as bool? ?? false,
  foreground: json['foreground'] == null
      ? SRGBColor.black
      : const ColorJsonConverter().fromJson(
          (json['foreground'] as num).toInt(),
        ),
  styleSheet: json['styleSheet'] == null
      ? null
      : NamedItem<TextStyleSheet>.fromJson(
          Map<String, dynamic>.from(json['styleSheet'] as Map),
          (value) =>
              TextStyleSheet.fromJson(Map<String, dynamic>.from(value as Map)),
        ),
  scale: (json['scale'] as num?)?.toDouble() ?? 2.0,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$LabelToolToJson(LabelTool instance) => <String, dynamic>{
  'name': instance.name,
  'displayIcon': instance.displayIcon,
  'mode': _$LabelModeEnumMap[instance.mode]!,
  'zoomDependent': instance.zoomDependent,
  'foreground': const ColorJsonConverter().toJson(instance.foreground),
  'styleSheet': instance.styleSheet?.toJson((value) => value.toJson()),
  'scale': instance.scale,
  'type': instance.$type,
};

const _$LabelModeEnumMap = {
  LabelMode.markdown: 'markdown',
  LabelMode.text: 'text',
};

PenTool _$PenToolFromJson(Map json) => PenTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  zoomDependent: json['zoomDependent'] as bool? ?? false,
  shapeDetectionTime: (json['shapeDetectionTime'] as num?)?.toDouble() ?? 0.5,
  shapeDetectionEnabled: json['shapeDetectionEnabled'] as bool? ?? false,
  property: json['property'] == null
      ? const PenProperty()
      : PenProperty.fromJson(
          Map<String, dynamic>.from(json['property'] as Map),
        ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$PenToolToJson(PenTool instance) => <String, dynamic>{
  'name': instance.name,
  'displayIcon': instance.displayIcon,
  'zoomDependent': instance.zoomDependent,
  'shapeDetectionTime': instance.shapeDetectionTime,
  'shapeDetectionEnabled': instance.shapeDetectionEnabled,
  'property': instance.property.toJson(),
  'type': instance.$type,
};

EraserTool _$EraserToolFromJson(Map json) => EraserTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
  eraseElements: json['eraseElements'] as bool? ?? false,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$EraserToolToJson(EraserTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'strokeWidth': instance.strokeWidth,
      'eraseElements': instance.eraseElements,
      'type': instance.$type,
    };

PathEraserTool _$PathEraserToolFromJson(Map json) => PathEraserTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
  eraseElements: json['eraseElements'] as bool? ?? false,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$PathEraserToolToJson(PathEraserTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'strokeWidth': instance.strokeWidth,
      'eraseElements': instance.eraseElements,
      'type': instance.$type,
    };

CollectionTool _$CollectionToolFromJson(Map json) => CollectionTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$CollectionToolToJson(CollectionTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'strokeWidth': instance.strokeWidth,
      'type': instance.$type,
    };

AreaTool _$AreaToolFromJson(Map json) => AreaTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  constrainedWidth: (json['constrainedWidth'] as num?)?.toDouble() ?? 0,
  constrainedHeight: (json['constrainedHeight'] as num?)?.toDouble() ?? 0,
  constrainedAspectRatio:
      (json['constrainedAspectRatio'] as num?)?.toDouble() ?? 0,
  askForName: json['askForName'] as bool? ?? false,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$AreaToolToJson(AreaTool instance) => <String, dynamic>{
  'name': instance.name,
  'displayIcon': instance.displayIcon,
  'constrainedWidth': instance.constrainedWidth,
  'constrainedHeight': instance.constrainedHeight,
  'constrainedAspectRatio': instance.constrainedAspectRatio,
  'askForName': instance.askForName,
  'type': instance.$type,
};

LaserTool _$LaserToolFromJson(Map json) => LaserTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  duration: (json['duration'] as num?)?.toDouble() ?? 5,
  hideDuration: (json['hideDuration'] as num?)?.toDouble() ?? 0.5,
  strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
  thinning: (json['thinning'] as num?)?.toDouble() ?? 0.4,
  color: json['color'] == null
      ? BasicColors.red
      : const ColorJsonConverter().fromJson((json['color'] as num).toInt()),
  animation:
      $enumDecodeNullable(_$LaserAnimationEnumMap, json['animation']) ??
      LaserAnimation.fade,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$LaserToolToJson(LaserTool instance) => <String, dynamic>{
  'name': instance.name,
  'displayIcon': instance.displayIcon,
  'duration': instance.duration,
  'hideDuration': instance.hideDuration,
  'strokeWidth': instance.strokeWidth,
  'thinning': instance.thinning,
  'color': const ColorJsonConverter().toJson(instance.color),
  'animation': _$LaserAnimationEnumMap[instance.animation]!,
  'type': instance.$type,
};

const _$LaserAnimationEnumMap = {
  LaserAnimation.fade: 'fade',
  LaserAnimation.path: 'path',
};

ShapeTool _$ShapeToolFromJson(Map json) => ShapeTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  zoomDependent: json['zoomDependent'] as bool? ?? false,
  constrainedWidth: (json['constrainedWidth'] as num?)?.toDouble() ?? 0,
  constrainedHeight: (json['constrainedHeight'] as num?)?.toDouble() ?? 0,
  constrainedAspectRatio:
      (json['constrainedAspectRatio'] as num?)?.toDouble() ?? 0,
  property: json['property'] == null
      ? const ShapeProperty(shape: RectangleShape())
      : ShapeProperty.fromJson(
          Map<String, dynamic>.from(json['property'] as Map),
        ),
  drawFromCenter: json['drawFromCenter'] as bool? ?? false,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ShapeToolToJson(ShapeTool instance) => <String, dynamic>{
  'name': instance.name,
  'displayIcon': instance.displayIcon,
  'zoomDependent': instance.zoomDependent,
  'constrainedWidth': instance.constrainedWidth,
  'constrainedHeight': instance.constrainedHeight,
  'constrainedAspectRatio': instance.constrainedAspectRatio,
  'property': instance.property.toJson(),
  'drawFromCenter': instance.drawFromCenter,
  'type': instance.$type,
};

StampTool _$StampToolFromJson(Map json) => StampTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  component: json['component'] == null
      ? null
      : NamedItem<ButterflyComponent>.fromJson(
          Map<String, dynamic>.from(json['component'] as Map),
          (value) => ButterflyComponent.fromJson(
            Map<String, dynamic>.from(value as Map),
          ),
        ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$StampToolToJson(StampTool instance) => <String, dynamic>{
  'name': instance.name,
  'displayIcon': instance.displayIcon,
  'component': instance.component?.toJson((value) => value.toJson()),
  'type': instance.$type,
};

PresentationTool _$PresentationToolFromJson(Map json) => PresentationTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  $type: json['type'] as String?,
);

Map<String, dynamic> _$PresentationToolToJson(PresentationTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'type': instance.$type,
    };

SpacerTool _$SpacerToolFromJson(Map json) => SpacerTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  axis: $enumDecodeNullable(_$Axis2DEnumMap, json['axis']) ?? Axis2D.horizontal,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SpacerToolToJson(SpacerTool instance) =>
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

FullScreenTool _$FullScreenToolFromJson(Map json) => FullScreenTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  $type: json['type'] as String?,
);

Map<String, dynamic> _$FullScreenToolToJson(FullScreenTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'type': instance.$type,
    };

AssetTool _$AssetToolFromJson(Map json) => AssetTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  importType:
      $enumDecodeNullable(_$ImportTypeEnumMap, json['importType']) ??
      ImportType.document,
  advanced: json['advanced'] as bool? ?? true,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$AssetToolToJson(AssetTool instance) => <String, dynamic>{
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
  ImportType.svgText: 'svgText',
  ImportType.pdf: 'pdf',
  ImportType.document: 'document',
  ImportType.markdown: 'markdown',
  ImportType.xopp: 'xopp',
};

ExportTool _$ExportToolFromJson(Map json) => ExportTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  options: ExportOptions.fromJson(
    Map<String, dynamic>.from(json['options'] as Map),
  ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ExportToolToJson(ExportTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'options': instance.options.toJson(),
      'type': instance.$type,
    };

TextureTool _$TextureToolFromJson(Map json) => TextureTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  zoomDependent: json['zoomDependent'] as bool? ?? false,
  constrainedWidth: (json['constrainedWidth'] as num?)?.toDouble() ?? 0,
  constrainedHeight: (json['constrainedHeight'] as num?)?.toDouble() ?? 0,
  constrainedAspectRatio:
      (json['constrainedAspectRatio'] as num?)?.toDouble() ?? 0,
  texture: json['texture'] == null
      ? const SurfaceTexture.pattern()
      : SurfaceTexture.fromJson(
          Map<String, dynamic>.from(json['texture'] as Map),
        ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$TextureToolToJson(TextureTool instance) =>
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

RulerTool _$RulerToolFromJson(Map json) => RulerTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  color: _$JsonConverterFromJson<int, SRGBColor>(
    json['color'],
    const ColorJsonConverter().fromJson,
  ),
  size: (json['size'] as num?)?.toInt() ?? 100,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$RulerToolToJson(RulerTool instance) => <String, dynamic>{
  'name': instance.name,
  'displayIcon': instance.displayIcon,
  'color': _$JsonConverterToJson<int, SRGBColor>(
    instance.color,
    const ColorJsonConverter().toJson,
  ),
  'size': instance.size,
  'type': instance.$type,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

GridTool _$GridToolFromJson(Map json) => GridTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  color: json['color'] == null
      ? SRGBColor.black
      : const ColorJsonConverter().fromJson((json['color'] as num).toInt()),
  xSize: (json['xSize'] as num?)?.toDouble() ?? 20,
  ySize: (json['ySize'] as num?)?.toDouble() ?? 20,
  xOffset: (json['xOffset'] as num?)?.toDouble() ?? 0,
  yOffset: (json['yOffset'] as num?)?.toDouble() ?? 0,
  positionDependent: json['positionDependent'] as bool? ?? false,
  zoomDependent: json['zoomDependent'] as bool? ?? false,
  stroke: (json['stroke'] as num?)?.toDouble() ?? 1,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$GridToolToJson(GridTool instance) => <String, dynamic>{
  'name': instance.name,
  'displayIcon': instance.displayIcon,
  'color': const ColorJsonConverter().toJson(instance.color),
  'xSize': instance.xSize,
  'ySize': instance.ySize,
  'xOffset': instance.xOffset,
  'yOffset': instance.yOffset,
  'positionDependent': instance.positionDependent,
  'zoomDependent': instance.zoomDependent,
  'stroke': instance.stroke,
  'type': instance.$type,
};

EyeDropperTool _$EyeDropperToolFromJson(Map json) => EyeDropperTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  $type: json['type'] as String?,
);

Map<String, dynamic> _$EyeDropperToolToJson(EyeDropperTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'type': instance.$type,
    };

BarcodeTool _$BarcodeToolFromJson(Map json) => BarcodeTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  barcodeType:
      $enumDecodeNullable(_$BarcodeTypeEnumMap, json['barcodeType']) ??
      BarcodeType.qrCode,
  color: json['color'] == null
      ? SRGBColor.black
      : const ColorJsonConverter().fromJson((json['color'] as num).toInt()),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$BarcodeToolToJson(BarcodeTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'barcodeType': _$BarcodeTypeEnumMap[instance.barcodeType]!,
      'color': const ColorJsonConverter().toJson(instance.color),
      'type': instance.$type,
    };

const _$BarcodeTypeEnumMap = {
  BarcodeType.qrCode: 'qrCode',
  BarcodeType.dataMatrix: 'dataMatrix',
  BarcodeType.code128: 'code128',
};

PolygonTool _$PolygonToolFromJson(Map json) => PolygonTool(
  name: json['name'] as String? ?? '',
  displayIcon: json['displayIcon'] as String? ?? '',
  zoomDependent: json['zoomDependent'] as bool? ?? false,
  property: json['property'] == null
      ? const PolygonProperty()
      : PolygonProperty.fromJson(
          Map<String, dynamic>.from(json['property'] as Map),
        ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$PolygonToolToJson(PolygonTool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayIcon': instance.displayIcon,
      'zoomDependent': instance.zoomDependent,
      'property': instance.property.toJson(),
      'type': instance.$type,
    };
