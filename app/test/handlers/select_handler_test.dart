import 'dart:math';
import 'dart:ui';

import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly/renderers/foregrounds/select.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _Context extends Mock implements EventContext {}

class _Controller extends Mock implements EditorController {}

class _Settings extends Mock implements SettingsCubit {}

class _Bloc extends Mock implements DocumentBloc {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    registerFallbackValue(Rect.zero);
    registerFallbackValue(Offset.zero);
  });

  test(
    'clicking outside a selection removes its transform hit target',
    () async {
      final context = _Context();
      final bloc = _Bloc();
      final handler = SelectHandler(SelectTool());
      const camera = CameraTransform(1, Offset.zero, 1, 0);
      final selected = ShapeRenderer(
        ShapeElement(
          firstPosition: const Point(100, 100),
          secondPosition: const Point(200, 200),
        ),
      );
      when(() => context.getCameraTransform()).thenReturn(camera);
      when(() => context.getSettings()).thenReturn(const ButterflySettings());
      when(() => context.getViewState()).thenReturn(const EditorViewState());
      when(() => context.getDocumentBloc()).thenReturn(bloc);
      when(() => context.isCtrlPressed).thenReturn(false);
      when(() => context.refresh()).thenAnswer((_) async {});
      when(
        () => bloc.rayCast(any(), any(), useCollection: false, useLayer: false),
      ).thenAnswer((invocation) async {
        final position = invocation.positionalArguments.first as Offset;
        return position == const Offset(150, 150) ? {selected} : {};
      });

      handler.onTapUp(
        TapUpDetails(
          localPosition: const Offset(150, 150),
          kind: PointerDeviceKind.mouse,
        ),
        context,
      );
      await pumpEventQueue();
      final inside = PointerDownEvent(position: const Offset(150, 150));
      expect(handler.getSelectionRect(), isNotNull);
      expect(handler.canChange(inside, context), isFalse);

      handler.onTapUp(
        TapUpDetails(
          localPosition: const Offset(400, 400),
          kind: PointerDeviceKind.mouse,
        ),
        context,
      );
      await pumpEventQueue();
      expect(handler.getSelectionRect(), isNull);
      expect(handler.canChange(inside, context), isTrue);
    },
  );

  test(
    'rotated rectangle preview and hit test match both drag directions',
    () async {
      final context = _Context();
      final controller = _Controller();
      final settings = _Settings();
      final bloc = _Bloc();
      final handler = SelectHandler(
        SelectTool(hitElementMode: HitElementMode.full),
      );
      const camera = CameraTransform(1, Offset(35, -22), 2, -pi / 3);
      final transformCubit = TransformCubit(1)..emit(camera);
      addTearDown(transformCubit.close);
      when(() => controller.transformCubit).thenReturn(transformCubit);
      when(() => context.getCameraTransform()).thenReturn(camera);
      when(() => context.getToolState())
          .thenReturn(ToolRuntimeState(handler: handler));
      when(() => context.getInputState()).thenReturn(const EditorInputState());
      when(() => context.getViewState()).thenReturn(const EditorViewState());
      when(() => context.getSettings()).thenReturn(const ButterflySettings());
      when(() => controller.settingsCubit).thenReturn(settings);
      when(() => settings.state).thenReturn(const ButterflySettings());
      when(() => context.getDocumentBloc()).thenReturn(bloc);
      when(() => context.isCtrlPressed).thenReturn(false);
      when(() => context.refresh()).thenAnswer((_) async {});
      when(() => context.refreshForegrounds()).thenAnswer((_) async {});
      List<Offset>? hitPolygon;
      when(
        () => bloc.rayCastRect(
          any(),
          rotation: any(named: 'rotation'),
          useCollection: false,
          useLayer: false,
          hitElementMode: HitElementMode.full,
        ),
      ).thenAnswer((invocation) async {
        hitPolygon = (invocation.positionalArguments.single as Rect).toPolygon(
          rotation: (invocation.namedArguments[#rotation] as double) * pi / 180,
        );
        return {};
      });

      List<RectSelectionForegroundRenderer> previews() => handler
          .createForegrounds(
            controller,
            NoteData(Archive()),
            DocumentPage(),
            DocumentInfo(),
          )
          .whereType<RectSelectionForegroundRenderer>()
          .toList();

      const first = Offset(120, 100), second = Offset(320, 240);
      for (final (start, end) in [(first, second), (second, first)]) {
        handler.onScaleStart(
          ScaleStartDetails(localFocalPoint: start),
          context,
        );
        handler.onScaleUpdate(
          ScaleUpdateDetails(localFocalPoint: end, pointerCount: 1),
          context,
        );
        final preview = previews().single;
        final expected = [
          first,
          const Offset(320, 100),
          second,
          const Offset(120, 240),
        ];
        for (var i = 0; i < expected.length; i++) {
          final point = camera.globalToLocal(preview.corners[i]);
          expect(point.dx, closeTo(expected[i].dx, 1e-7));
          expect(point.dy, closeTo(expected[i].dy, 1e-7));
        }
        await handler.onScaleEnd(ScaleEndDetails(), context);
        expect(hitPolygon, preview.corners);
        expect(previews(), isEmpty);
      }
    },
  );
}
