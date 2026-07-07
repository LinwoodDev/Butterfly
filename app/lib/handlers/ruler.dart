part of 'handler.dart';

const _rulerRotationSnapAngle = 90.0;
const _rulerRotationSnapThreshold = 5.0;

Rect _getRulerRect(
  RulerTool ruler,
  Size size,
  Offset position, [
  CameraTransform transform = const CameraTransform(),
]) {
  return Rect.fromLTWH(
    transform.position.dx + (position.dx - size.width / 2) / transform.size,
    transform.position.dy +
        (size.height / 2 + -ruler.size / 2 + position.dy) / transform.size,
    size.width * 2 / transform.size,
    ruler.size / transform.size,
  );
}

double snapRulerRotation(double rotation) {
  final normalized = (rotation % 360 + 360) % 360;
  final nearestSnap =
      (normalized / _rulerRotationSnapAngle).round() * _rulerRotationSnapAngle;
  final distance = (normalized - nearestSnap).abs();
  if (distance <= _rulerRotationSnapThreshold ||
      360 - distance <= _rulerRotationSnapThreshold) {
    return nearestSnap % 360;
  }
  return normalized;
}

class RulerHandler extends Handler<RulerTool> with PointerManipulationHandler {
  Offset _position = Offset.zero;
  double _rotation = 0;
  double _previousGestureRotation = 0;
  Offset _transformStartPosition = Offset.zero;
  Offset _transformStartPointer = Offset.zero;

  Offset get position => _position;
  double get rotation => snapRulerRotation(_rotation);

  RulerHandler(super.data);

  @override
  List<Renderer> createForegrounds(
    CurrentIndexCubit currentIndexCubit,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) => [RulerRenderer(data, position: _position, rulerRotation: rotation)];

  @override
  SelectState onSelected(BuildContext context, [bool wasAdded = true]) {
    return SelectState.toggle;
  }

  void transform(EventContext context, {Offset? position, double? rotation}) {
    if (position != null) {
      _position += position;
    }
    if (rotation != null) {
      _rotation += rotation;
    }
    context.refresh();
  }

  void beginTransform(Offset pointer) {
    _previousGestureRotation = 0;
    _transformStartPosition = _position;
    _transformStartPointer = pointer;
  }

  void endTransform() {
    _previousGestureRotation = 0;
  }

  Offset _getDragPosition(Offset pointer) =>
      _transformStartPosition + pointer - _transformStartPointer;

  void transformWithScaleUpdate(
    EventContext context,
    ScaleUpdateDetails details,
  ) {
    final deltaRotation =
        (details.rotation - _previousGestureRotation) * 180 / pi;
    _previousGestureRotation = details.rotation;
    _position = _getDragPosition(details.localFocalPoint);
    transform(context, rotation: deltaRotation);
  }

  void transformWithPointerMove(EventContext context, PointerMoveEvent event) {
    if ((event.buttons & kSecondaryMouseButton) != 0) {
      final rulerCenter = getRect(context.viewportSize).center;
      final previousPosition = event.localPosition - event.delta;
      transform(
        context,
        rotation:
            (event.localPosition - rulerCenter).direction * 180 / pi -
            (previousPosition - rulerCenter).direction * 180 / pi,
      );
    } else {
      _position = _getDragPosition(event.localPosition);
      transform(context);
    }
  }

  Rect getRect(
    Size size, [
    CameraTransform transform = const CameraTransform(),
  ]) {
    return _getRulerRect(data, size, _position, transform);
  }

  bool isPointerInside(Offset position, Size viewportSize) {
    final rect = getRect(viewportSize);
    // Check if the position is inside the ruler rect, consider rotation
    final rotatedPosition = position.rotate(rect.center, -rotation * pi / 180);
    return rect.contains(rotatedPosition);
  }

  @override
  Offset getPointerPosition(
    Offset position,
    Size viewportSize, [
    CameraTransform transform = const CameraTransform(),
  ]) {
    if (!isPointerInside(position, viewportSize)) {
      return position;
    }
    final rulerRect = getRect(viewportSize);
    final pivot = rulerRect.center;
    final angle = rotation * pi / 180;

    final rotatedPosition = position.rotate(pivot, -angle);
    final firstHalf =
        rulerRect.topLeft & Size(rulerRect.width, rulerRect.height / 2);
    final secondHalf = firstHalf.translate(0, rulerRect.height / 2);
    final firstHalfHit = firstHalf.contains(rotatedPosition);
    final secondHalfHit = secondHalf.contains(rotatedPosition);
    // If the pointer is in the first half of the ruler, set the y to the top
    // If the pointer is in the second half of the ruler, set the y to the bottom

    if (firstHalfHit) {
      return Offset(rotatedPosition.dx, rulerRect.top).rotate(pivot, angle);
    } else if (secondHalfHit) {
      return Offset(rotatedPosition.dx, rulerRect.bottom).rotate(pivot, angle);
    }
    return position;
  }

  static RulerHandler? getFirstRuler(
    CurrentIndex index,
    Offset position,
    Size viewportSize,
  ) {
    return index.toggleableHandlers.values
        .whereType<RulerHandler>()
        .firstWhereOrNull((e) => e.isPointerInside(position, viewportSize));
  }

  static RulerHandler? getInteractiveRuler(
    CurrentIndex index,
    Handler handler,
    Offset position,
    Size viewportSize,
  ) {
    if (handler is! SelectHandler && handler is! GeneralHandHandler) {
      return null;
    }
    return getFirstRuler(index, position, viewportSize);
  }
}

class RulerRenderer extends Renderer<RulerTool> {
  final Offset position;
  final double rulerRotation;

  RulerRenderer(
    super.element, {
    this.position = Offset.zero,
    this.rulerRotation = 0,
  });

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
    canvas.save();
    canvas.translate(transform.position.dx, transform.position.dy);
    canvas.scale(1 / transform.size, 1 / transform.size);
    var rulerRect = _getRulerRect(element, size, position);
    final rulerCenter = rulerRect.center;
    canvas.translate(rulerCenter.dx, rulerCenter.dy);
    canvas.rotate(rulerRotation * pi / 180);
    rulerRect = rulerRect.translate(-rulerCenter.dx, -rulerCenter.dy);
    final rulerColor = colorScheme?.primary ?? Colors.grey;
    final rulerBackgroundColor =
        element.color?.toColor() ??
        (colorScheme?.primaryContainer ?? Colors.grey).withAlpha(200);
    final rulerForegroundColor = colorScheme?.onPrimary ?? Colors.white;
    final rulerPaint = Paint()
      ..color = rulerColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    final rulerBackgroundPaint = Paint()
      ..color = rulerBackgroundColor
      ..style = PaintingStyle.fill;
    final rulerForegroundPaint = Paint()..color = rulerForegroundColor;

    // Calculate steps based on zoom level
    var steps = 50;

    // Paint ruler background
    canvas.drawRect(rulerRect, rulerBackgroundPaint);
    canvas.drawRect(rulerRect, rulerPaint);

    // Draw center dot
    canvas.drawCircle(rulerRect.center, 4, rulerForegroundPaint);

    // Paint ruler lines
    int x = steps;
    var even = (transform.position.dx ~/ (steps / transform.size)) % 2 == 0;
    while (x <= size.width * transform.size * 2) {
      final posX =
          x / transform.size -
          (transform.position.dx % (steps / transform.size)) -
          size.width / 2 -
          rulerRect.width / 4;
      canvas.drawLine(
        Offset(posX, rulerRect.top),
        Offset(
          posX,
          rulerRect.top + (even ? rulerRect.height / 8 : rulerRect.height / 4),
        ),
        rulerForegroundPaint,
      );
      even = !even;
      x += steps;
    }

    canvas.rotate(-rulerRotation * pi / 180);
    canvas.translate(-rulerCenter.dx, -rulerCenter.dy);
    canvas.scale(transform.size, transform.size);
    canvas.translate(-transform.position.dx, -transform.position.dy);
    canvas.restore();
  }
}
