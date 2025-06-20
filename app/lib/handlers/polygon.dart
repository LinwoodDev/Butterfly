part of 'handler.dart';

class PolygonSelectionRenderer extends Renderer<PolygonElement> {
  @override
  final Rect rect;
  final PolygonPoint? point;

  PolygonSelectionRenderer(super.element, this.rect, this.point);

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

    final point = this.point;
    if (point != null) {
      final paint = Paint()
        ..color = colorScheme?.primary ?? Colors.blue
        ..style = PaintingStyle.fill;
      final handlePaint = Paint()
        ..color = colorScheme?.secondary ?? Colors.green
        ..style = PaintingStyle.fill;
      final linePaint = Paint()
        ..color = colorScheme?.onSurface ?? Colors.grey
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth / transform.size;
      final handleIn = point.handleIn?.toPoint().toOffset();
      final handleOut = point.handleOut?.toPoint().toOffset();

      if (handleIn != null && handleOut != null) {
        canvas.drawLine(handleIn, handleOut, linePaint);
      }

      if (handleIn != null) {
        canvas.drawCircle(handleIn, strokeWidth / transform.size, handlePaint);
      }
      if (handleOut != null) {
        canvas.drawCircle(handleOut, strokeWidth / transform.size, handlePaint);
      }

      final position = point.toPoint().toOffset();
      canvas.drawCircle(position, strokeWidth + 2 / transform.size, paint);
    }
  }
}

class PolygonHandler extends Handler<PolygonTool> with ColoredHandler {
  PolygonElement? _element;
  String? _elementId;
  int? _selectedPointIndex;

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
          _element!.points[_selectedPointIndex!],
        ),
    ],
  ];

  Rect getSelectionRect() {
    final element = _element;
    if (element == null || element.points.isEmpty) return Rect.zero;
    Rect rect = Rect.fromPoints(
      Offset(element.points.first.x, element.points.first.y),
      Offset(element.points.first.x, element.points.first.y),
    );
    for (final point in element.points) {
      final offset = Offset(point.x, point.y);
      rect = rect.expandToInclude(Rect.fromPoints(offset, offset));
    }
    return rect;
  }

  @override
  SRGBColor getColor() => data.property.color;

  @override
  PolygonTool setColor(SRGBColor color) =>
      data.copyWith(property: data.property.copyWith(color: color));

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
    context.refresh();
  }

  @override
  void onTapUp(TapUpDetails details, EventContext context) {
    final localPos = details.localPosition;
    addPoint(context, localPos);
  }

  @override
  bool canChange(PointerDownEvent event, EventContext context) {
    return false;
  }

  @override
  void onSecondaryTapUp(TapUpDetails details, EventContext context) async {
    final localPos = details.localPosition;
    final transform = context.getCameraTransform();
    final globalPos = transform.localToGlobal(localPos);
    final element = _element;
    if (element == null) {
      final casted = (await context.getDocumentBloc().rayCast(
        globalPos,
        0.0,
        transform: transform,
      )).firstOrNull;
      if (casted == null) return;
      if (casted is! PolygonRenderer) return;
      _element = casted.element;
      _selectedPointIndex = casted.element.points.isEmpty
          ? null
          : casted.element.points.length - 1;
      context.refresh();
      return;
    }
    if (element.points.isEmpty) return;
    if (!getSelectionRect().contains(globalPos)) {
      _submitElement(context.getDocumentBloc());
      return;
    }
    final points = element.points;
    final closestIndex = points.indexWhere(
      (point) => (point.toPoint().toOffset() - globalPos).distance < 10.0,
    );
    if (closestIndex != -1) {
      _selectedPointIndex = closestIndex;
      context.refresh();
    }
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    super.onScaleUpdate(details, context);
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
    context.refresh();
  }

  @override
  void dispose(DocumentBloc bloc) {
    super.dispose(bloc);
    _submitElement(bloc);
  }

  void _submitElement(DocumentBloc bloc) {
    final element = _element;
    if (element == null || element.points.isEmpty) return;
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
    _element = null;
    _selectedPointIndex = null;
    _elementId = null;
    bloc.refresh();
  }
}
