import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('placing imported strokes preserves their relative positions', (
    tester,
  ) async {
    final fileSystem = MockButterflyFileSystem();
    final settingsCubit = fileSystem.settingsCubit as MockSettingsCubit;
    when(
      () => settingsCubit.state,
    ).thenReturn(const ButterflySettings(autosave: false));
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());
    final transformCubit = TransformCubit(1);
    final currentIndexCubit = CurrentIndexCubit(
      settingsCubit,
      transformCubit,
      const CameraViewport.unbaked(),
    );
    final windowCubit = WindowCubit(fullScreen: false);
    final page = DocumentPage(layers: [DocumentLayer(id: 'layer')]);
    final (data, pageName) = NoteData(Archive()).setPage(page, 'Page 1');
    final bloc = DocumentBloc(
      fileSystem,
      currentIndexCubit,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );
    addTearDown(() async {
      await bloc.close();
      await currentIndexCubit.close();
      await windowCubit.close();
    });
    BuildContext? buildContext;
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<DocumentBloc>.value(value: bloc),
          BlocProvider<TransformCubit>.value(value: transformCubit),
          BlocProvider<CurrentIndexCubit>.value(value: currentIndexCubit),
        ],
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              buildContext = context;
              return const SizedBox();
            },
          ),
        ),
      ),
    );
    final handler = ImportHandler(
      ImportTool(
        elements: [
          PenElement(points: const [PathPoint(0, 0), PathPoint(10, 10)]),
          PenElement(points: const [PathPoint(100, 50), PathPoint(110, 60)]),
        ],
        areas: const [],
      ),
    );
    final eventContext = EventContext(
      buildContext!,
      const Size(800, 600),
      false,
      false,
      false,
    );

    await handler.onPointerHover(
      const PointerHoverEvent(position: Offset(200, 200)),
      eventContext,
    );

    final state = bloc.state as DocumentLoadSuccess;
    final strokes = handler
        .createForegrounds(
          currentIndexCubit,
          state.data,
          state.page,
          state.info,
        )
        .whereType<PenRenderer>()
        .map((renderer) => renderer.element)
        .toList();
    expect(strokes, hasLength(2));
    expect(strokes[1].points.first.x - strokes[0].points.first.x, 100);
    expect(strokes[1].points.first.y - strokes[0].points.first.y, 50);
    await tester.pump(const Duration(milliseconds: 60));
  });
}
