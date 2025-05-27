part of 'handler.dart';

class SpacerHandler extends Handler<SpacerTool> {
  Offset? _startPosition;
  Set<Renderer<PadElement>>? _renderers;
  double _spacing = 0.0;

  SpacerHandler(super.data);

  @override
  List<Renderer> createForegrounds(
    CurrentIndexCubit currentIndexCubit,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) => [
    if (_startPosition != null)
      SpacerRenderer(_startPosition!, _spacing, data.axis),
    ...?_renderers?.map(
      (e) =>
          e.transform(
            position: (data.axis == Axis2D.horizontal
                ? Offset(_spacing, 0)
                : Offset(0, _spacing)),
          ) ??
          e,
    ),
  ];

  @override
  Map<String, RendererState> get rendererStates => Map.fromEntries(
    _renderers?.map((e) => MapEntry(e.id, RendererState.hidden)) ?? [],
  );

  Rect? _lastRect;

  Future<void> _refreshRenderers(Offset position, EventContext context) async {
    final rect = _getRect(position, _spacing);
    if (rect == _lastRect) return;
    _lastRect = rect;
    final renderers = await context.getDocumentBloc().rayCastRect(
      rect,
      useCollection: true,
    );
    if (rect != _lastRect) return;
    _renderers = renderers;
  }

  @override
  bool onScaleStart(ScaleStartDetails details, EventContext context) {
    final transform = context.getCameraTransform();
    _startPosition = transform.localToGlobal(details.localFocalPoint);
    _refreshRenderers(_startPosition!, context).whenComplete(context.refresh);
    return true;
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    if (details.pointerCount > 1) return;
    final transform = context.getCameraTransform();
    final globalPos = transform.localToGlobal(details.localFocalPoint);
    _spacing = (data.axis == Axis2D.horizontal
        ? globalPos.dx - _startPosition!.dx
        : globalPos.dy - _startPosition!.dy);
    _startPosition = (data.axis == Axis2D.horizontal
        ? Offset(_startPosition!.dx, globalPos.dy)
        : Offset(globalPos.dx, _startPosition!.dy));
    _refreshRenderers(_startPosition!, context).whenComplete(context.refresh);
  }

  @override
  Future<void> onScaleEnd(ScaleEndDetails details, EventContext context) async {
    await _refreshRenderers(_startPosition!, context);

    final elements = Map<String, List<PadElement>>.fromEntries(
      _renderers
              ?.map((e) {
                final id = e.element.id;
                if (id == null) return null;
                return MapEntry(id, [
                  e
                          .transform(
                            position: (data.axis == Axis2D.horizontal
                                ? Offset(_spacing, 0)
                                : Offset(0, _spacing)),
                          )
                          ?.element ??
                      e.element,
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
    await context.refresh();
    context.getDocumentBloc().add(ElementsChanged(elements));
  }

  Rect _getRect(Offset position, double spacing) {
    if (_startPosition == null || spacing == 0.0) {
      return Rect.zero;
    }
    if (data.axis == Axis2D.horizontal) {
      return Rect.fromLTRB(
        spacing > 0 ? _startPosition!.dx : -double.infinity,
        -double.infinity,
        spacing < 0 ? _startPosition!.dx : double.infinity,
        double.infinity,
      );
    } else {
      return Rect.fromLTRB(
        -double.infinity,
        spacing > 0 ? _startPosition!.dy : -double.infinity,
        double.infinity,
        spacing < 0 ? _startPosition!.dy : double.infinity,
      );
    }
  }
}

class SpacerRenderer extends Renderer {
  final Offset startPosition;
  final double spacing;
  final Axis2D axis;

  SpacerRenderer(this.startPosition, this.spacing, this.axis) : super(null);

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
    canvas.drawLine(
      startPosition,
      startPosition +
          (axis == Axis2D.horizontal ? Offset(spacing, 0) : Offset(0, spacing)),
      paint,
    );
  }
}
