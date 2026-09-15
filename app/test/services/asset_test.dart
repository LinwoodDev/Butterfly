import 'dart:async';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly/services/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pdfrx/pdfrx.dart';

class _Engine extends Mock implements PdfrxEntryFunctions {}

class _Pdf extends Mock implements PdfDocument {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late PdfrxEntryFunctions originalEngine;
  late _Engine engine;
  late _Pdf pdf;
  late AssetService service;
  final bytes = Uint8List.fromList([1, 2, 3]);
  final source = '$kPdfArchiveDirectory/test.pdf';
  final empty = NoteData(Archive());
  final document = empty.setAsset(source, bytes);

  setUpAll(() => registerFallbackValue(Uint8List(0)));
  setUp(() {
    originalEngine = PdfrxEntryFunctions.instance;
    engine = _Engine();
    pdf = _Pdf();
    service = AssetService();
    PdfrxEntryFunctions.instance = engine;
    when(() => engine.openData(any())).thenAnswer((_) async => pdf);
    when(() => pdf.dispose()).thenAnswer((_) async {});
  });
  tearDown(() async {
    await service.dispose();
    PdfrxEntryFunctions.instance = originalEngine;
  });

  test(
    'missing PDF and byte cache entries can recover when bytes arrive',
    () async {
      expect(await service.getPdfDocument(source, empty), isNull);
      expect(await service.getPdfDocument(source, document), same(pdf));
      verify(() => engine.openData(any())).called(1);
    },
  );

  test('all callers receive a recoverable PDF load failure', () async {
    final opening = Completer<PdfDocument>();
    final started = Completer<void>();
    when(() => engine.openData(any())).thenAnswer((_) {
      started.complete();
      return opening.future;
    });
    final first = service.getPdfDocument(source, document);
    final second = service.getPdfDocument(source, document);
    final results = Future.wait([first, second]);
    await started.future;
    opening.completeError(StateError('temporary failure'));
    expect(await results, [null, null]);
    when(() => engine.openData(any())).thenAnswer((_) async => pdf);
    expect(await service.getPdfDocument(source, document), same(pdf));
  });

  test('page change preserves PDFs shared with the destination page', () async {
    await service.getPdfDocument(source, document);
    final page = DocumentPage(
      layers: [
        DocumentLayer(
          content: [PdfElement(source: source, width: 100, height: 100)],
        ),
      ],
    );
    await service.removeUnusedSources(page);
    verifyNever(() => pdf.dispose());
    expect(await service.getPdfDocument(source, document), same(pdf));
    verify(() => engine.openData(any())).called(1);
  });

  test('page change evicts unused PDFs and their bytes', () async {
    await service.getPdfDocument(source, document);
    await service.removeUnusedSources(const DocumentPage());
    verify(() => pdf.dispose()).called(1);
    expect(await service.computeDataFromSource(source, empty), isNull);
    expect(await service.getPdfDocument(source, document), same(pdf));
    verify(() => engine.openData(any())).called(2);
  });

  test('page cleanup retains background and paint sources', () async {
    const background = 'background.png';
    const paint = 'paint.svg';
    final data = empty.setAsset(background, bytes).setAsset(paint, bytes);
    await service.computeDataFromSource(background, data);
    await service.computeDataFromSource(paint, data);
    await service.removeUnusedSources(
      DocumentPage(
        backgrounds: [
          Background.image(source: background, width: 100, height: 100),
        ],
        layers: [
          DocumentLayer(
            content: [
              ShapeElement(
                property: ShapeProperty(
                  shape: RectangleShape(
                    fillPaint: ElementPaint.svg(source: paint),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    expect(await service.computeDataFromSource(background, empty), bytes);
    expect(await service.computeDataFromSource(paint, empty), bytes);
  });

  test('document close disposes cached PDFs and prevents new loads', () async {
    await service.getPdfDocument(source, document);
    await service.dispose();
    verify(() => pdf.dispose()).called(1);
    expect(await service.getPdfDocument(source, document), isNull);
  });

  test('late failed load cannot evict a replacement PDF', () async {
    final opening = Completer<PdfDocument>();
    final started = Completer<void>();
    when(() => engine.openData(any())).thenAnswer((_) {
      started.complete();
      return opening.future;
    });
    final old = service.getPdfDocument(source, document);
    await started.future;
    final invalidating = service.invalidatePdfDocument(source);
    when(() => engine.openData(any())).thenAnswer((_) async => pdf);
    expect(await service.getPdfDocument(source, document), same(pdf));
    opening.completeError(StateError('old failure'));
    expect(await old, isNull);
    await invalidating;
    expect(await service.getPdfDocument(source, document), same(pdf));
    verify(() => engine.openData(any())).called(2);
  });
}
