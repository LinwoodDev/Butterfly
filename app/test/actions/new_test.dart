import 'dart:typed_data';

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

class _MockDocumentFileSystem extends Mock implements DocumentFileSystem {}

class _TrackingButterflyFileSystem extends MockButterflyFileSystem {
  _TrackingButterflyFileSystem({
    required super.settingsCubit,
    required this.documentSystem,
  });

  final DocumentFileSystem documentSystem;
  ExternalStorage? lastStorage;

  @override
  DocumentFileSystem buildDocumentSystem([
    ExternalStorage? storage,
    bool forceRecreate = false,
  ]) {
    lastStorage = storage;
    return documentSystem;
  }
}

void main() {
  late MockSettingsCubit settingsCubit;
  late MockButterflyFileSystem fileSystem;
  late GoRouter router;
  String? openedPath;
  String? openedRemote;
  Object? openedData;

  setUpAll(() => registerFallbackValue(NoteFile(Uint8List(0))));

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

  Widget buildApp(NoteData template, {String? remote, bool autoSave = true}) {
    router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: TextButton(
              onPressed: () => openNewDocument(
                context,
                true,
                template: template,
                remote: remote,
                autoSave: autoSave,
              ),
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

  testWidgets('template without a name delegates to the file system default', (
    tester,
  ) async {
    final documentSystem = _MockDocumentFileSystem();
    fileSystem = _TrackingButterflyFileSystem(
      settingsCubit: settingsCubit,
      documentSystem: documentSystem,
    );
    when(
      () => documentSystem.createFileWithName(
        any(),
        directory: any(named: 'directory'),
        name: '',
        suffix: any(named: 'suffix'),
      ),
    ).thenAnswer((invocation) async {
      final data = invocation.positionalArguments.first as NoteFile;
      return FileSystemFile(
        AssetLocation.local('journals/Default note.bfly'),
        data: data,
      );
    });
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
    expect((openedData as NoteData).getMetadata()?.name, isEmpty);
    verify(
      () => documentSystem.createFileWithName(
        any(),
        directory: 'journals',
        name: '',
        suffix: '.bfly',
      ),
    ).called(1);
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

  testWidgets('remote template keeps the selected remote identifier', (
    tester,
  ) async {
    const remote = DavRemoteStorage(
      name: 'remote-test',
      username: 'user',
      url: 'https://example.com',
    );
    final documentSystem = _MockDocumentFileSystem();
    final trackingFileSystem = _TrackingButterflyFileSystem(
      settingsCubit: settingsCubit,
      documentSystem: documentSystem,
    );
    fileSystem = trackingFileSystem;
    when(
      () => settingsCubit.state,
    ).thenReturn(const ButterflySettings(connections: [remote]));
    when(
      () => documentSystem.createFileWithName(
        any(),
        directory: any(named: 'directory'),
        name: any(named: 'name'),
        suffix: any(named: 'suffix'),
      ),
    ).thenAnswer((invocation) async {
      final data = invocation.positionalArguments.first as NoteFile;
      return FileSystemFile(
        AssetLocation.local('journals/Remote note.bfly'),
        data: data,
      );
    });
    var template = NoteData(Archive());
    template = template.setMetadata(
      const FileMetadata(
        type: NoteFileType.template,
        directory: 'journals',
        fileName: 'Remote note',
      ),
    );

    await tester.pumpWidget(buildApp(template, remote: remote.identifier));
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();

    expect(find.text('Opened'), findsOneWidget);
    expect(openedPath, 'journals/Remote note.bfly');
    expect(openedRemote, remote.identifier);
    expect(trackingFileSystem.lastStorage, same(remote));
  });

  testWidgets('write failure still opens the document unsaved', (tester) async {
    final documentSystem = _MockDocumentFileSystem();
    fileSystem = _TrackingButterflyFileSystem(
      settingsCubit: settingsCubit,
      documentSystem: documentSystem,
    );
    when(
      () => documentSystem.createFileWithName(
        any(),
        directory: any(named: 'directory'),
        name: any(named: 'name'),
        suffix: any(named: 'suffix'),
      ),
    ).thenThrow(StateError('Storage unavailable'));
    var template = NoteData(Archive());
    template = template.setMetadata(
      const FileMetadata(
        type: NoteFileType.template,
        directory: 'journals',
        fileName: 'Fallback note',
      ),
    );

    await tester.pumpWidget(buildApp(template));
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();

    expect(find.text('Opened'), findsOneWidget);
    expect(openedPath, 'journals');
    expect(openedRemote, isNull);
    expect((openedData as NoteData).getMetadata()?.name, 'Fallback note');
  });

  testWidgets('quick start ignores automatic filename patterns', (
    tester,
  ) async {
    final documentSystem = _MockDocumentFileSystem();
    fileSystem = _TrackingButterflyFileSystem(
      settingsCubit: settingsCubit,
      documentSystem: documentSystem,
    );
    var template = NoteData(Archive());
    template = template.setMetadata(
      const FileMetadata(
        type: NoteFileType.template,
        directory: 'journals',
        fileName: 'Template note',
      ),
    );

    await tester.pumpWidget(buildApp(template, autoSave: false));
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();

    expect(find.text('Opened'), findsOneWidget);
    expect(openedPath, 'journals');
    expect((openedData as NoteData).getMetadata()?.name, isEmpty);
    verifyNever(
      () => documentSystem.createFileWithName(
        any(),
        directory: any(named: 'directory'),
        name: any(named: 'name'),
        suffix: any(named: 'suffix'),
      ),
    );
  });
}
