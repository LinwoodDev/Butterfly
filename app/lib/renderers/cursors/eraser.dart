import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';

import '../../models/cursor.dart';
import '../renderer.dart';

class EraserInfo {
  final double strokeWidth;

  EraserInfo(this.strokeWidth);
  EraserInfo.fromEraser(EraserTool tool) : strokeWidth = tool.strokeWidth;
}

class EraserCursor extends Renderer<ToolCursorData<EraserInfo>> {
  EraserCursor(super.element);

  @override
  void build(
    Canvas canvas,
    Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {
    final radius = element.tool.strokeWidth;
    final position = transform.localToGlobal(element.position);
    // Keep both edges visible over light, dark, and transparent backgrounds,
    // even when the document is zoomed out.
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeWidth = 4 / transform.size;
    canvas.drawCircle(position, radius, paint);
    canvas.drawCircle(
      position,
      radius,
      paint
        ..color = Colors.black
        ..strokeWidth = 1 / transform.size,
    );
  }
}
