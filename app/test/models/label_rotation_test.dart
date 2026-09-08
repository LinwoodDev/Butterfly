import 'dart:math';

import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/label.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void expectOffset(Offset actual, Offset expected) {
  expect(actual.dx, closeTo(expected.dx, 1e-7));
  expect(actual.dy, closeTo(expected.dy, 1e-7));
}

void main() {
  const angle = -pi / 3;
  for (final markdown in [false, true]) {
    test(
      'text layout changes preserve the rotated anchor (markdown: $markdown)',
      () {
        final painter = TextPainter(textDirection: TextDirection.ltr);
        addTearDown(painter.dispose);
        final camera = CameraTransform(1, const Offset(34, -25), 2, angle);
        const screenAnchor = Offset(200, 160);
        final anchor = camera.localToGlobal(screenAnchor);
        LabelContext context = markdown
            ? LabelContext.markdown(
                tool: LabelTool(),
                textPainter: painter,
                element: MarkdownElement(text: '', rotation: -angle * 180 / pi),
              )
            : LabelContext.text(
                tool: LabelTool(),
                textPainter: painter,
                element: TextElement(
                  area: const text.TextArea(paragraph: text.TextParagraph()),
                  rotation: -angle * 180 / pi,
                ),
              );
        for (final text in [
          '',
          'a',
          'a longer label',
          'first line\nsecond line',
          'a',
          '',
        ]) {
          painter.text = TextSpan(
            text: text,
            style: const TextStyle(fontSize: 20),
          );
          painter.layout();
          context = context.withTextAnchor(anchor);
          final bounds = context.getRect()!;
          expectOffset(
            camera.globalToLocal(context.toGlobalPosition(bounds.topLeft)),
            screenAnchor,
          );
        }
      },
    );
  }
}
