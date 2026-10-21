import 'dart:math';
import 'dart:ui';

import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _Context extends Mock implements EventContext {}

class _Controller extends Mock implements EditorController {}

class _Bloc extends Mock implements DocumentBloc {}

class _State extends Mock implements DocumentLoadSuccess {}

void main() {
  setUpAll(() => registerFallbackValue(Offset.zero));

  test(
    'resizing a stamp on a rotated canvas preserves stroke layout',
    () async {
      final context = _Context();
      final controller = _Controller();
      final bloc = _Bloc();
      final state = _State();
      final transform = TransformCubit(1)
        ..teleport(const Offset(35, -22), 2.5, pi / 6);
      final assets = AssetService();
      addTearDown(assets.dispose);
      addTearDown(transform.close);
      final document = NoteData(Archive());
      const page = DocumentPage();
      final handler = StampHandler(
        StampTool(
          component: NamedItem(
            name: 'Drawing',
            item: ButterflyComponent(
              elements: [
                PenElement(
                  points: const [PathPoint(0, 0), PathPoint(10, 10)],
                  property: const PenProperty(strokeWidth: 2, thinning: 0),
                ),
                PenElement(
                  points: const [PathPoint(20, 5), PathPoint(30, 15)],
                  property: const PenProperty(strokeWidth: 2, thinning: 0),
                ),
                PolygonElement(
                  points: const [PolygonPoint(40, 20), PolygonPoint(50, 30)],
                  property: const PolygonProperty(strokeWidth: 0),
                ),
              ],
            ),
          ),
        ),
      );
      when(() => context.getState()).thenReturn(state);
      when(() => context.getEditorController()).thenReturn(controller);
      when(() => controller.transformCubit).thenReturn(transform);
      when(() => state.data).thenReturn(document);
      when(() => state.assetService).thenReturn(assets);
      when(() => state.page).thenReturn(page);
      when(() => state.currentCollection).thenReturn('');
      when(() => context.getCameraTransform()).thenReturn(transform.state);
      when(() => context.getToolState())
          .thenReturn(ToolRuntimeState(handler: handler));
      when(() => context.viewportSize).thenReturn(const Size(800, 600));
      when(() => context.getDocumentBloc()).thenReturn(bloc);
      when(() => bloc.isInBounds(any())).thenReturn(true);
      when(() => context.isShiftPressed).thenReturn(false);
      when(() => context.isAltPressed).thenReturn(false);
      when(() => context.refreshForegrounds()).thenAnswer((_) async {});

      await handler.preparePaste(context);
      handler.onScaleStart(
        ScaleStartDetails(localFocalPoint: const Offset(160, 140)),
        context,
      );
      handler.onScaleUpdate(
        ScaleUpdateDetails(localFocalPoint: const Offset(368, 204)),
        context,
      );
      final placed = handler.getTransformed(controller);
      // The source bounds include stroke padding: (-2, -2) to (50, 30).
      // This drag stretches the drawing by 4 horizontally and 2 vertically.
      const expected = [
        [Offset(168, 144), Offset(208, 164)],
        [Offset(248, 154), Offset(288, 174)],
        [Offset(328, 184), Offset(368, 204)],
      ];
      expect(placed, hasLength(expected.length));
      for (var i = 0; i < placed.length; i++) {
        final renderer = Renderer.fromInstance(placed[i]);
        addTearDown(renderer.dispose);
        await renderer.setup(transform, document, assets, page);
        final points = switch (placed[i]) {
          PenElement(:final points) => points,
          PolygonElement(:final points) => points,
          _ => throw StateError('Unexpected stamp element'),
        };
        expect(points, hasLength(expected[i].length));
        for (var j = 0; j < points.length; j++) {
          final actual = transform.state.globalToLocal(
            renderer.transformPoint(Offset(points[j].x, points[j].y)),
          );
          expect(actual, offsetMoreOrLessEquals(expected[i][j]));
        }
      }
    },
  );
}
