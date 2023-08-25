part of '../renderer.dart';

class TextureBackgroundRenderer extends Renderer<TextureBackground> {
  TextureBackgroundRenderer(super.element);

  SurfaceTexture get texture => element.texture;

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
          DocumentInfo info, CameraTransform transform,
          [ColorScheme? colorScheme, bool foreground = false]) =>
      drawSurfaceTextureOnCanvas(
        texture,
        canvas,
        transform.size,
        transform.position,
        size,
      );

  @override
  void buildSvg(XmlDocument xml, DocumentPage page, Rect viewportRect) =>
      drawSurfaceTextureOnSvg(
        texture,
        xml,
        viewportRect.topLeft,
        viewportRect.size,
      );
}
