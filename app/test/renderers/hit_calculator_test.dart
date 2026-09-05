import 'dart:collection';
import 'dart:ui';

import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestHitCalculator extends HitCalculator {
  @override
  bool hit(
    Rect rect, {
    HitElementMode hitElementMode = HitElementMode.touchAnywhere,
  }) => false;

  @override
  bool hitPolygon(
    List<Offset> polygon, {
    HitElementMode hitElementMode = HitElementMode.touchAnywhere,
  }) => false;
}

class _CountingPoints extends ListBase<Offset> {
  final List<Offset> _points;
  int reads = 0;

  _CountingPoints(this._points);

  @override
  int get length => _points.length;

  @override
  set length(int value) => throw UnsupportedError('Read-only points');

  @override
  Offset operator [](int index) {
    reads++;
    return _points[index];
  }

  @override
  void operator []=(int index, Offset value) =>
      throw UnsupportedError('Read-only points');
}

void main() {
  group('HitCalculator.isPolygonInPolygon', () {
    final calculator = _TestHitCalculator();
    const square = [Offset(0, 0), Offset(10, 0), Offset(10, 10), Offset(0, 10)];

    void expectSymmetricHit(List<Offset> a, List<Offset> b, bool expected) {
      expect(calculator.isPolygonInPolygon(a, b), expected);
      expect(calculator.isPolygonInPolygon(b, a), expected);
    }

    test('rejects disjoint dense polygons with linear point access', () {
      final first = _CountingPoints([
        for (var i = 0; i < 1000; i++) Offset(i.toDouble(), (i % 2).toDouble()),
      ]);
      final second = _CountingPoints([
        for (var i = 0; i < 1000; i++)
          Offset(i.toDouble(), 10 + (i % 2).toDouble()),
      ]);

      expectSymmetricHit(first, second, false);
      expect(first.reads + second.reads, lessThan(20 * 2000));
    });

    test('hits contained polygons, lines, and points in either order', () {
      expectSymmetricHit(square, [
        Offset(2, 2),
        Offset(8, 2),
        Offset(5, 8),
      ], true);
      expectSymmetricHit(square, [Offset(2, 2), Offset(8, 8)], true);
      expectSymmetricHit(square, [Offset(5, 5)], true);
    });

    test('hits shared edges and corners', () {
      expectSymmetricHit(square, [
        Offset(10, 0),
        Offset(20, 0),
        Offset(10, 10),
      ], true);
      expectSymmetricHit(square, [
        Offset(10, 10),
        Offset(20, 10),
        Offset(10, 20),
      ], true);
    });

    test('hits crossing and overlapping lines with zero-sized bounds', () {
      expectSymmetricHit(
        [Offset(0, 5), Offset(10, 5)],
        [Offset(5, 0), Offset(5, 10)],
        true,
      );
      expectSymmetricHit(
        [Offset(0, 5), Offset(10, 5)],
        [Offset(5, 5), Offset(15, 5)],
        true,
      );
    });

    test('rejects empty and non-finite polygons', () {
      expectSymmetricHit(square, [], false);
      expectSymmetricHit(square, [Offset(double.nan, 5)], false);
      expectSymmetricHit(square, [Offset(5, double.infinity)], false);
    });

    test('repeated vertices do not hit a line outside a concave polygon', () {
      const lasso = [
        Offset(0, 0),
        Offset(10, 0),
        Offset(10, 2),
        Offset(2, 2),
        Offset(2, 2),
        Offset(2, 8),
        Offset(10, 8),
        Offset(10, 10),
        Offset(0, 10),
      ];

      // The repeated vertex is collinear with this line, but lies outside it.
      expectSymmetricHit(lasso, [Offset(5, 5), Offset(7, 7)], false);
      expectSymmetricHit(lasso, [Offset(2, 2), Offset(3, 3)], true);
    });

    test('does not hit a polygon in the hollow of a concave lasso', () {
      final calculator = _TestHitCalculator();
      final lasso = [
        Offset(0, 0),
        Offset(10, 0),
        Offset(10, 2),
        Offset(2, 2),
        Offset(2, 8),
        Offset(10, 8),
        Offset(10, 10),
        Offset(0, 10),
      ];
      final shapeInHollow = [
        Offset(5, 4),
        Offset(7, 4),
        Offset(7, 6),
        Offset(5, 6),
      ];

      expect(calculator.isPolygonInPolygon(lasso, shapeInHollow), isFalse);
    });

    test('hits intersecting polygons', () {
      final calculator = _TestHitCalculator();
      final lasso = [
        Offset(0, 0),
        Offset(10, 0),
        Offset(10, 2),
        Offset(2, 2),
        Offset(2, 8),
        Offset(10, 8),
        Offset(10, 10),
        Offset(0, 10),
      ];
      final crossingShape = [
        Offset(1, 1),
        Offset(3, 1),
        Offset(3, 3),
        Offset(1, 3),
      ];

      expect(calculator.isPolygonInPolygon(lasso, crossingShape), isTrue);
    });
  });
}
