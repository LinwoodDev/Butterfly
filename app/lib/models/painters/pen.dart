import 'package:butterfly/models/elements/path.dart';
import 'package:butterfly/models/elements/pen.dart';
import 'package:butterfly/models/painters/painter.dart';
import 'package:butterfly/models/properties/pen.dart';
import 'package:flutter/material.dart';

class PenPainter extends BuildedPainter {
  final PenProperty property;
  final bool zoomDependent;

  const PenPainter(
      {this.property = const PenProperty(),
      String name = '',
      this.zoomDependent = false})
      : super(name: name);
  PenPainter.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : property = PenProperty.fromJson(json),
        zoomDependent = json['zoomDependent'] ?? false,
        super.fromJson(json);
  PenPainter copyWith(
          {String? name, bool? zoomDependent, PenProperty? property}) =>
      PenPainter(
          name: name ?? this.name,
          property: property ?? this.property,
          zoomDependent: zoomDependent ?? this.zoomDependent);
  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({'type': 'pen', 'zoomDependent': zoomDependent})
    ..addAll(property.toJson());

  @override
  PenElement buildElement(Offset position,
          [double pressure = 0, double zoom = 1.0]) =>
      PenElement(points: [
        PathPoint.fromOffset(position, pressure)
      ], property: property.copyWith(strokeWidth: property.strokeWidth / zoom));
}
