part of '../renderer.dart';

@freezed
sealed class TableHitTarget with _$TableHitTarget {
  const factory TableHitTarget.cell(int row, int column) = TableCellTarget;

  const factory TableHitTarget.line(TableAxis axis, int line) = TableLineTarget;

  const factory TableHitTarget.border(TableAxis axis, int line, int segment) =
      TableBorderTarget;
}

class TableRenderer extends Renderer<TableElement> {
  TableRenderer(super.element, [super.layer]);

  @override
  Rect get rect => Rect.fromPoints(
    element.firstPosition.toOffset(),
    element.secondPosition.toOffset(),
  );

  List<double> _boundaries(List<double> sizes, double start, double extent) {
    final total = sizes.fold<double>(0, (sum, size) => sum + size);
    final result = <double>[start];
    var offset = start;
    for (final size in sizes) {
      offset += extent * size / total;
      result.add(offset);
    }
    return result;
  }

  List<double> get _rowBoundaries =>
      _boundaries(element.normalizedRowSizes, rect.top, rect.height);

  List<double> get _columnBoundaries =>
      _boundaries(element.normalizedColumnSizes, rect.left, rect.width);

  int _segmentAt(double position, List<double> boundaries) {
    for (var index = 0; index < boundaries.length - 1; index++) {
      if (position < boundaries[index + 1]) return index;
    }
    return boundaries.length - 2;
  }

  ({int index, double distance}) _nearestBoundary(
    double position,
    List<double> boundaries,
  ) {
    var nearest = 0;
    var distance = (position - boundaries.first).abs();
    for (var index = 1; index < boundaries.length; index++) {
      final candidate = (position - boundaries[index]).abs();
      if (candidate < distance) {
        nearest = index;
        distance = candidate;
      }
    }
    return (index: nearest, distance: distance);
  }

  Rect cellRect(int row, int column) {
    final rowBoundaries = _rowBoundaries;
    final columnBoundaries = _columnBoundaries;
    return Rect.fromLTRB(
      columnBoundaries[column],
      rowBoundaries[row],
      columnBoundaries[column + 1],
      rowBoundaries[row + 1],
    );
  }

  Offset tablePosition(Offset position) {
    final center = rect.center;
    final rotated = (position - center).rotate(
      Offset.zero,
      -rotation * pi / 180,
    );
    return center + Offset(rotated.dx - rotated.dy * shear, rotated.dy);
  }

  TableHitTarget? hitTarget(Offset position, {double tolerance = 0}) {
    if (rect.width <= 0 || rect.height <= 0) return null;
    final local = tablePosition(position);
    if (!rect.inflate(tolerance).contains(local)) return null;

    final rows = _rowBoundaries;
    final columns = _columnBoundaries;
    final horizontal = _nearestBoundary(local.dy, rows);
    final vertical = _nearestBoundary(local.dx, columns);
    if (horizontal.distance <= tolerance || vertical.distance <= tolerance) {
      if (horizontal.distance <= vertical.distance) {
        return TableBorderTarget(
          TableAxis.horizontal,
          horizontal.index,
          _segmentAt(local.dx.clamp(rect.left, rect.right), columns),
        );
      }
      return TableBorderTarget(
        TableAxis.vertical,
        vertical.index,
        _segmentAt(local.dy.clamp(rect.top, rect.bottom), rows),
      );
    }

    if (!rect.contains(local)) return null;
    return TableCellTarget(
      _segmentAt(local.dy, rows),
      _segmentAt(local.dx, columns),
    );
  }

  ({int row, int column})? cellAtPosition(Offset position) {
    final target = hitTarget(position);
    return switch (target) {
      TableCellTarget(:final row, :final column) => (row: row, column: column),
      _ => null,
    };
  }

  ({Offset start, Offset end}) borderLine(
    TableAxis axis,
    int line,
    int segment,
  ) {
    final rows = _rowBoundaries;
    final columns = _columnBoundaries;
    if (axis == TableAxis.horizontal) {
      return (
        start: Offset(columns[segment], rows[line]),
        end: Offset(columns[segment + 1], rows[line]),
      );
    }
    return (
      start: Offset(columns[line], rows[segment]),
      end: Offset(columns[line], rows[segment + 1]),
    );
  }

  ({Offset start, Offset end}) fullBorderLine(TableAxis axis, int line) {
    final rows = _rowBoundaries;
    final columns = _columnBoundaries;
    return axis == TableAxis.horizontal
        ? (
            start: Offset(columns.first, rows[line]),
            end: Offset(columns.last, rows[line]),
          )
        : (
            start: Offset(columns[line], rows.first),
            end: Offset(columns[line], rows.last),
          );
  }

  @override
  Rect get expandedRect {
    final widths = [
      element.border.width,
      ...element.horizontalBorders.map((e) => e.width),
      ...element.verticalBorders.map((e) => e.width),
    ];
    final expanded = rect.inflate(max(widths.reduce(max) / 2, 1));
    return Renderer._expandedAabbFor(expanded, rotation * pi / 180, shear);
  }

  @override
  void build(
    Canvas canvas,
    Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {
    final bounds = rect;
    canvas.drawRect(
      bounds,
      Paint()
        ..color = element.fillColor.toColor()
        ..style = PaintingStyle.fill,
    );
    for (var row = 0; row < element.rows; row++) {
      for (var column = 0; column < element.columns; column++) {
        final cell = element.cellAt(row, column);
        if (cell.fillColor.a > 0) {
          canvas.drawRect(
            cellRect(row, column),
            Paint()
              ..color = cell.fillColor.toColor()
              ..style = PaintingStyle.fill,
          );
        }
      }
    }
    for (final axis in TableAxis.values) {
      for (var line = 0; line < element.borderLineCount(axis); line++) {
        for (
          var segment = 0;
          segment < element.borderSegmentCount(axis);
          segment++
        ) {
          final geometry = borderLine(axis, line, segment);
          _drawBorder(
            canvas,
            geometry.start,
            geometry.end,
            element.borderAt(axis, line, segment),
          );
        }
      }
    }
  }

  void _drawBorder(
    Canvas canvas,
    Offset start,
    Offset end,
    TableBorderProperty border,
  ) {
    if (border.width <= 0) return;
    final paint = Paint()
      ..color = border.color.toColor()
      ..style = PaintingStyle.stroke
      ..strokeCap = border.strokeStyle == StrokeStyle.dotted
          ? StrokeCap.round
          : StrokeCap.butt
      ..strokeWidth = border.width;
    if (border.strokeStyle == StrokeStyle.solid) {
      canvas.drawLine(start, end, paint);
      return;
    }

    final delta = end - start;
    final length = delta.distance;
    if (length == 0) return;
    final direction = delta / length;
    final dashLength = border.width * max(0.1, border.dashMultiplier);
    final gapLength = border.width * 2 * max(0.1, border.gapMultiplier);
    for (
      double distance = 0;
      distance < length;
      distance += dashLength + gapLength
    ) {
      canvas.drawLine(
        start + direction * distance,
        start + direction * min(distance + dashLength, length),
        paint,
      );
    }
  }

  @override
  void buildSvg(
    XmlDocument xml,
    NoteData document,
    DocumentPage page,
    Rect viewportRect,
  ) {
    if (!rect.overlaps(viewportRect)) return;
    final svg = xml.getElement('svg');
    if (svg == null) return;
    svg.createElement(
      'rect',
      attributes: {
        'x': '${rect.left}',
        'y': '${rect.top}',
        'width': '${rect.width}',
        'height': '${rect.height}',
        'fill': element.fillColor.toHexString(alpha: false),
        'fill-opacity': '${element.fillColor.a / 255}',
        'stroke': 'none',
      },
    );
    for (var row = 0; row < element.rows; row++) {
      for (var column = 0; column < element.columns; column++) {
        final cell = element.cellAt(row, column);
        if (cell.fillColor.a <= 0) continue;
        final bounds = cellRect(row, column);
        svg.createElement(
          'rect',
          attributes: {
            'x': '${bounds.left}',
            'y': '${bounds.top}',
            'width': '${bounds.width}',
            'height': '${bounds.height}',
            'fill': cell.fillColor.toHexString(alpha: false),
            'fill-opacity': '${cell.fillColor.a / 255}',
          },
        );
      }
    }
    for (final axis in TableAxis.values) {
      for (var line = 0; line < element.borderLineCount(axis); line++) {
        for (
          var segment = 0;
          segment < element.borderSegmentCount(axis);
          segment++
        ) {
          final geometry = borderLine(axis, line, segment);
          _createSvgLine(
            svg,
            geometry.start,
            geometry.end,
            element.borderAt(axis, line, segment),
          );
        }
      }
    }
  }

  void _createSvgLine(
    XmlElement svg,
    Offset start,
    Offset end,
    TableBorderProperty border,
  ) {
    if (border.width <= 0) return;
    final dashArray = border.strokeStyle == StrokeStyle.solid
        ? null
        : '${border.width * max(0.1, border.dashMultiplier)},'
              '${border.width * 2 * max(0.1, border.gapMultiplier)}';
    svg.createElement(
      'line',
      attributes: {
        'x1': '${start.dx}',
        'y1': '${start.dy}',
        'x2': '${end.dx}',
        'y2': '${end.dy}',
        'stroke': border.color.toHexString(alpha: false),
        'stroke-opacity': '${border.color.a / 255}',
        'stroke-width': '${border.width}',
        'stroke-dasharray': ?dashArray,
        'stroke-linecap': border.strokeStyle == StrokeStyle.dotted
            ? 'round'
            : 'butt',
      },
    );
  }

  @override
  TableRenderer _transform({
    required Offset position,
    required double rotation,
    required double shear,
    double scaleX = 1,
    double scaleY = 1,
  }) {
    final previous = rect.topLeft;
    final localFirst = element.firstPosition.toOffset() - previous;
    final localSecond = element.secondPosition.toOffset() - previous;
    return TableRenderer(
      element.copyWith(
        shear: shear,
        firstPosition: (localFirst.scale(scaleX, scaleY) + position).toPoint(),
        secondPosition: (localSecond.scale(scaleX, scaleY) + position)
            .toPoint(),
        rotation: rotation,
      ),
      layer,
    );
  }
}
