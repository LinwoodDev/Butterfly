import 'dart:typed_data';

import 'package:butterfly/models/converter.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'path_point.dart';
import 'property.dart';

part 'element.freezed.dart';
part 'element.g.dart';

@freezed
class PadConstraints with _$PadConstraints {
  const factory PadConstraints.scaled(double scale) = ScaledPadConstraints;
  const factory PadConstraints.fixed(double height, double width) =
      FixedPadConstraints;
  const factory PadConstraints.dynamic({
    @Default(0) double height,
    @Default(0) double width,
    @Default(null) double aspectRatio,
    @Default(true) bool includeArea,
  }) = DynamicPadConstraints;

  factory PadConstraints.fromJson(Map<String, dynamic> json) =>
      _$PadConstraintsFromJson(json);
}

abstract class PathElement {
  List<PathPoint> get points;
  PathProperty get property;
}

@freezed
class PadElement with _$PadElement {
  @Implements<PathElement>()
  const factory PadElement.pen(
      {@Default('') String layer,
      @Default([]) List<PathPoint> points,
      @Default(PenProperty()) PenProperty property}) = PenElement;

  @Implements<PathElement>()
  const factory PadElement.eraser({
    @Default('') String layer,
    @Default([]) List<PathPoint> points,
    @Default(EraserProperty()) EraserProperty property,
  }) = EraserElement;

  const factory PadElement.label({
    @Default('') String layer,
    @OffsetJsonConverter() @Default(Offset.zero) Offset position,
    @Default('') String text,
    @Default(LabelProperty()) LabelProperty property,
  }) = LabelElement;

  const factory PadElement.image({
    @Default('') String layer,
    @OffsetJsonConverter() @Default(Offset.zero) Offset position,
    @Default(ScaledPadConstraints(1)) PadConstraints? constraints,
    @Uint8ListJsonConverter() required Uint8List pixels,
    required int width,
    required int height,
  }) = ImageElement;

  factory PadElement.fromJson(Map<String, dynamic> json) =>
      _$PadElementFromJson(json);
}
