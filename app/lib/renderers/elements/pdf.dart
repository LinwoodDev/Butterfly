part of '../renderer.dart';

class PdfRenderer extends Renderer<PdfElement> {
  ui.Image? image;
  double? renderedScale;
  Rect? _lastRenderedRect;

  PdfRenderer(
    super.element, [
    super.layer,
    this.image,
    this.renderedScale,
    this._lastRenderedRect,
  ]);

  @override
  bool onAssetUpdate(
    NoteData document,
    AssetService assetService,
    DocumentPage page,
    String path,
  ) {
    final uri = Uri.parse(element.source);
    if (uri.hasScheme && !uri.isScheme('file')) return false;
    final shouldUpdate = uri.path == path;
    return shouldUpdate;
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
    if (this.image == null || element.background.a > 0) {
      // Render placeholder
      final paint = Paint()
        ..color = element.background.a > 0
            ? element.background.toColor()
            : Colors.grey
        ..style = PaintingStyle.fill;
      canvas.drawRect(rect, paint);
    }
    final image = this.image;
    final renderRect = _lastRenderedRect;
    if (image != null && renderRect != null && !renderRect.isEmpty) {
      final paint = Paint()
        ..filterQuality = FilterQuality.high
        ..isAntiAlias = true;
      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        renderRect,
        paint,
      );
    }
  }

  @override
  void buildSvg(
    XmlDocument xml,
    NoteData document,
    DocumentPage page,
    Rect viewportRect,
  ) {
    if (!rect.overlaps(viewportRect)) return;
    // Create data url
    final data = element.getUriData(document, 'image/png').toString();
    // Create image
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
  void onHidden(
    CurrentIndexCubit currentIndexCubit,
    DocumentLoaded blocState,
    CameraTransform renderTransform,
    ui.Size size,
  ) {
    image?.dispose();
    image = null;
    renderedScale = null;
    _lastRenderedRect = null;
  }

  Rect _getRenderRect(Rect viewportRect) => rect.intersect(viewportRect);

  Rect _getViewportRect(CameraTransform renderTransform, Size size) =>
      Rect.fromLTWH(
        renderTransform.position.dx,
        renderTransform.position.dy,
        size.width / renderTransform.size,
        size.height / renderTransform.size,
      );

  @override
  Future<void> onVisible(
    CurrentIndexCubit currentIndexCubit,
    DocumentLoaded blocState,
    CameraTransform renderTransform,
    ui.Size size,
  ) async {
    return _renderImage(
      _getRenderRect(_getViewportRect(renderTransform, size)),
      blocState.assetService,
      blocState.data,
      renderTransform.size * renderTransform.pixelRatio,
    );
  }

  @override
  Future<void> updateView(
    CurrentIndexCubit currentIndexCubit,
    DocumentLoaded blocState,
    CameraTransform renderTransform,
    ui.Size size,
  ) async {
    return _renderImage(
      _getRenderRect(_getViewportRect(renderTransform, size)),
      blocState.assetService,
      blocState.data,
      renderTransform.size * renderTransform.pixelRatio,
    );
  }

  Future<void> _renderImage(
    Rect renderRect,
    AssetService assetService,
    NoteData document,
    double scale,
  ) async {
    if (renderRect.isEmpty) {
      image?.dispose();
      image = null;
      renderedScale = null;
      _lastRenderedRect = null;
      return;
    }
    if (image != null &&
        _lastRenderedRect == renderRect &&
        renderedScale != null &&
        (renderedScale! - scale).abs() < 0.001) {
      return;
    }
    final data = await assetService.getPdfDocument(element.source, document);
    if (data == null) return;
    final relativeRect = renderRect.translate(
      -element.position.x,
      -element.position.y,
    );
    try {
      final raster = await data.pages
          .elementAtOrNull(element.page)
          ?.render(
            x: (relativeRect.left * scale).toInt(),
            y: (relativeRect.top * scale).toInt(),
            width: (relativeRect.width * scale).toInt(),
            height: (relativeRect.height * scale).toInt(),
            fullWidth: element.width * scale,
            fullHeight: element.height * scale,
          );
      if (raster == null) return;
      var imgImage = raster.createImageNF();
      if (element.invert) {
        final cmd = img.Command()
          ..image(imgImage)
          ..invert();
        final converted = await cmd.getImage();
        if (converted != null) imgImage = converted;
      }
      image?.dispose();
      image = await convertImageToFlutterUi(imgImage);
      renderedScale = scale;
      _lastRenderedRect = renderRect;
    } catch (_) {}
  }

  @override
  Rect get rect {
    final constraints = element.constraints;
    if (constraints is ScaledElementConstraints) {
      final scaleX = constraints.scaleX <= 0 ? 1 : constraints.scaleX;
      final scaleY = constraints.scaleY <= 0 ? 1 : constraints.scaleY;
      return Rect.fromLTWH(
        element.position.x,
        element.position.y,
        (element.width * scaleX).toDouble(),
        (element.height * scaleY).toDouble(),
      );
    } else if (constraints is FixedElementConstraints) {
      var height = constraints.height;
      var width = constraints.width;
      if (height <= 0) height = element.height.toDouble();
      if (width <= 0) width = element.width.toDouble();
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
        final bottom = element.position.y + element.height;
        height = min(bottomArea, bottom) - element.position.y;
      }
      if (height <= 0) height = element.height.toDouble();
      if (width <= 0) width = element.width.toDouble();
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
        element.width.toDouble(),
        element.height.toDouble(),
      );
    }
  }

  @override
  PdfRenderer _transform({
    required Offset position,
    required double rotation,
    double scaleX = 1,
    double scaleY = 1,
  }) {
    return PdfRenderer(
      element.copyWith(
        position: position.toPoint(),
        rotation: rotation,
        constraints: element.constraints.scale(scaleX, scaleY),
      ),
      layer,
      image,
      renderedScale,
      _lastRenderedRect,
    );
  }

  @override
  void dispose() {
    image?.dispose();
    image = null;
    renderedScale = null;
    _lastRenderedRect = null;
  }
}
