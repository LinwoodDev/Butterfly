import 'dart:math';

import 'package:butterfly_api/src/converter/color.dart';
import 'package:dart_leap/dart_leap.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'area.dart';
import 'colors.dart';
import 'element.dart';
import 'export.dart';
import 'pack.dart';
import 'property.dart';
import 'texture.dart';

part 'tool.freezed.dart';
part 'tool.g.dart';

const double _kSquareRatio = 1.0;
const double _kAPortraitRatio = 1 / sqrt2;
const double _kLandscapeRatio = sqrt2;

enum AspectRatioPreset { square, portrait, landscape }

extension RatioPresetExtension on AspectRatioPreset {
  double get ratio => switch (this) {
    AspectRatioPreset.square => _kSquareRatio,
    AspectRatioPreset.portrait => _kAPortraitRatio,
    AspectRatioPreset.landscape => _kLandscapeRatio,
  };
}

enum LabelMode { markdown, text }

enum Axis2D { horizontal, vertical }

enum ImportType { image, camera, svg, svgText, pdf, document, markdown, xopp }

enum SelectMode { rectangle, lasso }

enum LaserAnimation { fade, path }

enum ToolCategory { import, normal, surface, action, view }

enum BarcodeType {
  qrCode,
  dataMatrix,
  code128(width: 400, height: 160);

  final double width, height;

  const BarcodeType({this.width = 300, this.height = 300});
}

@Freezed(equal: false)
sealed class Tool with _$Tool {
  Tool._();

  factory Tool.select({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(SelectMode.rectangle) SelectMode mode,
  }) = SelectTool;

  factory Tool.hand({
    @Default('') String name,
    @Default('') String displayIcon,
  }) = HandTool;

  factory Tool.import({
    @Default('') String name,
    @Default('') String displayIcon,
    required List<PadElement> elements,
    required List<Area> areas,
  }) = ImportTool;

  factory Tool.undo({
    @Default('') String name,
    @Default('') String displayIcon,
  }) = UndoTool;

  factory Tool.redo({
    @Default('') String name,
    @Default('') String displayIcon,
  }) = RedoTool;

  factory Tool.label({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(LabelMode.text) LabelMode mode,
    @Default(false) bool zoomDependent,
    @Default(SRGBColor.black) @ColorJsonConverter() SRGBColor foreground,
    @Default(PackAssetLocation()) PackAssetLocation styleSheet,
    @Default(2.0) double scale,
  }) = LabelTool;

  factory Tool.pen({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(false) bool zoomDependent,
    @Default(0.5) double shapeDetectionTime,
    @Default(false) bool shapeDetectionEnabled,
    @Default(PenProperty()) PenProperty property,
  }) = PenTool;

  factory Tool.eraser({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(5) double strokeWidth,
    @Default(false) bool eraseElements,
  }) = EraserTool;

  factory Tool.pathEraser({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(5) double strokeWidth,
    @Default(false) bool eraseElements,
  }) = PathEraserTool;

  factory Tool.collection({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(5) double strokeWidth,
  }) = CollectionTool;

  factory Tool.area({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(0) double constrainedWidth,
    @Default(0) double constrainedHeight,
    @Default(0) double constrainedAspectRatio,
    @Default(false) bool askForName,
  }) = AreaTool;

  factory Tool.laser({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(5) double duration,
    @Default(0.5) double hideDuration,
    @Default(5) double strokeWidth,
    @Default(0.4) double thinning,
    @Default(BasicColors.red) @ColorJsonConverter() SRGBColor color,
    @Default(LaserAnimation.fade) LaserAnimation animation,
  }) = LaserTool;

  factory Tool.shape({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(false) bool zoomDependent,
    @Default(0) double constrainedWidth,
    @Default(0) double constrainedHeight,
    @Default(0) double constrainedAspectRatio,
    @Default(ShapeProperty(shape: RectangleShape())) ShapeProperty property,
    @Default(false) bool drawFromCenter,
  }) = ShapeTool;

  factory Tool.stamp({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(PackAssetLocation()) PackAssetLocation component,
  }) = StampTool;

  factory Tool.presentation({
    @Default('') String name,
    @Default('') String displayIcon,
  }) = PresentationTool;

  factory Tool.spacer({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(Axis2D.horizontal) Axis2D axis,
  }) = SpacerTool;

  @FreezedUnionValue('fullSceen')
  factory Tool.fullScreen({
    @Default('') String name,
    @Default('') String displayIcon,
  }) = FullScreenTool;

  factory Tool.asset({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(ImportType.document) ImportType importType,
    @Default(true) bool advanced,
  }) = AssetTool;

  factory Tool.export({
    @Default('') String name,
    @Default('') String displayIcon,
    required ExportOptions options,
  }) = ExportTool;

  factory Tool.texture({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(false) bool zoomDependent,
    @Default(0) double constrainedWidth,
    @Default(0) double constrainedHeight,
    @Default(0) double constrainedAspectRatio,
    @Default(SurfaceTexture.pattern()) SurfaceTexture texture,
  }) = TextureTool;

  factory Tool.ruler({
    @Default('') String name,
    @Default('') String displayIcon,
    @ColorJsonConverter() SRGBColor? color,
    @Default(100) int size,
  }) = RulerTool;

  factory Tool.grid({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(SRGBColor.black) @ColorJsonConverter() SRGBColor color,
    @Default(20) double xSize,
    @Default(20) double ySize,
    @Default(0) double xOffset,
    @Default(0) double yOffset,
    @Default(false) bool positionDependent,
    @Default(false) bool zoomDependent,
    @Default(1) double stroke,
  }) = GridTool;

  factory Tool.eyeDropper({
    @Default('') String name,
    @Default('') String displayIcon,
  }) = EyeDropperTool;

  factory Tool.barcode({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(BarcodeType.qrCode) BarcodeType barcodeType,
    @Default(SRGBColor.black) @ColorJsonConverter() SRGBColor color,
  }) = BarcodeTool;

  factory Tool.fromJson(Map<String, dynamic> json) => _$ToolFromJson(json);

  ToolCategory get category => switch (this) {
    SelectTool() => ToolCategory.normal,
    HandTool() => ToolCategory.normal,
    ImportTool() => ToolCategory.import,
    UndoTool() => ToolCategory.action,
    RedoTool() => ToolCategory.action,
    LabelTool() => ToolCategory.normal,
    PenTool() => ToolCategory.normal,
    EraserTool() => ToolCategory.normal,
    PathEraserTool() => ToolCategory.normal,
    CollectionTool() => ToolCategory.normal,
    AreaTool() => ToolCategory.normal,
    LaserTool() => ToolCategory.normal,
    ShapeTool() => ToolCategory.surface,
    StampTool() => ToolCategory.surface,
    PresentationTool() => ToolCategory.normal,
    SpacerTool() => ToolCategory.normal,
    FullScreenTool() => ToolCategory.action,
    AssetTool() => ToolCategory.import,
    ExportTool() => ToolCategory.action,
    TextureTool() => ToolCategory.surface,
    RulerTool() => ToolCategory.view,
    GridTool() => ToolCategory.view,
    EyeDropperTool() => ToolCategory.action,
    BarcodeTool() => ToolCategory.surface,
  };
}
