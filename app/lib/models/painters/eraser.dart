import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/elements/eraser.dart';
import 'package:butterfly/models/elements/path.dart';
import 'package:butterfly/models/properties/path.dart';

import 'dart:ui';

import 'painter.dart';

class EraserPainter extends BuildedPainter {
  final PathProperty property;

  const EraserPainter({this.property = const PathProperty(), String name = ''})
      : super(name: name);
  EraserPainter.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : property = PathProperty.fromJson(json),
        super.fromJson(json);
  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({'type': 'eraser'})
    ..addAll(property.toJson());
  EraserPainter copyWith({String? name, PathProperty? property}) =>
      EraserPainter(
          name: name ?? this.name, property: property ?? this.property);

  @override
  ElementLayer buildLayer(Offset position,
          [double pressure = 0, double zoom = 1.0]) =>
      EraserElement(points: [
        PathPoint.fromOffset(position, pressure)
      ], property: property.copyWith(strokeWidth: property.strokeWidth / zoom));
}
