part of 'handler.dart';

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
        firstPosition:
            (data.property.shape is LineShape
                    ? rect.topLeft
                    : rect.topLeft.translate(
                        min(0, rect.width),
                        min(0, rect.height),
                      ))
                .toPoint(),
        secondPosition:
            (data.property.shape is LineShape
                    ? rect.bottomRight
                    : rect.bottomRight.translate(
                        max(0, -rect.width),
                        max(0, -rect.height),
                      ))
                .toPoint(),
        property: data.property.copyWith(
          strokeWidth:
              data.property.strokeWidth /
              (data.zoomDependent ? cubit.rendererCubit.state.cameraViewport.scale : 1),
        ),
        collection: collection,
      ),
    ];
  }

  @override
  bool get shouldNormalize => false;
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
      paint: ElementPaint.solid(color: color.withValues(a: getColor().a)),
    ),
  );

  @override
  double getStrokeWidth() => data.property.strokeWidth;

  @override
  ShapeTool setStrokeWidth(double width) =>
      data.copyWith(property: data.property.copyWith(strokeWidth: width));
}
