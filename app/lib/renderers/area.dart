import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/area.dart';

import 'dart:async';

import 'package:butterfly/renderers/renderer.dart';
import 'package:flutter/material.dart';

class AreaRenderer extends Renderer<Area> {
  AreaRenderer(Area element) : super(element);

  @override
  FutureOr<void> build(Canvas canvas, Size size, CameraTransform transform,
      [bool foreground = false]) {
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5 / transform.size
      ..color = Colors.lightBlue;
    var backgroundPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue.withOpacity(0.5);
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
