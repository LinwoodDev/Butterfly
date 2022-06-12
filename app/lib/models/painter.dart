import 'dart:math';

import 'package:butterfly/models/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'property.dart';

part 'painter.g.dart';
part 'painter.freezed.dart';

const double _kSquareRatio = 1.0;
const double _kAPortraitRatio = sqrt2;
const double _kLandscapeRatio = 1 / sqrt2;

enum AreaRatioPreset {
  square,
  portrait,
  landscape,
}

extension AreaRatioPresetExtension on AreaRatioPreset {
  double get ratio {
    switch (this) {
      case AreaRatioPreset.square:
        return _kSquareRatio;
      case AreaRatioPreset.portrait:
        return _kAPortraitRatio;
      case AreaRatioPreset.landscape:
        return _kLandscapeRatio;
    }
  }

  String getLocalizedName(BuildContext context) {
    switch (this) {
      case AreaRatioPreset.square:
        return AppLocalizations.of(context)!.square;
      case AreaRatioPreset.portrait:
        return AppLocalizations.of(context)!.pagePortrait;
      case AreaRatioPreset.landscape:
        return AppLocalizations.of(context)!.pageLandscape;
    }
  }
}

@freezed
class Painter with _$Painter {
  const factory Painter.label({
    @Default('') String name,
    @Default(LabelProperty()) LabelProperty property,
  }) = LabelPainter;

  const factory Painter.pen({
    @Default('') String name,
    @Default(false) bool zoomDependent,
    @Default(PenProperty()) PenProperty property,
  }) = PenPainter;

  const factory Painter.eraser({
    @Default('') String name,
    @Default(EraserProperty()) EraserProperty property,
  }) = EraserPainter;

  const factory Painter.pathEraser(
      {@Default('') String name,
      @Default(5) double strokeWidth,
      @Default(false) bool includeEraser,
      @Default(false) bool deleteWholeStroke}) = PathEraserPainter;

  const factory Painter.layer(
      {@Default('') String name,
      @Default(5) double strokeWidth,
      @Default('') String layer,
      @Default(false) bool includeEraser}) = LayerPainter;

  const factory Painter.area({
    @Default('') String name,
    @Default(0) double constrainedWidth,
    @Default(0) double constrainedHeight,
    @Default(0) double constrainedAspectRatio,
  }) = AreaPainter;

  const factory Painter.laser(
      {@Default('') String name,
      @Default(5) double duration,
      @Default(5) double strokeWidth,
      @Default(10) double strokeMultiplier,
      @Default(kColorRed) int color}) = LaserPainter;

  factory Painter.fromJson(Map<String, dynamic> json) =>
      _$PainterFromJson(json);
}
