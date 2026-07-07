import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';

class AreaForegroundRenderer extends Renderer<Area> {
  AreaForegroundRenderer(super.element);

  @override
  void build(
    Canvas canvas,
    Size size,
    NoteData document,
    DocumentPage? page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {
    final areaColor = element.color?.toColor();
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5 / transform.size
      ..color = areaColor ?? colorScheme?.primary ?? Colors.blue;
    final backgroundPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = (areaColor ?? colorScheme?.primaryContainer ?? Colors.lightBlue)
          .withValues(alpha: 0.2);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(5 / transform.size)),
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(5 / transform.size)),
      backgroundPaint,
    );
  }

  @override
  Rect get rect => Rect.fromLTWH(
    element.position.x,
    element.position.y,
    element.width,
    element.height,
  );
}
