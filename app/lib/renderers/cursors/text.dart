import 'package:butterfly/models/document.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/text.dart' as text;
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../models/cursor.dart';
import '../../models/painter.dart';
import '../renderer.dart';

@immutable
class TextCursorData extends PainterCursorData<LabelPainter> {
  final text.TextContext? context;

  const TextCursorData(super.painter, super.position, this.context);
}

class TextCursor extends Renderer<TextCursorData> {
  TextCursor(super.element);

  @override
  void build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    const icon = PhosphorIcons.cursorTextLight;
    final property = element.context?.getDefinedProperty(document);
    final iconSize =
        (property ?? const text.DefinedParagraphProperty()).span.size;
    final iconColor = Color(property?.span.color ??
        colorScheme?.primary.value ??
        Colors.black.value);
    final iconPainter = TextPainter(
      textDirection: TextDirection.rtl,
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          fontSize: iconSize,
          color: iconColor,
        ),
      ),
      textAlign: TextAlign.center,
    );
    iconPainter.layout();
    iconPainter.paint(
      canvas,
      transform.localToGlobal(element.position) -
          Offset(iconSize / 2, iconSize / 2),
    );
  }
}

@immutable
class TextSelectionCursorData extends PainterCursorData<LabelPainter> {
  final int size;

  const TextSelectionCursorData(super.painter, super.position, this.size);
}

class TextSelectionCursor extends Renderer<TextSelectionCursorData> {
  TextSelectionCursor(super.element);

  @override
  void build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    // Paint vertical line
    final paint = Paint()
      ..color = colorScheme?.primary ?? Colors.black
      ..strokeWidth = 1 / transform.size;
    canvas.drawLine(
      element.position.translate(0, -element.size.toDouble()),
      element.position.translate(0, element.size.toDouble()),
      paint,
    );
  }
}
