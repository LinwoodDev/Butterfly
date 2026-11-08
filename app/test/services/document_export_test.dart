import 'dart:math';

import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/services/asset.dart';
import 'package:butterfly/services/batch_export.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

class _Bloc extends Mock implements DocumentBloc {}

DocumentPage _page(int color, {double width = 20}) => DocumentPage(
  layers: [
    DocumentLayer(
      id: 'layer',
      content: [
        ShapeElement(
          id: 'shape',
          firstPosition: const Point(0, 0),
          secondPosition: Point(width, 20),
          property: ShapeProperty(
            strokeWidth: 0,
            shape: RectangleShape(
              fillPaint: ElementPaint.solid(color: SRGBColor(color)),
            ),
          ),
        ),
      ],
    ),
  ],
  areas: [
    Area(name: 'Region', width: width, height: 20, position: const Point(0, 0)),
  ],
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('batch scopes use unsaved active content and render other pages without navigation', () async {
    final fileSystem = MockButterflyFileSystem();
    final settings = fileSystem.settingsCubit as MockSettingsCubit;
    when(() => settings.state)
        .thenReturn(const ButterflySettings(autosave: false));
    when(() => settings.stream).thenAnswer((_) => const Stream.empty());
    final window = WindowCubit(fullScreen: false),
        transform = TransformCubit(1);
    final assets = AssetService();
    final (first, currentId) = NoteData(Archive())
        .setPage(_page(0xffff0000), 'Studies');
    final (document, otherId) = first.setPage(_page(0xff0000ff), 'Cover');
    final active = _page(0xff00ff00, width: 40);
    final viewport = await CameraViewport.build(
      transform,
      document,
      assets,
      active,
    );
    final controller = EditorController(settings, transform, viewport);
    final bloc = _Bloc();
    final state = DocumentLoadSuccess(
      document,
      fileSystem: fileSystem,
      windowCubit: window,
      page: active,
      pageName: currentId,
      assetService: assets,
      metadata: const FileMetadata(type: NoteFileType.document, name: 'Notes'),
    );
    when(() => bloc.editorController).thenReturn(controller);
    when(() => bloc.state).thenReturn(state);
    addTearDown(() async {
      await controller.close();
      await window.close();
      await assets.dispose();
    });
    final source = DocumentExportSource(
      bloc,
      state,
      const ImageExportOptions(width: 100, height: 100),
    );
    final allPages = await source.items(.allPages);
    expect(allPages.map((e) => e.page), [currentId, otherId]);
    expect(allPages.map((e) => e.options.width), [40, 20]);
    expect((await source.items(.allAreas)).map((e) => e.options.width), [
      40,
      20,
    ]);
    expect((await source.items(.pageAreas)).single.page, currentId);

    final activePng = img.decodePng((await source.renderPng(allPages.first))!)!;
    expect(activePng.getPixel(10, 10).g, 255);
    expect(activePng.getPixel(10, 10).r, 0);
    final otherPng = img.decodePng((await source.renderPng(allPages.last))!)!;
    expect(otherPng.getPixel(10, 10).b, 255);
    expect(otherPng.getPixel(10, 10).g, 0);
    final svg = await source.renderSvg(allPages.last);
    expect(svg, contains('#0000ff'));
    expect(svg, isNot(contains('#00ff00')));
    expect(controller.rendererCubit.state.cameraViewport, same(viewport));
    expect(bloc.state, same(state));
    expect(controller.transformCubit.state.position, Offset.zero);
  });
}
