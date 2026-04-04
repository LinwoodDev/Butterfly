part of 'handler.dart';

enum _PolygonDragTarget { point, handleIn, handleOut, newHandle }

class PolygonSelectionRenderer extends Renderer<PolygonElement> {
  @override
  final Rect rect;
  final int? selectedPointIndex;

  PolygonSelectionRenderer(super.element, this.rect, this.selectedPointIndex);

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
    if (element.points.isEmpty) return;
    final strokeWidth = element.property.strokeWidth;

    for (var i = 0; i < element.points.length; i++) {
      final point = element.points[i];
      final isSelected = selectedPointIndex == i;
      final paint = Paint()
        ..color = colorScheme?.primary ?? Colors.blue
        ..style = isSelected ? PaintingStyle.fill : PaintingStyle.stroke
        ..strokeWidth = strokeWidth / 2 / transform.size;
      final handlePaint = Paint()
        ..color = colorScheme?.secondary ?? Colors.green
        ..style = PaintingStyle.fill;
      final linePaint = Paint()
        ..color = colorScheme?.onSurface ?? Colors.grey
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth / transform.size;
      final handleIn = point.handleIn?.toPoint().toOffset();
      final handleOut = point.handleOut?.toPoint().toOffset();

      if (isSelected) {
        if (handleIn != null && handleOut != null) {
          canvas.drawLine(handleIn, handleOut, linePaint);
        }

        if (handleIn != null) {
          canvas.drawCircle(
            handleIn,
            strokeWidth / transform.size,
            handlePaint,
          );
        }
        if (handleOut != null) {
          canvas.drawCircle(
            handleOut,
            strokeWidth / transform.size,
            handlePaint,
          );
        }
      }

      final position = point.toPoint().toOffset();
      canvas.drawCircle(position, strokeWidth + 1.5 / transform.size, paint);
    }
  }
}

class PolygonHandler extends Handler<PolygonTool> with ColoredHandler {
  PolygonElement? _element;
  String? _elementId;
  int? _selectedPointIndex;
  _PolygonDragTarget _dragTarget = _PolygonDragTarget.newHandle;

  PolygonHandler(super.data);

  @override
  List<Renderer> createForegrounds(
    CurrentIndexCubit currentIndexCubit,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) => [
    if (_element != null) ...[
      PolygonRenderer(_element!),
      if (_selectedPointIndex != null)
        PolygonSelectionRenderer(
          _element!,
          getSelectionRect(),
          _selectedPointIndex,
        ),
    ],
  ];

  Rect getSelectionRect() {
    return _element?.points.isEmpty ?? true
        ? Rect.zero
        : calculatePolygonRect(_element!.points);
  }

  @override
  SRGBColor getColor() => data.property.color;

  @override
  PolygonTool setColor(SRGBColor color) =>
      data.copyWith(property: data.property.copyWith(color: color));

  @override
  double getStrokeWidth() => data.property.strokeWidth;

  @override
  PolygonTool setStrokeWidth(double width) =>
      data.copyWith(property: data.property.copyWith(strokeWidth: width));

  void _resetTool() {
    _elementId = null;
    _element = null;
    _selectedPointIndex = null;
  }

  void addPoint(EventContext context, Offset localPos) {
    final globalPos = context.getCameraTransform().localToGlobal(localPos);
    var element =
        _element ??
        PolygonElement(
          points: [],
          property: data.property,
          id: createUniqueId(),
        );

    element = element.copyWith(
      points: [...element.points, PolygonPoint(globalPos.dx, globalPos.dy)],
    );
    _element = element;
    _selectedPointIndex = element.points.length - 1;
    context.refreshForegrounds();
    context.getDocumentBloc().refreshToolbar();
  }

  @override
  void onTapUp(TapUpDetails details, EventContext context) async {
    changeStartedDrawing(context);
    final localPos = details.localPosition;
    final globalPos = context.getCameraTransform().localToGlobal(localPos);

    if (!_editPoint(globalPos, context)) {
      addPoint(context, localPos);
    }
  }

  @override
  bool canChange(PointerDownEvent event, EventContext context) {
    return false;
  }

  @override
  void onSecondaryTapUp(TapUpDetails details, EventContext context) async {
    changeStartedDrawing(context);
    final localPos = details.localPosition;
    final transform = context.getCameraTransform();
    final globalPos = transform.localToGlobal(localPos);
    if (!getSelectionRect()
        .inflate(2 * data.property.strokeWidth)
        .contains(globalPos)) {
      _submitElement(context.getDocumentBloc());
      return;
    }
    if (!_editPoint(globalPos, context)) {
      addPoint(context, localPos);
    }
  }

  bool _editPoint(Offset globalPos, EventContext context) {
    final element = _element;
    if (element == null || element.points.isEmpty) return false;
    final points = element.points;
    final zoomedStrokeWidth =
        data.property.strokeWidth / context.getCameraTransform().size;
    final touchSlop = max(
      20.0 / context.getCameraTransform().size,
      zoomedStrokeWidth * 2,
    );
    final closestIndex = points.indexWhere((point) {
      final offset = point.toPoint().toOffset();
      final distance = (offset - globalPos).distance;
      return distance <= touchSlop;
    });
    if (closestIndex == -1) return false;
    _selectedPointIndex = closestIndex;
    context.refreshForegrounds();
    return true;
  }

  @override
  bool onScaleStart(ScaleStartDetails details, EventContext context) {
    if (_selectedPointIndex == null || _element == null) return true;
    final point = _element!.points[_selectedPointIndex!];
    final globalPos = context.getCameraTransform().localToGlobal(
      details.localFocalPoint,
    );
    final zoomedStrokeWidth =
        data.property.strokeWidth / context.getCameraTransform().size;
    final touchSlop = max(
      20.0 / context.getCameraTransform().size,
      zoomedStrokeWidth * 2,
    );

    if (point.handleIn != null) {
      final hInOffset = point.handleIn!.toPoint().toOffset();
      if ((hInOffset - globalPos).distance <= touchSlop) {
        _dragTarget = _PolygonDragTarget.handleIn;
        return true;
      }
    }

    if (point.handleOut != null) {
      final hOutOffset = point.handleOut!.toPoint().toOffset();
      if ((hOutOffset - globalPos).distance <= touchSlop) {
        _dragTarget = _PolygonDragTarget.handleOut;
        return true;
      }
    }

    final pOffset = point.toPoint().toOffset();
    if ((pOffset - globalPos).distance <= touchSlop) {
      _dragTarget = _PolygonDragTarget.point;
      return true;
    }

    _dragTarget = _PolygonDragTarget.newHandle;
    return true;
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    super.onScaleUpdate(details, context);
    changeStartedDrawing(context);
    final selectedIndex = _selectedPointIndex;
    final element = _element;
    if (selectedIndex == null || element == null) return;

    final point = element.points[selectedIndex];
    final offset = point.toPoint().toOffset();
    final localPos = details.localFocalPoint;
    final globalPos = context.getCameraTransform().localToGlobal(localPos);

    PolygonPoint updatedPoint = point;

    if (_dragTarget == _PolygonDragTarget.point) {
      final diff = globalPos - offset;
      updatedPoint = point.copyWith(
        x: globalPos.dx,
        y: globalPos.dy,
        handleIn: point.handleIn != null
            ? SimplePoint(
                point.handleIn!.x + diff.dx,
                point.handleIn!.y + diff.dy,
              )
            : null,
        handleOut: point.handleOut != null
            ? SimplePoint(
                point.handleOut!.x + diff.dx,
                point.handleOut!.y + diff.dy,
              )
            : null,
      );
    } else if (_dragTarget == _PolygonDragTarget.handleIn) {
      final opposite = offset - (globalPos - offset);
      updatedPoint = point.copyWith(
        handleIn: SimplePoint(globalPos.dx, globalPos.dy),
        handleOut: SimplePoint(opposite.dx, opposite.dy),
      );
    } else if (_dragTarget == _PolygonDragTarget.handleOut) {
      final opposite = offset - (globalPos - offset);
      updatedPoint = point.copyWith(
        handleOut: SimplePoint(globalPos.dx, globalPos.dy),
        handleIn: SimplePoint(opposite.dx, opposite.dy),
      );
    } else {
      final opposite = offset - (globalPos - offset);
      updatedPoint = point.copyWith(
        handleIn: SimplePoint(globalPos.dx, globalPos.dy),
        handleOut: SimplePoint(opposite.dx, opposite.dy),
      );
    }

    final updatedPoints = List<PolygonPoint>.from(element.points)
      ..[selectedIndex] = updatedPoint;

    _element = element.copyWith(points: updatedPoints);
    context.refreshForegrounds();
  }

  @override
  void onLongPressEnd(LongPressEndDetails details, EventContext context) async {
    changeStartedDrawing(context);
    final localPos = details.localPosition;
    final transform = context.getCameraTransform();
    final globalPos = transform.localToGlobal(localPos);

    if (_element == null) {
      final hit = await context.getDocumentBloc().rayCast(
        globalPos,
        max(
          10.0 / context.getCameraTransform().size,
          data.property.strokeWidth / context.getCameraTransform().size * 2,
        ),
      );
      final polygonRenderer = hit.whereType<PolygonRenderer>().firstOrNull;
      if (polygonRenderer != null) {
        editElement(polygonRenderer.element);
        context.refreshForegrounds();
        context.getDocumentBloc().refreshToolbar();
        return;
      }
      addPoint(context, localPos);
      return;
    }

    if (!getSelectionRect()
        .inflate(2 * data.property.strokeWidth)
        .contains(globalPos)) {
      _submitElement(context.getDocumentBloc());
      return;
    }
    if (_editPoint(globalPos, context)) {
      final selectedIndex = _selectedPointIndex;
      final element = _element;
      if (selectedIndex == null || element == null) return;
      final point = element.points[selectedIndex];
      final updatedPoint = point.copyWith(handleIn: null, handleOut: null);
      final updatedPoints = List<PolygonPoint>.from(element.points)
        ..[selectedIndex] = updatedPoint;
      _element = element.copyWith(points: updatedPoints);
      context.refreshForegrounds();
      context.getDocumentBloc().refreshToolbar();
    } else {
      addPoint(context, localPos);
    }
  }

  @override
  void dispose(DocumentBloc bloc) {
    super.dispose(bloc);
    _submitElement(bloc);
  }

  Future<void> _finalizeElement(
    DocumentBloc bloc, {
    bool closeShape = false,
  }) async {
    final element = _element;
    if (element == null || element.points.isEmpty) {
      _submitElement(bloc);
      return;
    }

    if (closeShape && element.points.length > 2) {
      final first = element.points.first;
      final last = element.points.last;
      if ((first.toPoint().toOffset() - last.toPoint().toOffset()).distance >
          1.0) {
        _element = element.copyWith(points: [...element.points, first]);
      }
    }

    _selectedPointIndex = null;
    _dragTarget = _PolygonDragTarget.newHandle;
    await bloc.refreshForegrounds();
    _submitElement(bloc);
  }

  void _submitElement(DocumentBloc bloc) {
    final element = _element;
    if (element == null || element.points.isEmpty) {
      _resetTool();
      return;
    }
    final id = _elementId;
    if (id != null) {
      bloc.add(
        ElementsChanged({
          id: [element],
        }),
      );
    } else {
      bloc.add(ElementsCreated([element]));
    }
    _resetTool();
    bloc.state.currentIndexCubit?.resetTemporaryHandler(bloc, true);
    bloc.delayedBake();
    bloc.refreshToolbar();
  }

  void _deleteCurrentPoint(DocumentBloc bloc) {
    final element = _element;
    if (element == null) return;
    final selectedIndex = _selectedPointIndex;

    // If no point is selected, or we only have 1 point left, delete the entire element
    if (selectedIndex == null ||
        selectedIndex >= element.points.length ||
        element.points.length <= 1) {
      if (_elementId != null) {
        bloc.add(ElementsRemoved([_elementId!]));
        bloc.refresh();
      }
      _resetTool();
      bloc.refreshForegrounds();
      bloc.refreshToolbar();
      bloc.state.currentIndexCubit?.resetTemporaryHandler(bloc, true);
      return;
    }

    final updatedPoints = List<PolygonPoint>.from(element.points)
      ..removeAt(selectedIndex);
    _element = element.copyWith(points: updatedPoints);
    if (_element?.points.isEmpty ?? true) {
      if (_elementId != null) {
        bloc.add(ElementsRemoved([_elementId!]));
        bloc.refresh();
      }
      _resetTool();
      bloc.state.currentIndexCubit?.resetTemporaryHandler(bloc, true);
    } else {
      _selectedPointIndex = max(0, selectedIndex - 1);
    }
    bloc.refreshForegrounds();
    bloc.refreshToolbar();
  }

  @override
  PreferredSizeWidget? getToolbar(DocumentBloc bloc) {
    return PolygonToolbarView(
      tool: data,
      hasPoints: (_element?.points.length ?? 0) > 0,
      onToolChanged: (tool) => changeTool(bloc, tool),
      onFinishShape: _element == null
          ? null
          : () async {
              await _finalizeElement(bloc, closeShape: true);
            },
      onSubmit: _element == null
          ? null
          : () async {
              await _finalizeElement(bloc);
            },
      onDelete: () {
        _deleteCurrentPoint(bloc);
      },
    );
  }

  @override
  Map<String, RendererState> get rendererStates => {
    ?_element?.id: RendererState.hidden,
  };

  void editElement(PolygonElement element) {
    _resetTool();
    _element = element;
    _elementId = element.id;
    _selectedPointIndex = max(0, element.points.length - 1);
  }
}
