import 'dart:async';

import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

Future<void> _settleBlocEvents() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockButterflyFileSystem fileSystem;
  late MockSettingsCubit settingsCubit;
  late CurrentIndexCubit currentIndexCubit;
  late WindowCubit windowCubit;
  late DocumentBloc bloc;

  setUp(() {
    fileSystem = MockButterflyFileSystem();
    settingsCubit = fileSystem.settingsCubit as MockSettingsCubit;

    when(
      () => settingsCubit.state,
    ).thenReturn(const ButterflySettings(autosave: false));
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());

    currentIndexCubit = CurrentIndexCubit(
      settingsCubit,
      TransformCubit(1),
      const CameraViewport.unbaked(),
    );
    windowCubit = WindowCubit(fullScreen: false);

    var data = NoteData(Archive());
    const firstPage = DocumentPage(
      layers: [DocumentLayer(id: 'first-page-layer')],
    );
    const secondPage = DocumentPage(
      layers: [DocumentLayer(id: 'second-page-layer')],
    );

    final (firstData, _) = data.setPage(firstPage, 'Page 1');
    data = firstData;
    final (secondData, secondPageName) = data.setPage(secondPage, 'Page 2');
    data = secondData;

    bloc = DocumentBloc(
      fileSystem,
      currentIndexCubit,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      const [],
      null,
      secondPage,
      secondPageName,
    );
  });

  tearDown(() async {
    await bloc.close();
    await currentIndexCubit.close();
    await windowCubit.close();
  });

  test(
    'renaming non-active page keeps active page and preserves page contents',
    () async {
      final initialState = bloc.state as DocumentLoadSuccess;
      final pages = initialState.data.getPages(true);
      final firstPageName = pages.firstWhere(
        (name) => name.endsWith('.Page 1'),
      );
      final secondPageName = pages.firstWhere(
        (name) => name.endsWith('.Page 2'),
      );

      expect(initialState.pageName, secondPageName);
      expect(initialState.page.layers.first.id, 'second-page-layer');

      bloc.add(PageRenamed(firstPageName, 'Renamed Page 1'));
      await _settleBlocEvents();

      final renamedState = bloc.state as DocumentLoadSuccess;
      expect(renamedState.pageName, secondPageName);
      expect(renamedState.page.layers.first.id, 'second-page-layer');

      final renamedPage = renamedState.data.getPage('Renamed Page 1');
      expect(renamedPage, isNotNull);
      expect(renamedPage!.layers.first.id, 'first-page-layer');

      bloc.add(const PageChanged('Renamed Page 1'));
      await _settleBlocEvents();

      final changedState = bloc.state as DocumentLoadSuccess;
      expect(changedState.page.layers.first.id, 'first-page-layer');
      expect(
        changedState.data.getPage('Page 2')?.layers.first.id,
        'second-page-layer',
      );
    },
  );

  test('renaming active page updates current page name', () async {
    final initialState = bloc.state as DocumentLoadSuccess;
    final secondPageName = initialState.data
        .getPages(true)
        .firstWhere((name) => name.endsWith('.Page 2'));

    bloc.add(PageRenamed(secondPageName, 'Renamed Active Page'));
    await _settleBlocEvents();

    final renamedState = bloc.state as DocumentLoadSuccess;
    expect(renamedState.pageName, endsWith('.Renamed Active Page'));
    expect(renamedState.page.layers.first.id, 'second-page-layer');
    expect(
      renamedState.data.getPage('Renamed Active Page')?.layers.first.id,
      'second-page-layer',
    );
  });
}
