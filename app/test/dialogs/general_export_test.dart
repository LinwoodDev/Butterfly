import 'dart:async';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/dialogs/export/general.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_leap/material_leap.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

class _Bloc extends Mock implements DocumentBloc {}

class _State extends Mock implements DocumentLoaded {}

class _Controller extends Mock implements EditorController {}

class _Renderer extends Mock implements RendererCubit {}

void main() {
  setUpAll(
    () => registerFallbackValue(const ImageExportOptions(width: 1, height: 1)),
  );

  for (final closeDialog in [false, true]) {
    testWidgets(
      'export preview discards stale renders${closeDialog ? ' after closing' : ''}',
      (tester) async {
        final bloc = _Bloc();
        final state = _State();
        final controller = _Controller();
        final renderer = _Renderer();
        final document = NoteData(Archive());
        const page = DocumentPage();
        const info = DocumentInfo();
        final renders = <Completer<ByteData?>>[];
        when(() => bloc.state).thenReturn(state);
        when(() => bloc.stream).thenAnswer((_) => const Stream.empty());
        when(() => bloc.editorController).thenReturn(controller);
        when(() => controller.rendererCubit).thenReturn(renderer);
        when(() => state.data).thenReturn(document);
        when(() => state.page).thenReturn(page);
        when(() => state.info).thenReturn(info);
        when(() => state.invisibleLayers).thenReturn({});
        when(
          () => renderer.render(
            controller,
            document,
            page,
            info,
            any(),
            invisibleLayers: any(named: 'invisibleLayers'),
            docState: state,
          ),
        ).thenAnswer((_) {
          final render = Completer<ByteData?>();
          renders.add(render);
          return render.future;
        });

        await tester.pumpWidget(
          BlocProvider<DocumentBloc>.value(
            value: bloc,
            child: MaterialApp(
              localizationsDelegates: const [
                ...AppLocalizations.localizationsDelegates,
                LeapLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              home: const Scaffold(
                body: GeneralExportDialog(
                  options: ImageExportOptions(width: 100, height: 100),
                ),
              ),
            ),
          ),
        );
        await tester.pump();
        expect(renders, hasLength(1));
        final background = tester.widget<CheckboxListTile>(
          find.widgetWithText(CheckboxListTile, 'Background'),
        );
        background.onChanged!(false);
        background.onChanged!(true);
        if (closeDialog) {
          await tester.pumpWidget(const SizedBox());
        }
        renders.first.complete(null);
        await tester.pump();
        if (!closeDialog) {
          // The queued intermediate request is skipped entirely.
          expect(renders, hasLength(2));
          renders.last.complete(null);
          await tester.pump();
        } else {
          expect(renders, hasLength(1));
        }
        expect(tester.takeException(), isNull);
      },
    );
  }
}
