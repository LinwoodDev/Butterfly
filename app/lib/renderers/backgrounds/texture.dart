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
  ]) => drawSurfaceTextureOnCanvas(
    texture,
    canvas,
    transform.size,
    transform.position,
    size,
    Offset.zero,
    true,
  );

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
