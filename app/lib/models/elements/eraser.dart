import 'package:butterfly/models/elements/path.dart';
import 'package:butterfly/models/properties/path.dart';
import 'package:flutter/material.dart';

class EraserElement extends PathElement {
  @override
  final PathProperty property;

  const EraserElement({List<PathPoint> points = const [], this.property = const PathProperty()})
      : super(points: points);
  EraserElement.fromJson(Map<String, dynamic> json, [String? fileVersion])
      : property = PathProperty.fromJson(json),
        super.fromJson(json);

  @override
  Paint buildPaint() => Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.transparent
    ..strokeCap = StrokeCap.round
    ..blendMode = BlendMode.clear;

  @override
  Map<String, dynamic> toJson() => super.toJson()..addAll({'type': 'eraser'});

  @override
  EraserElement copyWith({List<PathPoint>? points, PathProperty? property}) => EraserElement(
        points: points ?? this.points,
        property: property ?? this.property,
      );
}
