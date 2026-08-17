import 'dart:math';

import 'package:butterfly_api/src/converter/color.dart';
import 'package:dart_leap/dart_leap.dart';

import '../converter/core.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../converter/id.dart';
import 'pack.dart';
import 'point.dart';
import 'property.dart';
import 'text.dart';
import 'texture.dart';

part 'element.freezed.dart';
part 'element.g.dart';

@freezed
sealed class ElementConstraint with _$ElementConstraint {
  const factory ElementConstraint({
    @Default(0) double size,
    @Default(0) double length,
    @Default(true) bool includeArea,
  }) = _ElementConstraint;

  factory ElementConstraint.fromJson(Map<String, dynamic> json) =>
      _$ElementConstraintFromJson(json);
}

abstract class SourcedElement {
  String get source;
}

@freezed
@immutable
sealed class ElementConstraints with _$ElementConstraints {
  const factory ElementConstraints.scaled({
    @Default(1) double scaleX,
    @Default(1) double scaleY,
  }) = ScaledElementConstraints;
  const factory ElementConstraints.fixed(double height, double width) =
      FixedElementConstraints;
  const factory ElementConstraints.dynamic({
    @Default(0) double height,
    @Default(0) double width,
    @Default(0) double aspectRatio,
    @Default(true) bool includeArea,
  }) = DynamicElementConstraints;

  factory ElementConstraints.fromJson(Map<String, dynamic> json) =>
      _$ElementConstraintsFromJson(json);
}

abstract class PathElement {
  List<PathPoint> get points;
  PathProperty get property;
}

enum TableAxis { horizontal, vertical }

@freezed
sealed class TableBorderProperty with _$TableBorderProperty {
  const factory TableBorderProperty({
    @Default(1) double width,
    @Default(SRGBColor.black) @ColorJsonConverter() SRGBColor color,
    @Default(StrokeStyle.solid) StrokeStyle strokeStyle,
    @Default(1.0) double dashMultiplier,
    @Default(1.0) double gapMultiplier,
  }) = _TableBorderProperty;

  factory TableBorderProperty.fromJson(Map<String, dynamic> json) =>
      _$TableBorderPropertyFromJson(json);
}

@freezed
sealed class TableCellProperty with _$TableCellProperty {
  const factory TableCellProperty({
    @Default(SRGBColor.transparent) @ColorJsonConverter() SRGBColor fillColor,
  }) = _TableCellProperty;

  factory TableCellProperty.fromJson(Map<String, dynamic> json) =>
      _$TableCellPropertyFromJson(json);
}

mixin LabelElement {
  String get collection;
  Point<double> get position;
  double get scale;
  NamedItem<TextStyleSheet>? get styleSheet;
  ElementConstraint get constraint;
  SRGBColor get foreground;

  AreaProperty get areaProperty => switch (this) {
    MarkdownElement e => e.areaProperty,
    TextElement e => e.area.areaProperty,
    _ => throw UnimplementedError(),
  };

  String get text => switch (this) {
    MarkdownElement e => e.text,
    TextElement e => e.area.paragraph.text,
    _ => throw UnimplementedError(),
  };
}

@freezed
sealed class PadElement with _$PadElement {
  const PadElement._();

  @Implements<PathElement>()
  factory PadElement.pen({
    @Default(0) double rotation,
    @Default(0) double shear,
    @Default('') String collection,
    @IdJsonConverter() String? id,
    double? zoom,
    String? combineId,
    @Default([]) List<PathPoint> points,
    @Default(PenProperty()) PenProperty property,
    @Default({}) Map<String, dynamic> extra,
  }) = PenElement;

  @With<LabelElement>()
  factory PadElement.text({
    @Default(0) double rotation,
    @Default(0) double shear,
    @Default('') String collection,
    @IdJsonConverter() String? id,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
    Point<double> position,
    @Default(1.0) double scale,
    NamedItem<TextStyleSheet>? styleSheet,
    required TextArea area,
    @Default(ElementConstraint(size: 1000)) ElementConstraint constraint,
    @Default(SRGBColor.black) @ColorJsonConverter() SRGBColor foreground,
    @Default({}) Map<String, dynamic> extra,
  }) = TextElement;

  @With<LabelElement>()
  factory PadElement.markdown({
    @Default(0) double rotation,
    @Default(0) double shear,
    @Default('') String collection,
    @IdJsonConverter() String? id,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
    Point<double> position,
    @Default(1.0) double scale,
    NamedItem<TextStyleSheet>? styleSheet,
    @Default(AreaProperty()) AreaProperty areaProperty,
    required String text,
    @Default(ElementConstraint(size: 1000)) ElementConstraint constraint,
    @Default(SRGBColor.black) @ColorJsonConverter() SRGBColor foreground,
    @Default({}) Map<String, dynamic> extra,
  }) = MarkdownElement;

  @Implements<SourcedElement>()
  factory PadElement.image({
    @Default(0) double rotation,
    @Default(0) double shear,
    @Default('') String collection,
    @IdJsonConverter() String? id,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
    Point<double> position,
    @Default(ScaledElementConstraints(scaleX: 1, scaleY: 1))
    ElementConstraints? constraints,
    required String source,
    required double width,
    required double height,
    @Default({}) Map<String, dynamic> extra,
  }) = ImageElement;

  @Implements<SourcedElement>()
  factory PadElement.pdf({
    @Default(0) double rotation,
    @Default(0) double shear,
    @Default('') String collection,
    @IdJsonConverter() String? id,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
    Point<double> position,
    @Default(ScaledElementConstraints(scaleX: 1, scaleY: 1))
    ElementConstraints? constraints,
    required String source,
    @Default(0) int page,
    required double width,
    required double height,
    @Default(false) bool invert,
    @Default(SRGBColor.transparent) @ColorJsonConverter() SRGBColor background,
    @Default({}) Map<String, dynamic> extra,
  }) = PdfElement;

  @Implements<SourcedElement>()
  factory PadElement.svg({
    @Default(0) double rotation,
    @Default(0) double shear,
    @Default('') String collection,
    @IdJsonConverter() String? id,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
    Point<double> position,
    @Default(ScaledElementConstraints(scaleX: 1, scaleY: 1))
    ElementConstraints? constraints,
    required String source,
    required double width,
    required double height,
    @Default({}) Map<String, dynamic> extra,
  }) = SvgElement;

  factory PadElement.shape({
    @Default(0) double rotation,
    @Default(0) double shear,
    @Default('') String collection,
    @IdJsonConverter() String? id,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
    Point<double> firstPosition,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
    Point<double> secondPosition,
    @Default(ShapeProperty(shape: RectangleShape())) ShapeProperty property,
    @Default({}) Map<String, dynamic> extra,
  }) = ShapeElement;

  factory PadElement.table({
    @Default(0) double rotation,
    @Default(0) double shear,
    @Default('') String collection,
    @IdJsonConverter() String? id,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
    Point<double> firstPosition,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
    Point<double> secondPosition,
    @Default(3) int rows,
    @Default(3) int columns,
    @Default(TableBorderProperty()) TableBorderProperty border,
    @Default([]) List<double> rowSizes,
    @Default([]) List<double> columnSizes,
    @Default([]) List<TableBorderProperty> horizontalBorders,
    @Default([]) List<TableBorderProperty> verticalBorders,
    @Default([]) List<TableCellProperty> cells,
    @Default(SRGBColor.transparent) @ColorJsonConverter() SRGBColor fillColor,
    @Default({}) Map<String, dynamic> extra,
  }) = TableElement;

  factory PadElement.texture({
    @Default(0) double rotation,
    @Default(0) double shear,
    @Default('') String collection,
    @IdJsonConverter() String? id,
    @Default(SurfaceTexture.pattern()) SurfaceTexture texture,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
    Point<double> firstPosition,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
    Point<double> secondPosition,
    @Default({}) Map<String, dynamic> extra,
  }) = TextureElement;

  factory PadElement.polygon({
    @Default(0) double rotation,
    @Default(0) double shear,
    @Default('') String collection,
    @IdJsonConverter() String? id,
    @Default([]) List<PolygonPoint> points,
    @Default({}) Map<String, dynamic> extra,
    @Default(PolygonProperty()) PolygonProperty property,
  }) = PolygonElement;

  factory PadElement.fromJson(Map<String, dynamic> json) =>
      _$PadElementFromJson(json);

  bool isStroke() => switch (this) {
    PenElement _ => true,
    ShapeElement _ => true,
    PolygonElement _ => true,
    _ => false,
  };
}

extension TableElementOperations on TableElement {
  TableCellProperty cellAt(int row, int column) {
    final index = row * columns + column;
    return index < cells.length ? cells[index] : const TableCellProperty();
  }

  List<TableCellProperty> get normalizedCells {
    final count = rows * columns;
    return List.generate(
      count,
      (index) =>
          index < cells.length ? cells[index] : const TableCellProperty(),
    );
  }

  TableElement setCell(int row, int column, TableCellProperty cell) {
    if (row < 0 || row >= rows || column < 0 || column >= columns) return this;
    final updated = normalizedCells;
    updated[row * columns + column] = cell;
    return copyWith(cells: updated);
  }

  int borderLineCount(TableAxis axis) =>
      (axis == TableAxis.horizontal ? rows : columns) + 1;

  int borderSegmentCount(TableAxis axis) =>
      axis == TableAxis.horizontal ? columns : rows;

  TableBorderProperty borderAt(TableAxis axis, int line, int segment) {
    final borders = axis == TableAxis.horizontal
        ? horizontalBorders
        : verticalBorders;
    final segmentCount = borderSegmentCount(axis);
    final index = line * segmentCount + segment;
    return line >= 0 &&
            line < borderLineCount(axis) &&
            segment >= 0 &&
            segment < segmentCount &&
            index < borders.length
        ? borders[index]
        : border;
  }

  TableElement setBorder(
    TableAxis axis,
    int line,
    int segment,
    TableBorderProperty value,
  ) {
    final lineCount = borderLineCount(axis);
    final segmentCount = borderSegmentCount(axis);
    if (line < 0 ||
        line >= lineCount ||
        segment < 0 ||
        segment >= segmentCount) {
      return this;
    }
    final updated = _setTableBorderSegment(
      axis == TableAxis.horizontal ? horizontalBorders : verticalBorders,
      lineCount,
      segmentCount,
      line,
      segment,
      value,
      border,
    );
    return axis == TableAxis.horizontal
        ? copyWith(horizontalBorders: updated)
        : copyWith(verticalBorders: updated);
  }

  TableElement setBorderLine(
    TableAxis axis,
    int line,
    TableBorderProperty value,
  ) {
    if (line < 0 || line >= borderLineCount(axis)) return this;
    var updated = this;
    for (var segment = 0; segment < borderSegmentCount(axis); segment++) {
      updated = updated.setBorder(axis, line, segment, value);
    }
    return updated;
  }

  TableElement setCellBorders(int row, int column, TableBorderProperty value) {
    if (row < 0 || row >= rows || column < 0 || column >= columns) return this;
    return setBorder(TableAxis.horizontal, row, column, value)
        .setBorder(TableAxis.horizontal, row + 1, column, value)
        .setBorder(TableAxis.vertical, column, row, value)
        .setBorder(TableAxis.vertical, column + 1, row, value);
  }

  TableElement updateCellBorders(
    int row,
    int column,
    TableBorderProperty Function(TableBorderProperty border) transform,
  ) {
    if (row < 0 || row >= rows || column < 0 || column >= columns) return this;
    var updated = this;
    for (final edge in [
      (TableAxis.horizontal, row, column),
      (TableAxis.horizontal, row + 1, column),
      (TableAxis.vertical, column, row),
      (TableAxis.vertical, column + 1, row),
    ]) {
      updated = updated.setBorder(
        edge.$1,
        edge.$2,
        edge.$3,
        transform(updated.borderAt(edge.$1, edge.$2, edge.$3)),
      );
    }
    return updated;
  }

  List<double> get normalizedRowSizes => _normalizeTableSizes(rowSizes, rows);

  List<double> get normalizedColumnSizes =>
      _normalizeTableSizes(columnSizes, columns);

  TableElement scaleRow(int index, double factor) {
    if (index < 0 || index >= rows || factor <= 0) return this;
    final updated = normalizedRowSizes;
    updated[index] = max(0.1, updated[index] * factor);
    return copyWith(rowSizes: updated);
  }

  TableElement scaleColumn(int index, double factor) {
    if (index < 0 || index >= columns || factor <= 0) return this;
    final updated = normalizedColumnSizes;
    updated[index] = max(0.1, updated[index] * factor);
    return copyWith(columnSizes: updated);
  }

  TableElement setRowExtent(int index, double extent) =>
      _setTableExtent(TableAxis.horizontal, index, extent);

  TableElement setColumnExtent(int index, double extent) =>
      _setTableExtent(TableAxis.vertical, index, extent);

  TableElement _setTableExtent(TableAxis axis, int index, double extent) {
    final sizes = axis == TableAxis.horizontal
        ? normalizedRowSizes
        : normalizedColumnSizes;
    if (index < 0 || index >= sizes.length || extent <= 0) return this;
    final tableExtent = axis == TableAxis.horizontal
        ? secondPosition.y - firstPosition.y
        : secondPosition.x - firstPosition.x;
    final total = sizes.reduce((a, b) => a + b);
    final unit = tableExtent.abs() / total;
    if (unit <= 0) return this;
    final nextSize = max(0.1, extent / unit);
    final extentDelta = (nextSize - sizes[index]) * unit * tableExtent.sign;
    sizes[index] = nextSize;
    return axis == TableAxis.horizontal
        ? copyWith(
            rowSizes: sizes,
            secondPosition: Point(
              secondPosition.x,
              secondPosition.y + extentDelta,
            ),
          )
        : copyWith(
            columnSizes: sizes,
            secondPosition: Point(
              secondPosition.x + extentDelta,
              secondPosition.y,
            ),
          );
  }

  TableElement moveBorder(TableAxis axis, int line, double deltaFraction) {
    final sizes = axis == TableAxis.horizontal
        ? normalizedRowSizes
        : normalizedColumnSizes;
    if (line <= 0 || line > sizes.length || !deltaFraction.isFinite) {
      return this;
    }
    if (line == sizes.length) {
      final total = sizes.reduce((a, b) => a + b);
      final delta = deltaFraction * total;
      final previous = sizes.last;
      final next = max(0.1, previous + delta);
      final adjustedFraction = (next - previous) / total;
      sizes[sizes.length - 1] = next;
      return axis == TableAxis.horizontal
          ? copyWith(
              rowSizes: sizes,
              secondPosition: Point(
                secondPosition.x,
                secondPosition.y +
                    (secondPosition.y - firstPosition.y) * adjustedFraction,
              ),
            )
          : copyWith(
              columnSizes: sizes,
              secondPosition: Point(
                secondPosition.x +
                    (secondPosition.x - firstPosition.x) * adjustedFraction,
                secondPosition.y,
              ),
            );
    }
    final delta = deltaFraction * sizes.reduce((a, b) => a + b);
    final before = sizes[line - 1];
    final after = sizes[line];
    final adjusted = delta.clamp(0.1 - before, after - 0.1);
    sizes[line - 1] = before + adjusted;
    sizes[line] = after - adjusted;
    return axis == TableAxis.horizontal
        ? copyWith(rowSizes: sizes)
        : copyWith(columnSizes: sizes);
  }

  TableElement insertRow(int index) {
    final insertion = index.clamp(0, rows);
    final sizes = normalizedRowSizes;
    final unitHeight =
        (secondPosition.y - firstPosition.y) / sizes.reduce((a, b) => a + b);
    if (rowSizes.isNotEmpty) sizes.insert(insertion, 1);
    final updated = normalizedCells;
    updated.insertAll(
      insertion * columns,
      List.filled(columns, const TableCellProperty()),
    );
    final horizontal = _insertTableBorderLine(
      horizontalBorders,
      rows + 1,
      columns,
      insertion + 1,
      border,
    );
    final vertical = _insertTableBorderSegment(
      verticalBorders,
      columns + 1,
      rows,
      insertion,
      border,
    );
    return copyWith(
      rows: rows + 1,
      rowSizes: rowSizes.isEmpty ? rowSizes : sizes,
      cells: updated,
      horizontalBorders: horizontal,
      verticalBorders: vertical,
      secondPosition: Point(secondPosition.x, secondPosition.y + unitHeight),
    );
  }

  TableElement removeRow(int index) {
    if (rows <= 1 || index < 0 || index >= rows) return this;
    final sizes = normalizedRowSizes;
    final removedHeight =
        (secondPosition.y - firstPosition.y) *
        sizes[index] /
        sizes.reduce((a, b) => a + b);
    if (rowSizes.isNotEmpty) sizes.removeAt(index);
    final updated = normalizedCells
      ..removeRange(index * columns, (index + 1) * columns);
    return copyWith(
      rows: rows - 1,
      rowSizes: rowSizes.isEmpty ? rowSizes : sizes,
      cells: updated,
      horizontalBorders: _removeTableBorderLine(
        horizontalBorders,
        rows + 1,
        columns,
        index + 1,
        border,
      ),
      verticalBorders: _removeTableBorderSegment(
        verticalBorders,
        columns + 1,
        rows,
        index,
        border,
      ),
      secondPosition: Point(secondPosition.x, secondPosition.y - removedHeight),
    );
  }

  TableElement insertColumn(int index) {
    final insertion = index.clamp(0, columns);
    final sizes = normalizedColumnSizes;
    final unitWidth =
        (secondPosition.x - firstPosition.x) / sizes.reduce((a, b) => a + b);
    if (columnSizes.isNotEmpty) sizes.insert(insertion, 1);
    final source = normalizedCells;
    final updated = <TableCellProperty>[];
    for (var row = 0; row < rows; row++) {
      final start = row * columns;
      final current = source.sublist(start, start + columns)
        ..insert(insertion, const TableCellProperty());
      updated.addAll(current);
    }
    return copyWith(
      columns: columns + 1,
      columnSizes: columnSizes.isEmpty ? columnSizes : sizes,
      cells: updated,
      horizontalBorders: _insertTableBorderSegment(
        horizontalBorders,
        rows + 1,
        columns,
        insertion,
        border,
      ),
      verticalBorders: _insertTableBorderLine(
        verticalBorders,
        columns + 1,
        rows,
        insertion + 1,
        border,
      ),
      secondPosition: Point(secondPosition.x + unitWidth, secondPosition.y),
    );
  }

  TableElement removeColumn(int index) {
    if (columns <= 1 || index < 0 || index >= columns) return this;
    final sizes = normalizedColumnSizes;
    final removedWidth =
        (secondPosition.x - firstPosition.x) *
        sizes[index] /
        sizes.reduce((a, b) => a + b);
    if (columnSizes.isNotEmpty) sizes.removeAt(index);
    final source = normalizedCells;
    final updated = <TableCellProperty>[];
    for (var row = 0; row < rows; row++) {
      final start = row * columns;
      final current = source.sublist(start, start + columns)..removeAt(index);
      updated.addAll(current);
    }
    return copyWith(
      columns: columns - 1,
      columnSizes: columnSizes.isEmpty ? columnSizes : sizes,
      cells: updated,
      horizontalBorders: _removeTableBorderSegment(
        horizontalBorders,
        rows + 1,
        columns,
        index,
        border,
      ),
      verticalBorders: _removeTableBorderLine(
        verticalBorders,
        columns + 1,
        rows,
        index + 1,
        border,
      ),
      secondPosition: Point(secondPosition.x - removedWidth, secondPosition.y),
    );
  }
}

List<double> _normalizeTableSizes(List<double> sizes, int count) =>
    List.generate(
      count,
      (index) => index < sizes.length && sizes[index] > 0 ? sizes[index] : 1,
    );

List<TableBorderProperty> _insertTableBorderLine(
  List<TableBorderProperty> borders,
  int lineCount,
  int segmentCount,
  int index,
  TableBorderProperty fallback,
) {
  if (borders.isEmpty) return borders;
  final updated = _normalizeTableBorders(
    borders,
    lineCount,
    segmentCount,
    fallback,
  );
  updated.insertAll(
    index.clamp(0, lineCount) * segmentCount,
    List.filled(segmentCount, fallback),
  );
  return updated;
}

List<TableBorderProperty> _removeTableBorderLine(
  List<TableBorderProperty> borders,
  int lineCount,
  int segmentCount,
  int index,
  TableBorderProperty fallback,
) {
  if (borders.isEmpty) return borders;
  final updated = _normalizeTableBorders(
    borders,
    lineCount,
    segmentCount,
    fallback,
  );
  if (index >= 0 && index < lineCount) {
    updated.removeRange(index * segmentCount, (index + 1) * segmentCount);
  }
  return updated;
}

List<TableBorderProperty> _insertTableBorderSegment(
  List<TableBorderProperty> borders,
  int lineCount,
  int segmentCount,
  int index,
  TableBorderProperty fallback,
) {
  if (borders.isEmpty) return borders;
  final source = _normalizeTableBorders(
    borders,
    lineCount,
    segmentCount,
    fallback,
  );
  final updated = <TableBorderProperty>[];
  for (var line = 0; line < lineCount; line++) {
    final start = line * segmentCount;
    updated.addAll(
      source.sublist(start, start + segmentCount)
        ..insert(index.clamp(0, segmentCount), fallback),
    );
  }
  return updated;
}

List<TableBorderProperty> _removeTableBorderSegment(
  List<TableBorderProperty> borders,
  int lineCount,
  int segmentCount,
  int index,
  TableBorderProperty fallback,
) {
  if (borders.isEmpty) return borders;
  final source = _normalizeTableBorders(
    borders,
    lineCount,
    segmentCount,
    fallback,
  );
  final updated = <TableBorderProperty>[];
  for (var line = 0; line < lineCount; line++) {
    final start = line * segmentCount;
    final segments = source.sublist(start, start + segmentCount);
    if (index >= 0 && index < segments.length) segments.removeAt(index);
    updated.addAll(segments);
  }
  return updated;
}

List<TableBorderProperty> _setTableBorderSegment(
  List<TableBorderProperty> borders,
  int lineCount,
  int segmentCount,
  int line,
  int segment,
  TableBorderProperty value,
  TableBorderProperty fallback,
) {
  final updated = _normalizeTableBorders(
    borders,
    lineCount,
    segmentCount,
    fallback,
  );
  updated[line * segmentCount + segment] = value;
  return updated;
}

List<TableBorderProperty> _normalizeTableBorders(
  List<TableBorderProperty> borders,
  int lineCount,
  int segmentCount,
  TableBorderProperty fallback,
) => List.generate(
  lineCount * segmentCount,
  (index) => index < borders.length ? borders[index] : fallback,
);
