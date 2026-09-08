import 'dart:math';
import 'dart:ui';

import 'package:archive/archive.dart';

import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/selections/selection.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:dart_leap/dart_leap.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEditorController extends Mock implements EditorController {}

class MockEventContext extends Mock implements EventContext {}

class MockRendererCubit extends Mock implements RendererCubit {}

class MockDocumentBloc extends Mock implements DocumentBloc {}

void main() {
  setUpAll(() {
    registerFallbackValue(Rect.zero);
    registerFallbackValue(ElementsCreated([]));
  });

  group('table gestures', () {
    late TableHandler handler;
    late MockEventContext context;
    late MockEditorController controller;
    late MockRendererCubit renderers;
    late MockDocumentBloc bloc;
    late ToolCubit toolCubit;
    late TableRenderer table;

    setUp(() {
      handler = TableHandler(TableTool());
      context = MockEventContext();
      controller = MockEditorController();
      renderers = MockRendererCubit();
      bloc = MockDocumentBloc();
      toolCubit = ToolCubit();
      table = TableRenderer(
        TableElement(
          id: 'table',
          rows: 3,
          columns: 3,
          firstPosition: const Point(0, 0),
          secondPosition: const Point(300, 180),
        ),
      );
      when(() => context.getEditorController()).thenReturn(controller);
      when(() => controller.rendererCubit).thenReturn(renderers);
      when(() => controller.toolCubit).thenReturn(toolCubit);
      when(() => bloc.editorController).thenReturn(controller);
      when(() => context.getDocumentBloc()).thenReturn(bloc);
      when(() => context.getCameraTransform())
          .thenReturn(const CameraTransform());
      when(() => context.getViewState()).thenReturn(const EditorViewState());
      when(() => context.getInputState()).thenReturn(const EditorInputState());
      when(() => context.refreshForegrounds()).thenAnswer((_) async {});
      when(() => context.refresh()).thenAnswer((_) async {});
      when(() => bloc.refreshForegrounds()).thenAnswer((_) async {});
      when(() => renderers.visibleRenderers(any())).thenAnswer((_) => [table]);
    });

    tearDown(() => toolCubit.close());

    List<TableTargetIndicatorRenderer> selection() => handler
        .createForegrounds(
          controller,
          NoteData(Archive()),
          DocumentPage(),
          DocumentInfo(),
        )
        .whereType<TableTargetIndicatorRenderer>()
        .where((e) => e.selected)
        .toList();

    test(
      'outside press deselects without creating a table; next tap creates',
      () async {
        await handler.onTapUp(
          TapUpDetails(
            kind: PointerDeviceKind.touch,
            localPosition: Offset(50, 30),
          ),
          context,
        );
        expect(selection(), hasLength(1));
        handler.onPointerDown(
          const PointerDownEvent(position: Offset(400, 300)),
          context,
        );
        expect(selection(), isEmpty);
        await handler.onTapUp(
          TapUpDetails(
            kind: PointerDeviceKind.touch,
            localPosition: Offset(400, 300),
          ),
          context,
        );
        verifyNever(() => bloc.add(any()));
        handler.onPointerDown(
          const PointerDownEvent(position: Offset(400, 300)),
          context,
        );
        await handler.onTapUp(
          TapUpDetails(
            kind: PointerDeviceKind.touch,
            localPosition: Offset(400, 300),
          ),
          context,
        );
        verify(() => bloc.add(any(that: isA<ElementsCreated>()))).called(1);
      },
    );

    test(
      'touch drag selects a range from the press position without creating',
      () {
        handler.onPointerDown(
          const PointerDownEvent(position: Offset(50, 30)),
          context,
        );
        handler.onScaleStart(
          ScaleStartDetails(localFocalPoint: const Offset(150, 90)),
          context,
        );
        handler.onScaleUpdate(
          ScaleUpdateDetails(localFocalPoint: const Offset(400, 300)),
          context,
        );
        handler.onScaleEnd(ScaleEndDetails(), context);
        expect(selection().single.target, const TableCellTarget(0, 0));
        expect(selection().single.rangeEnd, const TableCellTarget(2, 2));
        verifyNever(() => bloc.add(any()));
      },
    );

    test(
      'border drag starts without hover and never creates another table',
      () {
        handler.onPointerDown(
          const PointerDownEvent(position: Offset(100, 30)),
          context,
        );
        handler.onScaleStart(
          ScaleStartDetails(localFocalPoint: const Offset(100, 30)),
          context,
        );
        handler.onScaleEnd(ScaleEndDetails(), context);
        expect(
          selection().single.target,
          const TableLineTarget(TableAxis.vertical, 1),
        );
        verifyNever(() => bloc.add(any()));
      },
    );

    test('reset clears the selected range and properties', () async {
      await handler.onTapUp(
        TapUpDetails(
          kind: PointerDeviceKind.touch,
          localPosition: Offset(50, 30),
        ),
        context,
      );
      toolCubit.setSelection(
        TableElementSelection([table], target: const TableCellTarget(0, 0)),
      );
      await handler.resetInput(bloc);
      expect(selection(), isEmpty);
      expect(toolCubit.state.selection, isNull);
    });

    test('border selection does not carry over to a different table', () async {
      await handler.onTapUp(
        TapUpDetails(
          kind: PointerDeviceKind.touch,
          localPosition: Offset(100, 30),
        ),
        context,
      );
      table = TableRenderer(table.element.copyWith(id: 'other'));
      await handler.onTapUp(
        TapUpDetails(
          kind: PointerDeviceKind.touch,
          localPosition: Offset(100, 30),
        ),
        context,
      );
      expect(
        selection().single.target,
        const TableLineTarget(TableAxis.vertical, 1),
      );
    });
  });

  test('does not create a table with zero size', () {
    final handler = TableHandler(TableTool());

    expect(
      handler.transformElements(
        Rect.fromPoints(Offset.zero, Offset.zero),
        '',
        MockEditorController(),
      ),
      isEmpty,
    );
  });

  test('creates a table with the configured layout and appearance', () {
    final tool = TableTool(
      rows: 4,
      columns: 5,
      border: TableBorderProperty(
        width: 2,
        color: SRGBColor(0xFF123456),
        strokeStyle: StrokeStyle.dotted,
        dashMultiplier: 3,
        gapMultiplier: 2,
      ),
      fillColor: SRGBColor(0x80112233),
    );
    final element =
        TableHandler(tool)
                .transformElements(
                  const Rect.fromLTWH(10, 20, 300, 200),
                  'tables',
                  MockEditorController(),
                )
                .single
            as TableElement;

    expect(element.firstPosition, const Point(10, 20));
    expect(element.secondPosition, const Point(310, 220));
    expect(element.rows, 4);
    expect(element.columns, 5);
    expect(element.border.width, 2);
    expect(element.border.color, const SRGBColor(0xFF123456));
    expect(element.border.strokeStyle, StrokeStyle.dotted);
    expect(element.border.dashMultiplier, 3);
    expect(element.border.gapMultiplier, 2);
    expect(element.fillColor, const SRGBColor(0x80112233));
    expect(element.collection, 'tables');
    expect(element.cells, hasLength(20));
  });

  test('keeps secondary mouse clicks on the table handler', () {
    final handler = TableHandler(TableTool());
    final context = MockEventContext();

    expect(
      handler.canChange(
        const PointerDownEvent(
          kind: PointerDeviceKind.mouse,
          buttons: kSecondaryMouseButton,
        ),
        context,
      ),
      isFalse,
    );
    expect(
      handler.canChange(
        const PointerDownEvent(
          kind: PointerDeviceKind.mouse,
          buttons: kPrimaryMouseButton,
        ),
        context,
      ),
      isTrue,
    );
  });

  test('selects a whole border line before narrowing to one segment', () {
    const hit = TableBorderTarget(TableAxis.horizontal, 2, 1);

    expect(
      resolveTableSelectionTarget(null, hit),
      const TableLineTarget(TableAxis.horizontal, 2),
    );
    expect(
      resolveTableSelectionTarget(
        const TableLineTarget(TableAxis.horizontal, 2),
        hit,
      ),
      hit,
    );
    expect(
      resolveTableSelectionTarget(
        const TableBorderTarget(TableAxis.horizontal, 2, 0),
        hit,
      ),
      hit,
    );
    expect(
      resolveTableSelectionTarget(
        const TableLineTarget(TableAxis.horizontal, 1),
        hit,
      ),
      const TableLineTarget(TableAxis.horizontal, 2),
    );
  });

  test('keeps the targeted property view when replacing its renderer', () {
    final original = TableRenderer(TableElement(id: 'table'));
    final updated = TableRenderer(
      TableElement(id: 'table', border: const TableBorderProperty(width: 4)),
    );
    const target = TableBorderTarget(TableAxis.vertical, 1, 0);
    final selection = TableElementSelection(
      [original],
      target: target,
      rangeEnd: const TableCellTarget(1, 1),
    );

    final replaced =
        selection.replaceSelected([updated]) as TableElementSelection;

    expect(replaced.target, target);
    expect(replaced.rangeEnd, const TableCellTarget(1, 1));
    expect(replaced.selected, [updated]);
  });
}
