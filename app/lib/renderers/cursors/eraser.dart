import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';

import '../../models/cursor.dart';
import '../renderer.dart';

class EraserCursor extends Renderer<PainterCursorData<EraserPainter>> {
  EraserCursor(super.element);

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    final radius = element.painter.strokeWidth / 2;
    final position = transform.localToGlobal(element.position);
    canvas.drawCircle(
        position,
        radius,
        Paint()
          ..style = PaintingStyle.stroke
          ..color =
              page.background.mapOrNull(box: (box) => Color(box.boxColor)) ??
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
          ..color =
              page.background.mapOrNull(box: (box) => Color(box.boxColor)) ??
                  Colors.white
          ..strokeCap = StrokeCap.round
          ..invertColors = false
          ..blendMode = foreground ? BlendMode.srcOver : BlendMode.clear);
  }
}
