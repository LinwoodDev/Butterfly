part of '../renderer.dart';

class TextureRenderer extends Renderer<TextureElement> {
  @override
  Rect rect;

  TextureRenderer(super.element, [this.rect = Rect.zero]);

  @override
  void setup(NoteData document, AssetService assetService, DocumentPage page) {
    _updateRect();
    super.setup(document, assetService, page);
  }

  void _updateRect() {
    rect = Rect.fromPoints(
        element.firstPosition.toOffset(), element.secondPosition.toOffset());
  }

  @override
  FutureOr<void> build(Canvas canvas, Size size, NoteData document,
      DocumentPage page, DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    _updateRect();
    drawSurfaceTextureOnCanvas(
        element.texture, canvas, 1, Offset.zero, rect.size, rect.topLeft);
  }

  @override
  void buildSvg(XmlDocument xml, NoteData document, DocumentPage page,
          Rect viewportRect) =>
      drawSurfaceTextureOnSvg(element.texture, xml, Offset.zero, rect.size);

  @override
  TextureRenderer _transform({
    required Offset position,
    required double rotation,
    double scaleX = 1,
    double scaleY = 1,
  }) {
    final newRect = position & Size(rect.width * scaleX, rect.height * scaleY);
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
      newRect,
    );
  }
}
