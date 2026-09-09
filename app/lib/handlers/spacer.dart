part of 'handler.dart';

class SpacerHandler extends Handler<SpacerTool> {
  Offset? _startPosition;
  Set<Renderer<PadElement>>? _renderers;
  double _spacing = 0.0;
  double _rotation = 0;

  Offset get _movement =>
      (data.axis == Axis2D.horizontal
              ? Offset(_spacing, 0)
              : Offset(0, _spacing))
          .rotate(Offset.zero, -_rotation);

  SpacerHandler(super.data);

  @override
  List<Renderer> createForegrounds(
    EditorController editorController,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) => [
    if (_startPosition != null) SpacerRenderer(_startPosition!, _movement),
    ...?_renderers?.map((e) => e.transform(position: _movement) ?? e),
  ];

  @override
  Map<String, RendererState> get rendererStates => Map.fromEntries(
    _renderers?.map((e) => MapEntry(e.id, RendererState.hidden)) ?? [],
  );

  Rect? _lastRect;

  Future<void>? _pendingRefresh;

  Future<void> _refreshRenderers(EventContext context) {
    final rect = _getRect(context);
    if (rect == _lastRect) return _pendingRefresh ?? Future.value();
    _lastRect = rect;
    if (rect == null) {
      _renderers = null;
      return Future.value();
    }
    final locks = context.getViewState().locks;
    return _pendingRefresh = context
        .getDocumentBloc()
        .rayCastRect(
          rect,
          rotation: -_rotation * 180 / pi,
          useCollection: locks.lockCollection,
          useLayer: locks.lockLayer,
        )
        .then((renderers) {
          if (rect == _lastRect) _renderers = renderers;
        });
  }

  @override
  bool onScaleStart(ScaleStartDetails details, EventContext context) {
    final transform = context.getCameraTransform();
    _startPosition = transform.localToGlobal(details.localFocalPoint);
    _rotation = transform.rotation;
    _spacing = 0;
    _renderers = null;
    _lastRect = null;
    _pendingRefresh = null;
    context.refresh();
    return true;
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    if (details.pointerCount > 1) return;
    final transform = context.getCameraTransform();
    final globalPos = transform.localToGlobal(details.localFocalPoint);
    final start = _startPosition;
    if (start == null) return;
    final delta = (globalPos - start).rotate(Offset.zero, _rotation);
    _spacing = data.axis == Axis2D.horizontal ? delta.dx : delta.dy;
    final perpendicular = data.axis == Axis2D.horizontal
        ? Offset(0, delta.dy)
        : Offset(delta.dx, 0);
    _startPosition = start + perpendicular.rotate(Offset.zero, -_rotation);
    _refreshRenderers(context).whenComplete(context.refreshForegrounds);
  }

  @override
  Future<void> onScaleEnd(ScaleEndDetails details, EventContext context) async {
    if (_startPosition == null) return;
    await _refreshRenderers(context);

    final elements = Map<String, List<PadElement>>.fromEntries(
      _renderers
              ?.map((e) {
                final id = e.element.id;
                if (id == null) return null;
                return MapEntry(id, [
                  e.transform(position: _movement)?.element ?? e.element,
                ]);
              })
              .nonNulls
              .toList() ??
          [],
    );
    _startPosition = null;
    _spacing = 0.0;
    _renderers = null;
    _lastRect = null;
    _pendingRefresh = null;
    await context.refresh();
    context.getDocumentBloc().add(ElementsChanged(elements));
  }

  Rect? _getRect(EventContext context) {
    final start = _startPosition;
    if (start == null || _spacing == 0) return null;
    // Bound the half-plane in viewport-aligned axes before rotating it back.
    // This keeps distant content eligible without rotating infinite corners.
    Rect? bounds;
    for (final renderer
        in context.getEditorController().rendererCubit.renderers) {
      final rect = renderer.expandedRect;
      if (rect == null) continue;
      for (final point in rect.toPolygon()) {
        final aligned = point.rotate(start, _rotation);
        final pointRect = Rect.fromPoints(aligned, aligned);
        bounds = bounds?.expandToInclude(pointRect) ?? pointRect;
      }
    }
    if (bounds == null) return null;
    final halfPlane = data.axis == Axis2D.horizontal
        ? Rect.fromLTRB(
            _spacing > 0 ? start.dx : -double.infinity,
            -double.infinity,
            _spacing < 0 ? start.dx : double.infinity,
            double.infinity,
          )
        : Rect.fromLTRB(
            -double.infinity,
            _spacing > 0 ? start.dy : -double.infinity,
            double.infinity,
            _spacing < 0 ? start.dy : double.infinity,
          );
    final rect = bounds.inflate(1).intersect(halfPlane);
    if (rect.isEmpty) return null;
    return rect.shift(rect.center.rotate(start, -_rotation) - rect.center);
  }
}

class SpacerRenderer extends Renderer {
  final Offset startPosition;
  final Offset movement;

  SpacerRenderer(this.startPosition, this.movement) : super(null);

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
    final paint = Paint()
      ..color = colorScheme?.primary ?? Colors.black
      ..strokeWidth = 4 / transform.size
      ..style = PaintingStyle.stroke;
    canvas.drawLine(startPosition, startPosition + movement, paint);
  }
}
