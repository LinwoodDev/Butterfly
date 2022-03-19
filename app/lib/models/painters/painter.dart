import 'dart:math';

import 'package:butterfly/models/elements/element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../properties/property.dart';

part 'area.dart';
part 'eraser.dart';
part 'label.dart';
part 'layer.dart';
part 'path_eraser.dart';
part 'pen.dart';

@immutable
abstract class Painter {
  final String name;

  const Painter({this.name = ''});
  Painter.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : name = json['name'] ?? '';

  Map<String, dynamic> toJson() => {'name': name};
}

abstract class BuildedPainter extends Painter {
  const BuildedPainter({String name = ''}) : super(name: name);
  BuildedPainter.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : super.fromJson(json, fileVersion);

  PadElement buildElement(Offset position,
      [double pressure = 0, double zoom = 1, String layer = '']);
}

enum PainterType { pen, pathEraser, label, layer, area, eraser }

extension PainterTypeExtension on PainterType {
  Painter create({String name = ''}) {
    switch (this) {
      case PainterType.pen:
        return PenPainter(name: name);
      case PainterType.pathEraser:
        return PathEraserPainter(name: name);
      case PainterType.label:
        return LabelPainter(name: name);
      case PainterType.layer:
        return LayerPainter(name: name);
      case PainterType.area:
        return AreaPainter(name: name);
      case PainterType.eraser:
        return EraserPainter(name: name);
    }
  }
}
