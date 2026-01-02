import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/home/page.dart';
import 'package:butterfly/views/files/view.dart';
import 'package:butterfly/views/files/recently.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/l10n/leap_localizations.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MockSettingsCubit extends Mock implements SettingsCubit {}

class MockButterflyFileSystem extends Mock implements ButterflyFileSystem {}

void main() {
  late MockSettingsCubit settingsCubit;
  late MockButterflyFileSystem butterflyFileSystem;
  late MockTypedKeyFileSystem<NoteData> templateFileSystem;
  late MockTypedDirectoryFileSystem<NoteFile> documentFileSystem;

  setUp(() {
    settingsCubit = MockSettingsCubit();
    butterflyFileSystem = MockButterflyFileSystem();
    final mockConfig = FileSystemConfig(
      passwordStorage: MockPasswordStorage(),
      storeName: '',
      getDirectory: (storage) => Future.value(''),
      database: '',
      databaseVersion: 1,
    );
    templateFileSystem = MockTypedKeyFileSystem<NoteData>(
      config: mockConfig,
      onEncode: encodeNoteData,
      onDecode: decodeNoteData,
    );
    documentFileSystem = MockTypedDirectoryFileSystem<NoteFile>(
      config: mockConfig,
      onEncode: encodeNoteFile,
      onDecode: decodeNoteFile,
    );

    when(() => settingsCubit.state).thenReturn(const ButterflySettings());
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => settingsCubit.hasNewerVersion()).thenAnswer((_) async => false);
    when(() => settingsCubit.getRemote(any())).thenReturn(null);

    when(
      () => butterflyFileSystem.buildTemplateSystem(any()),
    ).thenReturn(templateFileSystem);
    when(
      () => butterflyFileSystem.buildDocumentSystem(any()),
    ).thenReturn(documentFileSystem);
    when(() => butterflyFileSystem.buildAllDocumentSystems()).thenReturn({});
  });

  Widget createWidgetUnderTest() {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ButterflyFileSystem>.value(
          value: butterflyFileSystem,
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          LeapLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<SettingsCubit>.value(
          value: settingsCubit,
          child: const HomePage(),
        ),
      ),
    );
  }

  testWidgets('HomePage renders desktop layout correctly', (tester) async {
    // Set screen size to desktop
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Verify HomePage is present
    expect(find.byType(HomePage), findsOneWidget);

    // Verify FilesView is present
    expect(find.byType(FilesView), findsOneWidget);

    // Verify Quickstart section (via text, as the widget is private)
    expect(find.byIcon(PhosphorIconsLight.wrench), findsOneWidget);

    // Verify Header section
    expect(find.byIcon(PhosphorIconsLight.bookOpen), findsOneWidget);

    // Reset screen size
    addTearDown(tester.view.resetPhysicalSize);
  });

  testWidgets('HomePage renders mobile layout correctly', (tester) async {
    // Set screen size to mobile
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Verify NavigationBar is present
    expect(find.byType(NavigationBar), findsOneWidget);

    // Verify "Home" tab is selected (default)
    expect(find.byType(RecentFilesView), findsOneWidget);
    expect(
      find.byIcon(PhosphorIconsLight.wrench),
      findsOneWidget,
    ); // Quickstart

    // Switch to Files tab
    await tester.tap(find.byIcon(PhosphorIconsLight.folder));
    await tester.pumpAndSettle();

    // Verify FilesView is present
    expect(find.byType(FilesView), findsOneWidget);

    // Switch to Settings tab
    await tester.tap(find.byIcon(PhosphorIconsLight.gear));
    await tester.pumpAndSettle();

    // Verify SettingsPage is present (we can look for a specific widget in SettingsPage or just that FilesView is gone)
    expect(find.byType(FilesView), findsNothing);

    // Reset screen size
    addTearDown(tester.view.resetPhysicalSize);
  });
}
