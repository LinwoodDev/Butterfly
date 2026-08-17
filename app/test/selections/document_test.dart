import 'dart:math';

import 'package:archive/archive.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/selections/selection.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('camera sliders follow transform changes', (tester) async {
    final fileSystem = MockButterflyFileSystem();
    final settingsCubit = fileSystem.settingsCubit as MockSettingsCubit;
    when(() => settingsCubit.state)
        .thenReturn(const ButterflySettings(autosave: false));
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());

    final transformCubit = TransformCubit(1);
    final editorController = EditorController(
      settingsCubit,
      transformCubit,
      CameraViewport.unbaked(),
    );
    final windowCubit = WindowCubit(fullScreen: false);
    const page = DocumentPage();
    final (data, pageName) = NoteData(Archive()).setPage(page, 'Page');
    final bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'document-selection-test.bfly'),
      null,
      page,
      pageName,
    );
    addTearDown(() async {
      await bloc.close();
      await editorController.close();
      await windowCubit.close();
    });

    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ButterflyFileSystem>.value(value: fileSystem),
          RepositoryProvider<EditorController>.value(value: editorController),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: bloc),
            BlocProvider.value(value: transformCubit),
          ],
          child: MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: const [
              ...AppLocalizations.localizationsDelegates,
              LeapLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: Builder(
                builder: (context) => ListView(
                  children: DocumentSelection(editorController)
                      .buildProperties(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Camera'));
    await tester.pumpAndSettle();

    List<double> sliderValues() => tester
        .widgetList<ExactSlider>(find.byType(ExactSlider))
        .map((slider) => slider.value)
        .toList();

    expect(sliderValues(), [100, 0]);

    transformCubit
      ..zoom(2)
      ..rotate(pi / 12);
    await tester.pumpAndSettle();

    final values = sliderValues();
    expect(values.first, 200);
    expect(values.last, closeTo(15, 1e-9));
  });

  testWidgets('encryption tile follows document encryption changes', (
    tester,
  ) async {
    final fileSystem = MockButterflyFileSystem();
    final settingsCubit = fileSystem.settingsCubit as MockSettingsCubit;
    when(() => settingsCubit.state)
        .thenReturn(const ButterflySettings(autosave: false));
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());

    final transformCubit = TransformCubit(1);
    final editorController = EditorController(
      settingsCubit,
      transformCubit,
      CameraViewport.unbaked(),
    );
    final windowCubit = WindowCubit(fullScreen: false);
    final data = DocumentDefaults.createDocument(name: 'Encrypted')
        .changePassword('password');
    final pageName = data.getPages().first;
    final page = data.getPage(pageName)!;
    final bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'encrypted.bfly'),
      null,
      page,
      pageName,
    );
    addTearDown(() async {
      await bloc.close();
      await editorController.close();
      await windowCubit.close();
    });

    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ButterflyFileSystem>.value(value: fileSystem),
          RepositoryProvider<EditorController>.value(value: editorController),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: bloc),
            BlocProvider.value(value: transformCubit),
          ],
          child: MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: const [
              ...AppLocalizations.localizationsDelegates,
              LeapLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: Builder(
                builder: (context) => ListView(
                  children: DocumentSelection(editorController)
                      .buildProperties(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Unencrypt'), findsOneWidget);
    await tester.tap(find.text('Unencrypt'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'OK'));
    await tester.pumpAndSettle();

    expect((bloc.state as DocumentLoadSuccess).data.isEncrypted, isFalse);
    expect(find.text('Unencrypted'), findsOneWidget);
    expect(find.text('Encrypt'), findsOneWidget);

    await tester.tap(find.text('Encrypt'));
    await tester.pumpAndSettle();
    final passwordFields = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.byType(TextFormField),
    );
    await tester.enterText(passwordFields.at(0), 'new password');
    await tester.enterText(passwordFields.at(1), 'new password');
    await tester.tap(find.widgetWithText(ElevatedButton, 'OK'));
    await tester.pumpAndSettle();

    expect((bloc.state as DocumentLoadSuccess).data.isEncrypted, isTrue);
    expect(find.text('Encrypted'), findsOneWidget);
    expect(find.text('Unencrypt'), findsOneWidget);
  });
}
