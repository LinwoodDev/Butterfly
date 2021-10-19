import 'package:butterfly/models/elements/path.dart';
import 'package:butterfly/models/elements/pen.dart';
import 'package:butterfly/models/properties/pen.dart';
import 'package:butterfly/painter/painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PenPainter extends BuildedPainter {
  final PenProperty property;

  const PenPainter({this.property = const PenProperty(), String name = ''}) : super(name: name);
  PenPainter.fromJson(Map<String, dynamic> json, [String? fileVersion])
      : property = PenProperty.fromJson(json),
        super.fromJson(json);
  PenPainter copyWith({String? name, PenProperty? property}) =>
      PenPainter(name: name ?? this.name, property: property ?? this.property);
  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      "type": "pen",
    })
    ..addAll(property.toJson());

  @override
  PenElement buildLayer(Offset position, [double pressure = 0]) =>
      PenElement(property: property, points: [PathPoint.fromOffset(position, pressure)]);
}
