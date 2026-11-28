part of '../renderer.dart';

class SvgRenderer extends Renderer<SvgElement> {
  final AsyncResource<PictureInfo> _picture;
  PictureInfo? get pictureInfo => _picture.value;
  bool get ownsPictureInfo => _picture.ownsValue;

  SvgRenderer(
    super.element, [
    super.layer,
    PictureInfo? pictureInfo,
    bool ownsPictureInfo = true,
  ]) : _picture = AsyncResource(
         disposeValue: (info) => info.picture.dispose(),
         value: pictureInfo,
         ownsValue: ownsPictureInfo,
       );

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
    canvas.scale(
      rect.width /
          pictureInfo!.size.width *
          (element.width.isNegative ? -1 : 1),
      rect.height /
          pictureInfo!.size.height *
          (element.height.isNegative ? -1 : 1),
    );
    canvas.drawPicture(picture);
    canvas.restore();
  }

  @override
  void buildSvg(
    XmlDocument xml,
    NoteData document,
    DocumentPage page,
    Rect viewportRect,
  ) {
    final bounds = rect;
    if (!bounds.overlaps(viewportRect)) return;
    addSvgImage(
      xml,
      bounds,
      element.getUriData(document, 'image/svg+xml').toString(),
      flipX: element.width.isNegative,
      flipY: element.height.isNegative,
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
      await _picture.load(
        (_) => vg.loadPicture(
          SvgStringLoader(normalizeSvgBytes(data)),
          null,
          clipViewbox: false,
        ),
      );
    }
  }

  @override
  Rect get rect {
    final constraints = element.constraints;
    final size = Size(element.width.abs(), element.height.abs());
    var width = size.width;
    var height = size.height;
    if (constraints is ScaledElementConstraints) {
      final scaleX = constraints.scaleX <= 0 ? 1 : constraints.scaleX;
      final scaleY = constraints.scaleY <= 0 ? 1 : constraints.scaleY;
      width *= scaleX;
      height *= scaleY;
    } else if (constraints is FixedElementConstraints) {
      if (constraints.width > 0) width = constraints.width;
      if (constraints.height > 0) height = constraints.height;
    } else if (constraints is DynamicElementConstraints) {
      width = constraints.width;
      height = constraints.height;
      final ratio = constraints.aspectRatio;
      if (ratio != 0) {
        if (width <= 0) width = height * ratio;
        if (height <= 0) height = width / ratio;
      }
      if (constraints.includeArea) {
        final areaRect = area?.rect;
        final rightArea = areaRect?.right ?? 0;
        final right = element.position.x + size.width;
        width = min(rightArea, right) - element.position.x;
        final bottomArea = areaRect?.bottom ?? 0;
        final bottom = element.position.y + size.height;
        height = min(bottomArea, bottom) - element.position.y;
      }
      if (height <= 0) height = size.height;
      if (width <= 0) width = size.width;
    }
    final position = element.position.toOffset();
    return Rect.fromPoints(
      position,
      position.translate(
        element.width.isNegative ? -width : width,
        element.height.isNegative ? -height : height,
      ),
    );
  }

  @override
  void dispose() {
    _picture.dispose();
  }

  @override
  SvgRenderer _transform({
    required Offset position,
    required double rotation,
    required double shear,
    double scaleX = 1,
    double scaleY = 1,
    // ignore: unused_element_parameter
    double strokeWidthFactor = 1,
  }) {
    return SvgRenderer(
      element.copyWith(
        position: transformAssetPosition(
          element.position,
          rect,
          position,
          scaleX,
          scaleY,
        ),
        rotation: rotation,
        shear: shear,
        width: element.width * scaleX,
        height: element.height * scaleY,
      ),
      layer,
      pictureInfo,
      false,
    );
  }
}
