part of '../renderer.dart';

class TextureRenderer extends Renderer<TextureElement> {
  @override
  Rect get rect => Rect.fromPoints(
    element.firstPosition.toOffset(),
    element.secondPosition.toOffset(),
  );

  TextureRenderer(super.element, [super.layer]);

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
  ]) => drawSurfaceTextureOnCanvas(
    element.texture,
    canvas,
    1,
    Offset.zero,
    rect.size,
    rect.topLeft,
  );

  @override
  void buildSvg(
    XmlDocument xml,
    NoteData document,
    DocumentPage page,
    Rect viewportRect,
  ) => drawSurfaceTextureOnSvg(
    element.texture,
    xml,
    Offset.zero,
    rect.size,
    rect.topLeft,
  );

  @override
  TextureRenderer _transform({
    required Offset position,
    required double rotation,
    double scaleX = 1,
    double scaleY = 1,
  }) {
    final sizeX =
        (element.firstPosition.x - element.secondPosition.x).abs() * scaleX;
    final sizeY =
        (element.firstPosition.y - element.secondPosition.y).abs() * scaleY;
    return TextureRenderer(
      element.copyWith(
        firstPosition: position.toPoint(),
        secondPosition: position.translate(sizeX, sizeY).toPoint(),
        rotation: rotation,
      ),
      super.layer,
    );
  }
}
