part of 'handler.dart';

class ShapeHandler extends PastingHandler<ShapeTool> with ColoredHandler {
  ShapeHandler(super.data);

  @override
  void _updateElement(
    PointerEvent event,
    EventContext context, [
    bool first = false,
  ]) {
    changeStartedDrawing(context);
    super._updateElement(event, context, first);
  }

  @override
  List<PadElement> transformElements(
    Rect rect,
    String collection,
    CurrentIndexCubit cubit,
  ) {
    if (rect.top == 0 &&
        rect.left == 0 &&
        rect.right == 0 &&
        rect.bottom == 0) {
      return [];
    }

    return [
      ShapeElement(
        firstPosition: rect.topLeft.toPoint(),
        secondPosition: rect.bottomRight.toPoint(),
        property: data.property.copyWith(
          strokeWidth:
              data.property.strokeWidth /
              (data.zoomDependent ? cubit.state.cameraViewport.scale : 1),
        ),
        collection: collection,
      ),
    ];
  }

  @override
  bool get shouldNormalize => data.property.shape is! LineShape;
  @override
  double get constraintedAspectRatio => data.constrainedAspectRatio;
  @override
  double get constraintedHeight => data.constrainedHeight;
  @override
  double get constraintedWidth => data.constrainedWidth;
  @override
  bool get drawFromCenter => data.drawFromCenter;

  @override
  SRGBColor getColor() => data.property.color;

  @override
  ShapeTool setColor(SRGBColor color) => data.copyWith(
    property: data.property.copyWith(
      color: color.withValues(a: data.property.color.a),
    ),
  );

  @override
  double getStrokeWidth() => data.property.strokeWidth;

  @override
  ShapeTool setStrokeWidth(double width) =>
      data.copyWith(property: data.property.copyWith(strokeWidth: width));
}
