import 'package:butterfly/models/elements/path.dart';
import 'package:butterfly/models/properties/pen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:xml/xml.dart';

import '../../api/svg_helper.dart';

class PenElement extends PathElement {
  @override
  final List<PathPoint> points;
  @override
  final PenProperty property;

  const PenElement(
      {String layer = '',
      this.points = const [],
      this.property = const PenProperty()})
      : super(layer: layer);

  PenElement.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : property = PenProperty.fromJson(json),
        points = List<dynamic>.from(json['points'] ?? [])
            .map((e) => Map<String, dynamic>.from(e))
            .map((e) => PathPoint.fromJson(e))
            .toList(),
        super.fromJson(json);

  factory PenElement.fromSvg(XmlElement e) {
    var d = e.getAttribute('d') ?? '';
    var strokeWidth =
        double.tryParse(e.getAttribute('stroke-width') ?? '') ?? 1;
    var points = <PathPoint>[];
    var lastPosition = Offset.zero;

    String number = '';
    String operation = '';
    var color = e.getAttribute('stroke') ?? 'black';
    var fill = ['none', 'transparent'].contains(e.getAttribute('fill'));
    if (fill) {
      color = e.getAttribute('fill') ?? 'black';
    }

    while (d.isNotEmpty || operation.isNotEmpty) {
      var cmd = d.isEmpty ? '' : d[0];
      d = d.isEmpty ? '' : d.substring(1);
      if (RegExp(r'[0-9]|\.|\ ').hasMatch(cmd)) {
        number += cmd;
        continue;
      }
      var positions = number.split(' ');
      switch (operation) {
        case 'M':
          lastPosition =
              Offset(double.parse(positions[0]), double.parse(positions[1]));
          points.add(PathPoint.fromOffset(lastPosition, 0));
          break;
        case 'm':
          lastPosition = Offset(lastPosition.dx + double.parse(positions[0]),
              lastPosition.dy + double.parse(positions[1]));
          points.add(PathPoint.fromOffset(lastPosition, 0));
          break;
        case 'L':
          points.add(PathPoint.fromOffset(
              Offset(double.parse(positions[0]), double.parse(positions[1])),
              strokeWidth));
          break;
        case 'l':
          lastPosition = Offset(lastPosition.dx + double.parse(positions[0]),
              lastPosition.dy + double.parse(positions[1]));
          points.add(PathPoint.fromOffset(lastPosition, strokeWidth));
          break;
        case 'H':
          points.add(PathPoint.fromOffset(
              Offset(double.parse(positions[0]), lastPosition.dy),
              strokeWidth));
          break;
        case 'h':
          points.add(PathPoint.fromOffset(
              Offset(lastPosition.dx + double.parse(positions[0]),
                  lastPosition.dy),
              strokeWidth));
          break;
        case 'V':
          points.add(PathPoint.fromOffset(
              Offset(lastPosition.dx, double.parse(positions[0])),
              strokeWidth));
          break;
        case 'v':
          points.add(PathPoint.fromOffset(
              Offset(lastPosition.dx,
                  lastPosition.dy + double.parse(positions[0])),
              strokeWidth));
          break;
      }
      operation = cmd;
      number = '';
    }
    return PenElement(
        points: points,
        property: PenProperty(
            color: stringToColor(color),
            fill: fill,
            strokeWidth: 0,
            strokeMultiplier: 1));
  }

  @override
  PathElement moveBy(Offset offset) => copyWith(
      points: points
          .map((e) => PathPoint.fromOffset(e.toOffset() + offset, e.pressure))
          .toList());
  @override
  Map<String, dynamic> toJson() => super.toJson()..addAll({'type': 'paint'});

  @override
  Paint buildPaint([bool preview = false]) => Paint()
    ..color = property.color
    ..style = property.fill ? PaintingStyle.fill : PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, [bool preview = false]) {
    if (!property.fill) {
      super.paint(canvas, preview);
    } else if (points.isNotEmpty) {
      var path = Path();
      path.moveTo(points.first.x, points.first.y);
      for (var element in points.sublist(1)) {
        path.lineTo(element.x, element.y);
      }
      canvas.drawPath(path, buildPaint(preview));
    }
  }

  @override
  PenElement copyWith(
          {String? layer, List<PathPoint>? points, PenProperty? property}) =>
      PenElement(
          layer: layer ?? this.layer,
          points: points ?? this.points,
          property: property ?? this.property);
}
