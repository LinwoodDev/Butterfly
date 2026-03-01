part of '../renderer.dart';

class TextureBackgroundRenderer extends Renderer<TextureBackground> {
  TextureBackgroundRenderer(super.element);

  SurfaceTexture get texture => element.texture;

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
    // Overshoot bounds to avoid 1px fractional bleeding
    final overshoot = 20.0;
    final oversize = Size(
      size.width + overshoot * 2,
      size.height + overshoot * 2,
    );

    // We must shift the offset that drawSurfaceTextureOnCanvas uses
    // to keep the pattern visually anchored accurately despite our expanded canvas
    final shiftedOffset =
        transform.position -
        Offset(overshoot / transform.size, overshoot / transform.size);

    drawSurfaceTextureOnCanvas(
      texture,
      canvas,
      transform.size,
      shiftedOffset,
      oversize,
      Offset(-overshoot, -overshoot),
      true,
    );
  }

  @override
  void buildSvg(
    XmlDocument xml,
    NoteData document,
    DocumentPage page,
    Rect viewportRect,
  ) => drawSurfaceTextureOnSvg(
    texture,
    xml,
    Offset.zero,
    viewportRect.size,
    viewportRect.topLeft,
    true,
  );
}
