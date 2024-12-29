part of 'handler.dart';

class RulerHandler extends Handler<RulerTool> {
  Offset _position = Offset.zero;
  double _rotation = 0;

  RulerHandler(super.data);

  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
          NoteData document, DocumentPage page, DocumentInfo info,
          [Area? currentArea]) =>
      [
        RulerRenderer(data, position: _position, rotation: _rotation),
      ];

  @override
  SelectState onSelected(BuildContext context, [bool wasAdded = true]) {
    return SelectState.toggle;
  }

  void move(Offset offset, EventContext context) {
    _position = offset;
    context.refresh();
  }

  void rotate(double rotation, EventContext context) {
    _rotation = rotation;
    context.refresh();
  }
}

class RulerRenderer extends Renderer<RulerTool> {
  final Offset position;
  @override
  final double rotation;

  RulerRenderer(
    super.element, {
    this.position = Offset.zero,
    this.rotation = 0,
  });

  Rect getRulerRect(Size size, CameraTransform transform) {
    const rulerSize = 100.0;
    return Rect.fromLTWH(
      transform.position.dx,
      transform.position.dy +
          (size.height / 2 + -rulerSize / 2) / transform.size,
      size.width / transform.size,
      rulerSize / transform.size,
    );
  }

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    final rulerColor = colorScheme?.primary ?? Colors.grey;
    final rulerBackgroundColor = element.color?.toColor() ??
        (colorScheme?.primaryContainer ?? Colors.grey).withAlpha(200);
    final rulerForegroundColor = colorScheme?.onPrimary ?? Colors.white;
    final rulerPaint = Paint()
      ..color = rulerColor
      ..strokeWidth = 1 / transform.size
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    final rulerBackgroundPaint = Paint()
      ..color = rulerBackgroundColor
      ..style = PaintingStyle.fill;
    final rulerForegroundPaint = Paint()..color = rulerForegroundColor;
    final rulerRect = getRulerRect(size, transform);

    // Calculate steps based on zoom level
    var steps = 50;

    // Paint ruler background
    canvas.drawRect(rulerRect, rulerBackgroundPaint);
    canvas.drawLine(
      Offset(rulerRect.left, rulerRect.top),
      Offset(rulerRect.right, rulerRect.top),
      rulerPaint,
    );
    canvas.drawLine(
      Offset(rulerRect.left, rulerRect.bottom),
      Offset(rulerRect.right, rulerRect.bottom),
      rulerPaint,
    );

    // Paint ruler lines
    double x = 0;
    var even = (transform.position.dx ~/ (steps / transform.size)) % 2 == 0;
    while (x <= size.width / transform.size) {
      final posX = x -
          (transform.position.dx % (steps / transform.size)) +
          transform.position.dx;
      canvas.drawLine(
        Offset(posX, rulerRect.top),
        Offset(
            posX,
            rulerRect.top +
                (even ? rulerRect.height / 8 : rulerRect.height / 4)),
        rulerForegroundPaint,
      );
      even = !even;
      x += steps / transform.size;
    }
  }
}
