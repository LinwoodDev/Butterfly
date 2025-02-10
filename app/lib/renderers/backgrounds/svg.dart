part of '../renderer.dart';

class SvgBackgroundRenderer extends Renderer<SvgBackground> {
  PictureInfo? _pictureInfo;

  SvgBackgroundRenderer(super.element);

  @override
  FutureOr<void> setup(
      NoteData document, AssetService assetService, DocumentPage page) async {
    super.setup(document, assetService, page);
    final data = await getDataFromSource(document, element.source)
        .then((value) => value == null ? null : utf8.decode(value));
    if (data != null) {
      _pictureInfo = await vg.loadPicture(SvgStringLoader(data), null);
    }
  }

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    if (_pictureInfo == null) return;
    final sizeX = element.width * element.scaleX * transform.size;
    final sizeY = element.height * element.scaleY * transform.size;
    var offsetX = (transform.position.dx * -transform.size) % sizeX;
    if (offsetX > 0) {
      offsetX -= sizeX;
    }
    var offsetY = (transform.position.dy * -transform.size) % sizeY;
    if (offsetY > 0) {
      offsetY -= sizeY;
    }
    for (var x = offsetX; x < size.width; x += sizeX) {
      for (var y = offsetY; y < size.height; y += sizeY) {
        canvas.translate(x, y);
        canvas.scale(
            element.scaleX * transform.size, element.scaleY * transform.size);
        canvas.drawPicture(_pictureInfo!.picture);
        canvas.scale(1 / (element.scaleX * transform.size),
            1 / (element.scaleY * transform.size));
        canvas.translate(-x, -y);
      }
    }
  }
}
