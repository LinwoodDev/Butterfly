part of '../renderer.dart';

class EmptyBackgroundRenderer extends Renderer<EmptyBackground> {
  EmptyBackgroundRenderer(super.element);

  @override
  void build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [bool foreground = false]) {
    canvas.drawColor(Colors.white, BlendMode.src);
  }
}
