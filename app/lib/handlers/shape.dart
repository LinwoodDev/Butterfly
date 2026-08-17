part of 'handler.dart';

Offset snapLineEndPosition(Offset start, Offset end) {
  final delta = end - start;
  final length = delta.distance;
  if (length == 0) return end;

  final direction = (delta.direction / (pi / 4)).round() % 8;
  final diagonal = length / sqrt2;
  final snappedDelta = switch (direction) {
    0 => Offset(length, 0),
    1 => Offset(diagonal, diagonal),
    2 => Offset(0, length),
    3 => Offset(-diagonal, diagonal),
    4 => Offset(-length, 0),
    5 => Offset(-diagonal, -diagonal),
    6 => Offset(0, -length),
    7 => Offset(diagonal, -diagonal),
    _ => Offset(length, 0),
  };
  return start + snappedDelta;
}

class ShapeHandler extends PastingHandler<ShapeTool> with ColoredHandler {
  ShapeHandler(super.data);

  @override
  void _updateElement(
    Offset localPosition,
    EventContext context, [
    bool first = false,
  ]) {
    changeStartedDrawing(context);
    super._updateElement(localPosition, context, first);
  }

  @override
  List<PadElement> transformElements(
    Rect rect,
    String collection,
    EditorController cubit,
  ) {
    if (rect.topLeft == rect.bottomRight) return [];

    return [
      ShapeElement(
        firstPosition: rect.topLeft.toPoint(),
        secondPosition: rect.bottomRight.toPoint(),
        property: data.property.copyWith(
          strokeWidth:
              data.property.strokeWidth /
              (data.zoomDependent
                  ? cubit.rendererCubit.state.cameraViewport.scale
                  : 1),
        ),
        collection: collection,
      ),
    ];
  }

  @override
  bool get shouldNormalize => false;

  bool get _isLine => data.property.shape is LineShape;

  bool _shouldConstrain(bool modifierActive) =>
      data.constrain != modifierActive;

  @override
  Offset constrainPosition(Offset first, Offset second, bool modifierActive) {
    if (!_isLine || !_shouldConstrain(modifierActive)) return second;
    return snapLineEndPosition(first, second);
  }

  @override
  double getAspectRatio(bool modifierActive) {
    final constrained = _shouldConstrain(modifierActive);
    if (_isLine) return constrained ? 0 : super.getAspectRatio(false);
    return super.getAspectRatio(constrained);
  }

  @override
  List<Widget> getToolbarActions(DocumentBloc bloc) => [
    Builder(
      builder: (context) => IconButton(
        tooltip: AppLocalizations.of(context).center,
        icon: const PhosphorIcon(PhosphorIconsLight.target),
        selectedIcon: const PhosphorIcon(PhosphorIconsFill.target),
        isSelected: data.drawFromCenter,
        onPressed: () => changeTool(
          bloc,
          data.copyWith(drawFromCenter: !data.drawFromCenter),
        ),
      ),
    ),
    Builder(
      builder: (context) => IconButton(
        tooltip: AppLocalizations.of(context).constraint,
        icon: const PhosphorIcon(PhosphorIconsLight.angle),
        selectedIcon: const PhosphorIcon(PhosphorIconsFill.angle),
        isSelected: data.constrain,
        onPressed: () =>
            changeTool(bloc, data.copyWith(constrain: !data.constrain)),
      ),
    ),
  ];

  @override
  double get constraintedAspectRatio => data.constrainedAspectRatio;
  @override
  double get constraintedHeight => data.constrainedHeight;
  @override
  double get constraintedWidth => data.constrainedWidth;
  @override
  bool get drawFromCenter => data.drawFromCenter;

  @override
  SRGBColor getColor() => data.property.paint.previewColor;

  @override
  ShapeTool setColor(SRGBColor color) => data.copyWith(
    property: data.property.copyWith(
      paint: ElementPaint.solid(
        color: color.withValues(a: getColor().a),
        blur: data.property.paint.blur,
      ),
    ),
  );

  @override
  double getStrokeWidth() => data.property.strokeWidth;

  @override
  ShapeTool setStrokeWidth(double width) =>
      data.copyWith(property: data.property.copyWith(strokeWidth: width));
}
