import 'package:butterfly/models/document.dart';
import 'package:butterfly/cubits/transform.dart';

import 'package:butterfly/renderers/renderer.dart';
import 'package:flutter/material.dart';

import '../../models/waypoint.dart';

class WaypointForegroundRenderer extends Renderer<Waypoint> {
  final double size;

  WaypointForegroundRenderer(super.element, [this.size = 20]);

  @override
  void build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    // Test if the element is in the viewport
    // if (!transform.inViewport(element.position)) return;
    final radius = this.size / transform.size;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = colorScheme?.primary ?? Colors.blue;
    canvas.drawCircle(element.position, radius, paint);
    final painter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: element.name,
        style: TextStyle(
          color: Colors.black,
          fontSize: radius,
          backgroundColor: Colors.white,
        ),
      ),
      textAlign: TextAlign.center,
    );
    painter.layout();
    painter.paint(
      canvas,
      Offset(
        element.position.dx - painter.width / 2,
        element.position.dy + radius * 2,
      ),
    );
  }
}
