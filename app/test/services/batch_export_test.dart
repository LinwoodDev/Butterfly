import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly/services/batch_export.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:mocktail/mocktail.dart';
import 'package:pdfrx/pdfrx.dart';

class _Source extends ExportSource {
  @override
  String get documentName => 'Field notes';
  @override
  String get currentPage => '0.Studies';
  @override
  List<(String, String)> get pages => [
    ('Studies', currentPage),
    ('Cover', '1.Cover'),
  ];
  @override
  final presets = <ExportPreset>[];
  final rendered = <ExportItem>[];
  String? fail;
  Completer<void>? gate;
  @override
  ExportItem view() => ExportItem(
    'View',
    currentPage,
    const ImageExportOptions(width: 16, height: 16),
    region: .view,
  );
  @override
  Future<ExportItem> page(String page) async => ExportItem(
    page,
    page,
    const ImageExportOptions(width: 16, height: 16),
    region: .page,
  );
  @override
  List<ExportItem> areas(String page) => [
    ExportItem(
      'Area',
      page,
      const ImageExportOptions(width: 8, height: 8),
      region: .area,
    ),
  ];
  @override
  void savePreset(ExportPreset preset) => presets.add(preset);
  @override
  void removePreset(String name) => presets.removeWhere((e) => e.name == name);
  @override
  Future<Uint8List?> renderPng(ExportItem item, {bool preview = false}) async {
    rendered.add(item);
    await gate?.future;
    if (item.name == fail) return null;
    final size = exportPixelSize(item.options);
    final image = img.Image(
      width: size.width.toInt(),
      height: size.height.toInt(),
      numChannels: 4,
    );
    image.setPixelRgba(0, 0, 255, 0, 0, 255);
    return img.encodePng(image);
  }

  @override
  Future<String> renderSvg(ExportItem item) async =>
      '<svg><title>${item.name}</title></svg>';
}

class _Engine extends Mock implements PdfrxEntryFunctions {}

class _Pdf extends Mock implements PdfDocument {}

class _Page extends Mock implements PdfPage {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => registerFallbackValue(Uint8List(0)));

  for (final format in ExportFormat.values.where(
    (e) => e != .svg && e != .pdf,
  )) {
    test(
      '${format.label} produces a decodable image at the requested size',
      () async {
        final source = _Source();
        final result = await buildExport(source, [source.view()], format);
        final decoded = switch (format) {
          .cur => () {
            final header = ByteData.sublistView(result.bytes);
            expect(header.getUint16(2, Endian.little), 2);
            expect(header.getUint16(4, Endian.little), 1);
            expect(header.getUint16(10, Endian.little), 0);
            expect(header.getUint16(12, Endian.little), 0);
            final offset = header.getUint32(18, Endian.little);
            return img.decodePng(Uint8List.sublistView(result.bytes, offset));
          }(),
          .pvr => img.decodePvr(result.bytes),
          .tga => img.decodeTga(result.bytes),
          _ => img.decodeImage(result.bytes),
        };
        expect(decoded, isNotNull);
        expect(decoded!.width, 16);
        expect(decoded.height, 16);
        expect(result.fileName, 'View.${format.name}');
        expect(result.mimeType, format.mimeType);
        if (format == .jpg || format == .bmp) {
          final transparentPixel = decoded.getPixel(15, 15);
          expect(transparentPixel.r, greaterThan(245));
          expect(transparentPixel.g, greaterThan(245));
          expect(transparentPixel.b, greaterThan(245));
        }
      },
    );
  }

  test(
    'ordered ZIP uses unique safe names and preserves every entry',
    () async {
      final source = _Source();
      final entries = [
        ExportItem('Area', source.currentPage, source.view().options),
        ExportItem('area', '1.Cover', source.view().options),
        ExportItem(
          '../outside/area',
          source.currentPage,
          source.view().options,
        ),
      ];
      final progress = <double>[];
      final result = await buildExport(
        source,
        entries,
        .svg,
        onProgress: progress.add,
      );
      final archive = ZipDecoder().decodeBytes(result.bytes);
      expect(result.fileName, 'Field notes.zip');
      expect(result.mimeType, 'application/zip');
      expect(archive.files, hasLength(3));
      expect(archive.files[0].name, 'Area.svg');
      expect(archive.files[1].name, 'area (2).svg');
      expect(archive.files[2].name, isNot(contains('/')));
      expect(
        utf8.decode(archive.files[0].content),
        contains('<title>Area</title>'),
      );
      expect(
        utf8.decode(archive.files[1].content),
        contains('<title>area</title>'),
      );
      expect(progress, [1 / 3, 2 / 3, 1]);
    },
  );

  test('single SVG remains a standalone file', () async {
    final source = _Source();
    final output = await buildExport(source, [source.view()], .svg);
    expect(output.fileName, 'View.svg');
    expect(output.mimeType, 'image/svg+xml');
    expect(utf8.decode(output.bytes), '<svg><title>View</title></svg>');
  });

  test(
    'a failed entry fails the batch instead of silently omitting it',
    () async {
      final source = _Source()..fail = 'Missing';
      final missing = ExportItem(
        'Missing',
        source.currentPage,
        source.view().options,
      );
      await expectLater(
        buildExport(source, [source.view(), missing], .png),
        throwsStateError,
      );
      expect(source.rendered, hasLength(2));
    },
  );

  test(
    'selection and settings are snapshotted before asynchronous work',
    () async {
      final source = _Source()..gate = Completer<void>();
      final first = source.view(), second = source.view();
      final entries = [first, second];
      final output = buildExport(source, entries, .png);
      second.options = second.options.copyWith(width: 20);
      entries.clear();
      source.gate!.complete();
      final archive = ZipDecoder().decodeBytes((await output).bytes);
      expect(archive.files, hasLength(2));
      expect(img.decodePng(archive.files[1].content)!.width, 16);
    },
  );

  test(
    'old and new presets retain area selection, quality and rendering settings',
    () {
      final source = _Source();
      final old = ExportPreset.fromJson({
        'areas': [
          {'page': 'Studies', 'name': 'Area', 'quality': 2},
        ],
      });
      final legacy = source.fromPreset(old).single;
      expect(legacy.page, source.currentPage);
      expect(legacy.options.toImageOptions().quality, 2);
      final options = const ImageExportOptions(
        width: 99,
        height: 60,
        x: -12,
        y: 30,
        quality: 3,
        scale: 2,
        rotation: .5,
        renderBackground: false,
        padding: ExportPadding(top: 1, left: 4, right: 2, bottom: 3),
      );
      final preset = ExportPreset(
        name: 'Saved',
        areas: [
          AreaPreset(
            name: 'Custom',
            area: Area(
              name: 'Custom',
              width: 99,
              height: 60,
              position: Point(-12, 30),
            ),
            quality: 3,
            options: options,
          ),
        ],
      );
      final restored = ExportPreset.fromJson(
        jsonDecode(jsonEncode(preset.toJson())),
      );
      expect(source.fromPreset(restored).single.options, options);
      expect(source.fromPreset(restored).single.page, source.currentPage);
      expect(
        () => source.fromPreset(
          const ExportPreset(areas: [AreaPreset(name: 'Deleted')]),
        ),
        throwsStateError,
      );
    },
  );

  test(
    'invalid settings and an empty selection fail before rendering',
    () async {
      final source = _Source();
      await expectLater(buildExport(source, [], .png), throwsFormatException);
      final item = source.view()
        ..options = const ImageExportOptions(width: double.infinity, height: 5);
      await expectLater(
        buildExport(source, [item], .png),
        throwsFormatException,
      );
      expect(source.rendered, isEmpty);
    },
  );

  test(
    'PDF keeps entry order and physical page sizes, and releases documents',
    () async {
      final source = _Source();
      final engine = _Engine(), pdf = _Pdf();
      final imageDocs = [_Pdf(), _Pdf()];
      final pdfPages = [_Page(), _Page()];
      final original = PdfrxEntryFunctions.instance;
      PdfrxEntryFunctions.instance = engine;
      addTearDown(() => PdfrxEntryFunctions.instance = original);
      when(() => engine.createNew(sourceName: any(named: 'sourceName')))
          .thenAnswer((_) async => pdf);
      var index = 0;
      final sizes = <(double?, double?)>[];
      when(
        () => engine.createFromJpegData(
          any(),
          width: any(named: 'width'),
          height: any(named: 'height'),
          sourceName: any(named: 'sourceName'),
        ),
      ).thenAnswer((call) async {
        sizes.add((
          call.namedArguments[#width] as double?,
          call.namedArguments[#height] as double?,
        ));
        return imageDocs[index++];
      });
      when(() => pdf.encodePdf())
          .thenAnswer((_) async => Uint8List.fromList([37, 80, 68, 70]));
      when(() => pdf.dispose()).thenAnswer((_) async {});
      for (var i = 0; i < imageDocs.length; i++) {
        when(() => imageDocs[i].pages).thenReturn([pdfPages[i]]);
        when(() => imageDocs[i].dispose()).thenAnswer((_) async {});
      }
      final items = [
        source.view(),
        ExportItem(
          'Wide',
          source.currentPage,
          const ImageExportOptions(
            width: 32,
            height: 16,
            quality: 2,
            padding: ExportPadding(left: 4),
          ),
        ),
      ];
      final result = await buildExport(source, items, .pdf);
      expect(result.fileName, 'Field notes.pdf');
      expect(result.bytes, [37, 80, 68, 70]);
      expect(sizes, [(12, 12), (27, 12)]);
      verify(() => pdf.pages = pdfPages).called(1);
      verify(() => pdf.dispose()).called(1);
      for (final doc in imageDocs) {
        verify(() => doc.dispose()).called(1);
      }
    },
  );
}
