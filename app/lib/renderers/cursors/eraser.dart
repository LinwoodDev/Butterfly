import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/cursor.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/painter.dart';
import 'package:flutter/material.dart';

import '../renderer.dart';

class EraserCursor extends Renderer<PainterCursor<EraserPainter>> {
  EraserCursor(super.element);

  @override
  void build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [bool foreground = false]) {
    final radius = element.painter.property.strokeWidth / 2;
    final position = transform.localToGlobal(element.position);
    canvas.drawCircle(
        position,
        radius,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = document.background
                  .mapOrNull(box: (box) => Color(box.boxColor)) ??
              Colors.white
          ..strokeCap = StrokeCap.round
          ..invertColors = true
          ..strokeWidth = radius / transform.size
          ..blendMode = foreground ? BlendMode.srcOver : BlendMode.clear);
    canvas.drawCircle(
        position,
        radius,
        Paint()
          ..style = PaintingStyle.fill
          ..color = document.background
                  .mapOrNull(box: (box) => Color(box.boxColor)) ??
              Colors.white
          ..strokeCap = StrokeCap.round
          ..invertColors = false
          ..blendMode = foreground ? BlendMode.srcOver : BlendMode.clear);
  }
}
