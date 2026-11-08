import 'dart:typed_data';

import 'package:butterfly/helpers/pdf.dart';
import 'package:butterfly/services/batch_export.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:mocktail/mocktail.dart';
import 'package:pdfrx/pdfrx.dart';

class _Source extends Mock implements ExportSource {}

class _Engine extends Mock implements PdfrxEntryFunctions {}

class _Document extends Mock implements PdfDocument {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    registerFallbackValue(Uint8List(0));
    registerFallbackValue(
      ExportItem('', '', const ImageExportOptions(width: 1, height: 1)),
    );
  });

  for (final (name, width, height, pdfWidth, pdfHeight) in [
    (
      'A4 preset',
      AreaSizePreset.a4.width,
      AreaSizePreset.a4.height,
      595.2755905511812,
      841.8897637795276,
    ),
    (
      'Letter preset',
      AreaSizePreset.letter.width,
      AreaSizePreset.letter.height,
      612.0,
      792.0,
    ),
    (
      'photo preset',
      AreaSizePreset.photo4x6.width,
      AreaSizePreset.photo4x6.height,
      288.0,
      432.0,
    ),
    (
      'imported slide',
      pdfPointsToCanvasUnits(960),
      pdfPointsToCanvasUnits(540),
      960.0,
      540.0,
    ),
    (
      'imported custom page',
      pdfPointsToCanvasUnits(123.45),
      pdfPointsToCanvasUnits(678.9),
      123.45,
      678.9,
    ),
  ]) {
    for (final quality in [1.0, 3.0]) {
      test(
        '$name exports at its physical size with quality $quality',
        () async {
          final source = _Source();
          when(() => source.documentName).thenReturn('Test');
          when(() => source.renderPng(any())).thenAnswer(
            (_) async => img.encodePng(img.Image(width: 1, height: 1)),
          );
          final originalEngine = PdfrxEntryFunctions.instance;
          final engine = _Engine(), pdf = _Document(), imagePdf = _Document();
          PdfrxEntryFunctions.instance = engine;
          addTearDown(() => PdfrxEntryFunctions.instance = originalEngine);
          when(() => engine.createNew(sourceName: any(named: 'sourceName')))
              .thenAnswer((_) async => pdf);
          when(
            () => engine.createFromJpegData(
              any(),
              width: any(named: 'width'),
              height: any(named: 'height'),
              sourceName: any(named: 'sourceName'),
            ),
          ).thenAnswer((_) async => imagePdf);
          when(() => imagePdf.pages).thenReturn([]);
          when(() => pdf.encodePdf()).thenAnswer((_) async => Uint8List(0));
          when(() => pdf.dispose()).thenAnswer((_) async {});
          when(() => imagePdf.dispose()).thenAnswer((_) async {});

          await buildExport(source, [
            ExportItem(
              'Page',
              '',
              ImageExportOptions(
                width: width,
                height: height,
                x: 10,
                y: 20,
                quality: quality,
              ),
            ),
          ], .pdf);

          final created = verify(
            () => engine.createFromJpegData(
              any(),
              width: captureAny(named: 'width'),
              height: captureAny(named: 'height'),
              sourceName: any(named: 'sourceName'),
            ),
          ).captured;
          expect(created[0], closeTo(pdfWidth, 1e-9));
          expect(created[1], closeTo(pdfHeight, 1e-9));
          final rendered =
              verify(() => source.renderPng(captureAny())).captured.single
                  as ExportItem;
          expect(rendered.options.toImageOptions().quality, quality);
        },
      );
    }
  }
}
