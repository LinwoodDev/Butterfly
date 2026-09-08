import 'dart:math';
import 'dart:ui';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _Context extends Mock implements EventContext {}

class _Controller extends Mock implements EditorController {}

class _Bloc extends Mock implements DocumentBloc {}

// Exercise the shared creation gesture without unrelated toolbar state.
class _ShapeHandler extends PastingHandler<ShapeTool> {
  _ShapeHandler() : super(ShapeTool());

  @override
  bool get shouldNormalize => false;

  @override
  List<PadElement> transformElements(
    Rect rect,
    String collection,
    EditorController cubit,
  ) => [
    ShapeElement(
      firstPosition: Point(rect.left, rect.top),
      secondPosition: Point(rect.right, rect.bottom),
    ),
  ];
}

void expectOffset(Offset actual, Offset expected) {
  expect(actual.dx, closeTo(expected.dx, 1e-7));
  expect(actual.dy, closeTo(expected.dy, 1e-7));
}

void main() {
  setUpAll(() => registerFallbackValue(Offset.zero));

  const angle = -pi / 3;
  for (final end in [const Offset(320, 240), const Offset(60, 40)]) {
    test('rotated creation preserves drag endpoints and size to $end', () {
      final context = _Context();
      final controller = _Controller();
      final bloc = _Bloc();
      final handler = _ShapeHandler();
      final camera = CameraTransform(1, const Offset(35, -22), 2, angle);
      when(() => context.getCameraTransform()).thenReturn(camera);
      when(() => context.getToolState())
          .thenReturn(ToolRuntimeState(handler: handler));
      when(() => context.viewportSize).thenReturn(const Size(800, 600));
      when(() => context.getDocumentBloc()).thenReturn(bloc);
      when(() => bloc.isInBounds(any())).thenReturn(true);
      when(() => context.isShiftPressed).thenReturn(false);
      when(() => context.isAltPressed).thenReturn(false);
      when(() => context.refreshForegrounds()).thenAnswer((_) async {});
      const start = Offset(120, 100);
      handler.onScaleStart(ScaleStartDetails(localFocalPoint: start), context);
      handler.onScaleUpdate(ScaleUpdateDetails(localFocalPoint: end), context);
      final element = handler.getTransformed(controller).single as ShapeElement;
      final renderer = ShapeRenderer(element);
      expectOffset(
        camera.globalToLocal(
          renderer.transformPoint(
            Offset(element.firstPosition.x, element.firstPosition.y),
          ),
        ),
        start,
      );
      expectOffset(
        camera.globalToLocal(
          renderer.transformPoint(
            Offset(element.secondPosition.x, element.secondPosition.y),
          ),
        ),
        end,
      );
      expect(
        renderer.rect.width,
        closeTo((end.dx - start.dx).abs() / camera.size, 1e-7),
      );
      expect(
        renderer.rect.height,
        closeTo((end.dy - start.dy).abs() / camera.size, 1e-7),
      );
    });
  }

  for (final zoomDependent in [true, false]) {
    for (final positionDependent in [true, false]) {
      test(
        'grid snaps to rendered document axes ($zoomDependent, $positionDependent)',
        () {
          final camera = CameraTransform(1, const Offset(10, 20), 2, pi / 3);
          final handler = GridHandler(
            GridTool(
              xSize: 40,
              ySize: 60,
              xOffset: 6,
              yOffset: 8,
              zoomDependent: zoomDependent,
              positionDependent: positionDependent,
            ),
          );
          final origin =
              const Offset(3, 4) +
              (positionDependent ? Offset.zero : camera.position);
          final spacing = Offset(40, 60) / (zoomDependent ? 1 : camera.size);
          final expected = origin + spacing;
          final pointer = camera.globalToLocal(expected + const Offset(1, -1));
          expectOffset(
            handler.getPointerPosition(pointer, const Size(800, 600), camera),
            camera.globalToLocal(expected),
          );
        },
      );
    }
  }
}
