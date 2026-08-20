import 'package:butterfly/helpers/element.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('calculateImportAssetScale', () {
    test('does not enlarge assets that fit within the viewport limit', () {
      final scale = calculateImportAssetScale(
        assetWidth: 200,
        assetHeight: 100,
        viewportWidth: 1000,
        viewportHeight: 800,
        viewportScale: 1,
        maxViewportFraction: 0.5,
      );

      expect(scale, 1);
    });

    test('compensates for the current zoom', () {
      final scale = calculateImportAssetScale(
        assetWidth: 200,
        assetHeight: 100,
        viewportWidth: 1000,
        viewportHeight: 800,
        viewportScale: 2.5,
        maxViewportFraction: 0.5,
      );

      expect(scale, 0.4);
    });

    test('scales large assets down to the configured viewport limit', () {
      final scale = calculateImportAssetScale(
        assetWidth: 2000,
        assetHeight: 1000,
        viewportWidth: 1000,
        viewportHeight: 800,
        viewportScale: 1,
        maxViewportFraction: 0.5,
      );

      expect(scale, 0.25);
    });

    test('combines viewport fitting with zoom compensation', () {
      final scale = calculateImportAssetScale(
        assetWidth: 2000,
        assetHeight: 1000,
        viewportWidth: 1000,
        viewportHeight: 800,
        viewportScale: 2,
        maxViewportFraction: 0.5,
      );

      expect(scale, 0.125);
    });
  });
}
