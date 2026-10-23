import 'dart:convert';
import 'dart:math';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as image;
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:lw_sysapi/lw_sysapi.dart';

import '../helpers/mocks.dart';

class _Bloc extends Mock implements DocumentBloc {}

class _State extends Mock implements DocumentLoadSuccess {}

class _Controller extends Mock implements EditorController {}

class _RendererCubit extends Mock implements RendererCubit {}

class _RecordingBloc extends Mock implements DocumentBloc {
  final events = <DocumentEvent>[];

  @override
  void add(DocumentEvent event) => events.add(event);
}

void main() {
  final document = DocumentDefaults.createDocument();
  final images = [
    image.encodePng(image.Image(width: 20, height: 30)),
    image.encodePng(image.Image(width: 40, height: 10)),
  ];
  final imageFiles = images.map((bytes) => (AssetFileType.image, bytes, null));

  Future<BuildContext> mount(WidgetTester tester) async {
    late BuildContext context;
    final settings = MockSettingsCubit();
    when(() => settings.state).thenReturn(const ButterflySettings());
    when(() => settings.stream).thenAnswer((_) => const Stream.empty());
    await tester.pumpWidget(
      BlocProvider<SettingsCubit>.value(
        value: settings,
        child: MaterialApp(
          home: Builder(
            builder: (value) {
              context = value;
              return const Scaffold();
            },
          ),
        ),
      ),
    );
    return context;
  }

  testWidgets('named imports preserve order, placement, and saved assets', (
    tester,
  ) async {
    const position = Offset(50, 80);
    final service = ImportService(await mount(tester));
    final errors = <Object>[];
    final result = await tester.runAsync(
      () => service.importContents(
        [
          (
            name: 'one.png',
            content: (type: ClipboardMimeTypes.png, data: images.first),
          ),
          (
            name: 'not-an-image.jpg',
            content: (
              type: ClipboardMimeTypes.html,
              data: utf8.encode('<html>Page</html>'),
            ),
          ),
          (
            name: 'two.png',
            content: (type: 'application/octet-stream', data: images.last),
          ),
        ],
        document: document,
        position: position,
        onError: errors.add,
      ),
    );
    expect(errors, hasLength(1));
    expect(result, isNotNull);
    expect(result!.choosePosition, isFalse);
    final elements = result.elements.cast<ImageElement>();
    expect(elements.map((e) => e.width), [20, 40]);
    expect(elements.map((e) => e.height), [30, 10]);
    expect(elements.first.position, const Point(50, 80));
    expect(elements.last.position, const Point(50, 110));
    expect(elements.first.source, isNot(elements.last.source));

    final exported = await tester.runAsync(result.export);
    final saved = exported!.getPage()!.content.cast<ImageElement>();
    expect(saved.length, 2);
    for (var i = 0; i < saved.length; i++) {
      final decoded = image.decodePng(exported.getAsset(saved[i].source)!)!;
      expect(decoded.width, elements[i].width);
      expect(decoded.height, elements[i].height);
      expect(saved[i].position, elements[i].position);
    }
  });

  testWidgets('a delayed drop submits to its original page and layer', (
    tester,
  ) async {
    final bloc = _RecordingBloc();
    final state = _State();
    when(() => bloc.state).thenReturn(state);
    when(() => state.pageName).thenReturn('page-after-navigation');
    when(() => state.currentLayer).thenReturn('layer-after-navigation');
    final service = ImportService(await mount(tester), bloc: bloc);
    ImportResult(
      service: service,
      document: document,
      elements: [ImageElement(source: '', width: 20, height: 30)],
      areas: [
        Area(name: 'drop', width: 20, height: 30, position: const Point(0, 0)),
      ],
    ).submit(pageName: 'drop-page', layer: 'drop-layer');

    final created = bloc.events.whereType<ElementsCreated>().single;
    expect(created.pageName, 'drop-page');
    expect(created.layer, 'drop-layer');
    final area = bloc.events.whereType<AreasCreated>().single.areas.single;
    expect(area.page, 'drop-page');
  });

  testWidgets('image group spacing uses the scaled height', (tester) async {
    final bloc = _Bloc();
    final state = _State();
    final controller = _Controller();
    final rendererCubit = _RendererCubit();
    when(() => bloc.state).thenReturn(state);
    when(() => bloc.editorController).thenReturn(controller);
    when(() => state.currentCollection).thenReturn('photos');
    when(() => controller.rendererCubit).thenReturn(rendererCubit);
    when(() => rendererCubit.state).thenReturn(
      RendererRuntimeState(cameraViewport: CameraViewport.unbaked(scale: 2)),
    );
    final service = ImportService(await mount(tester), bloc: bloc);
    final result = await tester.runAsync(
      () => service.importBatch(imageFiles, document: document),
    );
    expect(result!.choosePosition, isTrue);
    final elements = result.elements.cast<ImageElement>();
    expect(elements.first.constraints, isA<ScaledElementConstraints>());
    expect(ImageRenderer(elements.first).rect.height, 15);
    expect(elements.last.position, const Point(0, 15));
    expect(elements.map((e) => e.collection), ['photos', 'photos']);
  });

  testWidgets('mixed visual files share one batch in selection order', (
    tester,
  ) async {
    final service = ImportService(await mount(tester));
    final svg = utf8.encode(
      '<svg xmlns="http://www.w3.org/2000/svg" width="8" height="5">'
      '<rect width="8" height="5" fill="red"/></svg>',
    );
    final result = await tester.runAsync(
      () => service.importBatch([
        (AssetFileType.image, images.first, 'first'),
        (AssetFileType.svg, svg, 'drawing'),
        (AssetFileType.image, images.last, 'second'),
      ], document: document),
    );
    expect(result!.elements, [
      isA<ImageElement>(),
      isA<SvgElement>(),
      isA<ImageElement>(),
    ]);
    expect(result.elements.map((e) => Renderer.fromInstance(e).rect!.top), [
      0,
      30,
      35,
    ]);
    expect(result.choosePosition, isTrue);
    final exported = await tester.runAsync(result.export);
    expect(exported!.getPage()!.content.length, 3);
  });

  testWidgets('note and image batch retains archived page assets', (
    tester,
  ) async {
    var note = DocumentDefaults.createDocument();
    String source;
    (note, source) = note.importImage(images.first, 'png');
    note = note
        .setPage(
          note.getPage()!.copyWith(
            layers: [
              DocumentLayer(
                id: createUniqueId(),
                content: [ImageElement(source: source, width: 20, height: 30)],
              ),
            ],
          ),
        )
        .$1;
    final service = ImportService(await mount(tester));
    final result = await tester.runAsync(
      () => service.importContents(
        [
          (
            name: null,
            content: (
              type: 'application/octet-stream',
              data: note.exportAsBytes(),
            ),
          ),
          (
            name: 'image.png',
            content: (type: ClipboardMimeTypes.png, data: images.last),
          ),
        ],
        document: document,
        advanced: false,
      ),
    );
    expect(result!.pages.length, note.getPages(true).length);
    expect(result.elements.single, isA<ImageElement>());
    expect(result.assets[source], images.first);
    expect(result.choosePosition, isTrue);
    final exported = await tester.runAsync(result.export);
    expect(exported!.getAsset(source), images.first);
    expect(
      exported.getPages(true).length,
      document.getPages(true).length + note.getPages(true).length,
    );
  });
}
