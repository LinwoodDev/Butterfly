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
    final viewport = transform.localToGlobalRect(
      (Offset.zero & size).inflate(20),
    );

    drawSurfaceTextureOnCanvas(
      texture,
      canvas,
      1,
      viewport.topLeft,
      viewport.size,
      viewport.topLeft,
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
