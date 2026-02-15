part of 'handler.dart';

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
    final outlinePaint = Paint()
      ..color = colorScheme?.primary ?? Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth / transform.size
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect.inflate(10 / transform.size),
        Radius.circular(8 / transform.size),
      ),
      outlinePaint,
    );

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
  bool _editing = false;

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
    _editing = false;
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
  void onTapUp(TapUpDetails details, EventContext context) {
    changeStartedDrawing(context);
    final localPos = details.localPosition;
    if (_editing) {
      _editPoint(context.getCameraTransform().localToGlobal(localPos), context);
      return;
    }
    addPoint(context, localPos);
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
    _editPoint(globalPos, context);
  }

  bool _editPoint(Offset globalPos, EventContext context) {
    final element = _element;
    if (element == null || element.points.isEmpty) return false;
    final points = element.points;
    final zoomedStrokeWidth =
        data.property.strokeWidth / context.getCameraTransform().size;
    final closestIndex = points.indexWhere((point) {
      final offset = point.toPoint().toOffset();
      final distance = (offset - globalPos).distance;
      return distance <= zoomedStrokeWidth * 2;
    });
    if (closestIndex == -1) return false;
    _selectedPointIndex = closestIndex;
    context.refreshForegrounds();
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
    final opposite = offset - (globalPos - offset);
    final updatedPoint = point.copyWith(
      handleIn: SimplePoint(globalPos.dx, globalPos.dy),
      handleOut: SimplePoint(opposite.dx, opposite.dy),
    );
    final updatedPoints = List<PolygonPoint>.from(element.points)
      ..[selectedIndex] = updatedPoint;
    _element = element.copyWith(points: updatedPoints);
    context.refreshForegrounds();
  }

  @override
  void onDoubleTapDown(TapDownDetails details, EventContext context) {
    changeStartedDrawing(context);
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
  }

  @override
  void onLongPressEnd(LongPressEndDetails details, EventContext context) {
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
    _editPoint(globalPos, context);
  }

  @override
  void dispose(DocumentBloc bloc) {
    super.dispose(bloc);
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
    bloc.refresh();
    bloc.refreshToolbar();
    bloc.state.currentIndexCubit?.resetTemporaryHandler(bloc, true);
  }

  void _deleteCurrentPoint(DocumentBloc bloc) {
    final element = _element;
    if (element == null || element.points.isEmpty) return;
    final selectedIndex = _selectedPointIndex;
    if (selectedIndex == null || selectedIndex >= element.points.length) return;
    final updatedPoints = List<PolygonPoint>.from(element.points)
      ..removeAt(selectedIndex);
    _element = element.copyWith(points: updatedPoints);
    if (_element?.points.isEmpty ?? true) {
      _elementId = null;
      _element = null;
      _selectedPointIndex = null;
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
      editing: _editing,
      onToggleEdit: () {
        _editing = !_editing;
        bloc.refreshToolbar();
      },
      onToolChanged: (tool) => changeTool(bloc, tool),
      onFinishShape: _element == null
          ? null
          : () {
              _element = _element?.copyWith(
                points: [...?_element?.points, ?_element?.points.firstOrNull],
              );
              _submitElement(bloc);
            },
      onSubmit: _element == null
          ? null
          : () {
              _submitElement(bloc);
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
