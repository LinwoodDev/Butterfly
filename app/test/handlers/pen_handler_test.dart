import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('bounds preview work while preserving stroke endpoints', () {
    final points = List.generate(1000, (i) => PathPoint(i.toDouble(), 0));

    final preview = limitPenPreviewPoints(points, 100);

    expect(preview, hasLength(100));
    expect(preview.first, same(points.first));
    expect(preview.last, same(points.last));
    expect(points, hasLength(1000));
  });

  test('keeps short previews unchanged', () {
    final points = [const PathPoint(0, 0), const PathPoint(1, 1)];

    expect(limitPenPreviewPoints(points), same(points));
  });
}
