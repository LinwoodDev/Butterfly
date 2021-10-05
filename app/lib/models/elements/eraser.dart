import 'package:butterfly/models/elements/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class EraserElement extends PathElement {
  EraserElement({List<Offset> points = const [], double strokeWidth = 5})
      : super(points: points, strokeWidth: strokeWidth);
  EraserElement.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  @override
  Paint buildPaint() => Paint()
    ..strokeWidth = strokeWidth
    ..style = PaintingStyle.stroke
    ..color = Colors.transparent
    ..strokeCap = StrokeCap.round
    ..blendMode = BlendMode.clear;

  @override
  Path buildPath() {
    var path = Path();
    if (points.length > 1) {
      var first = points.first;
      path.moveTo(first.dx, first.dy);
      points.sublist(1).forEach((element) => path.lineTo(element.dx, element.dy));
    }
    return path;
  }

  @override
  Map<String, dynamic> toJson() => super.toJson()..addAll({'type': 'eraser'});

  @override
  EraserElement copyWith({List<Offset>? points, double? strokeWidth}) => EraserElement(
        points: points ?? this.points,
        strokeWidth: strokeWidth ?? this.strokeWidth,
      );
}
