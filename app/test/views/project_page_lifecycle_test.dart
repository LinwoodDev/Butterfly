import 'dart:math';

import 'package:butterfly/actions/shortcuts.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/embed/embedding.dart';
import 'package:butterfly/embed/view_state.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly/services/font.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly/views/app_bar.dart';
import 'package:butterfly/views/main.dart';
import 'package:butterfly/views/navigator/view.dart';
import 'package:butterfly/views/view.dart';
import 'package:butterfly/views/zoom.dart';
import 'package:butterfly/widgets/document_page_preview.dart';
import 'package:butterfly/widgets/context_menu.dart';
import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/mocks.dart';

class _ReleaseTrackingHandler extends Handler<HandTool> {
  bool pointerUpCalled = false;

  _ReleaseTrackingHandler() : super(HandTool());

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    pointerUpCalled = true;
  }
}

void main() {
  late List<MethodCall> windowManagerCalls;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(AssetLocation.empty);
    SharedPreferences.setMockInitialValues({});
    await keybinder.ready;
    FlutterSecureStorage.setMockInitialValues({});
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('window_manager'), (
          call,
        ) async {
          windowManagerCalls.add(call);
          return switch (call.method) {
            'isMaximized' ||
            'isMinimized' ||
            'isFullScreen' ||
            'isPreventClose' ||
            'isAlwaysOnTop' ||
            'isSkipTaskbar' => false,
            _ => null,
          };
        });
  });

  late MockSettingsCubit settingsCubit;
  late MockButterflyFileSystem fileSystem;
  late WindowCubit windowCubit;
  late GoRouter router;
  late _LifecycleObserver observer;
  late BlocObserver previousObserver;

  setUp(() {
    windowManagerCalls = [];
    settingsCubit = MockSettingsCubit();
    fileSystem = MockButterflyFileSystem(settingsCubit: settingsCubit);
    windowCubit = WindowCubit(fullScreen: false);
    observer = _LifecycleObserver();
    previousObserver = Bloc.observer;
    Bloc.observer = observer;

    when(() => settingsCubit.state)
        .thenReturn(const ButterflySettings(defaultTemplate: 'default'));
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => settingsCubit.getRemote(any())).thenReturn(null);
    when(() => settingsCubit.addRecentHistory(any())).thenAnswer((_) async {});
  });

  tearDown(() async {
    Bloc.observer = previousObserver;
    router.dispose();
    await windowCubit.close();
  });

  Future<void> pumpUntil(
    WidgetTester tester,
    bool Function() condition,
    String description,
  ) async {
    for (var i = 0; i < 60; i++) {
      await tester.pump(const Duration(milliseconds: 16));
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 1)),
      );
      if (condition()) return;
    }
    final exception = tester.takeException();
    fail(
      'Timed out waiting for $description '
      '(ProjectPage: ${find.byType(ProjectPage).evaluate().length}, '
      'all ProjectPage: '
      '${find.byType(ProjectPage, skipOffstage: false).evaluate().length}, '
      'Progress: ${find.byType(CircularProgressIndicator).evaluate().length}, '
      'Scaffold: ${find.byType(Scaffold).evaluate().length}, '
      'DocumentBloc create/close: '
      '${observer.documentBlocCreates}/${observer.documentBlocCloses}, '
      'events: ${observer.events}, '
      'exception: $exception)',
    );
  }

  Widget buildApp({
    NoteData? embedDocument,
    String embedFileName = '',
    EmbedFullScreen embedFullScreen = EmbedFullScreen.enabled,
    Object? importData,
    bool readLocalFile = false,
  }) {
    final document =
        embedDocument ??
        DocumentDefaults.createDocument(
          name: 'Lifecycle test',
          page: const DocumentPage(backgrounds: []),
        );
    fileSystem.buildTemplateSystem().updateFile('default', document);
    router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: Center(
              child: TextButton(
                key: const ValueKey('open-document'),
                onPressed: () => openFile(
                  context,
                  true,
                  AssetLocation.local('lifecycle.bfly'),
                  document,
                ),
                child: const Text('Open'),
              ),
            ),
          ),
          routes: [
            GoRoute(
              name: 'local',
              path: 'local/:path(.*)',
              builder: (context, state) {
                final path = state.pathParameters['path'] ?? '';
                return ProjectPage(
                  data: readLocalFile ? null : state.extra ?? document,
                  location: AssetLocation.local(path),
                );
              },
            ),
            GoRoute(
              name: 'new',
              path: 'new',
              builder: (context, state) => ProjectPage(
                data: state.extra ?? document,
                isNewDocument: true,
                initialDirectory: state.uri.queryParameters['directory'],
                location: AssetLocation.local(
                  state.uri.queryParameters['path'] ?? '',
                ),
              ),
            ),
            GoRoute(
              path: 'import',
              builder: (context, state) =>
                  ProjectPage(data: importData ?? document),
            ),
            GoRoute(
              name: 'native',
              path: 'native',
              builder: (context, state) => ProjectPage(
                location: AssetLocation.local(
                  state.uri.queryParameters['path']!,
                ),
                absolute: true,
              ),
            ),
            GoRoute(
              path: 'embed',
              builder: (context, state) => ProjectPage(
                data: state.extra ?? document.toFile(),
                embedding: Embedding(
                  internal: true,
                  fileName: embedFileName,
                  fullScreen: embedFullScreen,
                ),
              ),
            ),
          ],
        ),
      ],
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ButterflyFileSystem>.value(value: fileSystem),
        RepositoryProvider<FontService>(
          create: (context) => FontService(fileSystem),
        ),
        RepositoryProvider<ClipboardManager>.value(
          value: UnsupportedClipboardManager(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsCubit>.value(value: settingsCubit),
          BlocProvider<WindowCubit>.value(value: windowCubit),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            LeapLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }

  Future<EditorController> openEditor(WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    await tester.tap(find.byKey(const ValueKey('open-document')));
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'document open',
    );
    await tester.pumpAndSettle();
    return observer.lastDocumentBloc!.editorController;
  }

  Finder cameraButton(String tooltip) => find.descendant(
    of: find.byType(ZoomView),
    matching: find.byWidgetPredicate(
      (widget) =>
          widget is IconButton &&
          (widget.tooltip == tooltip ||
              (widget.icon is Tooltip &&
                  (widget.icon as Tooltip).message == tooltip)),
    ),
  );

  Finder cameraField(String label) => find.descendant(
    of: find.byKey(
      ValueKey(label == 'Zoom' ? 'camera-zoom' : 'camera-rotation'),
    ),
    matching: find.byType(TextField),
  );

  testWidgets(
    'zoom panel steps, limits and reset keep the canvas center fixed',
    (tester) async {
      when(() => settingsCubit.state).thenReturn(
        const ButterflySettings(defaultTemplate: 'default', zoomStep: 0.1),
      );
      final editor = await openEditor(tester);
      final center = tester
          .getSize(find.byType(MainViewViewport))
          .center(Offset.zero);
      final documentCenter = editor.transformCubit.state.localToGlobal(center);
      expect(
        tester.widget<IconButton>(cameraButton('Reset zoom')).onPressed,
        isNull,
      );
      await tester.tap(cameraButton('Zoom in'));
      await tester.pumpAndSettle();
      expect(editor.transformCubit.state.size, closeTo(1.1, 1e-9));
      expect(
        editor.transformCubit.state.localToGlobal(center).dx,
        closeTo(documentCenter.dx, 1e-6),
      );
      expect(
        editor.transformCubit.state.localToGlobal(center).dy,
        closeTo(documentCenter.dy, 1e-6),
      );
      await tester.tap(cameraButton('Zoom out'));
      await tester.pumpAndSettle();
      expect(editor.transformCubit.state.size, closeTo(1, 1e-9));
      editor.transformCubit.size(10);
      await tester.pumpAndSettle();
      expect(
        tester.widget<IconButton>(cameraButton('Zoom in')).onPressed,
        isNull,
      );
      await tester.tap(cameraButton('Reset zoom'));
      await tester.pumpAndSettle();
      expect(editor.transformCubit.state.size, 1);
      editor.transformCubit.size(0.1);
      await tester.pumpAndSettle();
      expect(
        tester.widget<IconButton>(cameraButton('Zoom out')).onPressed,
        isNull,
      );
    },
  );

  testWidgets(
    'zoom input supports Ctrl+A, partial input and finite clamped values',
    (tester) async {
      final editor = await openEditor(tester);
      final field = cameraField('Zoom');
      await tester.tap(field);
      await tester.pump();
      await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
      await tester.sendKeyEvent(LogicalKeyboardKey.keyA);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
      await tester.pump();
      final controller = tester.widget<TextField>(field).controller!;
      expect(controller.selection.start, 0);
      expect(controller.selection.end, controller.text.length);
      await tester.enterText(field, '');
      await tester.pump();
      expect(controller.text, '');
      editor.transformCubit.rotate(0.3);
      await tester.pump();
      expect(controller.text, '');
      await tester.enterText(field, '125,5');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(editor.transformCubit.state.size, 1.255);
      await tester.enterText(field, 'NaN');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(editor.transformCubit.state.size, 1.255);
      await tester.enterText(field, '9999');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(editor.transformCubit.state.size, 1.255);
      expect(tester.widget<TextField>(field).decoration?.errorText, isNotNull);
      await tester.enterText(field, '1000');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(editor.transformCubit.state.size, 10);
      expect(controller.text, '1000.0');
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'rotation row follows camera state, edits angles and resets independently',
    (tester) async {
      final editor = await openEditor(tester);
      expect(cameraField('Rotation'), findsNothing);
      editor.transformCubit.rotate(16 * pi / 180);
      await tester.pumpAndSettle();
      expect(
        tester.widget<TextField>(cameraField('Rotation')).controller!.text,
        '16.0',
      );
      final center = tester
          .getSize(find.byType(MainViewViewport))
          .center(Offset.zero);
      final documentCenter = editor.transformCubit.state.localToGlobal(center);
      await tester.tap(cameraButton('Rotate right'));
      await tester.pumpAndSettle();
      expect(
        editor.transformCubit.state.rotation,
        closeTo((16 + settingsCubit.state.rotationStep) * pi / 180, 1e-6),
      );
      await tester.enterText(cameraField('Rotation'), '-');
      await tester.pump();
      expect(
        tester.widget<TextField>(cameraField('Rotation')).controller!.text,
        '-',
      );
      await tester.enterText(cameraField('Rotation'), '-45');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(editor.transformCubit.state.rotation, closeTo(-pi / 4, 1e-6));
      editor.transformCubit.size(2, center);
      await tester.pumpAndSettle();
      await tester.tap(cameraButton('Reset zoom'));
      await tester.pumpAndSettle();
      expect(editor.transformCubit.state.rotation, closeTo(-pi / 4, 1e-6));
      await tester.tap(cameraButton('Reset rotation'));
      await tester.pumpAndSettle();
      expect(editor.transformCubit.state.rotation, closeTo(0, 1e-6));
      expect(editor.transformCubit.state.size, 1);
      expect(
        (editor.transformCubit.state.localToGlobal(center) - documentCenter)
            .distance,
        lessThan(1e-6),
      );
      expect(cameraField('Rotation'), findsNothing);
    },
  );

  testWidgets(
    'camera numbers round for display without rounding the transform',
    (tester) async {
      final editor = await openEditor(tester);
      editor.transformCubit.size(1.23456789);
      editor.transformCubit.rotate(12.3456789 * pi / 180);
      await tester.pumpAndSettle();
      expect(
        tester.widget<TextField>(cameraField('Zoom')).controller!.text,
        '123.5',
      );
      expect(
        tester.widget<TextField>(cameraField('Rotation')).controller!.text,
        '12.3',
      );
      expect(editor.transformCubit.state.size, closeTo(1.23456789, 1e-9));
      expect(
        editor.transformCubit.state.rotation,
        closeTo(12.3456789 * pi / 180, 1e-9),
      );
      await tester.enterText(cameraField('Zoom'), '125.4567');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(
        tester.widget<TextField>(cameraField('Zoom')).controller!.text,
        '125.5',
      );
      expect(editor.transformCubit.state.size, closeTo(1.254567, 1e-9));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'camera sliders change zoom and rotation and reset independently',
    (tester) async {
      when(() => settingsCubit.state).thenReturn(
        const ButterflySettings(
          defaultTemplate: 'default',
          zoomPanelControls: ZoomPanelControls.slider,
          rotationDisplay: RotationDisplay.always,
        ),
      );
      final editor = await openEditor(tester);
      editor.inputCubit.detectPen(true);
      await tester.pumpAndSettle();
      final slider = find.descendant(
        of: find.byKey(const ValueKey('camera-zoom')),
        matching: find.byType(Slider),
      );
      await tester.drag(slider, const Offset(30, 0));
      await tester.pumpAndSettle();
      expect(editor.transformCubit.state.size, greaterThan(1));
      final zoom = editor.transformCubit.state.size;
      final rotationSlider = find.descendant(
        of: find.byKey(const ValueKey('camera-rotation')),
        matching: find.byType(Slider),
      );
      await tester.tapAt(
        tester.getCenter(rotationSlider) + const Offset(10, 0),
      );
      await tester.pumpAndSettle();
      expect(editor.transformCubit.state.rotation, greaterThan(0));
      expect(editor.transformCubit.state.size, zoom);
      await tester.tap(cameraButton('Reset zoom'));
      await tester.pumpAndSettle();
      expect(editor.transformCubit.state.size, 1);
      expect(editor.transformCubit.state.rotation, greaterThan(0));
      await tester.tap(cameraButton('Reset rotation'));
      await tester.pumpAndSettle();
      expect(editor.transformCubit.state.rotation, 0);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'rotation drag follows the configured binding and stops using the default',
    (tester) async {
      await tester.runAsync(() async {
        await keybinder.ready;
        await keybinder.updateBinding(
          rotateDragShortcut.id,
          const SingleActivator(LogicalKeyboardKey.keyR, alt: true),
        );
      });
      addTearDown(() => keybinder.resetBinding(rotateDragShortcut.id));
      final editor = await openEditor(tester);
      final center = tester.getCenter(find.byType(MainViewViewport));

      Future<void> drag() async {
        final gesture = await tester.startGesture(
          center + const Offset(100, 0),
          kind: PointerDeviceKind.mouse,
        );
        await gesture.moveTo(center + const Offset(0, 100));
        await gesture.up();
        await tester.pumpAndSettle();
      }

      await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
      await tester.sendKeyDownEvent(LogicalKeyboardKey.space);
      await drag();
      expect(editor.transformCubit.state.rotation, 0);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.space);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);

      await tester.sendKeyDownEvent(LogicalKeyboardKey.altLeft);
      await tester.sendKeyDownEvent(LogicalKeyboardKey.keyR);
      await drag();
      expect(editor.transformCubit.state.rotation, closeTo(pi / 2, 1e-6));
      await tester.sendKeyUpEvent(LogicalKeyboardKey.keyR);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.altLeft);
      expect(editor.inputCubit.state.pointers, isEmpty);
    },
  );

  testWidgets(
    'Shift+Space drag rotates without drawing and restores normal input',
    (tester) async {
      final editor = await openEditor(tester);
      final bloc = observer.lastDocumentBloc!;
      await editor.toolCubit.changeTool(
        editor,
        bloc,
        index: 1,
        allowBake: false,
      );
      await tester.pumpAndSettle();
      final viewport = find.byType(MainViewViewport);
      final center = tester.getCenter(viewport);
      final localCenter = tester.getSize(viewport).center(Offset.zero);
      final documentCenter = editor.transformCubit.state.localToGlobal(
        localCenter,
      );
      await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
      await tester.sendKeyDownEvent(LogicalKeyboardKey.space);
      final gesture = await tester.startGesture(
        center + const Offset(100, 0),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pump();
      await gesture.moveTo(center + const Offset(0, 100));
      await tester.pump();
      expect(editor.transformCubit.state.rotation, closeTo(pi / 2, 1e-6));
      expect(
        (editor.transformCubit.state.localToGlobal(localCenter) -
                documentCenter)
            .distance,
        lessThan(1e-6),
      );
      // The drag remains a camera gesture when the keys are released first.
      await tester.sendKeyUpEvent(LogicalKeyboardKey.space);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
      await gesture.up();
      await tester.pumpAndSettle();
      expect((bloc.state as DocumentLoadSuccess).page.content, isEmpty);
      expect(editor.inputCubit.state.pointers, isEmpty);
      final stroke = await tester.startGesture(
        center,
        kind: PointerDeviceKind.mouse,
      );
      await stroke.moveBy(const Offset(50, 30));
      await stroke.up();
      await tester.pumpAndSettle();
      expect((bloc.state as DocumentLoadSuccess).page.content, hasLength(1));
      await tester.pump(const Duration(seconds: 4));
    },
  );

  testWidgets('replacing document route closes document bloc', (tester) async {
    await tester.pumpWidget(buildApp());

    for (var i = 1; i <= 3; i++) {
      await tester.tap(find.byKey(const ValueKey('open-document')));
      await pumpUntil(
        tester,
        () =>
            find.byType(ProjectPage).evaluate().isNotEmpty &&
            observer.documentBlocCreates == i,
        'document open $i',
      );
      await tester.pump(const Duration(seconds: 1));

      router.go('/');
      await pumpUntil(
        tester,
        () =>
            find.byType(ProjectPage).evaluate().isEmpty &&
            find.byType(ProjectPage, skipOffstage: false).evaluate().isEmpty &&
            observer.documentBlocCloses == i,
        'document close $i',
      );
    }

    expect(observer.documentBlocCreates, 3);
    expect(observer.documentBlocCloses, 3);
  });

  testWidgets('extensionless notes autosave as bfly in their parent', (
    tester,
  ) async {
    when(() => settingsCubit.state).thenReturn(
      const ButterflySettings(
        defaultTemplate: 'default',
        delayedAutosave: false,
      ),
    );
    final original = DocumentDefaults.createDocument(name: 'Important note');
    await fileSystem.buildDocumentSystem().updateFile(
      '/notes/Important note',
      original.toFile(),
    );
    await tester.pumpWidget(buildApp(readLocalFile: true));
    router.go('/local/notes/Important note');
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'extensionless document open',
    );
    await tester.pump(const Duration(seconds: 1));
    final bloc = observer.lastDocumentBloc!;
    expect(bloc.editorController.saveCubit.state.location.isEmpty, isTrue);
    expect((bloc.state as DocumentLoadSuccess).metadata.directory, isEmpty);

    bloc.add(const DocumentDescriptionChanged(name: 'Edited important note'));
    await pumpUntil(
      tester,
      () =>
          bloc.editorController.saveCubit.state.location.path ==
              '/notes/Edited important note.bfly' &&
          bloc.editorController.saveCubit.state.saved == SaveState.saved,
      'extensionless document autosave',
    );

    final saved = await fileSystem.buildDocumentSystem().getAsset(
      '/notes/Edited important note.bfly',
    );
    expect(saved, isA<FileSystemFile<NoteFile>>());
    expect(
      (saved as FileSystemFile<NoteFile>).data?.load()?.name,
      'Edited important note',
    );
    expect(saved.data?.load()?.getMetadata()?.directory, isEmpty);
    expect(
      await fileSystem.buildDocumentSystem().getAsset('/notes/Important note'),
      isA<FileSystemFile<NoteFile>>(),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('native notes open writable at their device path', (
    tester,
  ) async {
    when(() => settingsCubit.state).thenReturn(
      const ButterflySettings(defaultTemplate: 'default', autosave: false),
    );
    const path = '/mnt/notes/Important note.tbfly';
    final system = fileSystem.buildDocumentSystem();
    final original = DocumentDefaults.createDocument(name: 'Device note');
    await system.saveAbsolute(path, original.toFile(isTextBased: true).data);
    await tester.pumpWidget(buildApp());
    router.goNamed('native', queryParameters: {'path': path});
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'native document open',
    );
    final bloc = observer.lastDocumentBloc!;
    expect(
      bloc.editorController.saveCubit.state.location,
      AssetLocation.local(path, true),
    );
    expect(bloc.editorController.saveCubit.state.saved, SaveState.saved);
    bloc.add(const DocumentDescriptionChanged(name: 'Edited device note'));
    await pumpUntil(
      tester,
      () => bloc.editorController.saveCubit.state.saved == SaveState.unsaved,
      'device note becomes unsaved after editing',
    );
  });

  testWidgets('new documents retain their target save folder', (tester) async {
    when(() => settingsCubit.state).thenReturn(
      const ButterflySettings(
        defaultTemplate: 'default',
        delayedAutosave: false,
      ),
    );
    await tester.pumpWidget(buildApp());
    router.go('/new?directory=/notebook');
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'new document open',
    );
    await tester.pump(const Duration(seconds: 1));
    final bloc = observer.lastDocumentBloc!;
    expect(bloc.editorController.saveCubit.state.isCreating, isTrue);

    bloc.add(const DocumentDescriptionChanged(name: 'Created note'));
    await pumpUntil(
      tester,
      () =>
          bloc.editorController.saveCubit.state.location.path ==
              '/notebook/Created note.bfly' &&
          bloc.editorController.saveCubit.state.saved == SaveState.saved,
      'new document autosave',
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('new documents can target a folder ending in .bfly', (
    tester,
  ) async {
    when(() => settingsCubit.state).thenReturn(
      const ButterflySettings(
        defaultTemplate: 'default',
        delayedAutosave: false,
      ),
    );
    final document = DocumentDefaults.createDocument(name: 'Created note');
    await tester.pumpWidget(
      buildApp(
        embedDocument: document.setMetadata(
          document.getMetadata()!.copyWith(directory: '/template-only'),
        ),
      ),
    );
    router.go('/new?directory=/notebook.bfly');
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'new document open',
    );
    await tester.pump(const Duration(seconds: 1));
    final bloc = observer.lastDocumentBloc!;
    expect(bloc.editorController.saveCubit.state.location.isEmpty, isTrue);
    expect(
      (bloc.state as DocumentLoadSuccess).metadata.directory,
      '/template-only',
    );
    bloc.add(const DocumentDescriptionChanged(name: 'Saved note'));
    await pumpUntil(
      tester,
      () =>
          bloc.editorController.saveCubit.state.location.path ==
              '/notebook.bfly/Saved note.bfly' &&
          bloc.editorController.saveCubit.state.saved == SaveState.saved,
      'new document autosave',
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'editing a new title preserves the target folder and its other notes',
    (tester) async {
      when(() => settingsCubit.state).thenReturn(
        const ButterflySettings(defaultTemplate: 'default', autosave: false),
      );
      when(
        () => settingsCubit.moveAssetReferences(
          any(),
          any(),
          directory: any(named: 'directory'),
        ),
      ).thenAnswer((_) async {});
      final sibling = DocumentDefaults.createDocument(
        name: 'Keep this important note',
      );
      await fileSystem.buildDocumentSystem().updateFile(
        '/notebook/Other.bfly',
        sibling.toFile(),
      );
      await tester.pumpWidget(buildApp());
      router.go('/new?directory=/notebook');
      await pumpUntil(
        tester,
        () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
        'new document',
      );
      await tester.pump(const Duration(seconds: 1));
      final bloc = observer.lastDocumentBloc!;
      expect(bloc.editorController.saveCubit.state.isCreating, isTrue);
      final titleField = find.byWidgetPredicate(
        (widget) =>
            widget is TextFormField &&
            widget.controller?.text == 'Lifecycle test',
      );
      expect(titleField, findsOneWidget);
      await tester.enterText(titleField, 'Renamed');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await pumpUntil(
        tester,
        () => (bloc.state as DocumentLoadSuccess).metadata.name == 'Renamed',
        'title rename',
      );
      await tester.runAsync(() => bloc.save(force: true));
      final surviving = await fileSystem.buildDocumentSystem().getAsset(
        '/notebook/Other.bfly',
      );
      expect(
        surviving,
        isA<FileSystemFile<NoteFile>>(),
        reason: 'Title rename must not recursively delete the selected folder',
      );
      expect(
        bloc.editorController.saveCubit.state.location.path,
        '/notebook/Renamed.bfly',
      );
    },
  );

  testWidgets(
    'title rename preserves conflicting notes and handles duplicate submissions',
    (tester) async {
      var referencesMoved = false;
      when(() => settingsCubit.state).thenReturn(
        const ButterflySettings(defaultTemplate: 'default', autosave: false),
      );
      when(
        () => settingsCubit.moveAssetReferences(
          any(),
          any(),
          directory: any(named: 'directory'),
        ),
      ).thenAnswer((_) async {
        referencesMoved = true;
      });
      final system = fileSystem.buildDocumentSystem();
      await system.updateFile(
        '/notebook/Existing.bfly',
        DocumentDefaults.createDocument(name: 'Keep this note').toFile(),
      );
      await tester.pumpWidget(buildApp());
      router.go('/new?directory=/notebook');
      await pumpUntil(
        tester,
        () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
        'new document',
      );
      await tester.pump(const Duration(seconds: 1));
      final bloc = observer.lastDocumentBloc!;
      await tester.runAsync(() => bloc.save(force: true));
      expect(bloc.editorController.saveCubit.state.isCreating, isTrue);
      final previousLocation = bloc.editorController.saveCubit.state.location;
      final titleField = find.byWidgetPredicate(
        (widget) =>
            widget is TextFormField &&
            widget.controller?.text == 'Lifecycle test',
      );
      await tester.enterText(titleField, 'Existing');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      bloc.editorController.focusNode.requestFocus();
      await pumpUntil(
        tester,
        () =>
            (bloc.state as DocumentLoadSuccess).metadata.name == 'Existing' &&
            referencesMoved,
        'title rename',
      );
      await tester.pump(const Duration(seconds: 1));
      expect(
        bloc.editorController.saveCubit.state.location.path,
        '/notebook/Existing (1).bfly',
      );
      final original = await system.getAsset(
        '/notebook/Existing.bfly',
      ) as FileSystemFile<NoteFile>;
      expect(original.data!.load()!.name, 'Keep this note');
      final renamed = await system.getAsset(
        '/notebook/Existing (1).bfly',
      ) as FileSystemFile<NoteFile>;
      expect(renamed.data!.load()!.name, 'Existing');
      expect(await system.getAsset(previousLocation.path), isNull);
      expect(await system.getAsset('/notebook/Existing (2).bfly'), isNull);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('backgrounding flushes a delayed autosave', (tester) async {
    when(() => settingsCubit.state).thenReturn(
      const ButterflySettings(
        defaultTemplate: 'default',
        autosaveDelaySeconds: 1800,
      ),
    );
    await tester.pumpWidget(buildApp());
    await tester.tap(find.byKey(const ValueKey('open-document')));
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'document open',
    );

    final bloc = observer.lastDocumentBloc!;
    bloc.add(const DocumentDescriptionChanged(name: 'Saved in background'));
    await pumpUntil(
      tester,
      () => bloc.editorController.saveCubit.state.isSaveDelayed,
      'delayed autosave',
    );

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await pumpUntil(
      tester,
      () => bloc.editorController.saveCubit.state.saved == SaveState.saved,
      'background save',
    );

    final saved = await fileSystem.buildDocumentSystem().getAsset(
      'lifecycle.bfly',
    );
    expect(saved, isA<FileSystemFile<NoteFile>>());
    expect(
      (saved as FileSystemFile<NoteFile>).data?.display()?.getMetadata()?.name,
      'Saved in background',
    );
    expect(bloc.editorController.saveCubit.state.isSaveDelayed, isFalse);

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump(const Duration(minutes: 30));
  });

  testWidgets('embed can start full screen and be toggled off', (tester) async {
    await tester.pumpWidget(
      buildApp(embedFullScreen: EmbedFullScreen.startInLayout),
    );

    router.go('/embed');
    await pumpUntil(
      tester,
      () =>
          observer.lastDocumentBloc?.state is DocumentLoadSuccess &&
          observer
                  .lastDocumentBloc
                  ?.editorController
                  .saveCubit
                  .state
                  .fullScreen ==
              true,
      'full screen embed open',
    );
    expect(windowCubit.state.fullScreen, isFalse);
    expect(find.byType(PadAppBar), findsNothing);
    expect(
      windowManagerCalls.where((call) => call.method == 'setFullScreen'),
      isEmpty,
    );

    windowManagerCalls.clear();
    final viewportContext = find.byType(MainViewViewport).evaluate().single;
    FullScreenHandler(FullScreenTool()).onSelected(viewportContext);
    await tester.pump();

    expect(
      observer.lastDocumentBloc!.editorController.saveCubit.state.fullScreen,
      isFalse,
    );
    expect(find.byType(PadAppBar), findsOneWidget);
    expect(
      windowManagerCalls.where((call) => call.method == 'setFullScreen'),
      isEmpty,
    );

    router.go('/');
    await pumpUntil(
      tester,
      () => observer.documentBlocCloses == 1,
      'full screen embed close',
    );
  });

  testWidgets('normal embed can toggle native full screen', (tester) async {
    await tester.pumpWidget(buildApp());

    router.go('/embed');
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'normal embed open',
    );
    expect(
      observer.lastDocumentBloc!.editorController.saveCubit.state.fullScreen,
      isFalse,
    );

    windowManagerCalls.clear();
    final viewportContext = find.byType(MainViewViewport).evaluate().single;
    FullScreenHandler(FullScreenTool()).onSelected(viewportContext);
    await tester.pump();

    expect(
      windowManagerCalls.where((call) => call.method == 'setFullScreen'),
      isNotEmpty,
    );
    expect(find.byType(PadAppBar), findsNothing);

    router.go('/');
    await pumpUntil(
      tester,
      () => observer.documentBlocCloses == 1,
      'normal embed close',
    );
  });

  testWidgets('embed shows full screen menu item when toggling is enabled', (
    tester,
  ) async {
    await tester.pumpWidget(buildApp());

    router.go('/embed');
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'toggleable embed open',
    );

    await tester.tap(find.byTooltip('Actions').hitTestable().first);
    await tester.pumpAndSettle();
    final fullScreenItem = find.widgetWithText(MenuItemButton, 'Full Screen');
    expect(fullScreenItem, findsOneWidget);

    windowManagerCalls.clear();
    await tester.tap(fullScreenItem);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(
      observer.lastDocumentBloc!.editorController.saveCubit.state.fullScreen,
      isTrue,
    );
    expect(
      windowManagerCalls.where((call) => call.method == 'setFullScreen'),
      isNotEmpty,
    );

    router.go('/');
    await pumpUntil(
      tester,
      () => observer.documentBlocCloses == 1,
      'toggleable embed close',
    );
  });

  testWidgets('embed hides full screen menu item when toggling is disabled', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildApp(embedFullScreen: EmbedFullScreen.disabled),
    );

    router.go('/embed');
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'locked normal embed open',
    );

    await tester.tap(find.byTooltip('Actions').hitTestable().first);
    await tester.pumpAndSettle();
    expect(find.widgetWithText(MenuItemButton, 'Full Screen'), findsNothing);

    router.go('/');
    await pumpUntil(
      tester,
      () => observer.documentBlocCloses == 1,
      'locked normal embed close',
    );
  });

  testWidgets('locked full screen layout ignores toggles', (tester) async {
    await tester.pumpWidget(buildApp(embedFullScreen: EmbedFullScreen.forced));

    router.go('/embed');
    await pumpUntil(
      tester,
      () =>
          observer.lastDocumentBloc?.state is DocumentLoadSuccess &&
          observer
                  .lastDocumentBloc
                  ?.editorController
                  .saveCubit
                  .state
                  .fullScreen ==
              true,
      'locked full screen layout embed open',
    );
    expect(windowCubit.state.fullScreen, isFalse);
    expect(find.byType(PadAppBar), findsNothing);
    expect(
      windowManagerCalls.where((call) => call.method == 'setFullScreen'),
      isEmpty,
    );

    windowManagerCalls.clear();
    final viewportContext = find.byType(MainViewViewport).evaluate().single;
    FullScreenHandler(FullScreenTool()).onSelected(viewportContext);
    await tester.pump();

    expect(
      observer.lastDocumentBloc!.editorController.saveCubit.state.fullScreen,
      isTrue,
    );
    expect(find.byType(PadAppBar), findsNothing);
    expect(
      windowManagerCalls.where((call) => call.method == 'setFullScreen'),
      isEmpty,
    );

    router.go('/');
    await pumpUntil(
      tester,
      () => observer.documentBlocCloses == 1,
      'locked full screen layout embed close',
    );
  });

  testWidgets('embed file name stays separate from document metadata', (
    tester,
  ) async {
    final document = DocumentDefaults.createDocument(
      name: 'Stored document name',
      page: const DocumentPage(backgrounds: []),
    );
    await tester.pumpWidget(
      buildApp(embedDocument: document, embedFileName: 'Host file.bfly'),
    );

    router.go('/embed');
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'named embed open',
    );
    await tester.pumpAndSettle();

    final titleFinder = find.byWidgetPredicate(
      (widget) =>
          widget is TextFormField &&
          widget.controller?.text == 'Stored document name',
    );
    final title = tester.widget<TextFormField>(titleFinder);
    expect(title.controller?.text, 'Stored document name');
    final titleField = tester.widget<TextField>(
      find.descendant(of: titleFinder, matching: find.byType(TextField)),
    );
    expect(titleField.readOnly, isFalse);

    var state = observer.lastDocumentBloc!.state as DocumentLoadSuccess;
    expect(state.metadata.name, 'Stored document name');
    expect(
      observer.lastDocumentBloc!.editorController.saveCubit.state.location.path,
      'Host file.bfly',
    );
    expect(find.text('Host file.bfly'), findsOneWidget);

    await tester.enterText(titleFinder, 'Renamed metadata');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    state = observer.lastDocumentBloc!.state as DocumentLoadSuccess;
    expect(state.metadata.name, 'Renamed metadata');
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextFormField &&
            widget.controller?.text == 'Renamed metadata',
      ),
      findsOneWidget,
    );
    expect(
      observer.lastDocumentBloc!.editorController.saveCubit.state.location.path,
      'Host file.bfly',
    );
    expect(find.text('Host file.bfly'), findsOneWidget);

    await tester.tap(find.byTooltip('Actions'));
    await tester.pumpAndSettle();
    expect(find.text('Templates'), findsNothing);
    expect(find.text('Files'), findsNothing);
    expect(find.text('Recent files'), findsNothing);

    router.go('/');
    await pumpUntil(
      tester,
      () => observer.documentBlocCloses == 1,
      'named embed close',
    );
  });

  testWidgets('double tap shortcut does not draw with the pen tool', (
    tester,
  ) async {
    when(() => settingsCubit.state).thenReturn(
      const ButterflySettings(
        defaultTemplate: 'default',
        inputConfiguration: InputConfiguration(doubleTouchShortcut: 'undo'),
      ),
    );
    await tester.pumpWidget(buildApp());
    await tester.tap(find.byKey(const ValueKey('open-document')));
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'document open',
    );
    await tester.pumpAndSettle();

    final viewport = find.byType(MainViewViewport);
    final documentBloc = observer.lastDocumentBloc!;
    final editorController = documentBloc.editorController;
    await editorController.toolCubit.changeTool(
      editorController,
      documentBloc,
      index: 1,
      allowBake: false,
    );
    await tester.pumpAndSettle();
    final position = tester.getCenter(viewport);
    final firstTap = await tester.startGesture(
      position,
      pointer: 1,
      kind: PointerDeviceKind.touch,
    );
    await firstTap.up();
    await tester.pump(const Duration(milliseconds: 50));
    final secondTap = await tester.startGesture(
      position,
      pointer: 2,
      kind: PointerDeviceKind.touch,
    );
    await secondTap.up();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    final state = observer.lastDocumentBloc!.state as DocumentLoadSuccess;
    expect(state.page.content, isEmpty);
    expect(observer.events, isNot(contains('ElementsCreated')));

    final singleTap = await tester.startGesture(
      position + const Offset(30, 0),
      pointer: 3,
      kind: PointerDeviceKind.touch,
    );
    await singleTap.up();
    await tester.pump(const Duration(milliseconds: 550));
    await tester.pumpAndSettle();

    final updatedState =
        observer.lastDocumentBloc!.state as DocumentLoadSuccess;
    expect(updatedState.page.content, hasLength(1));
    expect(observer.events, contains('ElementsCreated'));
    await tester.pump(const Duration(seconds: 4));
  });

  testWidgets('releasing one touch pointer keeps the camera stable', (
    tester,
  ) async {
    when(() => settingsCubit.state).thenReturn(
      const ButterflySettings(
        defaultTemplate: 'default',
        flags: ['smoothNavigation'],
      ),
    );
    await tester.pumpWidget(buildApp());
    await tester.tap(find.byKey(const ValueKey('open-document')));
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'document open',
    );
    await tester.pumpAndSettle();

    final viewport = find.byType(MainViewViewport);
    final center = tester.getCenter(viewport);
    final firstFinger = await tester.startGesture(
      center - const Offset(30, 0),
      pointer: 1,
      kind: PointerDeviceKind.touch,
    );
    final secondFinger = await tester.startGesture(
      center + const Offset(30, 0),
      pointer: 2,
      kind: PointerDeviceKind.touch,
    );
    await tester.pump();
    await firstFinger.moveBy(const Offset(20, 10));
    await secondFinger.moveBy(const Offset(20, 10));
    await tester.pump();

    final transformCubit =
        observer.lastDocumentBloc!.editorController.transformCubit;
    final beforeRelease = transformCubit.state;
    await secondFinger.up();
    await tester.pump();
    final afterRelease = transformCubit.state;

    expect(afterRelease.position, beforeRelease.position);
    expect(afterRelease.size, beforeRelease.size);
    expect(afterRelease.friction, isNull);

    await firstFinger.up();
    await tester.pumpAndSettle();
  });

  for (final (kind, cancel) in [
    for (final kind in [PointerDeviceKind.mouse, PointerDeviceKind.stylus])
      for (final cancel in [false, true]) (kind, cancel),
  ]) {
    testWidgets(
      'single touch draws after temporary hand ($kind, cancel: $cancel)',
      (tester) async {
        when(() => settingsCubit.state).thenReturn(
          const ButterflySettings(
            defaultTemplate: 'default',
            penOnlyInput: false,
            flags: ['smoothNavigation'],
            inputConfiguration: InputConfiguration(
              firstPenButton: InputMapping(InputMapping.handToolValue),
            ),
          ),
        );
        await tester.pumpWidget(buildApp());
        await tester.tap(find.byKey(const ValueKey('open-document')));
        await pumpUntil(
          tester,
          () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
          'document open',
        );
        await tester.pumpAndSettle();

        final bloc = observer.lastDocumentBloc!;
        final controller = bloc.editorController;
        await controller.toolCubit.changeTool(
          controller,
          bloc,
          index: 1,
          allowBake: false,
        );
        await tester.pumpAndSettle();
        final center = tester.getCenter(find.byType(MainViewViewport));
        final beforeHand = controller.transformCubit.state;
        final handGesture = await tester.startGesture(
          center,
          pointer: 1,
          kind: kind,
          buttons: kind == PointerDeviceKind.mouse
              ? kMiddleMouseButton
              : kPrimaryStylusButton,
        );
        await tester.pump();
        expect(controller.toolCubit.getHandler(), isA<HandHandler>());
        await handGesture.moveBy(const Offset(30, 0));
        await handGesture.moveBy(const Offset(30, 0));
        if (cancel) {
          await handGesture.cancel();
        } else {
          await handGesture.up();
        }
        await tester.pumpAndSettle();

        final beforeStroke = controller.transformCubit.state;
        expect(beforeStroke.position, isNot(beforeHand.position));
        final stroke = await tester.startGesture(
          center,
          pointer: 2,
          kind: PointerDeviceKind.touch,
        );
        await stroke.moveBy(const Offset(30, 0));
        await stroke.moveBy(const Offset(30, 10));
        await stroke.up();
        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 4));

        expect(controller.transformCubit.state.position, beforeStroke.position);
        expect(controller.transformCubit.state.size, beforeStroke.size);
        expect(controller.transformCubit.state.rotation, beforeStroke.rotation);
        expect((bloc.state as DocumentLoadSuccess).page.content, hasLength(1));
      },
    );
  }

  testWidgets('pinch zoom stays anchored to the stationary finger', (
    tester,
  ) async {
    when(() => settingsCubit.state).thenReturn(
      const ButterflySettings(
        defaultTemplate: 'default',
        flags: ['smoothNavigation'],
      ),
    );
    await tester.pumpWidget(buildApp());
    await tester.tap(find.byKey(const ValueKey('open-document')));
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'document open',
    );
    await tester.pumpAndSettle();

    final viewport = find.byType(MainViewViewport);
    final center = tester.getCenter(viewport);
    final viewportOrigin = tester.getTopLeft(viewport);
    final firstFinger = await tester.startGesture(
      center - const Offset(40, 0),
      pointer: 1,
      kind: PointerDeviceKind.touch,
    );
    final secondFingerPosition = center + const Offset(40, 0);
    final secondFinger = await tester.startGesture(
      secondFingerPosition,
      pointer: 2,
      kind: PointerDeviceKind.touch,
    );
    await tester.pump();

    // Cross the gesture slop before measuring the focal-point invariant.
    await firstFinger.moveBy(const Offset(-10, 0));
    await tester.pump();
    await firstFinger.moveBy(const Offset(-30, 0));
    await tester.pump();
    final transformCubit =
        observer.lastDocumentBloc!.editorController.transformCubit;
    final stationaryLocalPosition = secondFingerPosition - viewportOrigin;
    final documentPoint = transformCubit.state.localToGlobal(
      stationaryLocalPosition,
    );

    await firstFinger.moveBy(const Offset(-30, 0));
    await tester.pump();

    final restored = transformCubit.state.localToGlobal(
      stationaryLocalPosition,
    );
    expect(restored.dx, closeTo(documentPoint.dx, 1e-6));
    expect(restored.dy, closeTo(documentPoint.dy, 1e-6));

    await firstFinger.moveBy(const Offset(-30, 0));
    await tester.pump();

    final restoredAgain = transformCubit.state.localToGlobal(
      stationaryLocalPosition,
    );
    expect(restoredAgain.dx, closeTo(documentPoint.dx, 1e-6));
    expect(restoredAgain.dy, closeTo(documentPoint.dy, 1e-6));

    await firstFinger.up();
    await secondFinger.up();
    await tester.pumpAndSettle();
  });

  testWidgets('hold shortcut resets when the key is released', (tester) async {
    when(() => settingsCubit.state).thenReturn(
      ButterflySettings(
        defaultTemplate: 'default',
        inputConfiguration: InputConfiguration(
          holdShortcuts: [
            HoldShortcut(
              keyId: LogicalKeyboardKey.digit1.keyId,
              mapping: const InputMapping(2),
            ),
          ],
        ),
      ),
    );
    await tester.pumpWidget(buildApp());
    await tester.tap(find.byKey(const ValueKey('open-document')));
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'document open',
    );
    await tester.pumpAndSettle();

    final viewport = find.byType(MainViewViewport);
    final documentBloc = observer.lastDocumentBloc!;
    final editorController = documentBloc.editorController;
    await editorController.toolCubit.changeTool(
      editorController,
      documentBloc,
      index: 1,
      allowBake: false,
    );
    await tester.pumpAndSettle();

    await tester.sendKeyDownEvent(LogicalKeyboardKey.digit1);
    final gesture = await tester.startGesture(
      tester.getCenter(viewport),
      kind: PointerDeviceKind.mouse,
    );
    await tester.pump();

    expect(editorController.toolCubit.state.index, 1);
    expect(editorController.toolCubit.state.temporaryIndex, 2);

    await gesture.up();
    await tester.sendKeyUpEvent(LogicalKeyboardKey.digit1);
    await tester.pumpAndSettle();

    expect(editorController.toolCubit.state.index, 1);
    expect(editorController.toolCubit.state.temporaryHandler, isNull);
    expect(editorController.toolCubit.state.temporaryIndex, isNull);

    final nextGesture = await tester.startGesture(
      tester.getCenter(viewport),
      kind: PointerDeviceKind.mouse,
    );
    await tester.pump();

    expect(editorController.toolCubit.state.index, 1);
    expect(editorController.toolCubit.state.temporaryHandler, isNull);
    expect(editorController.toolCubit.state.temporaryIndex, isNull);

    await nextGesture.up();
    await tester.pumpAndSettle();

    expect(editorController.toolCubit.state.index, 1);
    expect(editorController.toolCubit.state.temporaryHandler, isNull);
    expect(editorController.toolCubit.state.temporaryIndex, isNull);
    final state = documentBloc.state as DocumentLoadSuccess;
    expect(state.page.content, hasLength(1));

    await tester.sendKeyDownEvent(LogicalKeyboardKey.digit1);
    final heldGesture = await tester.startGesture(
      tester.getCenter(viewport),
      kind: PointerDeviceKind.mouse,
    );
    await tester.pump();
    expect(editorController.toolCubit.state.temporaryIndex, 2);

    await tester.sendKeyUpEvent(LogicalKeyboardKey.digit1);
    await tester.pump();
    expect(editorController.toolCubit.state.temporaryIndex, 2);
    expect(
      editorController.toolCubit.state.temporaryState,
      TemporaryState.removeAfterRelease,
    );

    await heldGesture.up();
    await tester.pumpAndSettle();
    expect(editorController.toolCubit.state.temporaryHandler, isNull);
    await tester.pump(const Duration(seconds: 4));
  });

  testWidgets('temporary release handler receives pointer up before removal', (
    tester,
  ) async {
    await tester.pumpWidget(buildApp());
    await tester.tap(find.byKey(const ValueKey('open-document')));
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'document open',
    );
    await tester.pumpAndSettle();

    final documentBloc = observer.lastDocumentBloc!;
    final editorController = documentBloc.editorController;
    final handler = _ReleaseTrackingHandler();
    editorController.toolCubit.setTemporaryTool(
      handler: handler,
      index: null,
      foregrounds: const [],
      toolbar: null,
      cursor: null,
      rendererStates: const {},
      temporaryState: TemporaryState.removeAfterRelease,
    );
    await tester.pump();

    final gesture = await tester.startGesture(
      tester.getCenter(find.byType(MainViewViewport)),
      kind: PointerDeviceKind.mouse,
    );
    await gesture.up();
    await tester.pumpAndSettle();

    expect(handler.pointerUpCalled, isTrue);
    expect(editorController.toolCubit.state.temporaryHandler, isNull);
    await tester.pump(const Duration(seconds: 4));
  });

  testWidgets('select tool manipulates a ruler enabled after viewport build', (
    tester,
  ) async {
    await tester.pumpWidget(buildApp());
    await tester.tap(find.byKey(const ValueKey('open-document')));
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'document open',
    );
    await tester.pumpAndSettle();

    final documentBloc = observer.lastDocumentBloc!;
    final editorController = documentBloc.editorController;
    expect(editorController.toolCubit.state.handler, isA<SelectHandler>());
    documentBloc.add(ToolCreated(RulerTool(id: 'ruler')));
    await tester.pumpAndSettle();
    final rulerIndex =
        (documentBloc.state as DocumentLoadSuccess).info.tools.length - 1;
    await editorController.toolCubit.toggleHandler(
      editorController,
      documentBloc,
      rulerIndex,
    );
    await tester.pump();

    final viewport = find.byType(MainViewViewport);
    final gesture = await tester.startGesture(
      tester.getCenter(viewport),
      kind: PointerDeviceKind.mouse,
    );
    await gesture.moveBy(const Offset(20, 10));
    await tester.pump();
    await gesture.moveBy(const Offset(30, 15));
    await tester.pump();
    await gesture.up();
    await tester.pumpAndSettle();

    final ruler =
        editorController.toolCubit.state.toggleableHandlers[rulerIndex]
            as RulerHandler;
    expect(ruler.position, const Offset(50, 25));

    final rulerCenter = tester.getCenter(viewport) + ruler.position;
    final rotationGesture = await tester.startGesture(
      rulerCenter + const Offset(100, 0),
      kind: PointerDeviceKind.mouse,
      buttons: kSecondaryMouseButton,
    );
    await rotationGesture.moveTo(rulerCenter + const Offset(0, 100));
    await tester.pump();
    await rotationGesture.up();
    await tester.pumpAndSettle();
    expect(ruler.rotation, closeTo(90, 0.1));
    await tester.pump(const Duration(seconds: 4));
  });

  testWidgets('context menu key opens the active tool context menu', (
    tester,
  ) async {
    await tester.pumpWidget(buildApp());
    await tester.tap(find.byKey(const ValueKey('open-document')));
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'document open',
    );
    await tester.pumpAndSettle();

    await tester.sendKeyDownEvent(LogicalKeyboardKey.contextMenu);
    await tester.pumpAndSettle();

    expect(find.byType(ContextMenu), findsOneWidget);

    await tester.sendKeyUpEvent(LogicalKeyboardKey.contextMenu);
  });

  testWidgets('mobile navigator dialogs receive the editor runtime cubits', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildApp());
    await tester.tap(find.byKey(const ValueKey('open-document')));
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'document open',
    );
    await tester.pumpAndSettle();

    for (final page in [
      'Waypoints',
      'Areas',
      'Layers',
      'Pages',
      'Components',
      'Files',
    ]) {
      await tester.tap(find.byTooltip('Actions'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(page));
      await tester.pumpAndSettle();

      expect(find.byType(DocumentNavigator), findsOneWidget, reason: page);
      expect(tester.takeException(), isNull, reason: page);

      await tester.tap(
        find.descendant(
          of: find.byType(DocumentNavigator),
          matching: find.byTooltip('Close'),
        ),
      );
      await tester.pumpAndSettle();
    }

    final documentBloc = observer.lastDocumentBloc!;
    expect(
      debugDocumentPagePreviewCacheRetainedCount(documentBloc),
      greaterThan(0),
    );
    router.go('/');
    await pumpUntil(
      tester,
      () => observer.documentBlocCloses == 1,
      'preview document close',
    );
    expect(debugDocumentPagePreviewCacheRetainedCount(documentBloc), 0);
  });

  testWidgets('full screen navigator menu opens the sidebar', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildApp());
    await tester.tap(find.byKey(const ValueKey('open-document')));
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'document open',
    );
    await windowCubit.changeFullScreen(true);
    await tester.pumpAndSettle();

    final editorController = observer.lastDocumentBloc!.editorController;
    expect(find.byType(PadAppBar), findsNothing);
    expect(find.byType(NavigatorView), findsNothing);

    for (final page in NavigatorPage.values) {
      await tester.tap(
        find
            .descendant(
              of: find.byType(MainPopupMenu),
              matching: find.byTooltip('Actions'),
            )
            .hitTestable()
            .first,
      );
      await tester.pumpAndSettle();
      await tester.tap(
        find.widgetWithText(
          MenuItemButton,
          page.getLocalizedName(tester.element(find.byType(ProjectPage))),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(NavigatorView), findsOneWidget, reason: page.name);
      expect(find.byType(DocumentNavigator), findsOneWidget, reason: page.name);
      expect(find.byType(Dialog), findsNothing, reason: page.name);
      expect(
        editorController.viewCubit.state.navigatorPage,
        page,
        reason: page.name,
      );
      expect(
        editorController.viewCubit.state.navigatorEnabled,
        isTrue,
        reason: page.name,
      );
      expect(tester.takeException(), isNull, reason: page.name);
    }
  });

  testWidgets(
    'desktop navigator menu opens the sidebar when its rail is disabled',
    (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      when(() => settingsCubit.state).thenReturn(
        const ButterflySettings(
          defaultTemplate: 'default',
          navigationRail: false,
        ),
      );

      await tester.pumpWidget(buildApp());
      await tester.tap(find.byKey(const ValueKey('open-document')));
      await pumpUntil(
        tester,
        () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
        'document open',
      );
      await tester.pumpAndSettle();

      final editorController = observer.lastDocumentBloc!.editorController;
      expect(find.byType(PadAppBar), findsOneWidget);
      expect(find.byType(NavigatorView), findsNothing);

      for (final page in NavigatorPage.values) {
        await tester.tap(
          find
              .descendant(
                of: find.byType(MainPopupMenu),
                matching: find.byTooltip('Actions'),
              )
              .hitTestable()
              .first,
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.widgetWithText(
            MenuItemButton,
            page.getLocalizedName(tester.element(find.byType(ProjectPage))),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(NavigatorView), findsOneWidget, reason: page.name);
        expect(
          find.byType(DocumentNavigator),
          findsOneWidget,
          reason: page.name,
        );
        expect(find.byType(Dialog), findsNothing, reason: page.name);
        expect(
          editorController.viewCubit.state.navigatorPage,
          page,
          reason: page.name,
        );
        expect(
          editorController.viewCubit.state.navigatorEnabled,
          isTrue,
          reason: page.name,
        );
        expect(tester.takeException(), isNull, reason: page.name);
      }
    },
  );

  testWidgets('converted imported file starts unsaved', (tester) async {
    await tester.pumpWidget(buildApp());

    router.go('/import');
    await pumpUntil(
      tester,
      () =>
          find.byType(ProjectPage).evaluate().isNotEmpty &&
          observer.lastSaveCubit != null,
      'imported document open',
    );

    expect(observer.lastSaveCubit!.state.saved, SaveState.unsaved);

    router.go('/');
    await pumpUntil(
      tester,
      () =>
          find.byType(ProjectPage).evaluate().isEmpty &&
          find.byType(ProjectPage, skipOffstage: false).evaluate().isEmpty &&
          observer.documentBlocCloses == 1 &&
          observer.saveCubitCloses == 1,
      'imported document close',
    );
  });

  testWidgets('cancelling a newer document warning returns home', (
    tester,
  ) async {
    var document = DocumentDefaults.createDocument(
      name: 'Future document',
      page: const DocumentPage(backgrounds: []),
    );
    document = document.setMetadata(
      document.getMetadata()!.copyWith(fileVersion: kFileVersion + 1),
    );
    await tester.pumpWidget(buildApp(embedDocument: document));

    router.go('/import');
    await pumpUntil(
      tester,
      () => find.text('Breaking changes').evaluate().isNotEmpty,
      'newer file version warning',
    );

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
      find.textContaining('The current file version is ${kFileVersion + 1}'),
      findsOneWidget,
    );

    await tester.tap(find.text('Cancel'));
    await pumpUntil(
      tester,
      () => find.byType(ProjectPage).evaluate().isEmpty,
      'return home after cancelling future document',
    );

    expect(observer.documentBlocCreates, 0);
    expect(find.byKey(const ValueKey('open-document')), findsOneWidget);
  });

  testWidgets('wrong encrypted document password returns home', (tester) async {
    final document = DocumentDefaults.createDocument(
      name: 'Encrypted document',
      page: const DocumentPage(backgrounds: []),
    );
    final encrypted = document.changePassword('correct password').toFile();
    await tester.pumpWidget(buildApp(importData: encrypted));

    router.go('/import');
    await pumpUntil(
      tester,
      () => find.text('Encrypted').evaluate().isNotEmpty,
      'encrypted document password prompt',
    );

    await tester.enterText(find.byType(TextFormField), 'wrong password');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Open'));
    await pumpUntil(
      tester,
      () => find.text('Unknown import type').evaluate().isNotEmpty,
      'wrong password error',
    );
    await tester.tap(find.text('Close'));
    await pumpUntil(
      tester,
      () => find.byType(ProjectPage).evaluate().isEmpty,
      'return home after wrong password',
    );

    expect(observer.documentBlocCreates, 0);
    expect(find.byKey(const ValueKey('open-document')), findsOneWidget);
  });

  testWidgets('saved connection password opens without a prompt', (
    tester,
  ) async {
    const password = 'connection password';
    const remote = DavRemoteStorage(
      username: 'user',
      url: 'https://example.com/dav',
      extra: {connectionEncryptionEnabledKey: true},
    );
    final document = DocumentDefaults.createDocument(
      name: 'Connection encrypted document',
      page: const DocumentPage(backgrounds: []),
    );
    final encrypted = document.changePassword(password).toFile();
    when(() => settingsCubit.getRemote(any())).thenReturn(remote);
    await connectionEncryptionPasswordStorage.write(remote, password);
    addTearDown(() => connectionEncryptionPasswordStorage.delete(remote));

    await tester.pumpWidget(buildApp(importData: encrypted));
    router.go('/import');
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'connection encrypted document open',
    );

    expect(find.text('Encrypted'), findsNothing);
    final state = observer.lastDocumentBloc!.state as DocumentLoadSuccess;
    expect(state.metadata.name, 'Connection encrypted document');

    router.go('/');
    await pumpUntil(
      tester,
      () => observer.documentBlocCloses == 1,
      'connection encrypted document close',
    );
    await tester.pump(const Duration(milliseconds: 10));
  });

  testWidgets('embed does not load or save persistent document state', (
    tester,
  ) async {
    final document = DocumentDefaults.createDocument(
      name: 'Embed lifecycle test',
      page: const DocumentPage(backgrounds: []),
    );
    final contentKey = documentStateContentKey(
      documentStateContentHash(document.exportAsBytes()),
    );
    final documentStateSystem = fileSystem.buildDocumentStateSystem();
    await documentStateSystem.initialize();
    await documentStateSystem.createFile(
      contentKey,
      const PersistedDocumentState(
        camera: PersistedCameraState(positionX: 100, positionY: 200, zoom: 3),
      ),
    );
    await tester.pumpWidget(buildApp(embedDocument: document));

    router.go('/embed');
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'embedded document open',
    );
    verifyNever(() => settingsCubit.changeLocaleTemporarily(any()));

    final editorController = observer.lastDocumentBloc!.editorController;
    expect(editorController.transformCubit.state.position, Offset.zero);
    expect(editorController.transformCubit.state.size, 1);
    editorController.transformCubit.teleport(const Offset(10, 20), 2);

    router.go('/');
    await pumpUntil(
      tester,
      () => observer.documentBlocCloses == 1,
      'embedded document close',
    );

    final stored = await documentStateSystem.getFile(contentKey);
    expect(stored?.camera.positionX, 100);
    expect(stored?.camera.positionY, 200);
    expect(stored?.camera.zoom, 3);
  });

  testWidgets('embed can replace a used document with a blank document', (
    tester,
  ) async {
    final usedDocument = DocumentDefaults.createDocument(name: 'Used document');
    await tester.pumpWidget(buildApp(embedDocument: usedDocument));

    router.go('/embed');
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'used embedded document open',
    );
    final previousBloc = observer.lastDocumentBloc!;
    expect(
      (previousBloc.state as DocumentLoadSuccess).data.getMetadata()?.name,
      'Used document',
    );

    router.go('/embed', extra: DocumentDefaults.createDocument());
    await pumpUntil(
      tester,
      () =>
          observer.documentBlocCreates == 2 &&
          observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'blank embedded document open',
    );

    expect(previousBloc.isClosed, isTrue);
    final state = observer.lastDocumentBloc!.state as DocumentLoadSuccess;
    expect(state.data.getMetadata()?.name, isEmpty);
    expect(state.page.content, isEmpty);
  });

  testWidgets('embed restores a view with replacement document data', (
    tester,
  ) async {
    final initialDocument = DocumentDefaults.createDocument(name: 'Initial');
    await tester.pumpWidget(buildApp(embedDocument: initialDocument));
    router.go('/embed');
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'initial embedded document open',
    );

    final replacement = DocumentDefaults.createDocument(name: 'Replacement');
    router.go(
      '/embed',
      extra: EmbedDocumentData(
        replacement.exportAsBytes(),
        const EmbedViewState(x: 120, y: -45, zoom: 2, rotation: 0.5),
      ),
    );
    await pumpUntil(
      tester,
      () =>
          observer.documentBlocCreates == 2 &&
          observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'replacement embedded document open',
    );

    final bloc = observer.lastDocumentBloc!;
    expect(
      (bloc.state as DocumentLoadSuccess).data.getMetadata()?.name,
      'Replacement',
    );
    final camera = bloc.editorController.transformCubit.state;
    expect(camera.position, const Offset(120, -45));
    expect(camera.size, 2);
    expect(camera.rotation, closeTo(0.5, 0.000001));
  });
}

class _LifecycleObserver extends BlocObserver {
  int documentBlocCreates = 0;
  int documentBlocCloses = 0;
  int saveCubitCreates = 0;
  int saveCubitCloses = 0;
  DocumentBloc? lastDocumentBloc;
  DocumentSaveCubit? lastSaveCubit;
  final events = <String>[];

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    if (bloc is DocumentBloc) {
      documentBlocCreates++;
      lastDocumentBloc = bloc;
    } else if (bloc is DocumentSaveCubit) {
      saveCubitCreates++;
      lastSaveCubit = bloc;
    }
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    if (bloc is DocumentBloc) {
      documentBlocCloses++;
    } else if (bloc is DocumentSaveCubit) {
      saveCubitCloses++;
    }
    super.onClose(bloc);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    if (bloc is DocumentBloc) {
      events.add(event.runtimeType.toString());
    }
    super.onEvent(bloc, event);
  }
}
