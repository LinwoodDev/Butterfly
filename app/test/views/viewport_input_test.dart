import 'dart:async';
import 'dart:math';

import 'package:archive/archive.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/cursors/label.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/views/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

class _Controller extends Mock implements EditorController {}

class _Settings extends Mock implements SettingsCubit {}

class _Bloc extends Mock implements DocumentBloc {}

class _Loaded extends Mock implements DocumentLoadSuccess {}

class _Renderer extends Mock implements RendererCubit {}

class _Clipboard extends Mock implements ClipboardManager {}

class _TapHandler extends SelectHandler {
  _TapHandler() : super(SelectTool(mode: .lasso));

  final taps = <String>[];

  @override
  void onTapDown(TapDownDetails details, EventContext context) =>
      taps.add('down');

  @override
  void onTapUp(TapUpDetails details, EventContext context) => taps.add('up');
}

void main() {
  late _Settings settings;
  late _Controller controller;
  late _Bloc bloc;
  late _Loaded loaded;
  late _Renderer renderer;
  late ToolCubit tools;
  late EditorInputCubit input;
  late EditorViewCubit view;
  late DocumentSaveCubit save;
  late TransformCubit transform;
  late ChangeNotifier repaint;
  late ButterflyFileSystem fileSystem;

  setUpAll(() {
    registerFallbackValue(Offset.zero);
    registerFallbackValue(ElementsCreated([]));
  });

  setUp(() {
    settings = _Settings();
    controller = _Controller();
    bloc = _Bloc();
    loaded = _Loaded();
    renderer = _Renderer();
    tools = ToolCubit(
      ToolRuntimeState(handler: SelectHandler(SelectTool(mode: .lasso))),
    );
    input = EditorInputCubit(settings);
    view = EditorViewCubit();
    save = DocumentSaveCubit(settings);
    transform = TransformCubit(1);
    repaint = ChangeNotifier();
    fileSystem = MockButterflyFileSystem();
    when(() => controller.inputCubit).thenReturn(input);
    when(() => controller.toolCubit).thenReturn(tools);
    when(() => controller.rendererCubit).thenReturn(renderer);
    when(() => controller.saveCubit).thenReturn(save);
    when(() => controller.settingsCubit).thenReturn(settings);
    when(() => controller.transformCubit).thenReturn(transform);
    when(() => controller.viewCubit).thenReturn(view);
    when(() => controller.isEditingText).thenReturn(false);
    when(() => settings.stream).thenAnswer((_) => const Stream.empty());
    when(() => bloc.state).thenReturn(loaded);
    when(() => bloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => bloc.refresh(allowBake: false)).thenAnswer((_) async {});
    when(() => bloc.refresh()).thenAnswer((_) async {});
    when(() => bloc.refreshForegrounds()).thenAnswer((_) async {});
    when(() => loaded.data).thenReturn(NoteData(Archive()));
    when(() => loaded.page).thenReturn(const DocumentPage());
    when(() => loaded.info).thenReturn(
      DocumentInfo(
        tools: [
          SelectTool(mode: .lasso),
          HandTool(),
        ],
      ),
    );
    when(() => loaded.currentArea).thenReturn(null);
    when(() => loaded.invisibleLayers).thenReturn({});
    when(() => loaded.settingsCubit).thenReturn(settings);
    when(() => renderer.state).thenReturn(
      const RendererRuntimeState(
        cameraViewport: CameraViewport.unbaked(
          width: 800,
          height: 600,
          viewportSize: Size(800, 600),
        ),
      ),
    );
    when(() => renderer.stream).thenAnswer((_) => const Stream.empty());
    when(() => renderer.repaint).thenReturn(repaint);
    when(() => renderer.bake(controller, loaded)).thenAnswer((_) async {});
  });

  tearDown(() async {
    await tools.close();
    await input.close();
    await view.close();
    await save.close();
    await transform.close();
    repaint.dispose();
  });

  Future<void> pumpViewport(
    WidgetTester tester, {
    bool gestures = true,
    bool penOnlyInput = false,
    bool repeatedTap = false,
    double? limitViewportMultiplier,
    bool limitViewportPositive = false,
    InputMapping touch = const InputMapping(InputMapping.handToolValue),
    InputMapping invertedPen = InputMappingDefault.invertedPen,
    bool reserveBottomSystemGestures = false,
  }) async {
    when(() => settings.state).thenReturn(
      ButterflySettings(
        inputGestures: gestures,
        penOnlyInput: penOnlyInput,
        limitViewportMultiplier: limitViewportMultiplier,
        limitViewportPositive: limitViewportPositive,
        flags: ['smoothNavigation'],
        inputConfiguration: InputConfiguration(
          touch: touch,
          invertedPen: invertedPen,
          doubleTouchShortcut: repeatedTap ? 'undo' : null,
        ),
      ),
    );
    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<EditorController>.value(value: controller),
          RepositoryProvider<ClipboardManager>.value(value: _Clipboard()),
          RepositoryProvider<ButterflyFileSystem>.value(value: fileSystem),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SettingsCubit>.value(value: settings),
            BlocProvider<DocumentBloc>.value(value: bloc),
            BlocProvider<TransformCubit>.value(value: transform),
            BlocProvider<ToolCubit>.value(value: tools),
            BlocProvider<EditorInputCubit>.value(value: input),
            BlocProvider<EditorViewCubit>.value(value: view),
            BlocProvider<RendererCubit>.value(value: renderer),
          ],
          child: MaterialApp(
            home: MainViewViewport(
              reserveBottomSystemGestures: reserveBottomSystemGestures,
            ),
          ),
        ),
      ),
    );
  }

  void usePen() {
    tools.replace(ToolRuntimeState(handler: PenHandler(PenTool())));
    when(() => bloc.isInBounds(any())).thenReturn(true);
    when(() => bloc.delayedRefreshForegrounds()).thenAnswer((_) async {});
    when(() => loaded.currentCollection).thenReturn('');
    when(() => loaded.pageName).thenReturn('page');
    when(() => loaded.currentLayer).thenReturn('');
  }

  testWidgets('label editing refreshes the foreground and keeps spans merged', (
    tester,
  ) async {
    final handler = LabelHandler(
      LabelTool(
        styleSheet: const NamedItem(name: 'test', item: text.TextStyleSheet()),
      ),
    );
    tools.replace(ToolRuntimeState(handler: handler));
    when(() => loaded.currentCollection).thenReturn('');
    when(() => loaded.pageName).thenReturn('page');
    when(() => loaded.currentLayer).thenReturn('');
    when(() => bloc.refreshToolbar()).thenAnswer((_) async {});
    when(() => bloc.delayedRefreshForegrounds()).thenAnswer((_) async {});
    when(() => bloc.delayedBake()).thenAnswer((_) async {});
    when(() => bloc.rayCast(any(), 0)).thenAnswer((_) async => {});
    await pumpViewport(tester, repeatedTap: true);

    await tester.tapAt(const Offset(200, 200), kind: PointerDeviceKind.mouse);
    await tester.pumpAndSettle();
    expect(handler.isEditingText, isTrue);
    tester.testTextInput.enterText('a');
    tester.testTextInput.enterText('ab');
    await tester.pump();
    expect(handler.currentTextEditingValue.text, 'ab');
    verifyNever(() => bloc.refresh());

    final events = verify(() => bloc.add(captureAny())).captured;
    final created = events[0] as ElementsCreated;
    final changed = events[1] as ElementsChanged;
    final label =
        changed.elements[created.elements.single.id]!.single as TextElement;
    expect(label.area.paragraph.textSpans.single.text, 'ab');

    await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
    expect(handler.currentTextEditingValue.selection.extentOffset, 1);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
    expect(
      handler.currentTextEditingValue.selection,
      const TextSelection(baseOffset: 1, extentOffset: 0),
    );

    final bounds = handler
        .createForegrounds(controller, loaded.data, loaded.page, loaded.info)
        .whereType<LabelSelectionCursor>()
        .single
        .rect!;
    final start = Offset(bounds.left + 1, bounds.center.dy);
    await tester.tapAt(start, kind: PointerDeviceKind.mouse);
    await tester.pumpAndSettle();
    expect(
      handler.currentTextEditingValue.selection,
      const TextSelection.collapsed(offset: 0),
    );

    final drag = await tester.startGesture(
      start,
      kind: PointerDeviceKind.mouse,
    );
    await drag.moveTo(Offset(bounds.right + 30, bounds.center.dy));
    await drag.up();
    await tester.pumpAndSettle();
    expect(
      handler.currentTextEditingValue.selection,
      const TextSelection(baseOffset: 0, extentOffset: 2),
    );

    await tester.sendKeyEvent(LogicalKeyboardKey.home);
    await tester.sendKeyEvent(LogicalKeyboardKey.end);
    expect(
      handler.currentTextEditingValue.selection,
      const TextSelection.collapsed(offset: 2),
    );

    tester.testTextInput.enterText('hello world');
    await tester.pump();
    verify(() => bloc.add(any())).called(1);
    final word = start + const Offset(16, 0);
    for (final kind in [PointerDeviceKind.mouse, PointerDeviceKind.touch]) {
      final first = await tester.createGesture(kind: kind);
      await first.down(word, timeStamp: const Duration(seconds: 1));
      await first.up(timeStamp: const Duration(milliseconds: 1020));
      await tester.pump(const Duration(milliseconds: 80));
      final second = await tester.createGesture(kind: kind);
      await second.down(word, timeStamp: const Duration(milliseconds: 1100));
      await second.up(timeStamp: const Duration(milliseconds: 1120));
      await tester.pumpAndSettle();
      expect(handler.currentTextEditingValue.text, 'hello world');
      expect(
        handler.currentTextEditingValue.selection,
        const TextSelection(baseOffset: 0, extentOffset: 5),
      );
    }

    handler.dispose(bloc);
    verifyNever(() => bloc.add(any()));
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('pending label placement respects a tool change', (tester) async {
    final handler = LabelHandler(
      LabelTool(
        styleSheet: const NamedItem(name: 'test', item: text.TextStyleSheet()),
      ),
    );
    tools.replace(ToolRuntimeState(handler: handler));
    final hitTest = Completer<Set<Renderer<PadElement>>>();
    when(() => bloc.rayCast(any(), 0)).thenAnswer((_) => hitTest.future);
    await pumpViewport(tester);

    await tester.tapAt(const Offset(200, 200), kind: PointerDeviceKind.mouse);
    await tester.pump();
    verify(() => bloc.rayCast(any(), 0)).called(1);
    handler.dispose(bloc);
    tools.replace(ToolRuntimeState(handler: HandHandler()));
    hitTest.complete({});
    await tester.pumpAndSettle();

    expect(handler.isCurrentlyEditing, isFalse);
    expect(tester.testTextInput.hasAnyClients, isFalse);
    verifyNever(() => bloc.add(any()));
  });

  testWidgets('label pointer cursor disappears when the mouse leaves', (
    tester,
  ) async {
    final handler = LabelHandler(LabelTool());
    tools.replace(ToolRuntimeState(handler: handler));
    when(() => bloc.delayedRefreshForegrounds()).thenAnswer((_) async {});
    await pumpViewport(tester);
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: const Offset(100, 100));
    await mouse.moveTo(const Offset(200, 200));
    await tester.pump();

    Iterable<LabelCursor> cursors() => handler
        .createForegrounds(controller, loaded.data, loaded.page, loaded.info)
        .whereType<LabelCursor>();
    expect(cursors(), hasLength(1));

    await mouse.moveTo(const Offset(100, -10));
    await tester.pump();
    expect(cursors(), isEmpty);
    await mouse.removePointer();
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
    'preset activators work without a toolbar entry and restore the active tool',
    (tester) async {
      const location = PackAssetLocation('navigation.bfly', 'hand');
      final system = fileSystem.buildDefaultPackSystem();
      await system.initialize();
      await system.createFile(
        location.namespace,
        NoteData(Archive()).setToolPreset(location.key, HandTool()),
      );
      usePen();
      final active = tools.state.handler;
      await pumpViewport(
        tester,
        invertedPen: const InputMapping.preset(location),
      );
      final inverted = TestPointer(1, PointerDeviceKind.invertedStylus);
      tester.binding.handlePointerEvent(inverted.down(const Offset(200, 200)));
      await tester.pumpAndSettle();
      expect(tools.state.temporaryHandler, isA<HandHandler>());
      expect(tools.state.temporaryIndex, isNull);
      expect(tools.state.handler, same(active));
      tester.binding.handlePointerEvent(inverted.up());
      await tester.pumpAndSettle();
      final stylus = TestPointer(2, PointerDeviceKind.stylus);
      tester.binding.handlePointerEvent(stylus.down(const Offset(200, 200)));
      await tester.pumpAndSettle();
      expect(tools.state.temporaryHandler, isNull);
      expect(tools.getHandler(), same(active));
      tester.binding.handlePointerEvent(stylus.cancel());
      await tester.pumpAndSettle();
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets('a missing preset leaves the active tool usable', (tester) async {
    usePen();
    final active = tools.state.handler;
    await pumpViewport(
      tester,
      invertedPen: const InputMapping.preset(
        PackAssetLocation('missing.bfly', 'eraser'),
      ),
    );
    final pointer = TestPointer(1, PointerDeviceKind.invertedStylus);
    tester.binding.handlePointerEvent(pointer.down(const Offset(200, 200)));
    await tester.pumpAndSettle();
    expect(tools.state.temporaryHandler, isNull);
    expect(tools.getHandler(), same(active));
    tester.binding.handlePointerEvent(pointer.cancel());
    await tester.pumpAndSettle();
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
    'inverted stylus uses the default eraser without a toolbar eraser',
    (tester) async {
      when(
        () => bloc.rayCast(
          any(),
          any(),
          useCollection: false,
          useLayer: false,
          hitElementMode: HitElementMode.touchAnywhere,
        ),
      ).thenAnswer((_) async => <Renderer<PadElement>>{});
      usePen();
      final active = tools.state.handler;
      await pumpViewport(tester);
      final pointer = TestPointer(1, PointerDeviceKind.invertedStylus);
      tester.binding.handlePointerEvent(pointer.down(const Offset(200, 200)));
      await tester.pumpAndSettle();
      expect(tools.state.temporaryHandler, isA<EraserHandler>());
      expect(
        (tools.state.temporaryHandler as EraserHandler).data.mode,
        EraserMode.path,
      );
      expect(tools.state.handler, same(active));
      tester.binding.handlePointerEvent(pointer.up());
      await tester.pumpAndSettle();
      expect(input.state.pointers, isEmpty);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  for (final (touch, gestures, kind) in [
    (
      const InputMapping(InputMapping.handToolValue),
      true,
      PointerDeviceKind.stylus,
    ),
    (InputMappingDefault.touch, true, PointerDeviceKind.stylus),
    (InputMappingDefault.touch, false, PointerDeviceKind.stylus),
    (InputMappingDefault.touch, true, PointerDeviceKind.invertedStylus),
  ]) {
    testWidgets(
      'touch during $kind preserves the stroke (mapping: $touch, gestures: $gestures)',
      (tester) async {
        usePen();
        final handMapping = touch.getCategory() == .handTool;
        await pumpViewport(
          tester,
          gestures: gestures,
          penOnlyInput: !handMapping,
          touch: touch,
          invertedPen: InputMappingDefault.pen,
        );

        final stylus = await tester.startGesture(
          const Offset(200, 200),
          kind: kind,
        );
        await stylus.moveTo(const Offset(250, 210));
        final finger = await tester.startGesture(const Offset(470, 210));
        const contactDuration = Duration(milliseconds: 3);
        await tester.pump(contactDuration);
        await finger.up(timeStamp: contactDuration);
        await stylus.moveTo(const Offset(300, 260));
        await stylus.moveTo(const Offset(350, 240));
        await stylus.up();
        await tester.pump();

        final events = verify(() => bloc.add(captureAny())).captured;
        final stroke =
            (events.whereType<ElementsCreated>().single.elements.single
                as PenElement);
        expect(stroke.points.map((point) => (point.x, point.y)), [
          (200, 200),
          (250, 210),
          (300, 260),
          (350, 240),
        ]);
        expect(transform.state.position, Offset.zero);
        expect(input.state.pointers, isEmpty);
        await tester.pumpWidget(const SizedBox.shrink());
      },
    );
  }

  for (final cancel in [false, true]) {
    testWidgets(
      'only a new touch can pan after stylus release (cancel: $cancel)',
      (tester) async {
        final handler = _TapHandler();
        tools.replace(ToolRuntimeState(handler: handler));
        await pumpViewport(tester);
        final stylus = TestPointer(1, .stylus);
        final finger = TestPointer(2);
        final send = tester.binding.handlePointerEvent;
        send(stylus.down(const Offset(200, 200)));
        send(finger.down(const Offset(450, 200)));
        await tester.pump();
        expect(input.state.pointers, [1]);

        send(cancel ? const PointerCancelEvent(pointer: 1) : stylus.up());
        send(finger.move(const Offset(530, 200)));
        send(finger.up());
        await tester.pump();
        expect(input.state.pointers, isEmpty);
        expect(transform.state.position, Offset.zero);
        expect(handler.taps, cancel ? isEmpty : ['down', 'up']);

        await tester.timedDragFrom(
          const Offset(200, 200),
          const Offset(80, 0),
          const Duration(milliseconds: 100),
        );
        await tester.pump();
        expect(transform.state.position.dx, lessThan(0));
        await tester.pumpWidget(const SizedBox.shrink());
      },
    );
  }

  testWidgets('the bottom system gesture region can be reserved for touch', (
    tester,
  ) async {
    tester.view.systemGestureInsets = FakeViewPadding(
      bottom: 24 * tester.view.devicePixelRatio,
    );
    addTearDown(tester.view.resetSystemGestureInsets);
    usePen();
    await pumpViewport(
      tester,
      reserveBottomSystemGestures: true,
      touch: InputMappingDefault.touch,
    );

    const edge = Offset(250, 595);
    const swipe = Offset(0, -145);
    await tester.dragFrom(edge, swipe);
    await tester.pump();
    verifyNever(() => bloc.add(any()));

    const intoEdge = Offset(0, 30);
    await tester.dragFrom(edge - intoEdge, intoEdge);
    await tester.pump();
    verify(() => bloc.add(any())).called(1);

    await tester.dragFrom(edge, swipe, kind: .stylus);
    await tester.pump();
    verify(() => bloc.add(any())).called(1);
    expect(input.state.pointers, isEmpty);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  for (final positive in [false, true]) {
    testWidgets('touch panning reaches rotated content (positive: $positive)', (
      tester,
    ) async {
      final shape = ShapeRenderer(
        ShapeElement(
          firstPosition: const Point(0, 0),
          secondPosition: const Point(100, 100),
        ),
      );
      when(() => renderer.renderers).thenReturn([shape]);
      await pumpViewport(
        tester,
        limitViewportMultiplier: positive ? null : 1,
        limitViewportPositive: positive,
      );
      const size = Size(800, 600);
      if (!positive) {
        transform.teleport(shape.rect.center - size.center(Offset.zero));
      }
      transform.rotate(
        positive ? -3 * pi / 4 : 3 * pi / 4,
        size.center(Offset.zero),
      );
      final delta = positive
          ? -transform.state.globalToLocal(
              transform.state.position + const Offset(-1000, -1000),
            )
          : const Offset(40, 0);
      final gesture = await tester.startGesture(const Offset(200, 200));
      await gesture.moveBy(delta);
      await gesture.moveBy(delta);
      await tester.pump();

      final screen = (Offset.zero & size).inflate(1e-7);
      for (final corner in [
        shape.rect.topLeft,
        shape.rect.topRight,
        shape.rect.bottomLeft,
        shape.rect.bottomRight,
      ]) {
        expect(screen.contains(transform.state.globalToLocal(corner)), isTrue);
      }
      if (positive) {
        final atLimit = transform.state.position;
        await gesture.moveBy(delta);
        await tester.pump();
        expect(transform.state.position, atLimit);
      }

      await gesture.cancel();
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }

  for (final kind in [PointerDeviceKind.touch, PointerDeviceKind.mouse]) {
    testWidgets(
      'hand mapping still pans when input gestures are disabled ($kind)',
      (tester) async {
        await pumpViewport(tester, gestures: false);
        final gesture = await tester.startGesture(
          const Offset(200, 200),
          kind: kind,
          buttons: kind == PointerDeviceKind.mouse
              ? kMiddleMouseButton
              : kPrimaryButton,
        );
        await tester.pump();
        await gesture.moveBy(const Offset(40, 0));
        await tester.pump();
        await gesture.moveBy(const Offset(40, 0));
        await tester.pump();
        expect(transform.state.position.dx, lessThan(0));
        await gesture.cancel();
        await tester.pumpWidget(const SizedBox.shrink());
      },
    );
  }

  testWidgets('selected hand tool pans when input gestures are disabled', (
    tester,
  ) async {
    tools.replace(ToolRuntimeState(handler: HandHandler()));
    await pumpViewport(
      tester,
      gestures: false,
      touch: InputMappingDefault.touch,
    );
    final gesture = await tester.startGesture(const Offset(200, 200));
    await gesture.moveBy(const Offset(40, 0));
    await gesture.moveBy(const Offset(40, 0));
    expect(transform.state.position.dx, lessThan(0));
    await gesture.cancel();
    await tester.pumpWidget(const SizedBox.shrink());
  });

  for (final toolbarMapping in [false, true]) {
    for (final repeatedTap in [false, true]) {
      testWidgets(
        'batched touch events use the hand mapping before starting a gesture (toolbar: $toolbarMapping, repeated tap: $repeatedTap)',
        (tester) async {
          await pumpViewport(
            tester,
            touch: InputMapping(
              toolbarMapping ? 1 : InputMapping.handToolValue,
            ),
            repeatedTap: repeatedTap,
          );
          // Platform events may arrive together before asynchronous callbacks resume.
          final pointer = TestPointer(1, PointerDeviceKind.touch);
          tester.binding.handlePointerEvent(
            pointer.down(const Offset(200, 200)),
          );
          tester.binding.handlePointerEvent(
            pointer.move(const Offset(240, 200)),
          );
          await tester.pump();
          tester.binding.handlePointerEvent(
            pointer.move(const Offset(280, 200)),
          );
          await tester.pump();
          expect(tools.getHandler(), isA<HandHandler>());
          expect(transform.state.position.dx, lessThan(0));
          verifyNever(() => bloc.refresh());
          tester.binding.handlePointerEvent(pointer.cancel());
          await tester.pumpWidget(const SizedBox.shrink());
        },
      );
    }
  }

  testWidgets(
    'temporary hand finishes its gesture after the previous tool is restored',
    (tester) async {
      await pumpViewport(tester);
      final pointer = TestPointer(1, PointerDeviceKind.touch);
      tester.binding.handlePointerEvent(pointer.down(const Offset(200, 200)));
      tester.binding.handlePointerEvent(pointer.move(const Offset(240, 200)));
      tester.binding.handlePointerEvent(pointer.move(const Offset(280, 200)));
      tester.binding.handlePointerEvent(pointer.up());
      await tester.pump();
      expect(tools.getHandler(), isA<SelectHandler>());
      expect(input.state.pointers, isEmpty);
      expect(transform.state.position.dx, lessThan(0));
      verify(() => bloc.updateCursor(SystemMouseCursors.grab)).called(1);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  for (final cancel in [false, true]) {
    testWidgets(
      'pending tool change preserves gestures and pointer release (cancel: $cancel)',
      (tester) async {
        final bake = Completer<void>();
        when(() => renderer.bake(controller, loaded))
            .thenAnswer((_) => bake.future);
        await pumpViewport(tester, touch: const InputMapping(1));
        final pointer = TestPointer(1, PointerDeviceKind.touch);
        tester.binding.handlePointerEvent(pointer.down(const Offset(200, 200)));
        tester.binding.handlePointerEvent(pointer.move(const Offset(240, 200)));
        tester.binding.handlePointerEvent(pointer.move(const Offset(280, 200)));
        await tester.pump();
        expect(transform.state.position, Offset.zero);
        verifyNever(() => bloc.refresh());

        tester.binding.handlePointerEvent(
          cancel ? pointer.cancel() : pointer.up(),
        );
        bake.complete();
        await tester.pump();
        expect(transform.state.position.dx, lessThan(0));
        expect(input.state.pointers, isEmpty);
        verifyNever(() => bloc.refresh());
        await tester.pumpWidget(const SizedBox.shrink());
      },
    );
  }

  testWidgets('multiple fingers wait for queued tool changes', (tester) async {
    final bake = Completer<void>();
    when(() => renderer.bake(controller, loaded))
        .thenAnswer((_) => bake.future);
    await pumpViewport(tester, touch: const InputMapping(1));
    final first = TestPointer(1, PointerDeviceKind.touch);
    final second = TestPointer(2, PointerDeviceKind.touch);
    tester.binding.handlePointerEvent(first.down(const Offset(200, 200)));
    tester.binding.handlePointerEvent(second.down(const Offset(400, 200)));
    tester.binding.handlePointerEvent(first.move(const Offset(240, 200)));
    tester.binding.handlePointerEvent(second.move(const Offset(440, 200)));
    await tester.pump();
    expect(transform.state.position, Offset.zero);
    verifyNever(() => bloc.refresh());

    bake.complete();
    await tester.pump();
    final afterToolChange = transform.state.position;
    tester.binding.handlePointerEvent(first.move(const Offset(280, 200)));
    tester.binding.handlePointerEvent(second.move(const Offset(480, 200)));
    await tester.pump();
    expect(transform.state.position.dx, lessThan(afterToolChange.dx));
    verifyNever(() => bloc.refresh());
    tester.binding.handlePointerEvent(first.cancel());
    tester.binding.handlePointerEvent(second.cancel());
    await tester.pump();
    expect(input.state.pointers, isEmpty);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
    'tap waits for the mapped tool instead of reaching the previous selector',
    (tester) async {
      final previous = _TapHandler();
      tools.replace(ToolRuntimeState(handler: previous));
      final bake = Completer<void>();
      when(() => renderer.bake(controller, loaded))
          .thenAnswer((_) => bake.future);
      await pumpViewport(tester, touch: const InputMapping(1));
      final pointer = TestPointer(1, PointerDeviceKind.touch);
      tester.binding.handlePointerEvent(pointer.down(const Offset(200, 200)));
      tester.binding.handlePointerEvent(pointer.up());
      await tester.pump();
      expect(previous.taps, isEmpty);
      bake.complete();
      await tester.pump();
      expect(previous.taps, isEmpty);
      expect(input.state.pointers, isEmpty);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets('pending input is discarded when the viewport is disposed', (
    tester,
  ) async {
    final bake = Completer<void>();
    when(() => renderer.bake(controller, loaded))
        .thenAnswer((_) => bake.future);
    await pumpViewport(tester, touch: const InputMapping(1));
    final pointer = TestPointer(1, PointerDeviceKind.touch);
    tester.binding.handlePointerEvent(pointer.down(const Offset(200, 200)));
    tester.binding.handlePointerEvent(pointer.move(const Offset(240, 200)));
    await tester.pump();
    await tester.pumpWidget(const SizedBox.shrink());
    bake.complete();
    await tester.pump();
    expect(transform.state.position, Offset.zero);
    verifyNever(() => bloc.refresh());
    expect(tester.takeException(), isNull);
  });
}
