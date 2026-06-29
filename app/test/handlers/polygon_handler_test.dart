import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/views/toolbar/polygon.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

Future<void> _settleBlocEvents() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockButterflyFileSystem fileSystem;
  late MockSettingsCubit settingsCubit;
  late EditorController editorController;
  late WindowCubit windowCubit;
  DocumentBloc? bloc;

  setUp(() {
    fileSystem = MockButterflyFileSystem();
    settingsCubit = fileSystem.settingsCubit as MockSettingsCubit;

    when(
      () => settingsCubit.state,
    ).thenReturn(const ButterflySettings(autosave: false));
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());

    editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      const CameraViewport.unbaked(),
    );
    windowCubit = WindowCubit(fullScreen: false);
  });

  tearDown(() async {
    final currentBloc = bloc;
    if (currentBloc != null && !currentBloc.isClosed) {
      await currentBloc.close();
    }
    if (!editorController.isClosed) {
      await editorController.close();
    }
    windowCubit.close();
  });

  test('toolbar changes update edited polygon element', () async {
    const originalProperty = PolygonProperty(
      strokeWidth: 3,
      paint: ElementPaint.solid(color: SRGBColor(0xFF000000)),
    );
    const updatedProperty = PolygonProperty(
      strokeWidth: 9,
      paint: ElementPaint.solid(color: SRGBColor(0xFFFF0000)),
    );
    final element = PolygonElement(
      id: 'polygon',
      points: const [PolygonPoint(0, 0), PolygonPoint(10, 10)],
      property: originalProperty,
    );
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'layer', content: [element]),
      ],
    );
    final (data, pageName) = NoteData(Archive()).setPage(page, 'Page 1');
    bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );
    final handler = PolygonHandler(
      PolygonTool(id: 'polygon-tool', property: originalProperty),
    )..editElement(element);

    final toolbar = handler.getToolbar(bloc!) as PolygonToolbarView;
    toolbar.onToolChanged(toolbar.tool.copyWith(property: updatedProperty));
    await _settleBlocEvents();
    final updatedState = bloc!.stream
        .where((state) => state is DocumentLoadSuccess)
        .cast<DocumentLoadSuccess>()
        .firstWhere(
          (state) =>
              (state.page.content.single as PolygonElement).property ==
              updatedProperty,
        );
    (handler.getToolbar(bloc!) as PolygonToolbarView).onSubmit?.call();
    await updatedState;

    final state = bloc!.state as DocumentLoadSuccess;
    final updatedElement = state.page.content.single as PolygonElement;
    expect(updatedElement.property, updatedProperty);
  });

  test('toolbar changes keep edited polygon visible in foregrounds', () async {
    const originalProperty = PolygonProperty(
      strokeWidth: 3,
      paint: ElementPaint.solid(color: SRGBColor(0xFF000000)),
    );
    const updatedProperty = PolygonProperty(
      strokeWidth: 9,
      paint: ElementPaint.solid(color: SRGBColor(0xFFFF0000)),
    );
    final element = PolygonElement(
      id: 'polygon',
      points: const [PolygonPoint(0, 0), PolygonPoint(10, 10)],
      property: originalProperty,
    );
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'layer', content: [element]),
      ],
    );
    final (data, pageName) = NoteData(Archive()).setPage(page, 'Page 1');
    bloc = DocumentBloc(
      fileSystem,
      currentIndexCubit,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );
    final handler = PolygonHandler(
      PolygonTool(id: 'polygon-tool', property: originalProperty),
    )..editElement(element);
    final toolbar = handler.getToolbar(bloc!) as PolygonToolbarView;
    toolbar.onToolChanged(toolbar.tool.copyWith(property: updatedProperty));
    await _settleBlocEvents();

    final polygon = handler
        .createForegrounds(
          currentIndexCubit,
          (bloc!.state as DocumentLoadSuccess).data,
          (bloc!.state as DocumentLoadSuccess).page,
          (bloc!.state as DocumentLoadSuccess).info,
        )
        .whereType<PolygonRenderer>()
        .single
        .element;
    expect(polygon.property, updatedProperty);
  });
}
