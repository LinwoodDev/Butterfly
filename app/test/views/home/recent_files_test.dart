import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:archive/archive.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/files/card.dart';
import 'package:butterfly/views/files/recent.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mocks.dart';

void main() {
  late MockSettingsCubit settingsCubit;
  late MockButterflyFileSystem butterflyFileSystem;
  late StreamController<ButterflySettings> settingsController;
  late ButterflySettings settings;

  setUp(() async {
    settings = const ButterflySettings(
      history: [AssetLocation(path: '/folder/note.bfly')],
      hideExtension: true,
      showThumbnails: false,
    );
    settingsController = StreamController<ButterflySettings>.broadcast();
    settingsCubit = MockSettingsCubit();
    butterflyFileSystem = MockButterflyFileSystem(settingsCubit: settingsCubit);

    when(() => settingsCubit.state).thenAnswer((_) => settings);
    when(() => settingsCubit.stream)
        .thenAnswer((_) => settingsController.stream);
    when(() => settingsCubit.getRemote(any())).thenReturn(null);

    await butterflyFileSystem.buildDocumentSystem().updateFile(
      '/folder/note.bfly',
      NoteData(Archive())
          .setThumbnail(
            base64Decode(
              'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+jRZkAAAAASUVORK5CYII=',
            ),
          )
          .toFile(),
    );
  });

  tearDown(() async {
    await settingsController.close();
  });

  Widget createWidgetUnderTest() {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ButterflyFileSystem>.value(
          value: butterflyFileSystem,
        ),
      ],
      child: MaterialApp(
        home: BlocProvider<SettingsCubit>.value(
          value: settingsCubit,
          child: const RecentFilesView(replace: false),
        ),
      ),
    );
  }

  testWidgets('hides file extension in recent file path', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('folder/note'), findsOneWidget);
    expect(find.text('folder/note.bfly'), findsNothing);
  });

  testWidgets('updates recent file path when hide extension changes', (
    tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    settings = settings.copyWith(hideExtension: false);
    settingsController.add(settings);
    await tester.pumpAndSettle();

    expect(find.text('folder/note.bfly'), findsOneWidget);
    expect(find.text('folder/note'), findsNothing);
  });

  testWidgets('refreshes recent thumbnails when the setting changes', (
    tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(tester.widget<AssetCard>(find.byType(AssetCard)).thumbnail, isNull);

    settings = settings.copyWith(showThumbnails: true);
    settingsController.add(settings);
    await tester.pumpAndSettle();

    expect(
      tester.widget<AssetCard>(find.byType(AssetCard)).thumbnail,
      isNotNull,
    );
  });

  testWidgets('recent card tooltip stays clear near the screen bottom', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 200,
              height: 128,
              child: AssetCard(
                metadata: null,
                thumbnail: null,
                name: 'note',
                tooltip: 'path/to/note.bfly',
                onTap: () {},
              ),
            ),
          ),
        ),
      ),
    );
    final card = find.byType(AssetCard);
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: tester.getCenter(card));
    await mouse.moveTo(tester.getCenter(card) + const Offset(1, 0));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));

    expect(
      tester.getBottomLeft(find.text('path/to/note.bfly')).dy,
      lessThan(tester.getTopLeft(card).dy),
    );
    await mouse.removePointer();
  });
}
