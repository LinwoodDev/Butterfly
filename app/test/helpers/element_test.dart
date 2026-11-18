import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:butterfly/helpers/element.dart';
import 'package:butterfly/services/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'copied pages carry element and paint assets into another note',
    () async {
      final bytes = img.encodePng(img.Image(width: 2, height: 3));
      final svgBytes = utf8.encode(
        '<svg xmlns="http://www.w3.org/2000/svg" width="2" height="3">'
        '<rect width="2" height="3"/></svg>',
      );
      final pdfBytes = utf8.encode('pdf document');
      final (withImage, image) = NoteData(Archive()).importImage(bytes, 'png');
      final (withSvg, svg) = withImage.importImage(svgBytes, 'svg');
      final (withPdf, pdf) = withSvg.importPdf(pdfBytes);
      final (withTexture, texture) = withPdf.importTexture(bytes, 'png');
      final (source, svgTexture) = withTexture.importTexture(svgBytes, 'svg');
      final page = DocumentPage(
        layers: [
          DocumentLayer(
            id: 'visuals',
            content: [
              ImageElement(source: image, width: 1, height: 1),
              SvgElement(source: svg, width: 1, height: 1),
              PdfElement(source: pdf, page: 2, width: 1, height: 1),
              PdfElement(source: pdf, page: 3, width: 1, height: 1),
            ],
          ),
          DocumentLayer(
            id: 'paints',
            content: [
              PenElement(
                property: PenProperty(
                  paint: ImageElementPaint(source: texture),
                  fillPaint: SvgElementPaint(source: svgTexture),
                ),
              ),
              PolygonElement(
                property: PolygonProperty(
                  paint: SvgElementPaint(source: svgTexture),
                  fillPaint: ImageElementPaint(source: texture),
                ),
              ),
              ShapeElement(
                property: ShapeProperty(
                  paint: ImageElementPaint(source: texture),
                  shape: RectangleShape(
                    fillPaint: SvgElementPaint(source: svgTexture),
                  ),
                ),
              ),
            ],
          ),
        ],
      );

      final json = page.toDataJson(source);
      expect((json['assets'] as Map).keys, unorderedEquals(page.sources));
      final copied = DocumentPageDataExtension.fromDataJson(
        jsonDecode(jsonEncode(json)) as Map<String, dynamic>,
      );
      expect(copied.layers.map((layer) => layer.id), ['visuals', 'paints']);

      final assetService = AssetService();
      addTearDown(assetService.dispose);
      for (final source in copied.content[4].sources) {
        final image = await assetService.getImage(source, NoteData(Archive()));
        expect(image, isNotNull);
        expect((image!.width, image.height), (2, 3));
        image.dispose();
      }

      final (destination, pasted) = importAssets((
        NoteData(Archive()),
        copied.content,
        alreadyImported: null,
        assets: null,
        onInvalidate: null,
      ));
      expect((pasted[2] as PdfElement).page, 2);
      expect((pasted[3] as PdfElement).page, 3);
      expect(pasted[2].sources.single, pasted[3].sources.single);
      for (var i = 0; i < page.content.length; i++) {
        expect(
          pasted[i].sources.map((path) => getDataFromSource(destination, path)),
          page.content[i].sources.map(source.getAsset),
          reason: 'Asset bytes for ${pasted[i].runtimeType}',
        );
        expect(pasted[i].sources, everyElement(isNot(startsWith('data:'))));
      }
      expect(destination.getAllAssets().keys, unorderedEquals(page.sources));
    },
  );

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
