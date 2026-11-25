import 'package:butterfly/helpers/thumbnail.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const settings = PersistedThumbnailArea(pageName: 'Page', areaName: 'Cover');
  final ratio = kThumbnailWidth / kThumbnailHeight;

  test('fit contains the whole area and centers the surrounding space', () {
    const area = Rect.fromLTWH(-100, 200, 100, 300);
    final bounds = thumbnailAreaBounds(area, settings)!;
    expect(bounds.center, area.center);
    expect(bounds.height, area.height);
    expect(bounds.width / bounds.height, closeTo(ratio, 1e-10));
    expect(bounds.contains(area.topLeft), isTrue);
    expect(bounds.right, greaterThanOrEqualTo(area.right));
  });

  test('fill keeps the requested edge for portrait and landscape areas', () {
    for (final area in [
      const Rect.fromLTWH(-200, -300, 100, 500),
      const Rect.fromLTWH(-200, -300, 500, 100),
    ]) {
      for (final alignment in ThumbnailAreaAlignment.values) {
        final bounds = thumbnailAreaBounds(
          area,
          settings.copyWith(fit: ThumbnailAreaFit.fill, alignment: alignment),
        )!;
        expect(bounds.width / bounds.height, closeTo(ratio, 1e-10));
        expect(
          bounds.left,
          closeTo(area.left + (area.width - bounds.width) * alignment.x, 1e-10),
        );
        expect(
          bounds.top,
          closeTo(
            area.top + (area.height - bounds.height) * alignment.y,
            1e-10,
          ),
        );
        expect(bounds.width, lessThanOrEqualTo(area.width + 1e-10));
        expect(bounds.height, lessThanOrEqualTo(area.height + 1e-10));
      }
    }
  });

  test('invalid areas cannot produce a thumbnail', () {
    for (final area in [
      Rect.zero,
      const Rect.fromLTWH(0, 0, -1, 10),
      const Rect.fromLTWH(0, 0, double.infinity, 10),
    ]) {
      expect(thumbnailAreaBounds(area, settings), isNull);
    }
  });
}
