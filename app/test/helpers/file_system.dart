import 'dart:typed_data';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/services/sync.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly/widgets/file_name_display.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

class _MockSyncService extends Mock implements SyncService {}

MockSettingsCubit configureFileSystemSettings(
  MockButterflyFileSystem fileSystem,
) {
  final settings = fileSystem.settingsCubit as MockSettingsCubit;
  when(() => settings.state)
      .thenReturn(const ButterflySettings(showThumbnails: false));
  when(() => settings.stream).thenAnswer((_) => const Stream.empty());
  when(() => settings.getRemote(any())).thenReturn(null);
  when(
    () => settings.moveAssetReferences(
      any(),
      any(),
      directory: any(named: 'directory'),
    ),
  ).thenAnswer((_) async {});
  when(() => settings.removeRecentHistory(any())).thenAnswer((_) async {});
  return settings;
}

Widget buildFileSystemTestApp({
  required MockButterflyFileSystem fileSystem,
  required Widget child,
}) => MultiRepositoryProvider(
  providers: [
    RepositoryProvider<ButterflyFileSystem>.value(value: fileSystem),
    RepositoryProvider<SyncService>.value(value: _MockSyncService()),
  ],
  child: BlocProvider<SettingsCubit>.value(
    value: fileSystem.settingsCubit,
    child: MaterialApp(
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        LeapLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    ),
  ),
);

Future<FileSystemFile<NoteFile>> createTestNote(
  DocumentFileSystem system,
  String path,
) => system.createFile(path, NoteFile(Uint8List.fromList([1, 2, 3])));

Future<void> startFileRename(WidgetTester tester, Finder item) async {
  final label = find.descendant(
    of: item,
    matching: find.byType(FileNameDisplay),
  );
  await tester.tap(label);
  await tester.pump(const Duration(milliseconds: 100));
  await tester.tap(label);
  await tester.pumpAndSettle();
}
