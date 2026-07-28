import 'dart:math';
import 'dart:ui';

import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:dart_leap/dart_leap.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('table hit targets are immutable Freezed values', () {
    const target = TableHitTarget.border(TableAxis.vertical, 2, 1);

    expect(target, const TableBorderTarget(TableAxis.vertical, 2, 1));
    expect(
      (target as TableBorderTarget).copyWith(segment: 3),
      const TableBorderTarget(TableAxis.vertical, 2, 3),
    );
  });

  test('table renderer exposes its bounds including its border', () {
    final renderer = TableRenderer(
      TableElement(
        firstPosition: const Point(10, 20),
        secondPosition: const Point(310, 220),
        border: const TableBorderProperty(width: 4),
        horizontalBorders: const [TableBorderProperty(width: 8)],
      ),
    );

    expect(renderer.rect, const Rect.fromLTWH(10, 20, 300, 200));
    expect(renderer.expandedRect, const Rect.fromLTWH(6, 16, 308, 208));
  });

  test('table renderer preserves layout while transforming geometry', () {
    final renderer = TableRenderer(
      TableElement(
        firstPosition: const Point(0, 0),
        secondPosition: const Point(300, 200),
        rows: 4,
        columns: 5,
        cells: const [TableCellProperty(fillColor: SRGBColor(0xFF123456))],
      ),
    );
    final transformed = renderer.transform(scaleX: 2, scaleY: 0.5)!;

    expect(transformed.rect, const Rect.fromLTWH(0, 0, 600, 100));
    expect(transformed.element.rows, 4);
    expect(transformed.element.columns, 5);
    expect(
      transformed.element.cellAt(0, 0).fillColor,
      const SRGBColor(0xFF123456),
    );
  });

  test('table renderer resolves hovered cells through element transforms', () {
    final renderer = TableRenderer(
      TableElement(
        rotation: 30,
        shear: 0.2,
        firstPosition: const Point(100, 200),
        secondPosition: const Point(400, 400),
        rows: 2,
        columns: 3,
      ),
    );
    final cellCenter = renderer.cellRect(1, 2).center;
    final transformedCenter = renderer.transformPoint(
      cellCenter,
      renderer.rect,
    );

    expect(renderer.cellAtPosition(transformedCenter), (row: 1, column: 2));
    expect(renderer.cellAtPosition(const Offset(-100, -100)), isNull);
  });

  test('table renderer resolves individual borders through transforms', () {
    final renderer = TableRenderer(
      TableElement(
        rotation: 30,
        shear: 0.2,
        firstPosition: const Point(100, 200),
        secondPosition: const Point(400, 400),
        rows: 2,
        columns: 3,
      ),
    );
    final horizontalLine = renderer.borderLine(TableAxis.horizontal, 1, 1);
    final horizontalCenter = renderer.transformPoint(
      (horizontalLine.start + horizontalLine.end) / 2,
      renderer.rect,
    );
    final verticalLine = renderer.borderLine(TableAxis.vertical, 2, 0);
    final verticalCenter = renderer.transformPoint(
      Offset.lerp(verticalLine.start, verticalLine.end, 0.25)!,
      renderer.rect,
    );
    final cellCenter = renderer.transformPoint(
      renderer.cellRect(0, 0).center,
      renderer.rect,
    );

    expect(
      renderer.hitTarget(horizontalCenter, tolerance: 2),
      const TableBorderTarget(TableAxis.horizontal, 1, 1),
    );
    expect(
      renderer.hitTarget(verticalCenter, tolerance: 2),
      const TableBorderTarget(TableAxis.vertical, 2, 0),
    );
    expect(
      renderer.hitTarget(cellCenter, tolerance: 2),
      const TableCellTarget(0, 0),
    );
  });

  test('table renderer resolves the final row and column boundaries', () {
    final renderer = TableRenderer(
      TableElement(
        firstPosition: const Point(10, 20),
        secondPosition: const Point(310, 220),
        rows: 2,
        columns: 3,
      ),
    );

    expect(
      renderer.hitTarget(const Offset(160, 220), tolerance: 2),
      const TableBorderTarget(TableAxis.horizontal, 2, 1),
    );
    expect(
      renderer.hitTarget(const Offset(310, 70), tolerance: 2),
      const TableBorderTarget(TableAxis.vertical, 3, 0),
    );
  });

  test('table renderer lays out independently sized rows and columns', () {
    final renderer = TableRenderer(
      TableElement(
        firstPosition: const Point(0, 0),
        secondPosition: const Point(400, 200),
        rows: 2,
        columns: 3,
        rowSizes: const [1, 3],
        columnSizes: const [1, 2, 1],
      ),
    );

    expect(renderer.cellRect(0, 0), const Rect.fromLTWH(0, 0, 100, 50));
    expect(renderer.cellRect(1, 1), const Rect.fromLTWH(100, 50, 200, 150));
    expect(
      renderer.hitTarget(const Offset(250, 125), tolerance: 2),
      const TableCellTarget(1, 1),
    );
  });
}
