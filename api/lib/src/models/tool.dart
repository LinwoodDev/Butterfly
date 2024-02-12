import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'area.dart';
import 'colors.dart';
import 'element.dart';
import 'pack.dart';
import 'property.dart';
import 'texture.dart';

part 'tool.freezed.dart';
part 'tool.g.dart';

const double _kSquareRatio = 1.0;
const double _kAPortraitRatio = 1 / sqrt2;
const double _kLandscapeRatio = sqrt2;

enum AspectRatioPreset {
  square,
  portrait,
  landscape,
}

extension RatioPresetExtension on AspectRatioPreset {
  double get ratio {
    switch (this) {
      case AspectRatioPreset.square:
        return _kSquareRatio;
      case AspectRatioPreset.portrait:
        return _kAPortraitRatio;
      case AspectRatioPreset.landscape:
        return _kLandscapeRatio;
    }
  }
}

enum LabelMode { markdown, text }

enum Axis2D { horizontal, vertical }

enum ImportType { image, camera, svg, pdf, document, markdown, xopp }

enum SelectMode { rectangle, lasso }

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
    @Default(true) bool zoomDependent,
    @Default(true) bool straightLineEnabled,
    @Default(BasicColors.black) int foreground,
    @Default(PackAssetLocation()) PackAssetLocation styleSheet,
    @Default(2.0) double scale,
  }) = LabelTool;

  factory Tool.pen({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(true) bool zoomDependent,
    @Default(0.5) double straightLineTime,
    @Default(false) bool straightLineEnabled,
    @Default(PenProperty()) PenProperty property,
  }) = PenTool;

  factory Tool.eraser({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(5) double strokeWidth,
  }) = EraserTool;

  factory Tool.pathEraser({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(5) double strokeWidth,
  }) = PathEraserTool;

  factory Tool.layer({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(5) double strokeWidth,
  }) = LayerTool;

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
    @Default(5) double strokeWidth,
    @Default(0.4) double thinning,
    @Default(BasicColors.red) int color,
  }) = LaserTool;

  factory Tool.shape({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(true) bool zoomDependent,
    @Default(0) double constrainedWidth,
    @Default(0) double constrainedHeight,
    @Default(0) double constrainedAspectRatio,
    @Default(ShapeProperty(shape: RectangleShape())) ShapeProperty property,
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

  factory Tool.fullSceen({
    @Default('') String name,
    @Default('') String displayIcon,
  }) = FullScreenTool;

  factory Tool.asset({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(ImportType.document) ImportType importType,
    @Default(true) bool advanced,
  }) = AssetTool;

  factory Tool.texture({
    @Default('') String name,
    @Default('') String displayIcon,
    @Default(true) bool zoomDependent,
    @Default(0) double constrainedWidth,
    @Default(0) double constrainedHeight,
    @Default(0) double constrainedAspectRatio,
    @Default(SurfaceTexture.pattern()) SurfaceTexture texture,
  }) = TextureTool;

  factory Tool.eyeDropper({
    @Default('') String name,
    @Default('') String displayIcon,
  }) = EyeDropperTool;

  factory Tool.fromJson(Map<String, dynamic> json) => _$ToolFromJson(json);
}
