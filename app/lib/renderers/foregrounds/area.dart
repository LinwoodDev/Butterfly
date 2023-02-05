import 'package:butterfly/cubits/transform.dart';

import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';

class AreaForegroundRenderer extends Renderer<Area> {
  AreaForegroundRenderer(super.element);

  @override
  void build(Canvas canvas, Size size, AppDocument? document,
      CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5 / transform.size
      ..color = colorScheme?.primary ?? Colors.blue;
    var backgroundPaint = Paint()
      ..style = PaintingStyle.fill
      ..color =
          (colorScheme?.primaryContainer ?? Colors.lightBlue).withOpacity(0.2);
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect.inflate(5 / transform.size),
            Radius.circular(5 / transform.size)),
        paint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect.inflate(5 / transform.size),
            Radius.circular(5 / transform.size)),
        backgroundPaint);
  }

  @override
  Rect get rect => Rect.fromLTWH(
      element.position.dx, element.position.dy, element.width, element.height);
}
