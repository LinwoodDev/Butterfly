import 'dart:typed_data';

import 'package:butterfly/models/converter.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'path_point.dart';
import 'property.dart';

part 'element.freezed.dart';
part 'element.g.dart';

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
    @Default(1) int scale,
    @Uint8ListJsonConverter() required Uint8List pixels,
    required int width,
    required int height,
  }) = ImageElement;

  factory PadElement.fromJson(Map<String, dynamic> json) =>
      _$PadElementFromJson(json);
}
