import 'package:butterfly/models/elements/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class EraserElement extends PathElement {
  const EraserElement(
      {List<PathPoint> points = const [], double strokeWidth = 5, double strokeMultiplier = 1.0})
      : super(points: points, strokeWidth: strokeWidth, strokeMultiplier: strokeMultiplier);
  EraserElement.fromJson(Map<String, dynamic> json, [String? fileVersion]) : super.fromJson(json);

  @override
  Paint buildPaint() => Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.transparent
    ..strokeCap = StrokeCap.round
    ..blendMode = BlendMode.clear;

  @override
  Map<String, dynamic> toJson() => super.toJson()..addAll({'type': 'eraser'});

  @override
  EraserElement copyWith({List<PathPoint>? points, double? strokeWidth}) => EraserElement(
        points: points ?? this.points,
        strokeWidth: strokeWidth ?? this.strokeWidth,
      );
}
