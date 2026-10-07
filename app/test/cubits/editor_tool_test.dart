import 'dart:async';

import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _Controller extends Mock implements EditorController {}

class _Loaded extends Mock implements DocumentLoaded {}

class _RendererCubit extends Mock implements RendererCubit {}

class _Assets extends Mock implements AssetService {}

void main() {
  for (final delayed in [false, true]) {
    testWidgets(
      '${delayed ? 'frame-delayed' : 'immediate'} pen preview advances while a canvas bake is pending',
      (tester) async {
        final controller = _Controller();
        final loaded = _Loaded();
        final rendererCubit = _RendererCubit();
        final transform = TransformCubit(1);
        final handler = PenHandler(PenTool());
        final tools = ToolCubit(ToolRuntimeState(handler: handler));
        final bake = Completer<void>();
        Future<void> dispose() async {
          tools.foregroundRefreshRunner.dispose();
          tools.delayedForegroundRefreshRunner.dispose();
          bake.complete();
          await tester.pump();
          await tools.foregroundRefreshRunner.disposeAndWait();
          await tools.delayedForegroundRefreshRunner.disposeAndWait();
          tools.disposeAllForegrounds();
          await tools.close();
          await transform.close();
        }

        try {
          when(() => controller.isClosed).thenReturn(false);
          when(() => controller.rendererCubit).thenReturn(rendererCubit);
          when(() => controller.transformCubit).thenReturn(transform);
          when(() => loaded.data).thenReturn(NoteData(Archive()));
          when(() => loaded.page).thenReturn(DocumentPage());
          when(() => loaded.info).thenReturn(DocumentInfo());
          when(() => loaded.assetService).thenReturn(_Assets());
          when(() => loaded.currentArea).thenReturn(null);
          // A completed stroke has not reached the canvas cache yet.
          when(() => rendererCubit.state).thenReturn(
            RendererRuntimeState(
              cameraViewport: CameraViewport.unbaked(
                unbakedElements: [PenRenderer(PenElement(id: 'completed'))],
              ),
            ),
          );
          when(
            () => rendererCubit.rendererStateChangesAffectBaked(
              const {},
              const {},
            ),
          ).thenReturn(false);
          when(() => rendererCubit.delayedBake(controller, loaded))
              .thenAnswer((_) => bake.future);

          Future<void> refresh() => delayed
              ? tools.delayedRefreshForegrounds(controller, loaded)
              : tools.refreshForegrounds(controller, loaded);
          final interval = Duration(milliseconds: delayed ? 16 : 0);
          final stroke = PenElement(
            id: 'drawing',
            points: [PathPoint(0, 0), PathPoint(10, 0)],
          );
          handler.elements[1] = stroke;
          unawaited(refresh());
          await tester.pump(interval);
          expect(
            (tools.state.foregrounds.single.element as PenElement)
                .points
                .last
                .x,
            10,
          );
          expect(bake.isCompleted, isFalse);

          handler.elements[1] = stroke.copyWith(
            points: [...stroke.points, PathPoint(20, 0)],
          );
          unawaited(refresh());
          await tester.pump(interval);
          expect(
            (tools.state.foregrounds.single.element as PenElement)
                .points
                .last
                .x,
            20,
            reason:
                'Drawing must update before the canvas cache finishes baking',
          );
          expect(bake.isCompleted, isFalse);
        } finally {
          await dispose();
        }
      },
    );
  }
}
