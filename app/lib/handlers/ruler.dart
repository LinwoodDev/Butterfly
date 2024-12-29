part of 'handler.dart';

Rect _getRulerRect(Size size,
    [CameraTransform transform = const CameraTransform()]) {
  const rulerSize = 100.0;
  return Rect.fromLTWH(
    transform.position.dx,
    transform.position.dy + (size.height / 2 + -rulerSize / 2) / transform.size,
    size.width / transform.size,
    rulerSize / transform.size,
  );
}

class RulerHandler extends Handler<RulerTool> with PointerManipulationHandler {
  Offset _position = Offset.zero;
  double _rotation = 0;

  Offset get position => _position;
  double get rotation => _rotation;

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

  void transform(
    EventContext context, {
    Offset? position,
    double? rotation,
  }) {
    if (position != null) {
      _position = position;
    }
    if (rotation != null) {
      _rotation = rotation;
    }
    context.refresh();
  }

  bool isPointerInside(Offset position, Size viewportSize) {
    final rect = _getRulerRect(viewportSize);
    // Check if the position is inside the ruler rect, consider rotation
    final rotatedPosition = position.rotate(rect.center, -_rotation);
    return rect.contains(rotatedPosition);
  }

  @override
  Offset getPointerPosition(Offset position, Size viewportSize) {
    if (!isPointerInside(position, viewportSize)) {
      return _position;
    }
    final rotatedPosition = position.rotate(_position, _rotation);
    return Offset(
      _position.dx + (rotatedPosition.dx - _position.dx).roundToDouble(),
      _position.dy + (rotatedPosition.dy - _position.dy).roundToDouble(),
    );
  }

  static RulerHandler? getFirstRuler(
      CurrentIndex index, Offset position, Size viewportSize) {
    return index.toggleableHandlers.values
        .whereType<RulerHandler>()
        .firstWhereOrNull((e) => e.isPointerInside(position, viewportSize));
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
    final rulerRect = _getRulerRect(size, transform);

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
