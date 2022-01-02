import 'package:butterfly/models/elements/path.dart';
import 'package:butterfly/models/properties/path.dart';
import 'package:flutter/material.dart';

class EraserElement extends PathElement {
  @override
  final List<PathPoint> points;
  @override
  final PathProperty property;

  const EraserElement(
      {String layer = '',
      this.points = const [],
      this.property = const PathProperty()})
      : super(layer: layer);
  EraserElement.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : property = PathProperty.fromJson(json),
        points = List<dynamic>.from(json['points'] ?? [])
            .map((e) => Map<String, dynamic>.from(e))
            .map((e) => PathPoint.fromJson(e))
            .toList(),
        super.fromJson(json);

  @override
  PathElement moveBy(Offset offset) => copyWith(
      points: points
          .map((e) => PathPoint.fromOffset(e.toOffset() + offset, e.pressure))
          .toList());

  @override
  Paint buildPaint([bool preview = false]) => Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.white
    ..strokeCap = StrokeCap.round
    ..blendMode = preview ? BlendMode.srcOver : BlendMode.clear;

  @override
  Map<String, dynamic> toJson() => super.toJson()..addAll({'type': 'eraser'});

  @override
  EraserElement copyWith(
          {String? layer, List<PathPoint>? points, PathProperty? property}) =>
      EraserElement(
        layer: layer ?? this.layer,
        points: points ?? this.points,
        property: property ?? this.property,
      );
}
