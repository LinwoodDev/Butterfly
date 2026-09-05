import 'dart:async';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockContext extends Mock implements EventContext {}

class _MockBloc extends Mock implements DocumentBloc {}

class _MockController extends Mock implements EditorController {}

void main() {
  setUpAll(() {
    registerFallbackValue(Offset.zero);
    registerFallbackValue(ElementsRemoved(const []));
  });

  group('stroke clipping', () {
    test('cuts sparse segments exactly and interpolates pressure', () {
      const points = [PathPoint(0, 0, 0.5), PathPoint(100, 0, 1)];
      final result = cutPenPointsForEraser(points, const Offset(50, 0), 10)!;

      expect(result.map((path) => path.length), [2, 2]);
      expect(result.first.first, same(points.first));
      expect(result.last.last, same(points.last));
      expect(result.first.last.x, closeTo(40, 1e-10));
      expect(result.first.last.pressure, closeTo(0.7, 1e-10));
      expect(result.last.first.x, closeTo(60, 1e-10));
      expect(result.last.first.pressure, closeTo(0.8, 1e-10));
    });

    test('small cuts on long strokes need only two new points', () {
      const points = [PathPoint(0, 0), PathPoint(1000000, 0)];
      final result = cutPenPointsForEraser(points, const Offset(12345, 0), 1)!;

      expect(result.expand((path) => path), hasLength(4));
      expect(result.first.last.x, closeTo(12344, 1e-8));
      expect(result.last.first.x, closeTo(12346, 1e-8));
    });

    test('preserves untouched, tangent, and boundary-only strokes', () {
      const points = [PathPoint(0, 0), PathPoint(100, 0)];
      expect(cutPenPointsForEraser(points, const Offset(50, 20), 10), isNull);
      expect(cutPenPointsForEraser(points, const Offset(50, 10), 10), isNull);
      expect(cutPenPointsForEraser(points, const Offset(110, 0), 10), isNull);
    });

    test('handles isolated points, repeated points, and complete removal', () {
      expect(cutPenPointsForEraser([], Offset.zero, 10), isNull);
      expect(
        cutPenPointsForEraser([PathPoint(20, 0)], Offset.zero, 10),
        isNull,
      );
      expect(
        cutPenPointsForEraser([PathPoint(0, 0)], Offset.zero, 10),
        isEmpty,
      );
      expect(
        cutPenPointsForEraser(
          [PathPoint(0, 0), PathPoint(0, 0)],
          Offset.zero,
          10,
        ),
        isEmpty,
      );
      expect(
        cutPenPointsForEraser(
          [PathPoint(-1, 0), PathPoint(1, 0)],
          Offset.zero,
          10,
        ),
        isEmpty,
      );
    });

    test('handles strokes starting or ending inside the eraser', () {
      final leaving = cutPenPointsForEraser(
        [PathPoint(0, 0), PathPoint(20, 0)],
        Offset.zero,
        10,
      )!;
      final entering = cutPenPointsForEraser(
        [PathPoint(20, 0), PathPoint(0, 0)],
        Offset.zero,
        10,
      )!;
      expect(leaving.single.map((point) => point.x), [10, 20]);
      expect(entering.single.map((point) => point.x), [20, 10]);
    });

    test('keeps separate fragments on repeated crossings', () {
      final result = cutPenPointsForEraser(
        [PathPoint(-20, 0), PathPoint(20, 0), PathPoint(-20, 0)],
        Offset.zero,
        10,
      )!;
      expect(
        result.map((path) => path.map((point) => point.x).toList()).toList(),
        [
          [-20, -10],
          [10, 20, 10],
          [-10, -20],
        ],
      );
    });

    test('preserves points far from a cut without resampling them', () {
      const points = [
        PathPoint(-1000000, 0),
        PathPoint(-20, 0),
        PathPoint(20, 0),
        PathPoint(1000000, 0),
      ];
      final result = cutPenPointsForEraser(points, Offset.zero, 10)!;
      expect(result.map((path) => path.length), [3, 3]);
      expect(result.first[1], same(points[1]));
      expect(result.last[1], same(points[2]));
    });

    test('ignores invalid eraser sizes', () {
      for (final radius in [0.0, -1.0, double.nan, double.infinity]) {
        expect(
          cutPenPointsForEraser([PathPoint(0, 0)], Offset.zero, radius),
          isNull,
        );
      }
    });

    test('clips vertical and diagonal strokes at the circle boundary', () {
      for (final (start, end, entry, exit) in [
        (PathPoint(3, -20), PathPoint(3, 20), Offset(3, -4), Offset(3, 4)),
        (PathPoint(-30, -40), PathPoint(30, 40), Offset(-3, -4), Offset(3, 4)),
      ]) {
        final paths = cutPenPointsForEraser([start, end], Offset.zero, 5)!;
        expect(paths, hasLength(2));
        expect(paths.first.last.x, closeTo(entry.dx, 1e-10));
        expect(paths.first.last.y, closeTo(entry.dy, 1e-10));
        expect(paths.last.first.x, closeTo(exit.dx, 1e-10));
        expect(paths.last.first.y, closeTo(exit.dy, 1e-10));
      }
    });
  });

  group('eraser input', () {
    late _MockContext context;
    late _MockBloc bloc;
    late TransformCubit transform;
    late EditorViewCubit view;
    late EraserHandler handler;
    late Future<Set<Renderer<PadElement>>> Function(Offset) hit;
    late List<DocumentEvent> events;
    late List<Offset> positions;
    late int refreshes;

    Set<Renderer<PadElement>> element(String id) => {
      PenRenderer(
        PenElement(id: id, points: [PathPoint(0, 0), PathPoint(100, 0)]),
      ),
    };

    Future<void> down([double x = 0]) => handler.onPointerDown(
      PointerDownEvent(position: Offset(x, 0)),
      context,
    );
    Future<void> move(double x) => handler.onPointerMove(
      PointerMoveEvent(position: Offset(x, 0)),
      context,
    );
    Future<void> up(double x) =>
        handler.onPointerUp(PointerUpEvent(position: Offset(x, 0)), context);

    setUp(() {
      context = _MockContext();
      bloc = _MockBloc();
      final controller = _MockController();
      transform = TransformCubit(1);
      view = EditorViewCubit();
      handler = EraserHandler(
        EraserTool(mode: EraserMode.path, strokeWidth: 10),
      );
      events = [];
      positions = [];
      refreshes = 0;
      hit = (_) async => {};
      when(() => context.getEditorController()).thenReturn(controller);
      when(() => controller.transformCubit).thenReturn(transform);
      when(() => controller.viewCubit).thenReturn(view);
      when(() => context.getDocumentBloc()).thenReturn(bloc);
      when(() => context.getPage()).thenReturn(const DocumentPage());
      when(() => context.refreshForegrounds()).thenAnswer((_) async {});
      when(() => context.refresh()).thenAnswer((_) async {
        refreshes++;
      });
      when(() => bloc.add(any())).thenAnswer((invocation) {
        events.add(invocation.positionalArguments.single as DocumentEvent);
      });
      when(
        () => bloc.rayCast(
          any(),
          any(),
          useCollection: any(named: 'useCollection'),
          useLayer: any(named: 'useLayer'),
          hitElementMode: any(named: 'hitElementMode'),
        ),
      ).thenAnswer((invocation) {
        final position = invocation.positionalArguments.first as Offset;
        positions.add(position);
        return hit(position);
      });
    });

    tearDown(() async {
      handler.dispose(bloc);
      await transform.close();
      await view.close();
    });

    test(
      'release waits for queued work and processes its final position',
      () async {
        final results = List.generate(
          3,
          (_) => Completer<Set<Renderer<PadElement>>>(),
        );
        final started = List.generate(3, (_) => Completer<void>());
        var calls = 0;
        hit = (_) {
          final index = calls++;
          started[index].complete();
          return results[index].future;
        };
        final first = down();
        await started[0].future;
        final moving = move(30);
        results[0].complete(element('first'));
        await started[1].future;
        final released = up(31); // Under the normal spacing threshold.
        expect(events, isEmpty);
        results[1].complete(element('second'));
        await started[2].future;
        expect(events, isEmpty);
        results[2].complete(element('last'));
        await Future.wait([first, moving, released]);
        expect(positions, [Offset.zero, Offset(30, 0), Offset(31, 0)]);
        expect((events.single as ElementsRemoved).elements, [
          'first',
          'second',
          'last',
        ]);
      },
    );

    test(
      'recovers after a ray cast fails, including the same position',
      () async {
        hit = (_) async => throw StateError('ray cast failed');
        await expectLater(down(), throwsStateError);
        hit = (_) async => element('recovered');
        await move(0);
        await up(0);
        expect((events.single as ElementsRemoved).elements, ['recovered']);
      },
    );

    for (final dispose in [false, true]) {
      test(
        '${dispose ? 'dispose' : 'reset'} ignores in-flight hits and queued moves',
        () async {
          final result = Completer<Set<Renderer<PadElement>>>();
          final started = Completer<void>();
          hit = (_) {
            started.complete();
            return result.future;
          };
          final first = down();
          await started.future;
          final moving = move(30);
          if (dispose) {
            handler.dispose(bloc);
          } else {
            handler.resetInput(bloc);
          }
          result.complete(element('stale'));
          await Future.wait([first, moving]);
          expect(handler.rendererStates, isEmpty);
          expect(events, isEmpty);
          expect(refreshes, 0);
          expect(positions, hasLength(1));
        },
      );
    }

    test('repeated hits do not refresh the canvas again', () async {
      hit = (_) async => element('same');
      await down();
      await move(30);
      await move(60);
      await up(61);
      expect(refreshes, 1);
      expect((events.single as ElementsRemoved).elements, ['same']);
    });

    test(
      'coalesces queued moves and keeps callers waiting for the drain',
      () async {
        final result = Completer<Set<Renderer<PadElement>>>();
        final started = Completer<void>();
        hit = (_) {
          started.complete();
          return result.future;
        };
        final first = down();
        await started.future;
        final moves = [move(30), move(60), move(90)];
        hit = (_) async => element('latest');
        result.complete(element('first'));
        await Future.wait([first, ...moves]);
        expect(positions, [Offset.zero, Offset(90, 0)]);
        expect(handler.rendererStates.keys, ['first', 'latest']);
      },
    );

    test(
      'a stale drain cannot clear a new gesture or submit its changes',
      () async {
        final oldResult = Completer<Set<Renderer<PadElement>>>();
        final oldStarted = Completer<void>();
        hit = (_) {
          oldStarted.complete();
          return oldResult.future;
        };
        final first = down();
        await oldStarted.future;
        final oldRelease = up(1);
        handler.resetInput(bloc);

        final newResult = Completer<Set<Renderer<PadElement>>>();
        final newStarted = Completer<void>();
        hit = (_) {
          newStarted.complete();
          return newResult.future;
        };
        final second = down(50);
        await newStarted.future;
        oldResult.complete(element('stale'));
        await Future.wait([first, oldRelease]);
        expect(events, isEmpty);
        final release = up(50);
        newResult.complete(element('current'));
        await Future.wait([second, release]);
        expect((events.single as ElementsRemoved).elements, ['current']);
        expect(positions, [Offset.zero, Offset(50, 0)]);
      },
    );

    test(
      'stroke mode commits compact fragments with preserved metadata',
      () async {
        handler = EraserHandler(
          EraserTool(mode: EraserMode.stroke, strokeWidth: 10),
        );
        final pen = PenElement(
          id: 'pen',
          collection: 'notes',
          points: [PathPoint(0, 0, 0.5), PathPoint(100, 0, 1)],
        );
        hit = (_) async => {PenRenderer(pen)};
        await down(50);
        await up(50);
        final fragments = (events.single as ElementsChanged).elements['pen']!
            .cast<PenElement>();
        expect(fragments, hasLength(2));
        expect(fragments.map((pen) => pen.points.length), [2, 2]);
        expect(fragments.map((pen) => pen.collection), ['notes', 'notes']);
        expect(fragments.map((pen) => pen.id).toSet(), hasLength(2));
        expect(fragments.every((pen) => pen.id != 'pen'), isTrue);
      },
    );
  });
}
