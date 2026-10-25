import 'dart:ui';
import 'dart:async';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pdfrx/pdfrx.dart';

class _Assets extends Mock implements AssetService {}

class _State extends Mock implements DocumentLoaded {}

class _Controller extends Mock implements EditorController {}

class _Pdf extends Mock implements PdfDocument {}

class _Page extends Mock implements PdfPage {}

class _Raster extends Mock implements PdfImage {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('PDF raster finishing after hiding is released', () async {
    final document = NoteData(Archive());
    final assets = _Assets();
    final state = _State();
    final controller = _Controller();
    final pdf = _Pdf();
    final page = _Page();
    final raster = _Raster();
    final rendering = Completer<PdfImage?>();
    final started = Completer<void>();
    when(() => state.assetService).thenReturn(assets);
    when(() => state.data).thenReturn(document);
    when(() => assets.getPdfDocument('test.pdf', document))
        .thenAnswer((_) async => pdf);
    when(() => pdf.pages).thenReturn([page]);
    when(
      () => page.render(
        x: 0,
        y: 0,
        width: 10,
        height: 10,
        fullWidth: 10,
        fullHeight: 10,
      ),
    ).thenAnswer((_) {
      started.complete();
      return rendering.future;
    });
    final renderer = PdfRenderer(
      PdfElement(source: 'test.pdf', width: 10, height: 10),
    );
    final visible = renderer.onVisible(
      controller,
      state,
      const CameraTransform(),
      Size.zero,
    );
    await started.future;
    renderer.onHidden(controller, state, const CameraTransform(), Size.zero);
    rendering.complete(raster);
    await visible;
    expect(renderer.image, isNull);
    expect(renderer.renderedScale, isNull);
    verify(() => raster.dispose()).called(1);
    verifyNever(() => raster.pixels);
    renderer.dispose();
  });

  for (final invert in [false, true]) {
    test('PDF image ownership is released once (invert: $invert)', () async {
      final document = NoteData(Archive());
      final assets = _Assets();
      final state = _State();
      final controller = _Controller();
      final pdf = _Pdf();
      final page = _Page();
      final raster = _Raster();
      when(() => state.assetService).thenReturn(assets);
      when(() => state.data).thenReturn(document);
      when(() => assets.getPdfDocument('test.pdf', document))
          .thenAnswer((_) async => pdf);
      when(() => pdf.pages).thenReturn([page]);
      when(
        () => page.render(
          x: 0,
          y: 0,
          width: 10,
          height: 10,
          fullWidth: 10,
          fullHeight: 10,
        ),
      ).thenAnswer((_) async => raster);
      when(() => raster.width).thenReturn(10);
      when(() => raster.height).thenReturn(10);
      when(() => raster.pixels).thenReturn(Uint8List(400));
      final renderer = PdfRenderer(
        PdfElement(source: 'test.pdf', width: 10, height: 10, invert: invert),
      );
      addTearDown(renderer.dispose);
      await renderer.onVisible(
        controller,
        state,
        const CameraTransform(),
        Size.zero,
      );
      final image = renderer.image;
      expect(image, isNotNull);
      expect(renderer.renderedScale, 1);
      verify(() => raster.dispose()).called(1);
      final preview = renderer.transform(position: Offset.zero)! as PdfRenderer;
      expect(preview.image, same(image));
      preview.dispose();
      preview.dispose();
      expect(image!.debugDisposed, isFalse);
      renderer.dispose();
      renderer.dispose();
      expect(image.debugDisposed, isTrue);
    });
  }

  test('negative PDF scale keeps mirrored bounds', () {
    final renderer = PdfRenderer(
      PdfElement(source: 'test.pdf', width: 100, height: 50),
    );

    final mirrored = renderer.transform(scaleX: -1)!;

    expect(mirrored.rotation, 0);
    expect(mirrored.rect, const Rect.fromLTWH(-100, 0, 100, 50));
    expect(
      (mirrored.element.constraints as ScaledElementConstraints).scaleX,
      -1,
    );
  });

  test('mirrored PDF remains stable through a subsequent transform', () {
    final renderer = PdfRenderer(
      PdfElement(source: 'test.pdf', width: 100, height: 50),
    );

    final mirrored = renderer.transform(scaleX: -1)!;
    final resized = mirrored.transform(scaleX: 2)!;

    expect(resized.rotation, 0);
    expect(resized.rect, const Rect.fromLTWH(-300, 0, 200, 50));
    expect(
      (resized.element.constraints as ScaledElementConstraints).scaleX,
      -2,
    );
  });
}
