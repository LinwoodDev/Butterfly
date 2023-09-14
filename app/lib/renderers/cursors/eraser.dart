import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';

import '../../models/cursor.dart';
import '../renderer.dart';

class EraserCursor extends Renderer<ToolCursorData<EraserTool>> {
  EraserCursor(super.element);

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    final radius = element.tool.strokeWidth / 2;
    final position = transform.localToGlobal(element.position);
    final background = page.backgrounds.firstOrNull;
    canvas.drawCircle(
        position,
        radius,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = background?.mapOrNull(
                  texture: (box) => Color(box.texture.boxColor)) ??
              Colors.white
          ..strokeCap = StrokeCap.round
          ..invertColors = true
          ..strokeWidth = radius / transform.size
          ..blendMode = foreground ? BlendMode.srcOver : BlendMode.clear);
  }
}
