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
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    const icon = PhosphorIconsLight.cursorText;
    final property = element.context?.getDefinedProperty(document);
    final iconSize =
        (property ?? const text.DefinedParagraphProperty()).span.getSize() *
            (element.context?.element?.scale ??
                (element.painter.zoomDependent ? 1 / transform.size : 1));
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
          Offset(iconPainter.width / 2, iconPainter.height / 2),
    );
  }
}

class TextSelectionCursor extends Renderer<TextContext> {
  TextSelectionCursor(super.element);

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      CameraTransform transform,
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
        element.textPainter.getFullHeightForCaret(selection.base, Rect.zero) ??
            0;
    canvas.drawRect(
      Rect.fromLTWH(
        textElement.position.x + cursorBox.dx - 1 / transform.size,
        textElement.position.y + cursorBox.dy,
        2 / transform.size,
        height,
      ),
      Paint()
        ..color = color
        ..strokeWidth = 1 / transform.size,
    );

    final rect = element.getRect();
    if (rect != null) {
      canvas.drawRect(
        rect,
        Paint()
          ..color = color.withOpacity(0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1 / transform.size,
      );
    }
  }
}
