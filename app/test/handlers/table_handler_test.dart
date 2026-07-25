import 'dart:math';
import 'dart:ui';

import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/selections/selection.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:dart_leap/dart_leap.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEditorController extends Mock implements EditorController {}

class MockEventContext extends Mock implements EventContext {}

void main() {
  test('does not create a table with zero size', () {
    final handler = TableHandler(TableTool());

    expect(
      handler.transformElements(
        Rect.fromPoints(Offset.zero, Offset.zero),
        '',
        MockEditorController(),
      ),
      isEmpty,
    );
  });

  test('creates a table with the configured layout and appearance', () {
    final tool = TableTool(
      rows: 4,
      columns: 5,
      border: TableBorderProperty(
        width: 2,
        color: SRGBColor(0xFF123456),
        strokeStyle: StrokeStyle.dotted,
        dashMultiplier: 3,
        gapMultiplier: 2,
      ),
      fillColor: SRGBColor(0x80112233),
    );
    final element =
        TableHandler(tool)
                .transformElements(
                  const Rect.fromLTWH(10, 20, 300, 200),
                  'tables',
                  MockEditorController(),
                )
                .single
            as TableElement;

    expect(element.firstPosition, const Point(10, 20));
    expect(element.secondPosition, const Point(310, 220));
    expect(element.rows, 4);
    expect(element.columns, 5);
    expect(element.border.width, 2);
    expect(element.border.color, const SRGBColor(0xFF123456));
    expect(element.border.strokeStyle, StrokeStyle.dotted);
    expect(element.border.dashMultiplier, 3);
    expect(element.border.gapMultiplier, 2);
    expect(element.fillColor, const SRGBColor(0x80112233));
    expect(element.collection, 'tables');
    expect(element.cells, hasLength(20));
  });

  test('keeps secondary mouse clicks on the table handler', () {
    final handler = TableHandler(TableTool());
    final context = MockEventContext();

    expect(
      handler.canChange(
        const PointerDownEvent(
          kind: PointerDeviceKind.mouse,
          buttons: kSecondaryMouseButton,
        ),
        context,
      ),
      isFalse,
    );
    expect(
      handler.canChange(
        const PointerDownEvent(
          kind: PointerDeviceKind.mouse,
          buttons: kPrimaryMouseButton,
        ),
        context,
      ),
      isTrue,
    );
  });

  test('selects a whole border line before narrowing to one segment', () {
    const hit = TableBorderTarget(TableAxis.horizontal, 2, 1);

    expect(
      resolveTableSelectionTarget(null, hit),
      const TableLineTarget(TableAxis.horizontal, 2),
    );
    expect(
      resolveTableSelectionTarget(
        const TableLineTarget(TableAxis.horizontal, 2),
        hit,
      ),
      hit,
    );
    expect(
      resolveTableSelectionTarget(
        const TableBorderTarget(TableAxis.horizontal, 2, 0),
        hit,
      ),
      hit,
    );
    expect(
      resolveTableSelectionTarget(
        const TableLineTarget(TableAxis.horizontal, 1),
        hit,
      ),
      const TableLineTarget(TableAxis.horizontal, 2),
    );
  });

  test('keeps the targeted property view when replacing its renderer', () {
    final original = TableRenderer(TableElement(id: 'table'));
    final updated = TableRenderer(
      TableElement(id: 'table', border: const TableBorderProperty(width: 4)),
    );
    const target = TableBorderTarget(TableAxis.vertical, 1, 0);
    final selection = TableElementSelection([original], target: target);

    final replaced =
        selection.replaceSelected([updated]) as TableElementSelection;

    expect(replaced.target, target);
    expect(replaced.selected, [updated]);
  });
}
