import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../models/cursor.dart';
import '../../models/text.dart';
import '../renderer.dart';

@immutable
class TextCursorData extends PainterCursorData<LabelPainter> {
  final TextContext? context;

  const TextCursorData(super.painter, super.position, this.context);
}

class TextCursor extends Renderer<TextCursorData> {
  TextCursor(super.element);

  @override
  void build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    final icon = PhosphorIcons.light.cursorText;
    final property = element.context?.getDefinedProperty(document);
    final iconSize =
        (property ?? const text.DefinedParagraphProperty()).span.getSize();
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
          fontStyle: property?.span.italic == true
              ? FontStyle.italic
              : FontStyle.normal,
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

class TextSelectionCursor extends Renderer<TextContext> {
  TextSelectionCursor(super.element);

  @override
  void build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    final color = colorScheme?.primary ?? Colors.blue;
    // Paint vertical line
    final selection = element.selection;
    final textElement = element.element;
    if (textElement == null) return;
    final boxes = element.textPainter.getBoxesForSelection(selection);
    for (final box in boxes) {
      final rect = box.toRect().translate(
            textElement.position.x,
            textElement.position.y,
          );
      canvas.drawRect(
        rect,
        Paint()..color = color.withOpacity(0.5),
      );
    }
    // Paint cursor
    final cursorBox =
        element.textPainter.getOffsetForCaret(selection.base, Rect.zero);
    final height =
        element.textPainter.getFullHeightForCaret(selection.base, Rect.zero);
    canvas.drawRect(
      Rect.fromLTWH(
        textElement.position.x + cursorBox.dx - 1,
        textElement.position.y + cursorBox.dy,
        2,
        height ?? element.textPainter.preferredLineHeight,
      ),
      Paint()..color = color,
    );
  }
}
