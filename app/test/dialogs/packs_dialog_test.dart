import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/packs/dialog.dart';
import 'package:butterfly/dialogs/packs/pack.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

class _WidgetPackFileSystem extends TypedKeyFileSystem<NoteData> {
  _WidgetPackFileSystem()
    : super.raw(
        MockKeyFileSystem(),
        config: const MockFileSystemConfig(),
        onEncode: encodeNoteData,
        onDecode: decodeNoteData,
      );

  // Stream-backed enumeration can wait on real events in widget tests.
  @override
  Future<List<FileSystemFile<NoteData>>> getFiles() async {
    final files = <FileSystemFile<NoteData>>[];
    for (final key in await getKeys()) {
      final pack = await getFile(key);
      if (pack != null) {
        files.add(FileSystemFile(AssetLocation(path: key), data: pack));
      }
    }
    return files;
  }
}

class _WidgetFileSystem extends MockButterflyFileSystem {
  final local = _WidgetPackFileSystem();
  final secondary = _WidgetPackFileSystem();

  @override
  PackFileSystem buildDefaultPackSystem({bool forceRecreate = false}) => local;

  @override
  PackFileSystem buildPackSystem([
    ExternalStorage? storage,
    bool forceRecreate = false,
  ]) => storage == null ? local : secondary;
}

NoteData _pack(String name, {String author = '', String description = ''}) =>
    DocumentDefaults.createPack().setMetadata(
      DocumentDefaults.createMetadata(
        type: NoteFileType.pack,
        name: name,
      ).copyWith(author: author, description: description),
    );

Future<void> _openDialog(
  WidgetTester tester,
  Widget dialog, {
  Size size = const Size(1280, 900),
  MockButterflyFileSystem? fileSystem,
  ButterflySettings settings = const ButterflySettings(autosave: false),
  ValueChanged<NoteData?>? onResult,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  Widget app = MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: const [
      ...AppLocalizations.localizationsDelegates,
      LeapLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: Builder(
        builder: (context) => TextButton(
          child: const Text('Open'),
          onPressed: () async {
            final result = await showDialog<NoteData>(
              context: context,
              builder: (_) => dialog,
            );
            onResult?.call(result);
          },
        ),
      ),
    ),
  );
  if (fileSystem != null) {
    final settingsCubit = fileSystem.settingsCubit as MockSettingsCubit;
    when(() => settingsCubit.state).thenReturn(settings);
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => settingsCubit.getRemote(any())).thenAnswer(
      (invocation) => settings.getRemote(invocation.positionalArguments.first),
    );
    app = RepositoryProvider<ButterflyFileSystem>.value(
      value: fileSystem,
      child: BlocProvider<SettingsCubit>.value(
        value: settingsCubit,
        child: app,
      ),
    );
  }
  await tester.pumpWidget(app);
  await tester.tap(find.text('Open'));
  await tester.pumpAndSettle();
}

Finder _section(String name) =>
    find.widgetWithText(NavigationDrawerDestination, name);

void main() {
  testWidgets('pack edits are saved only when confirmed', (tester) async {
    NoteData? saved;
    final pack = _pack('Studio').setPalette('Ocean', ColorPalette());
    await _openDialog(
      tester,
      PackDialog(pack: pack),
      onResult: (value) => saved = value,
    );

    await tester.enterText(find.byType(TextFormField).first, 'Updated studio');
    await tester.pumpAndSettle();
    await tester.tap(_section('Palettes'));
    await tester.pumpAndSettle();
    expect(find.text('Ocean'), findsOneWidget);
    await tester.tap(find.byTooltip('Delete'));
    await tester.pumpAndSettle();
    expect(find.text('No elements'), findsOneWidget);
    await tester.tap(_section('General'));
    await tester.pumpAndSettle();
    expect(find.text('Updated studio'), findsAtLeastNWidgets(1));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    expect(saved?.getMetadata()?.name, 'Updated studio');
    expect(saved?.getPalettes(), isEmpty);
    expect(pack.getPalettes(), ['Ocean']);
    saved = null;
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, 'Discarded');
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(saved, isNull);
    expect(pack.name, 'Studio');
    expect(tester.takeException(), isNull);
  });

  testWidgets('mobile navigation preserves edits between pack pages', (
    tester,
  ) async {
    NoteData? saved;
    final pack = _pack('Studio').setPalette('Ocean', ColorPalette());
    await _openDialog(
      tester,
      PackDialog(pack: pack),
      size: const Size(390, 844),
      onResult: (value) => saved = value,
    );
    await tester.enterText(find.byType(TextFormField).first, 'Mobile studio');
    await tester.tap(find.byType(DrawerButton));
    await tester.pumpAndSettle();
    await tester.tap(_section('Palettes'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();
    expect(saved?.name, 'Mobile studio');
    expect(saved?.getPalettes(), isEmpty);
    expect(pack.getPalettes(), ['Ocean']);
  });

  testWidgets('new packs include assets added before creation', (tester) async {
    NoteData? saved;
    await _openDialog(
      tester,
      const PackDialog(),
      onResult: (value) => saved = value,
    );
    await tester.enterText(find.byType(TextFormField).first, 'New collection');
    await tester.pumpAndSettle();
    await tester.tap(_section('Palettes'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Create').first);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Evening');
    await tester.tap(find.text('Create').last);
    await tester.pumpAndSettle();
    expect(find.text('Evening'), findsOneWidget);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Create').last);
    await tester.pumpAndSettle();
    expect(saved?.getMetadata()?.name, 'New collection');
    expect(saved?.getPalettes(), ['Evening']);
  });

  testWidgets(
    'library search matches authors and descriptions and can be cleared',
    (tester) async {
      final fileSystem = _WidgetFileSystem();
      await tester.runAsync(() async {
        await fileSystem.createPack(_pack('Nature', author: 'Alex'));
        await fileSystem.createPack(
          _pack('Studio', description: 'Ink brushes'),
        );
      });
      await _openDialog(
        tester,
        const PacksDialog(globalOnly: true),
        fileSystem: fileSystem,
      );
      await tester.enterText(find.byType(TextField), 'alex');
      await tester.pumpAndSettle();
      expect(find.text('Nature'), findsOneWidget);
      expect(find.text('Studio'), findsNothing);
      await tester.enterText(find.byType(TextField), 'brushes');
      await tester.pumpAndSettle();
      expect(find.text('Studio'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'missing');
      await tester.pumpAndSettle();
      expect(find.text('No results found'), findsOneWidget);
      await tester.tap(find.byTooltip('Clear text'));
      await tester.pumpAndSettle();
      expect(find.text('Nature'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('connection changes apply to pack edits, deletes and creation', (
    tester,
  ) async {
    final fileSystem = _WidgetFileSystem();
    const storage = LocalStorage(name: 'Archive');
    await tester.runAsync(() async {
      await fileSystem.createPack(_pack('Local pack'));
      await fileSystem.createPack(_pack('Archived pack'), storage: storage);
    });
    await _openDialog(
      tester,
      const PacksDialog(globalOnly: true),
      fileSystem: fileSystem,
      settings: const ButterflySettings(
        autosave: false,
        connections: [storage],
      ),
    );
    await tester.tap(find.byTooltip('Connection'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Archive'));
    await tester.pumpAndSettle();
    expect(find.text('Local pack'), findsNothing);
    await tester.tap(find.text('Archived pack'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, 'Updated archive');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();
    expect(find.text('Updated archive'), findsOneWidget);
    await tester.tap(find.byTooltip('Actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(find.text('There are currently no packs available'), findsOneWidget);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Create pack'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, 'New archive');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Create'));
    await tester.pumpAndSettle();
    final local = (await tester.runAsync(
      () => fileSystem.buildDefaultPackSystem().getFiles(),
    ))!;
    final secondary = (await tester.runAsync(
      () => fileSystem.secondary.getFiles(),
    ))!;
    expect(local.single.data?.name, 'Local pack');
    expect(secondary.single.data?.name, 'New archive');
    expect(tester.takeException(), isNull);
  });
}
