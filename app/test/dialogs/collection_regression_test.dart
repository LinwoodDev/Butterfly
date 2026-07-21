import 'package:archive/archive.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/collections.dart';
import 'package:butterfly/dialogs/layers.dart';
import 'package:butterfly/models/viewport.dart';
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

  testWidgets('move to layer keeps the layer picker open', (tester) async {
    final fileSystem = MockButterflyFileSystem();
    final settingsCubit = fileSystem.settingsCubit as MockSettingsCubit;
    when(
      () => settingsCubit.state,
    ).thenReturn(const ButterflySettings(autosave: false));
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());

    final editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(),
    );
    final windowCubit = WindowCubit(fullScreen: false);
    final element = PenElement(id: 'element', collection: 'collection');
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'bottom', name: 'Bottom'),
        DocumentLayer(id: 'top', name: 'Top', content: [element]),
      ],
    );
    final (data, pageName) = NoteData(Archive()).setPage(page, 'Page');
    final bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'regression-test.bfly'),
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
      RepositoryProvider<ButterflyFileSystem>.value(
        value: fileSystem,
        child: BlocProvider.value(
          value: bloc,
          child: MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: const [
              ...AppLocalizations.localizationsDelegates,
              LeapLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: const Scaffold(body: CollectionsDialog()),
          ),
        ),
      ),
    );
    bloc.add(const CurrentCollectionChanged('collection'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Move to layer'));
    await tester.pumpAndSettle();

    expect(find.byType(MoveToLayerDialog), findsOneWidget);
    await tester.tap(find.text('Bottom'));
    await tester.pumpAndSettle();

    final state = bloc.state as DocumentLoadSuccess;
    expect(state.page.getLayer('bottom').content.single.id, 'element');
  });
}
