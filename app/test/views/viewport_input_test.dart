import 'dart:async';

import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/views/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

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
    bool repeatedTap = false,
    InputMapping touch = const InputMapping(InputMapping.handToolValue),
  }) async {
    when(() => settings.state).thenReturn(
      ButterflySettings(
        inputGestures: gestures,
        penOnlyInput: false,
        flags: ['smoothNavigation'],
        inputConfiguration: InputConfiguration(
          touch: touch,
          doubleTouchShortcut: repeatedTap ? 'undo' : null,
        ),
      ),
    );
    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<EditorController>.value(value: controller),
          RepositoryProvider<ClipboardManager>.value(value: _Clipboard()),
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
          child: MaterialApp(home: const MainViewViewport()),
        ),
      ),
    );
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
