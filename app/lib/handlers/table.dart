part of 'handler.dart';

@visibleForTesting
TableHitTarget resolveTableSelectionTarget(
  TableHitTarget? selected,
  TableHitTarget hit,
) {
  if (hit is! TableBorderTarget) return hit;
  final sameLine = switch (selected) {
    TableLineTarget(:final axis, :final line) ||
    TableBorderTarget(
      :final axis,
      :final line,
    ) => axis == hit.axis && line == hit.line,
    _ => false,
  };
  return sameLine ? hit : TableLineTarget(hit.axis, hit.line);
}

class TableTargetIndicatorRenderer extends Renderer<TableElement> {
  final TableHitTarget target;
  final bool selected;

  TableTargetIndicatorRenderer(
    super.element,
    this.target, {
    this.selected = false,
  });

  Path _transformedRect(TableRenderer renderer, Rect rect) {
    final path = Path();
    final points = [
      rect.topLeft,
      rect.topRight,
      rect.bottomRight,
      rect.bottomLeft,
    ].map((point) => renderer.transformPoint(point, renderer.rect)).toList();
    return path
      ..moveTo(points[0].dx, points[0].dy)
      ..lineTo(points[1].dx, points[1].dy)
      ..lineTo(points[2].dx, points[2].dy)
      ..lineTo(points[3].dx, points[3].dy)
      ..close();
  }

  @override
  void build(
    Canvas canvas,
    Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {
    final renderer = TableRenderer(element);
    final color = colorScheme?.primary ?? Colors.blue;
    final borderGeometry = switch (target) {
      TableLineTarget(:final axis, :final line) => renderer.fullBorderLine(
        axis,
        line,
      ),
      TableBorderTarget(:final axis, :final line, :final segment) =>
        renderer.borderLine(axis, line, segment),
      _ => null,
    };
    if (borderGeometry != null) {
      _drawBorderIndicator(canvas, renderer, borderGeometry, color, transform);
      return;
    }

    final cellTarget = target as TableCellTarget;
    final tableRect = renderer.rect;
    final cell = renderer.cellRect(cellTarget.row, cellTarget.column);
    final rowRect = Rect.fromLTRB(
      tableRect.left,
      cell.top,
      tableRect.right,
      cell.bottom,
    );
    final columnRect = Rect.fromLTRB(
      cell.left,
      tableRect.top,
      cell.right,
      tableRect.bottom,
    );
    final guidePaint = Paint()
      ..color = color.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5 / transform.size;
    canvas
      ..drawPath(_transformedRect(renderer, rowRect), guidePaint)
      ..drawPath(_transformedRect(renderer, columnRect), guidePaint)
      ..drawPath(
        _transformedRect(renderer, cell),
        Paint()
          ..color = color.withValues(alpha: selected ? 0.24 : 0.12)
          ..style = PaintingStyle.fill,
      )
      ..drawPath(
        _transformedRect(renderer, cell),
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = (selected ? 3 : 2) / transform.size,
      );
  }

  void _drawBorderIndicator(
    Canvas canvas,
    TableRenderer renderer,
    ({Offset start, Offset end}) geometry,
    Color color,
    CameraTransform transform,
  ) {
    final start = renderer.transformPoint(geometry.start, renderer.rect);
    final end = renderer.transformPoint(geometry.end, renderer.rect);
    canvas.drawLine(
      start,
      end,
      Paint()
        ..color = color.withValues(alpha: selected ? 0.32 : 0.2)
        ..strokeCap = StrokeCap.round
        ..strokeWidth = (selected ? 8 : 6) / transform.size,
    );
    canvas.drawLine(
      start,
      end,
      Paint()
        ..color = color
        ..strokeCap = StrokeCap.round
        ..strokeWidth = (selected ? 3 : 2) / transform.size,
    );
  }
}

class TableHandler extends PastingHandler<TableTool> with ColoredHandler {
  TableRenderer? _activeRenderer;
  TableHitTarget? _activeTarget;
  TableRenderer? _hoverRenderer;
  TableHitTarget? _hoverTarget;
  TableRenderer? _resizeRenderer;
  TableLineTarget? _resizeTarget;
  Offset? _resizePosition;
  ToolCubit? _selectionCubit;
  int _hoverRequest = 0;
  bool _didResize = false;

  TableHandler(super.data);

  Future<({TableRenderer renderer, TableHitTarget target})?> _hitTable(
    EventContext context,
    Offset localPosition,
  ) async {
    final transform = context.getCameraTransform();
    final position = transform.localToGlobal(localPosition);
    final locks = context.getViewState().locks;
    final hits = await context.getDocumentBloc().rayCast(
      position,
      0,
      useCollection: locks.lockCollection,
      useLayer: locks.lockLayer,
    );
    for (final renderer in hits.whereType<TableRenderer>()) {
      final target = renderer.hitTarget(
        position,
        tolerance: 8 / transform.size,
      );
      if (target != null) return (renderer: renderer, target: target);
    }
    return null;
  }

  void _activateTarget(
    EventContext context,
    TableRenderer renderer,
    TableHitTarget target,
  ) {
    _activeRenderer = renderer;
    _activeTarget = target;
    _selectionCubit = context.getEditorController().toolCubit;
    if (_selectionCubit!.state.selection is TableElementSelection) {
      _selectionCubit!.setSelection(null);
    }
    context.refreshForegrounds();
  }

  void _openTargetProperties(
    EventContext context,
    TableRenderer renderer,
    TableHitTarget target,
  ) {
    _activeRenderer = renderer;
    _activeTarget = target;
    _selectionCubit = context.getEditorController().toolCubit;
    _selectionCubit!.setSelection(
      TableElementSelection([renderer], target: target),
    );
    context.refreshForegrounds();
  }

  @override
  List<Renderer> createForegrounds(
    EditorController editorController,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) => [
    ...super.createForegrounds(
      editorController,
      document,
      page,
      info,
      currentArea,
    ),
    if (_hoverRenderer != null && _hoverTarget != null)
      TableTargetIndicatorRenderer(_hoverRenderer!.element, _hoverTarget!),
    if (_activeRenderer != null && _activeTarget != null)
      TableTargetIndicatorRenderer(
        _activeRenderer!.element,
        _activeTarget!,
        selected: true,
      ),
  ];

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) async {
    final request = ++_hoverRequest;
    final hit = await _hitTable(context, event.localPosition);
    if (request != _hoverRequest) return;
    _hoverRenderer = hit?.renderer;
    _hoverTarget = hit == null
        ? null
        : resolveTableSelectionTarget(_activeTarget, hit.target);
    context.refreshForegrounds();
  }

  @override
  // ignore: must_call_super
  Future<void> onTapUp(TapUpDetails details, EventContext context) async {
    if (_didResize) {
      _didResize = false;
      return;
    }
    final hit = await _hitTable(context, details.localPosition);
    if (hit != null) {
      _activateTarget(
        context,
        hit.renderer,
        resolveTableSelectionTarget(_activeTarget, hit.target),
      );
      return;
    }

    final bloc = context.getDocumentBloc();
    final position = context.getCameraTransform().localToGlobal(
      details.localPosition,
    );
    final width = data.constrainedWidth > 0
        ? data.constrainedWidth
        : data.columns * 120.0;
    final height = data.constrainedHeight > 0
        ? data.constrainedHeight
        : data.rows * 60.0;
    final collection = context.getState()?.currentCollection ?? '';
    final elements = transformElements(
      Rect.fromLTWH(position.dx, position.dy, width, height),
      collection,
      bloc.editorController,
    );
    if (elements.isNotEmpty) {
      bloc.add(ElementsCreated(elements));
      context.refresh();
    }
  }

  @override
  void onSecondaryTapUp(TapUpDetails details, EventContext context) async {
    final hit = await _hitTable(context, details.localPosition);
    if (hit == null || !context.buildContext.mounted) return;
    final target = resolveTableSelectionTarget(_activeTarget, hit.target);
    _activateTarget(context, hit.renderer, target);
    final element = hit.renderer.element;
    final bloc = context.getDocumentBloc();

    await showContextMenu<void>(
      context: context.buildContext,
      position: details.localPosition,
      builder: (overlayContext) {
        final loc = AppLocalizations.of(overlayContext);
        void close() => Navigator.pop(overlayContext);
        final structural = switch (target) {
          TableCellTarget(:final row, :final column) => <ContextMenuEntry>[
            ContextMenuItem(
              label: loc.insertRowBefore,
              icon: const PhosphorIcon(PhosphorIconsLight.rowsPlusTop),
              onPressed: () {
                close();
                _replaceElement(bloc, element, element.insertRow(row));
              },
            ),
            ContextMenuItem(
              label: loc.insertRowAfter,
              icon: const PhosphorIcon(PhosphorIconsLight.rowsPlusBottom),
              onPressed: () {
                close();
                _replaceElement(bloc, element, element.insertRow(row + 1));
              },
            ),
            ContextMenuItem(
              label: loc.deleteRow,
              icon: const PhosphorIcon(PhosphorIconsLight.rows),
              onPressed: element.rows > 1
                  ? () {
                      close();
                      _replaceElement(bloc, element, element.removeRow(row));
                    }
                  : null,
            ),
            ContextMenuItem(
              label: loc.insertColumnBefore,
              icon: const PhosphorIcon(PhosphorIconsLight.columnsPlusLeft),
              onPressed: () {
                close();
                _replaceElement(bloc, element, element.insertColumn(column));
              },
            ),
            ContextMenuItem(
              label: loc.insertColumnAfter,
              icon: const PhosphorIcon(PhosphorIconsLight.columnsPlusRight),
              onPressed: () {
                close();
                _replaceElement(
                  bloc,
                  element,
                  element.insertColumn(column + 1),
                );
              },
            ),
            ContextMenuItem(
              label: loc.deleteColumn,
              icon: const PhosphorIcon(PhosphorIconsLight.columns),
              onPressed: element.columns > 1
                  ? () {
                      close();
                      _replaceElement(
                        bloc,
                        element,
                        element.removeColumn(column),
                      );
                    }
                  : null,
            ),
          ],
          _ => const <ContextMenuEntry>[],
        };
        return [
          ...structural,
          ContextMenuItem(
            label: loc.properties,
            icon: const PhosphorIcon(PhosphorIconsLight.faders),
            onPressed: () {
              close();
              _openTargetProperties(context, hit.renderer, target);
            },
          ),
          ContextMenuItem(
            label: loc.delete,
            icon: const PhosphorIcon(PhosphorIconsLight.trash),
            onPressed: () {
              close();
              final id = element.id;
              if (id != null) bloc.add(ElementsRemoved([id]));
              _activeRenderer = null;
              _activeTarget = null;
              bloc.delayedBake();
              bloc.refresh();
            },
          ),
        ];
      },
    );
    context.refreshForegrounds();
  }

  void _replaceElement(
    DocumentBloc bloc,
    TableElement previous,
    TableElement updated,
  ) {
    final id = previous.id;
    if (id == null) return;
    bloc.add(
      ElementsChanged({
        id: [updated],
      }),
    );
    final renderer = TableRenderer(updated);
    _activeRenderer = renderer;
    _activeTarget = switch (_activeTarget) {
      TableCellTarget(:final row, :final column) => TableCellTarget(
        min(row, updated.rows - 1),
        min(column, updated.columns - 1),
      ),
      TableLineTarget(:final axis, :final line) => TableLineTarget(
        axis,
        min(line, updated.borderLineCount(axis) - 1),
      ),
      TableBorderTarget(:final axis, :final line, :final segment) =>
        TableBorderTarget(
          axis,
          min(line, updated.borderLineCount(axis) - 1),
          min(segment, updated.borderSegmentCount(axis) - 1),
        ),
      null => null,
    };
    final selection = _selectionCubit?.state.selection;
    if (selection is TableElementSelection &&
        selection.selected.first.element.id == id) {
      _selectionCubit!.setSelection(
        TableElementSelection([renderer], target: _activeTarget),
      );
    }
    bloc.delayedBake();
    bloc.refresh();
  }

  @override
  bool onScaleStart(ScaleStartDetails details, EventContext context) {
    if (context.getInputState().buttons == kSecondaryMouseButton &&
        context.getToolState().temporaryHandler == null) {
      return false;
    }
    final renderer = _hoverRenderer;
    final target = switch (_hoverTarget) {
      TableLineTarget target => target,
      TableBorderTarget(:final axis, :final line) => TableLineTarget(
        axis,
        line,
      ),
      _ => null,
    };
    if (target != null &&
        renderer != null &&
        target.line > 0 &&
        target.line < renderer.element.borderLineCount(target.axis)) {
      _resizeRenderer = renderer;
      _resizeTarget = target;
      _resizePosition = context.getCameraTransform().localToGlobal(
        details.localFocalPoint,
      );
      _didResize = false;
      _activateTarget(context, renderer, _activeTarget ?? target);
      return true;
    }
    return super.onScaleStart(details, context);
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    final renderer = _resizeRenderer;
    final target = _resizeTarget;
    final previous = _resizePosition;
    if (renderer == null || target == null || previous == null) {
      super.onScaleUpdate(details, context);
      return;
    }
    final current = context.getCameraTransform().localToGlobal(
      details.localFocalPoint,
    );
    final previousLocal = renderer.tablePosition(previous);
    final currentLocal = renderer.tablePosition(current);
    final extent = target.axis == TableAxis.horizontal
        ? renderer.rect.height
        : renderer.rect.width;
    if (extent <= 0) return;
    final delta = target.axis == TableAxis.horizontal
        ? currentLocal.dy - previousLocal.dy
        : currentLocal.dx - previousLocal.dx;
    final updated = renderer.element.moveBorder(
      target.axis,
      target.line,
      delta / extent,
    );
    if (updated == renderer.element) return;
    _didResize = true;
    _replaceElement(context.getDocumentBloc(), renderer.element, updated);
    _resizeRenderer = TableRenderer(updated);
    _hoverRenderer = _resizeRenderer;
    _hoverTarget = target;
    _resizePosition = current;
    context.refreshForegrounds();
  }

  @override
  void onScaleEnd(ScaleEndDetails details, EventContext context) {
    if (_resizeRenderer == null) {
      super.onScaleEnd(details, context);
    }
    _resizeRenderer = null;
    _resizeTarget = null;
    _resizePosition = null;
  }

  @override
  bool canChange(PointerDownEvent event, EventContext context) =>
      event.kind == PointerDeviceKind.mouse &&
      event.buttons != kSecondaryMouseButton;

  @override
  MouseCursor? get cursor => switch (_hoverTarget) {
    TableLineTarget(axis: TableAxis.horizontal) ||
    TableBorderTarget(
      axis: TableAxis.horizontal,
    ) => SystemMouseCursors.resizeUpDown,
    TableLineTarget(axis: TableAxis.vertical) ||
    TableBorderTarget(
      axis: TableAxis.vertical,
    ) => SystemMouseCursors.resizeLeftRight,
    _ => super.cursor,
  };

  @override
  bool onRendererUpdated(
    DocumentPage page,
    Renderer old,
    List<Renderer> updated,
  ) {
    final id = _activeRenderer?.element.id;
    if (id == null || old.element?.id != id) return false;
    final renderer = updated.whereType<TableRenderer>().firstOrNull;
    if (renderer == null) return false;
    _activeRenderer = renderer;
    return true;
  }

  @override
  void dispose(DocumentBloc bloc) {
    _hoverRequest++;
    _activeRenderer = null;
    _activeTarget = null;
    _hoverRenderer = null;
    _hoverTarget = null;
    _resizeRenderer = null;
    _resizeTarget = null;
    _resizePosition = null;
    _selectionCubit = null;
    super.dispose(bloc);
  }

  @override
  List<PadElement> transformElements(
    Rect rect,
    String collection,
    EditorController cubit,
  ) {
    if (rect.isEmpty) return [];
    return [
      TableElement(
        firstPosition: rect.topLeft.toPoint(),
        secondPosition: rect.bottomRight.toPoint(),
        rows: data.rows,
        columns: data.columns,
        border: data.border.copyWith(
          width:
              data.border.width /
              (data.zoomDependent
                  ? cubit.rendererCubit.state.cameraViewport.scale
                  : 1),
        ),
        fillColor: data.fillColor,
        cells: List.filled(data.rows * data.columns, const TableCellProperty()),
        collection: collection,
      ),
    ];
  }

  @override
  double get constraintedAspectRatio => data.constrainedAspectRatio;
  @override
  double get constraintedHeight => data.constrainedHeight;
  @override
  double get constraintedWidth => data.constrainedWidth;

  @override
  SRGBColor getColor() => data.border.color;

  @override
  TableTool setColor(SRGBColor color) =>
      data.copyWith(border: data.border.copyWith(color: color));

  @override
  double getStrokeWidth() => data.border.width;

  @override
  TableTool setStrokeWidth(double width) =>
      data.copyWith(border: data.border.copyWith(width: width));
}
