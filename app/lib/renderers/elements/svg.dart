part of '../renderer.dart';

class SvgRenderer extends Renderer<SvgElement> {
  PictureInfo? pictureInfo;

  SvgRenderer(super.element, [super.layer, this.pictureInfo]);

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
    final rect = this.rect;
    if (pictureInfo == null) {
      // Render placeholder
      final paint = Paint()
        ..color = Colors.grey
        ..style = PaintingStyle.fill;
      canvas.drawRect(rect, paint);
      return;
    }
    canvas.save();
    canvas.translate(element.position.x, element.position.y);
    final picture = pictureInfo!.picture;
    final sx = rect.width / pictureInfo!.size.width;
    final sy = rect.height / pictureInfo!.size.height;
    canvas.scale(sx, sy);
    canvas.drawPicture(picture);
    canvas.scale(1 / sx, 1 / sy);

    canvas.translate(-element.position.x, -element.position.x);
    canvas.restore();
  }

  @override
  void buildSvg(
    XmlDocument xml,
    NoteData document,
    DocumentPage page,
    Rect viewportRect,
  ) {
    if (!rect.overlaps(rect)) return;
    final data = element.getUriData(document, 'image/png').toString();
    xml
        .getElement('svg')
        ?.createElement(
          'image',
          attributes: {
            'x': '${rect.left}px',
            'y': '${rect.top}px',
            'width': '${rect.width}px',
            'height': '${rect.height}px',
            'xlink:href': data,
          },
        );
  }

  @override
  Future<void> setup(
    TransformCubit transformCubit,
    NoteData document,
    AssetService assetService,
    DocumentPage page,
  ) async {
    super.setup(transformCubit, document, assetService, page);
    final data = element.getData(document);
    if (data != null) {
      pictureInfo = await vg.loadPicture(
        SvgStringLoader(utf8.decode(data)),
        null,
        clipViewbox: false,
      );
    }
  }

  @override
  Rect get rect {
    final constraints = element.constraints;
    final size = Size(element.width, element.height);
    if (constraints is ScaledElementConstraints) {
      final scaleX = constraints.scaleX <= 0 ? 1 : constraints.scaleX;
      final scaleY = constraints.scaleY <= 0 ? 1 : constraints.scaleY;
      return Rect.fromLTWH(
        element.position.x,
        element.position.y,
        (size.width * scaleX).toDouble(),
        (size.height * scaleY).toDouble(),
      );
    } else if (constraints is FixedElementConstraints) {
      var height = constraints.height;
      var width = constraints.width;
      if (height <= 0) height = size.height.toDouble();
      if (width <= 0) width = size.width.toDouble();
      return Rect.fromLTWH(
        element.position.x,
        element.position.y,
        width,
        height,
      );
    } else if (constraints is DynamicElementConstraints) {
      var width = constraints.width;
      var height = constraints.height;
      final ratio = constraints.aspectRatio;
      if (ratio != 0) {
        if (width <= 0) width = height * ratio;
        if (height <= 0) height = width / ratio;
      }
      if (constraints.includeArea) {
        final areaRect = area?.rect;
        final rightArea = areaRect?.right ?? 0;
        final right = element.position.x + element.width;
        width = min(rightArea, right) - element.position.x;
        final bottomArea = areaRect?.bottom ?? 0;
        final bottom = element.position.y + size.height;
        height = min(bottomArea, bottom) - element.position.y;
      }
      if (height <= 0) height = size.height.toDouble();
      if (width <= 0) width = size.width.toDouble();
      return Rect.fromLTWH(
        element.position.x,
        element.position.y,
        width,
        height,
      );
    } else {
      return Rect.fromLTWH(
        element.position.x,
        element.position.y,
        size.width.toDouble(),
        size.height.toDouble(),
      );
    }
  }

  /*@override
  void dispose() {
    info?.picture.dispose();
  }*/

  @override
  SvgRenderer _transform({
    required Offset position,
    required double rotation,
    double scaleX = 1,
    double scaleY = 1,
  }) {
    return SvgRenderer(
      element.copyWith(
        position: position.toPoint(),
        rotation: rotation,
        width: element.width * scaleX,
        height: element.height * scaleY,
      ),
      layer,
      pictureInfo,
    );
  }
}
