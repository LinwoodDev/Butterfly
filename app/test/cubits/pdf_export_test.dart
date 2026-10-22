import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/services/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Controller extends Mock implements EditorController {}

class _State extends Mock implements DocumentLoaded {}

class _Assets extends Mock implements AssetService {}

class _Engine extends Mock implements PdfrxEntryFunctions {}

class _Document extends Mock implements PdfDocument {}

class _Renderer extends RendererCubit {
  _Renderer(super.settingsCubit, this.image);

  final ui.Image image;
  ImageExportOptions? options;

  @override
  Future<ui.Image?> renderImage(
    EditorController controller,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    ImageExportOptions options, {
    CameraViewport? cameraViewport,
    Set<String>? invisibleLayers,
    DocumentLoaded? docState,
    Future<ui.Image> Function(ui.Picture, int, int)? pictureToImage,
  }) async {
    this.options = options;
    return image;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => registerFallbackValue(Uint8List(0)));

  for (final quality in [1.0, 3.0]) {
    test('A4 exports at its physical size with quality $quality', () async {
      SharedPreferences.setMockInitialValues({});
      final settings = SettingsCubit(await SharedPreferences.getInstance());
      final picture = ui.PictureRecorder();
      ui.Canvas(picture)
          .drawColor(const ui.Color(0xffffffff), ui.BlendMode.src);
      final recording = picture.endRecording();
      final image = await recording.toImage(1, 1);
      recording.dispose();
      final renderer = _Renderer(settings, image);
      final controller = _Controller();
      final state = _State();
      final transform = TransformCubit(2)..size(1.75);
      final area = Area(
        name: 'A4',
        width: AreaSizePreset.a4.width,
        height: AreaSizePreset.a4.height,
        position: const Point(10, 20),
      );
      when(() => controller.transformCubit).thenReturn(transform);
      when(() => state.metadata).thenReturn(
        const FileMetadata(type: NoteFileType.document, name: 'Test'),
      );
      when(() => state.data).thenReturn(DocumentDefaults.createDocument());
      when(() => state.info).thenReturn(const DocumentInfo());
      when(() => state.pageName).thenReturn('default');
      when(() => state.page).thenReturn(DocumentPage(areas: [area]));
      when(() => state.assetService).thenReturn(_Assets());
      when(() => state.invisibleLayers).thenReturn({});

      final originalEngine = PdfrxEntryFunctions.instance;
      final engine = _Engine();
      final pdf = _Document();
      final imagePdf = _Document();
      PdfrxEntryFunctions.instance = engine;
      addTearDown(() async {
        PdfrxEntryFunctions.instance = originalEngine;
        await renderer.close();
        await transform.close();
        await settings.close();
      });
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

      await renderer.renderPDF(
        controller,
        state,
        areas: [AreaPreset(name: 'A4', page: 'default', quality: quality)],
      );

      final created = verify(
        () => engine.createFromJpegData(
          any(),
          width: captureAny(named: 'width'),
          height: captureAny(named: 'height'),
          sourceName: any(named: 'sourceName'),
        ),
      ).captured;
      expect(created[0], closeTo(595.2755905511812, 1e-9));
      expect(created[1], closeTo(841.8897637795276, 1e-9));
      expect(renderer.options!.width, 210);
      expect(renderer.options!.height, 297);
      expect(
        renderer.options!.quality,
        closeTo(quality * 2.834645669291339, 1e-9),
      );
    });
  }
}
