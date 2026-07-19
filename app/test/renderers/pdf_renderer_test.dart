import 'dart:ui';

import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('negative PDF scale keeps mirrored bounds', () {
    final renderer = PdfRenderer(
      PdfElement(source: 'test.pdf', width: 100, height: 50),
    );

    final mirrored = renderer.transform(scaleX: -1)!;

    expect(mirrored.rotation, 0);
    expect(mirrored.rect, const Rect.fromLTWH(-100, 0, 100, 50));
    expect(
      (mirrored.element.constraints as ScaledElementConstraints).scaleX,
      -1,
    );
  });

  test('mirrored PDF remains stable through a subsequent transform', () {
    final renderer = PdfRenderer(
      PdfElement(source: 'test.pdf', width: 100, height: 50),
    );

    final mirrored = renderer.transform(scaleX: -1)!;
    final resized = mirrored.transform(scaleX: 2)!;

    expect(resized.rotation, 0);
    expect(resized.rect, const Rect.fromLTWH(-300, 0, 200, 50));
    expect(
      (resized.element.constraints as ScaledElementConstraints).scaleX,
      -2,
    );
  });
}
