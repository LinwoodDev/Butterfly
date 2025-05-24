part of '../renderer.dart';

class PenRenderer extends PathRenderer<PenElement> {
  PenRenderer(super.element, [super.layer, super.rect = Rect.zero]);

  @override
  double? get zoom => element.zoom;

  @override
  PathVisual buildPathVisual([DocumentPage? page, bool foreground = false]) =>
      (color: element.property.color, fill: element.property.fill);

  @override
  PenRenderer _transform({
    required Offset position,
    required double rotation,
    double scaleX = 1,
    double scaleY = 1,
  }) => PenRenderer(
    element.copyWith(
      rotation: rotation,
      points: movePoints(position, scaleX, scaleY),
    ),
    layer,
    moveRect(position, scaleX, scaleY),
  );
}
