import 'dart:ui';

import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const sourceRect = Rect.fromLTWH(0, 0, 100, 50);

  test('stamp placement preserves drag direction for flipping', () {
    final handler = StampHandler(StampTool());

    expect(handler.shouldNormalize, isFalse);
    expect(
      StampHandler.calculateScale(
        sourceRect,
        const Rect.fromLTRB(100, 100, -100, 200),
      ),
      (-2.0, 2.0),
    );
    expect(
      StampHandler.calculateScale(
        sourceRect,
        const Rect.fromLTRB(100, 100, 300, 0),
      ),
      (2.0, -2.0),
    );
  });

  test('stamp placement only keeps its original size for a tap', () {
    expect(
      StampHandler.calculateScale(
        sourceRect,
        const Rect.fromLTRB(100, 100, 100, 200),
      ),
      (0.0, 2.0),
    );
    expect(
      StampHandler.calculateScale(
        sourceRect,
        const Rect.fromLTRB(100, 100, 300, 100),
      ),
      (2.0, 0.0),
    );
    expect(
      StampHandler.calculateScale(
        sourceRect,
        const Rect.fromLTRB(100, 100, 100, 100),
      ),
      (1.0, 1.0),
    );
    expect(
      StampHandler.calculateScale(
        sourceRect,
        const Rect.fromLTRB(100, 100, 100.00000000001, 99.99999999999),
      ),
      (1.0, 1.0),
    );
  });
}
