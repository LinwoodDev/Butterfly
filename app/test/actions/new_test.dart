import 'package:archive/archive.dart';
import 'package:butterfly/actions/new.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  late MockSettingsCubit settingsCubit;
  late MockButterflyFileSystem fileSystem;
  late GoRouter router;
  String? openedPath;
  String? openedRemote;
  Object? openedData;

  setUp(() {
    settingsCubit = MockSettingsCubit();
    fileSystem = MockButterflyFileSystem(settingsCubit: settingsCubit);
    openedPath = null;
    openedRemote = null;
    openedData = null;

    when(() => settingsCubit.state).thenReturn(const ButterflySettings());
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  tearDown(() => router.dispose());

  Widget buildApp(NoteData template) {
    router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: TextButton(
              onPressed: () => openNewDocument(context, true, template),
              child: const Text('Create'),
            ),
          ),
        ),
        GoRoute(
          name: 'new',
          path: '/new',
          builder: (context, state) {
            openedPath = state.uri.queryParameters['path'];
            openedRemote = state.uri.queryParameters['remote'];
            openedData = state.extra;
            return const Scaffold(body: Text('Opened'));
          },
        ),
      ],
    );

    return RepositoryProvider<ButterflyFileSystem>.value(
      value: fileSystem,
      child: BlocProvider<SettingsCubit>.value(
        value: settingsCubit,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
  }

  testWidgets('template file name creates the document before opening it', (
    tester,
  ) async {
    var template = NoteData(Archive());
    template = template.setMetadata(
      const FileMetadata(
        type: NoteFileType.template,
        name: 'Journal template',
        directory: 'journals',
        fileName: 'Journal entry',
      ),
    );

    await tester.pumpWidget(buildApp(template));
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();

    expect(find.text('Opened'), findsOneWidget);
    expect(openedPath, endsWith('journals/Journal entry.bfly'));
    expect(openedRemote, '');
    expect((openedData as NoteData).getMetadata()?.name, 'Journal entry');

    final asset = await fileSystem.buildDocumentSystem().getAsset(openedPath!);
    expect(asset, isA<FileSystemFile<NoteFile>>());
    final saved = (asset as FileSystemFile<NoteFile>).data?.display();
    expect(saved?.getMetadata()?.name, 'Journal entry');
  });

  testWidgets('settings file name is used when template has none', (
    tester,
  ) async {
    when(
      () => settingsCubit.state,
    ).thenReturn(const ButterflySettings(defaultFileName: 'Default note'));
    var template = NoteData(Archive());
    template = template.setMetadata(
      const FileMetadata(
        type: NoteFileType.template,
        name: 'Legacy template',
        directory: 'journals',
      ),
    );

    await tester.pumpWidget(buildApp(template));
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();

    expect(find.text('Opened'), findsOneWidget);
    expect(openedPath, endsWith('journals/Default note.bfly'));
    expect((openedData as NoteData).getMetadata()?.name, 'Default note');
  });

  testWidgets('template file name overrides the settings default', (
    tester,
  ) async {
    when(
      () => settingsCubit.state,
    ).thenReturn(const ButterflySettings(defaultFileName: 'Default note'));
    var template = NoteData(Archive());
    template = template.setMetadata(
      const FileMetadata(
        type: NoteFileType.template,
        directory: 'journals',
        fileName: 'Template note',
      ),
    );

    await tester.pumpWidget(buildApp(template));
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();

    expect(openedPath, endsWith('journals/Template note.bfly'));
    expect((openedData as NoteData).getMetadata()?.name, 'Template note');
  });
}
