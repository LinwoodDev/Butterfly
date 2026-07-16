import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/embed/embedding.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly/views/main.dart';
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
  test('internal embedding preserves the user language', () {
    expect(Embedding(internal: true).language, 'user');
  });

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
      'CurrentIndexCubit create/close: '
      '${observer.currentIndexCubitCreates}/${observer.currentIndexCubitCloses}, '
      'events: ${observer.events}, '
      'exception: $exception)',
    );
  }

  Widget buildApp() {
    final document = DocumentDefaults.createDocument(
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
          ],
        ),
      ],
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ButterflyFileSystem>.value(value: fileSystem),
        RepositoryProvider<ClipboardManager>.value(
          value: _TestClipboardManager(),
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

  testWidgets('replacing document route closes document bloc and index cubit', (
    tester,
  ) async {
    await tester.pumpWidget(buildApp());

    for (var i = 1; i <= 3; i++) {
      await tester.tap(find.byKey(const ValueKey('open-document')));
      await pumpUntil(
        tester,
        () =>
            find.byType(ProjectPage).evaluate().isNotEmpty &&
            observer.documentBlocCreates == i &&
            observer.currentIndexCubitCreates == i,
        'document open $i',
      );
      await tester.pump(const Duration(seconds: 1));

      router.go('/');
      await pumpUntil(
        tester,
        () =>
            find.byType(ProjectPage).evaluate().isEmpty &&
            find.byType(ProjectPage, skipOffstage: false).evaluate().isEmpty &&
            observer.documentBlocCloses == i &&
            observer.currentIndexCubitCloses == i,
        'document close $i',
      );
    }

    expect(observer.documentBlocCreates, 3);
    expect(observer.documentBlocCloses, 3);
    expect(observer.currentIndexCubitCreates, 3);
    expect(observer.currentIndexCubitCloses, 3);
  });
}

class _LifecycleObserver extends BlocObserver {
  int documentBlocCreates = 0;
  int documentBlocCloses = 0;
  int currentIndexCubitCreates = 0;
  int currentIndexCubitCloses = 0;
  final events = <String>[];

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    if (bloc is DocumentBloc) {
      documentBlocCreates++;
    } else if (bloc is CurrentIndexCubit) {
      currentIndexCubitCreates++;
    }
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    if (bloc is DocumentBloc) {
      documentBlocCloses++;
    } else if (bloc is CurrentIndexCubit) {
      currentIndexCubitCloses++;
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

class _TestClipboardManager implements ClipboardManager {
  ClipboardContent? _content;

  @override
  ClipboardContent? getContent() => _content;

  @override
  void setContent(ClipboardContent content) => _content = content;
}
