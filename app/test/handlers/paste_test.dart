import 'dart:convert';
import 'dart:math';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/helpers/element.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/export.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

class _Context extends Mock implements EventContext {}

class _Controller extends Mock implements EditorController {}

class _Settings extends Mock implements SettingsCubit {}

class _Bloc extends Mock implements DocumentBloc {}

class _State extends Mock implements DocumentLoadSuccess {}

class _Export extends Mock implements ExportService {}

void main() {
  setUpAll(() {
    registerFallbackValue(Offset.zero);
    registerFallbackValue(ElementsCreated([]));
  });

  test('copy serializes the orientation shown on a rotated canvas', () async {
    final controller = _Controller();
    final bloc = _Bloc();
    final state = _State();
    final camera = TransformCubit(1)
      ..teleport(const Offset(35, -22), 2, pi / 6);
    addTearDown(camera.close);
    final handler = SelectHandler(SelectTool());
    final clipboard = InternalClipboardManager();
    when(() => controller.transformCubit).thenReturn(camera);
    when(() => bloc.editorController).thenReturn(controller);
    when(() => bloc.state).thenReturn(state);
    when(() => bloc.isClosed).thenReturn(false);
    when(() => bloc.refresh()).thenAnswer((_) async {});
    when(() => state.data).thenReturn(DocumentDefaults.createDocument());
    final original = ShapeRenderer(
      ShapeElement(
        firstPosition: const Point(70, 80),
        secondPosition: const Point(170, 130),
        rotation: 330,
      ),
    );
    addTearDown(original.dispose);
    handler.transform(bloc, null, next: [original]);
    await handler.copySelection(bloc, clipboard);
    final content = clipboard.getContent(
      types: AssetFileType.page.getMimeTypes(),
    );
    final page = DocumentPageDataExtension.fromDataJson(
      jsonDecode(utf8.decode(content!.data)),
    );
    final copied = ShapeRenderer(page.content.single as ShapeElement);
    addTearDown(copied.dispose);
    expect(
      copied.transformPoint(copied.rect.topLeft),
      offsetMoreOrLessEquals(Offset.zero),
    );
    expect(
      copied.transformPoint(copied.rect.bottomRight),
      offsetMoreOrLessEquals(const Offset(100, 50)),
    );
  });

  for (final rotation in [0.0, pi / 6]) {
    testWidgets(
      'long-press paste keeps the release point while its menu is open ($rotation)',
      (tester) async {
        final context = _Context();
        final controller = _Controller();
        final bloc = _Bloc();
        final state = _State();
        final settings = _Settings();
        final transform = TransformCubit(1)
          ..teleport(const Offset(35, -22), .195, rotation);
        addTearDown(transform.close);
        final handler = SelectHandler(SelectTool());
        final clipboard = InternalClipboardManager();
        final document = DocumentDefaults.createDocument();
        final page = DocumentPage(
          layers: [
            DocumentLayer(
              content: [
                PenElement(points: const [PathPoint(0, 0), PathPoint(50, 100)]),
              ],
            ),
          ],
        );
        clipboard.setContent((
          type: AssetFileType.page.getMimeTypes().first,
          data: utf8.encode(jsonEncode(page.toDataJson(document))),
        ));
        when(() => settings.state).thenReturn(
          const ButterflySettings(platformTheme: PlatformTheme.mobile),
        );
        when(() => settings.stream).thenAnswer((_) => const Stream.empty());
        when(() => state.settingsCubit).thenReturn(settings);
        when(() => state.data).thenReturn(document);
        when(() => state.pageName).thenReturn('page');
        when(() => state.currentLayer).thenReturn('layer');
        when(() => bloc.state).thenReturn(state);
        when(() => bloc.isClosed).thenReturn(false);
        when(() => bloc.editorController).thenReturn(controller);
        when(() => bloc.transformCubit).thenReturn(transform);
        when(() => context.getDocumentBloc()).thenReturn(bloc);
        when(() => context.getCameraTransform())
            .thenAnswer((_) => transform.state);
        when(() => context.getSettings()).thenAnswer((_) => settings.state);
        when(() => context.getViewState()).thenReturn(const EditorViewState());
        when(() => context.isCtrlPressed).thenReturn(false);
        when(() => context.refresh()).thenAnswer((_) async {});
        when(
          () =>
              bloc.rayCast(any(), any(), useCollection: false, useLayer: false),
        ).thenAnswer((_) async => {});
        when(() => context.getClipboardManager()).thenReturn(clipboard);
        when(() => context.getExportService()).thenReturn(_Export());

        await tester.pumpWidget(
          RepositoryProvider<ClipboardManager>.value(
            value: clipboard,
            child: BlocProvider<SettingsCubit>.value(
              value: settings,
              child: MaterialApp(
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                home: Builder(
                  builder: (buildContext) {
                    when(() => context.buildContext).thenReturn(buildContext);
                    when(() => context.getImportService())
                        .thenReturn(ImportService(buildContext, bloc: bloc));
                    return const SizedBox.expand();
                  },
                ),
              ),
            ),
          ),
        );
        const start = Offset(200, 200);
        for (final (end, moveCamera) in [
          (start, false),
          (start + const Offset(20, -30), false),
          (start, true),
          (start + const Offset(-30, 20), false),
        ]) {
          final camera = transform.state;
          final expected = camera.localToGlobal(end);
          handler.onLongPressStart(
            const LongPressStartDetails(localPosition: start),
            context,
          );
          handler.onLongPressEnd(
            LongPressEndDetails(localPosition: end),
            context,
          );
          await tester.pumpAndSettle();
          if (moveCamera) {
            transform.teleport(const Offset(-50, 80), .5, rotation - pi / 4);
          }
          await tester.tap(find.byTooltip('Paste'));
          await tester.pumpAndSettle();
          final events = verify(() => bloc.add(captureAny())).captured;
          final pasted =
              events.whereType<ElementsCreated>().single.elements.single
                  as PenElement;
          final renderer = PenRenderer(pasted);
          final points = pasted.points
              .map((point) => renderer.transformPoint(Offset(point.x, point.y)))
              .toList();
          expect(points.first, offsetMoreOrLessEquals(expected));
          expect(
            points.last - points.first,
            offsetMoreOrLessEquals(
              camera.localToGlobalDelta(const Offset(50, 100) * camera.size),
            ),
          );
        }
      },
    );
  }
}
