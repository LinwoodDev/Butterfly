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
}
