import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/embed/embedding.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/models/persisted_document_state.dart';
import 'package:butterfly/services/font.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly/views/main.dart';
import 'package:butterfly/views/navigator/view.dart';
import 'package:butterfly/widgets/document_page_preview.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/mocks.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('window_manager'),
          (call) async => switch (call.method) {
            'isMaximized' ||
            'isMinimized' ||
            'isFullScreen' ||
            'isPreventClose' ||
            'isAlwaysOnTop' ||
            'isSkipTaskbar' => false,
            _ => null,
          },
        );
  });

  late MockSettingsCubit settingsCubit;
  late MockButterflyFileSystem fileSystem;
  late WindowCubit windowCubit;
  late GoRouter router;
  late _LifecycleObserver observer;
  late BlocObserver previousObserver;

  setUp(() {
    settingsCubit = MockSettingsCubit();
    fileSystem = MockButterflyFileSystem(settingsCubit: settingsCubit);
    windowCubit = WindowCubit(fullScreen: false);
    observer = _LifecycleObserver();
    previousObserver = Bloc.observer;
    Bloc.observer = observer;

    when(
      () => settingsCubit.state,
    ).thenReturn(const ButterflySettings(defaultTemplate: 'default'));
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => settingsCubit.getRemote(any())).thenReturn(null);
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

  Future<void> tapHomeMenuItem(WidgetTester tester) async {
    await tester.tap(find.byTooltip('Actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(MenuItemButton, 'Home'));
  }

  Widget buildApp({NoteData? embedDocument}) {
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
                  data: state.extra ?? document,
                  location: AssetLocation.local(path),
                );
              },
            ),
            GoRoute(
              path: 'import',
              builder: (context, state) => ProjectPage(data: document),
            ),
            GoRoute(
              path: 'embed',
              builder: (context, state) => ProjectPage(
                data: document.toFile(),
                embedding: Embedding(internal: true),
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

  testWidgets('closed document runtime becomes garbage collectable', (
    tester,
  ) async {
    await tester.pumpWidget(buildApp());
    await tester.tap(find.byKey(const ValueKey('open-document')));
    await pumpUntil(
      tester,
      () => observer.lastDocumentBloc?.state is DocumentLoadSuccess,
      'document open for garbage collection',
    );
    await tester.pumpAndSettle();

    final pageState = WeakReference<Object>(
      tester.state(find.byType(ProjectPage)),
    );
    DocumentBloc? documentBloc = observer.lastDocumentBloc!;
    final bloc = WeakReference<Object>(documentBloc);
    final editorController = WeakReference<Object>(
      documentBloc.editorController,
    );

    await tapHomeMenuItem(tester);
    await pumpUntil(
      tester,
      () => observer.documentBlocCloses == 1,
      'document close for garbage collection',
    );
    observer.lastDocumentBloc = null;
    observer.lastSaveCubit = null;
    documentBloc = null;
    await tester.pumpAndSettle();

    for (
      var cycle = 0;
      cycle < 20 &&
          (pageState.target != null ||
              bloc.target != null ||
              editorController.target != null);
      cycle++
    ) {
      await tester.runAsync(() async {
        final garbage = List.generate(64, (_) => Uint8List(1024 * 1024));
        garbage[cycle % garbage.length][0] = cycle;
        await Future<void>.delayed(Duration.zero);
      });
      await tester.pump();
    }

    expect(
      <Object?>[pageState.target, bloc.target, editorController.target],
      everyElement(isNull),
      reason: 'The closed route must not retain its page, bloc, or controller.',
    );
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
