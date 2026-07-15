import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('samples sparse pen segments for stroke erasing', () {
    const points = [PathPoint(0, 0, 0.5), PathPoint(100, 0, 1)];

    final sampled = samplePenPointsForEraser(points, 10);

    expect(sampled, hasLength(11));
    expect(sampled.first, points.first);
    expect(sampled.last, points.last);
    expect(sampled[5].x, 50);
    expect(sampled[5].pressure, 0.75);
  });

  test('does not resample already isolated pen points', () {
    const points = [PathPoint(12, 34, 0.8)];

    expect(samplePenPointsForEraser(points, 10), same(points));
  });
}
