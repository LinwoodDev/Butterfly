import 'dart:typed_data';

import 'package:butterfly/models/converter.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'path_point.dart';
import 'property.dart';

part 'element.freezed.dart';
part 'element.g.dart';

@freezed
class ElementConstraint with _$ElementConstraint {
  const factory ElementConstraint({
    @Default(0) double size,
    @Default(0) double length,
    @Default(true) bool includeArea,
  }) = _ElementConstraint;

  factory ElementConstraint.fromJson(Map<String, dynamic> json) =>
      _$ElementConstraintFromJson(json);
}

@freezed
class ElementConstraints with _$ElementConstraints {
  const factory ElementConstraints.scaled(double scale) =
      ScaledElementConstraints;
  const factory ElementConstraints.fixed(double height, double width) =
      FixedElementConstraints;
  const factory ElementConstraints.dynamic({
    @Default(0) double height,
    @Default(0) double width,
    @Default(0) double aspectRatio,
    @Default(true) bool includeArea,
  }) = DynamicElementConstraints;

  factory ElementConstraints.fromJson(Map<String, dynamic> json) =>
      _$ElementConstraintsFromJson(json);
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
    @Default(ElementConstraint(size: 1000)) ElementConstraint constraint,
  }) = LabelElement;

  const factory PadElement.image({
    @Default('') String layer,
    @OffsetJsonConverter() @Default(Offset.zero) Offset position,
    @Default(ScaledElementConstraints(1)) ElementConstraints? constraints,
    @Uint8ListJsonConverter() required Uint8List pixels,
    required int width,
    required int height,
  }) = ImageElement;

  factory PadElement.fromJson(Map<String, dynamic> json) =>
      _$PadElementFromJson(json);
}
