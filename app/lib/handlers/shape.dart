part of 'handler.dart';

class ShapeHandler extends PastingHandler<ShapeTool> with ColoredHandler {
  ShapeHandler(super.data);

  @override
  List<PadElement> transformElements(Rect rect, String collection) {
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
        property: data.property,
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
  int getColor() => data.property.color;

  @override
  ShapeTool setColor(int color) =>
      data.copyWith(property: data.property.copyWith(color: color));
}
