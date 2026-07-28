import 'dart:math';

import 'package:butterfly_api/butterfly_models.dart';
import 'package:dart_leap/dart_leap.dart';
import 'package:test/test.dart';

void main() {
  test('row and column operations preserve surrounding cell data', () {
    var element = TableElement(
      firstPosition: const Point(0, 0),
      secondPosition: const Point(200, 100),
      rows: 2,
      columns: 2,
      cells: const [
        TableCellProperty(fillColor: SRGBColor(0xFF000001)),
        TableCellProperty(fillColor: SRGBColor(0xFF000002)),
        TableCellProperty(fillColor: SRGBColor(0xFF000003)),
        TableCellProperty(fillColor: SRGBColor(0xFF000004)),
      ],
    );

    element = element.insertRow(1);
    expect(element.rows, 3);
    expect(element.normalizedCells.map((cell) => cell.fillColor).toList(), [
      const SRGBColor(0xFF000001),
      const SRGBColor(0xFF000002),
      SRGBColor.transparent,
      SRGBColor.transparent,
      const SRGBColor(0xFF000003),
      const SRGBColor(0xFF000004),
    ]);

    element = element.insertColumn(1);
    expect(element.columns, 3);
    expect(element.normalizedCells.map((cell) => cell.fillColor).toList(), [
      const SRGBColor(0xFF000001),
      SRGBColor.transparent,
      const SRGBColor(0xFF000002),
      SRGBColor.transparent,
      SRGBColor.transparent,
      SRGBColor.transparent,
      const SRGBColor(0xFF000003),
      SRGBColor.transparent,
      const SRGBColor(0xFF000004),
    ]);

    element = element.removeRow(1).removeColumn(1);
    expect(element.rows, 2);
    expect(element.columns, 2);
    expect(element.normalizedCells.map((cell) => cell.fillColor).toList(), [
      const SRGBColor(0xFF000001),
      const SRGBColor(0xFF000002),
      const SRGBColor(0xFF000003),
      const SRGBColor(0xFF000004),
    ]);
    expect(element.secondPosition, const Point(200, 100));
  });

  test('table always retains at least one row and column', () {
    final element = TableElement(rows: 1, columns: 1);

    expect(element.removeRow(0).rows, 1);
    expect(element.removeColumn(0).columns, 1);
  });

  test('individual border changes materialize all table border lines', () {
    final border = const TableBorderProperty(
      width: 4,
      color: SRGBColor(0xFF00AAFF),
      strokeStyle: StrokeStyle.dotted,
      dashMultiplier: 3,
      gapMultiplier: 2,
    );
    final element = TableElement(rows: 2, columns: 3)
        .setBorder(TableAxis.horizontal, 1, 2, border)
        .setBorder(TableAxis.vertical, 2, 1, border);

    expect(element.horizontalBorders, hasLength(9));
    expect(element.verticalBorders, hasLength(8));
    expect(element.borderAt(TableAxis.horizontal, 1, 2), border);
    expect(element.borderAt(TableAxis.vertical, 2, 1), border);
    expect(element.borderLineCount(TableAxis.horizontal), 3);
    expect(element.borderLineCount(TableAxis.vertical), 4);
    expect(element.borderSegmentCount(TableAxis.horizontal), 3);
    expect(element.borderSegmentCount(TableAxis.vertical), 2);
  });

  test('row insertion preserves existing boundaries', () {
    const top = TableBorderProperty(color: SRGBColor(0xFF000001));
    const middle = TableBorderProperty(color: SRGBColor(0xFF000002));
    const bottom = TableBorderProperty(color: SRGBColor(0xFF000003));
    final element = TableElement(
      rows: 2,
      columns: 1,
      horizontalBorders: const [top, middle, bottom],
    ).insertRow(0);

    expect(element.horizontalBorders, [
      top,
      const TableBorderProperty(),
      middle,
      bottom,
    ]);
  });

  test('column insertion preserves customized border segments', () {
    const first = TableBorderProperty(color: SRGBColor(0xFF000001));
    const second = TableBorderProperty(color: SRGBColor(0xFF000002));
    const third = TableBorderProperty(color: SRGBColor(0xFF000003));
    const fourth = TableBorderProperty(color: SRGBColor(0xFF000004));
    final element = TableElement(
      rows: 1,
      columns: 2,
      horizontalBorders: const [first, second, third, fourth],
    ).insertColumn(1);

    expect(element.horizontalBorders, [
      first,
      const TableBorderProperty(),
      second,
      third,
      const TableBorderProperty(),
      fourth,
    ]);
  });

  test('cell border changes affect only its four edge segments', () {
    const border = TableBorderProperty(width: 3, color: SRGBColor(0xFF123456));
    final element = TableElement(
      rows: 2,
      columns: 2,
    ).setCellBorders(0, 0, border);

    expect(element.borderAt(TableAxis.horizontal, 0, 0), border);
    expect(element.borderAt(TableAxis.horizontal, 1, 0), border);
    expect(element.borderAt(TableAxis.vertical, 0, 0), border);
    expect(element.borderAt(TableAxis.vertical, 1, 0), border);
    expect(
      element.borderAt(TableAxis.horizontal, 0, 1),
      const TableBorderProperty(),
    );
    expect(
      element.borderAt(TableAxis.vertical, 2, 0),
      const TableBorderProperty(),
    );
  });

  test('table boundaries resize adjacent rows and columns', () {
    final element = TableElement(rows: 2, columns: 2)
        .moveBorder(TableAxis.vertical, 1, 0.25)
        .moveBorder(TableAxis.horizontal, 1, -0.25);

    expect(element.normalizedColumnSizes, [1.5, 0.5]);
    expect(element.normalizedRowSizes, [0.5, 1.5]);
  });

  test('last boundaries resize the table and final row or column', () {
    final element =
        TableElement(
              firstPosition: const Point(0, 0),
              secondPosition: const Point(200, 100),
              rows: 2,
              columns: 2,
            )
            .moveBorder(TableAxis.vertical, 2, 0.25)
            .moveBorder(TableAxis.horizontal, 2, 0.5);

    expect(element.normalizedColumnSizes, [1, 1.5]);
    expect(element.normalizedRowSizes, [1, 2]);
    expect(element.secondPosition, const Point(250, 150));
  });

  test('setting a row or column extent only changes that track size', () {
    final element = TableElement(
      firstPosition: const Point(0, 0),
      secondPosition: const Point(200, 100),
      rows: 2,
      columns: 2,
    ).setRowExtent(0, 75).setColumnExtent(1, 150);

    expect(element.normalizedRowSizes, [1.5, 1]);
    expect(element.normalizedColumnSizes, [1, 1.5]);
    expect(element.secondPosition, const Point(250, 125));
  });

  test('column insertion preserves existing custom widths', () {
    final inserted = TableElement(
      firstPosition: const Point(0, 0),
      secondPosition: const Point(300, 100),
      rows: 1,
      columns: 2,
      columnSizes: const [1, 2],
    ).insertColumn(1);

    expect(inserted.normalizedColumnSizes, [1, 1, 2]);
    expect(inserted.secondPosition, const Point(400, 100));
    final restored = inserted.removeColumn(1);
    expect(restored.normalizedColumnSizes, [1, 2]);
    expect(restored.secondPosition, const Point(300, 100));
  });
}
