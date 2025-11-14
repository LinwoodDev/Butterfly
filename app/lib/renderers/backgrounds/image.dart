part of '../renderer.dart';

class ImageBackgroundRenderer extends Renderer<ImageBackground> {
  ui.Image? image;

  ImageBackgroundRenderer(super.element, [this.image]);

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
    if (image == null) return;
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

    var paint = Paint();

    for (var x = offsetX; x < size.width; x += sizeX) {
      for (var y = offsetY; y < size.height; y += sizeY) {
        canvas.drawImageRect(
          image!,
          Rect.fromLTWH(
            0,
            0,
            element.width.toDouble(),
            element.height.toDouble(),
          ),
          Rect.fromLTWH(x, y, sizeX, sizeY),
          paint,
        );
      }
    }
  }

  @override
  void buildSvg(
    XmlDocument xml,
    NoteData document,
    DocumentPage page,
    Rect viewportRect,
  ) {
    final height = element.height;
    final width = element.width;
    final id = createUniqueId();
    // Add pattern
    final pattern = xml
        .getOrCreateElement('svg')
        .getOrCreateElement('defs')
        .createElement(
          'pattern',
          attributes: {
            'id': 'image-background-$id',
            'viewBox': '0,0,$width,$height',
            'width': '$width',
            'height': '$height',
            'patternUnits': 'userSpaceOnUse',
          },
        );
    final data = getUriDataFromSource(
      document,
      element.source,
      'image/png',
    ).toString();
    pattern.createElement(
      'image',
      attributes: {'xlink:href': data, 'width': '$width', 'height': '$height'},
    );
    // Add patern to svg
    xml
        .getOrCreateElement('svg')
        .createElement(
          'rect',
          attributes: {
            'x': viewportRect.left.toString(),
            'y': viewportRect.top.toString(),
            'width': viewportRect.width.toString(),
            'height': viewportRect.height.toString(),
            'fill': 'url(#image-background-$id)',
          },
        );
  }

  @override
  Future<void> setup(
    TransformCubit transformCubit,
    NoteData document,
    AssetService assetService,
    DocumentPage page, {
    bool isTemporary = false,
  }) async {
    super.setup(transformCubit, document, assetService, page);
    if (image != null) return;
    try {
      image = await assetService.getImage(element.source, document);
    } catch (_) {}
  }

  @override
  void dispose() {
    image?.dispose();
    image = null;
  }
}
