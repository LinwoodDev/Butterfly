import 'package:butterfly/models/elements/path.dart';
import 'package:butterfly/models/properties/pen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class PenElement extends PathElement {
  @override
  final PenProperty property;

  const PenElement(
      {List<PathPoint> points = const [], this.property = const PenProperty()})
      : super(points: points);

  PenElement.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : property = PenProperty.fromJson(json),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => super.toJson()..addAll({'type': 'paint'});
  @override
  Paint buildPaint([bool preview = false]) => Paint()
    ..color = property.color
    ..style = property.fill ? PaintingStyle.fill : PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  @override
  PenElement copyWith({List<PathPoint>? points, PenProperty? property}) =>
      PenElement(
          points: points ?? this.points, property: property ?? this.property);
}
