part of '../renderer.dart';

class EmptyBackgroundRenderer extends Renderer<EmptyBackground> {
  EmptyBackgroundRenderer(EmptyBackground element) : super(element);

  @override
  FutureOr<void> build(Canvas canvas, Size size, CameraTransform transform,
      [bool foreground = false]) {}
}
