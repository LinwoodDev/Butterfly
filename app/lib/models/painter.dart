import 'dart:math';

import 'package:butterfly/models/colors.dart';
import 'package:butterfly/models/pack.dart';
import 'package:butterfly/models/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'area.dart';
import 'element.dart';
import 'property.dart';

part 'painter.g.dart';
part 'painter.freezed.dart';

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

  String getLocalizedName(BuildContext context) {
    switch (this) {
      case AspectRatioPreset.square:
        return AppLocalizations.of(context).square;
      case AspectRatioPreset.portrait:
        return AppLocalizations.of(context).pagePortrait;
      case AspectRatioPreset.landscape:
        return AppLocalizations.of(context).pageLandscape;
    }
  }
}

@freezed
class LabelOption with _$LabelOption {
  const factory LabelOption.text({
    @Default(AreaProperty()) AreaProperty property,
  }) = TextOption;
  const factory LabelOption.markdown({
    String? styleSheet,
  }) = MarkdownOption;

  const factory LabelOption.richText({
    String? styleSheet,
  }) = RichTextOption;

  factory LabelOption.fromJson(Map<String, dynamic> json) =>
      _$LabelOptionFromJson(json);
}

@Freezed(equal: false)
class Painter with _$Painter {
  factory Painter.hand({
    @Default('') String name,
  }) = HandPainter;

  factory Painter.import({
    @Default('') String name,
    required List<PadElement> elements,
    required List<Area> areas,
  }) = ImportPainter;

  factory Painter.undo({
    @Default('') String name,
  }) = UndoPainter;

  factory Painter.redo({
    @Default('') String name,
  }) = RedoPainter;

  factory Painter.label({
    @Default('') String name,
    @Default(PackAssetLocation()) PackAssetLocation styleSheet,
  }) = LabelPainter;

  factory Painter.pen({
    @Default('') String name,
    @Default(true) bool zoomDependent,
    @Default(PenProperty()) PenProperty property,
  }) = PenPainter;

  factory Painter.eraser({
    @Default('') String name,
    @Default(5) double strokeWidth,
  }) = EraserPainter;

  factory Painter.pathEraser({
    @Default('') String name,
    @Default(5) double strokeWidth,
  }) = PathEraserPainter;

  factory Painter.layer({
    @Default('') String name,
    @Default(5) double strokeWidth,
  }) = LayerPainter;

  factory Painter.area({
    @Default('') String name,
    @Default(0) double constrainedWidth,
    @Default(0) double constrainedHeight,
    @Default(0) double constrainedAspectRatio,
    @Default(false) bool askForName,
  }) = AreaPainter;

  factory Painter.waypoint({
    @Default('') String name,
  }) = WaypointPainter;

  factory Painter.laser({
    @Default('') String name,
    @Default(5) double duration,
    @Default(5) double strokeWidth,
    @Default(10) double strokeMultiplier,
    @Default(kColorRed) int color,
  }) = LaserPainter;

  factory Painter.shape({
    @Default('') String name,
    @Default(true) bool zoomDependent,
    @Default(0) double constrainedWidth,
    @Default(0) double constrainedHeight,
    @Default(0) double constrainedAspectRatio,
    @Default(ShapeProperty(shape: RectangleShape())) ShapeProperty property,
  }) = ShapePainter;

  factory Painter.stamp({
    @Default('') String name,
    @Default(PackAssetLocation()) PackAssetLocation component,
  }) = StampPainter;

  factory Painter.fromJson(Map<String, dynamic> json) =>
      _$PainterFromJson(json);
}
