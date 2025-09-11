import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';

import '../../models/cursor.dart';
import '../renderer.dart';

class EraserInfo {
  final double strokeWidth;

  EraserInfo(this.strokeWidth);
  EraserInfo.fromEraser(EraserTool tool) : strokeWidth = tool.strokeWidth;
  EraserInfo.fromPathEraser(PathEraserTool tool)
    : strokeWidth = tool.strokeWidth;
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
    final radius = element.tool.strokeWidth / 2;
    final position = transform.localToGlobal(element.position);
    final background = page.backgrounds.firstOrNull;
    canvas.drawCircle(
      position,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = switch (background) {
          TextureBackground e => e.texture.boxColor,
          _ => SRGBColor.white,
        }.toColor()
        ..strokeCap = StrokeCap.round
        ..invertColors = true
        ..strokeWidth = element.tool.strokeWidth / 8
        ..blendMode = foreground ? BlendMode.srcOver : BlendMode.clear,
    );
  }
}
