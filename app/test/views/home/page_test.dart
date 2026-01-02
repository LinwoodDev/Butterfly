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
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:archive/archive.dart';
import '../../helpers/mocks.dart';

void main() {
  late MockSettingsCubit settingsCubit;
  late MockButterflyFileSystem butterflyFileSystem;

  setUpAll(() {
    registerFallbackValue(BannerVisibility.always);
  });

  setUp(() {
    settingsCubit = MockSettingsCubit();
    butterflyFileSystem = MockButterflyFileSystem();

    when(() => settingsCubit.state).thenReturn(const ButterflySettings());
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => settingsCubit.hasNewerVersion()).thenAnswer((_) async => false);
    when(() => settingsCubit.getRemote(any())).thenReturn(null);
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

  testWidgets('Quickstart shows favorite templates', (tester) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    final favoriteTemplate = const FavoriteLocation(
      path: 'test_template',
      remote: 'test_remote',
    );
    when(
      () => settingsCubit.state,
    ).thenReturn(ButterflySettings(favoriteTemplates: [favoriteTemplate]));

    final metadata = FileMetadata(
      name: 'Test Template',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      type: NoteFileType.template,
      fileVersion: 1,
    );
    var noteData = NoteData(Archive());
    noteData = noteData.setMetadata(metadata);

    butterflyFileSystem.buildTemplateSystem().updateFile(
      'test_template',
      noteData,
    );

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Test Template'), findsOneWidget);

    addTearDown(tester.view.resetPhysicalSize);
  });

  testWidgets('Header changes banner visibility', (tester) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    when(() => settingsCubit.state).thenReturn(
      const ButterflySettings(bannerVisibility: BannerVisibility.always),
    );
    when(
      () => settingsCubit.changeBannerVisibility(any()),
    ).thenAnswer((_) async {});

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Find the visibility button. It has a tooltip 'Visibility'.
    final visibilityButton = find.byTooltip('Visibility');
    expect(visibilityButton, findsOneWidget);

    await tester.tap(visibilityButton);
    await tester.pumpAndSettle();

    // Verify menu items are shown
    expect(find.text('Never'), findsOneWidget);

    // Tap 'Never'
    await tester.tap(find.text('Never'));
    await tester.pumpAndSettle();

    verify(
      () => settingsCubit.changeBannerVisibility(BannerVisibility.never),
    ).called(1);

    addTearDown(tester.view.resetPhysicalSize);
  });

  testWidgets('HomePage renders tablet layout correctly', (tester) async {
    // Set screen size to tablet (between compact and expanded)
    // Assuming compact=600, expanded=840. 700 should be safe.
    tester.view.physicalSize = const Size(700, 1000);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Verify HomePage is present
    expect(find.byType(HomePage), findsOneWidget);

    // Verify FilesView is present
    expect(find.byType(FilesView), findsOneWidget);

    // Verify Quickstart section
    expect(find.byIcon(PhosphorIconsLight.wrench), findsOneWidget);

    // Verify Header section
    expect(find.byIcon(PhosphorIconsLight.bookOpen), findsOneWidget);

    // Verify layout is Column (not Row like desktop)
    final filesViewFinder = find.byType(FilesView);
    final quickstartFinder = find.byIcon(PhosphorIconsLight.wrench);

    final filesViewCenter = tester.getCenter(filesViewFinder);
    final quickstartCenter = tester.getCenter(quickstartFinder);

    // In tablet (Column), Quickstart is above FilesView
    expect(quickstartCenter.dy, lessThan(filesViewCenter.dy));

    // Reset screen size
    addTearDown(tester.view.resetPhysicalSize);
  });

  testWidgets('HomePage shows update banner when available and enabled', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    when(() => settingsCubit.hasNewerVersion()).thenAnswer((_) async => true);
    when(() => settingsCubit.state).thenReturn(
      const ButterflySettings(bannerVisibility: BannerVisibility.always),
    );

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Verify "What's New" button is present
    expect(find.text("What's new?"), findsOneWidget);

    // Verify it is a FilledButton (since hasNewerVersion is true)
    expect(find.byType(FilledButton), findsOneWidget);

    addTearDown(tester.view.resetPhysicalSize);
  });

  testWidgets('HomePage hides update banner when disabled', (tester) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    when(() => settingsCubit.hasNewerVersion()).thenAnswer((_) async => true);
    when(() => settingsCubit.state).thenReturn(
      const ButterflySettings(bannerVisibility: BannerVisibility.never),
    );

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Verify "What's New" button is present in the tree (it's always built)
    expect(find.text("What's new?"), findsOneWidget);

    // But it should not be visible/hit-testable because SizeTransition hides it
    expect(find.text("What's new?").hitTestable(), findsNothing);

    addTearDown(tester.view.resetPhysicalSize);
  });

  testWidgets('Header buttons are present', (tester) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Verify Documentation button (TextButton, so look for text)
    expect(find.text('Documentation'), findsOneWidget);

    // Verify Settings button (IconButton, so look for tooltip)
    expect(find.byTooltip('Settings'), findsOneWidget);

    addTearDown(tester.view.resetPhysicalSize);
  });
}
