import 'dart:ui';

import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEditorController extends Mock implements EditorController {}

void main() {
  test('does not create shapes with zero size', () {
    final handler = ShapeHandler(ShapeTool());
    final cubit = MockEditorController();

    expect(
      handler.transformElements(
        Rect.fromPoints(Offset.zero, Offset.zero),
        '',
        cubit,
      ),
      isEmpty,
    );
  });

  test('still creates horizontal and vertical lines', () {
    final handler = ShapeHandler(
      ShapeTool(property: const ShapeProperty(shape: LineShape())),
    );
    final cubit = MockEditorController();

    expect(
      handler.transformElements(const Rect.fromLTRB(10, 10, 10, 20), '', cubit),
      isNotEmpty,
    );
    expect(
      handler.transformElements(const Rect.fromLTRB(10, 10, 20, 10), '', cubit),
      isNotEmpty,
    );
  });

  test('triangle creation preserves negative drag dimensions', () {
    final handler = ShapeHandler(
      ShapeTool(property: const ShapeProperty(shape: TriangleShape())),
    );
    final cubit = MockEditorController();

    final element =
        handler
                .transformElements(
                  const Rect.fromLTRB(100, 80, 10, 20),
                  '',
                  cubit,
                )
                .single
            as ShapeElement;

    expect(element.firstPosition.x, 100);
    expect(element.firstPosition.y, 80);
    expect(element.secondPosition.x, 10);
    expect(element.secondPosition.y, 20);
    expect(element.rotation, 0);
  });
}
