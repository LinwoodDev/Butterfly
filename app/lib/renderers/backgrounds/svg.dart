part of '../renderer.dart';

class SvgBackgroundRenderer extends Renderer<SvgBackground> {
  PictureInfo? _pictureInfo;

  SvgBackgroundRenderer(super.element);

  @override
  Future<void> setup(
    TransformCubit transformCubit,
    NoteData document,
    AssetService assetService,
    DocumentPage page,
  ) async {
    super.setup(transformCubit, document, assetService, page);
    final bytes = getDataFromSource(document, element.source);
    if (bytes == null) return;
    final data = utf8.decode(bytes);
    _pictureInfo = await vg.loadPicture(SvgStringLoader(data), null);
  }

  @override
  void dispose() {
    _pictureInfo?.picture.dispose();
  }

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
    for (var x = offsetX - sizeX; x < size.width + sizeX; x += sizeX) {
      for (var y = offsetY - sizeY; y < size.height + sizeY; y += sizeY) {
        canvas.save();
        canvas.translate(x, y);
        canvas.scale(
          element.scaleX * transform.size,
          element.scaleY * transform.size,
        );
        canvas.drawPicture(_pictureInfo!.picture);
        canvas.restore();
      }
    }
  }

  @override
  void buildSvg(
    XmlDocument xml,
    NoteData document,
    DocumentPage page,
    ui.Rect viewportRect,
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
            'id': 'svg-background-$id',
            'viewBox': '0,0,$width,$height',
            'width': '$width',
            'height': '$height',
            'patternUnits': 'userSpaceOnUse',
          },
        );
    final data = getUriDataFromSource(
      document,
      element.source,
      'image/svg+xml',
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
            'width': '100%',
            'height': '100%',
            'fill': 'url(#svg-background-$id)',
          },
        );
  }
}
