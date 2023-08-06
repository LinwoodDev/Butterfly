part of 'handler.dart';

class SpacerHandler extends Handler<SpacerPainter> {
  Offset? _startPosition;
  double _spacing = 0.0;

  SpacerHandler(super.data);

  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
          NoteData document, DocumentPage page, DocumentInfo info,
          [Area? currentArea]) =>
      [
        if (_startPosition != null)
          SpacerRenderer(
            _startPosition!,
            _spacing,
            data.axis,
          ),
      ];

  @override
  bool onScaleStart(ScaleStartDetails details, EventContext context) {
    final transform = context.getCameraTransform();
    _startPosition = transform.localToGlobal(details.localFocalPoint);
    return false;
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
    context.refresh();
  }

  @override
  Future<void> onScaleEnd(ScaleEndDetails details, EventContext context) async {
    await _submit(context);
    _startPosition = null;
    _spacing = 0.0;
    context.refresh();
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

  Future<void> _submit(EventContext context) async {
    final rect = _getRect(_startPosition!, _spacing);
    if (rect.isEmpty) {
      return;
    }
    final renderers = await rayCastRect(
        rect, context.getDocumentBloc(), context.getCameraTransform());
    final content = context.getPage()?.content;
    if (content == null) return;
    final elements = Map.fromEntries(renderers
        .map((e) => MapEntry(content.indexOf(e.element), [
              e
                      .transform(
                          position: (data.axis == Axis2D.horizontal
                              ? Offset(_spacing, 0)
                              : Offset(0, _spacing)))
                      ?.element ??
                  e.element
            ]))
        .toList());
    context.getDocumentBloc().add(ElementsChanged(elements));
  }
}

class SpacerRenderer extends Renderer {
  final Offset startPosition;
  final double spacing;
  final Axis2D axis;

  SpacerRenderer(this.startPosition, this.spacing, this.axis) : super(null);

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
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
