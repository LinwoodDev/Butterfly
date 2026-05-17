part of '../renderer.dart';

class PdfRenderer extends Renderer<PdfElement> {
  ui.Image? image;
  double? renderedScale;
  int _renderId = 0;

  PdfRenderer(super.element, [super.layer, this.image, this.renderedScale]);

  @override
  bool onAssetUpdate(
    NoteData document,
    AssetService assetService,
    DocumentPage page,
    String path,
  ) {
    final uri = Uri.tryParse(element.source);
    if (uri != null && uri.hasScheme && !uri.isScheme('file')) return false;
    final sourcePath = uri?.path ?? element.source;
    final shouldUpdate = sourcePath == path;
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
    final image = this.image;

    if (image == null) {
      // Render placeholder
      final paint = Paint()
        ..color = element.background.a > 0
            ? element.background.toColor()
            : Colors.grey
        ..style = PaintingStyle.fill;
      canvas.drawRect(rect, paint);
    } else {
      final paint = Paint()
        ..filterQuality = FilterQuality.high
        ..isAntiAlias = true;
      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        rect,
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
    _renderId++;
    image?.dispose();
    image = null;
    renderedScale = null;
  }

  @override
  Future<void> onVisible(
    CurrentIndexCubit currentIndexCubit,
    DocumentLoaded blocState,
    CameraTransform renderTransform,
    ui.Size size,
  ) async {
    return _renderImage(
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
    final scale = renderTransform.size * renderTransform.pixelRatio;
    if (renderedScale != null && (renderedScale! - scale).abs() < 0.001) {
      return;
    }
    return _renderImage(blocState.assetService, blocState.data, scale);
  }

  Future<void> _renderImage(
    AssetService assetService,
    NoteData document,
    double scale,
  ) async {
    if (image != null &&
        renderedScale != null &&
        (renderedScale! - scale).abs() < 0.001) {
      return;
    }

    final currentRenderId = ++_renderId;
    try {
      final data = await assetService.getPdfDocument(element.source, document);
      if (data == null || currentRenderId != _renderId) return;

      var renderScale = scale;
      const double maxDimension = 4000.0;
      final renderRect = rect;
      if (renderRect.width * renderScale > maxDimension) {
        renderScale = maxDimension / renderRect.width;
      }
      if (renderRect.height * renderScale > maxDimension) {
        renderScale = maxDimension / renderRect.height;
      }

      final width = (renderRect.width * renderScale).toInt();
      final height = (renderRect.height * renderScale).toInt();
      if (width <= 0 || height <= 0) return;

      final raster = await data.pages
          .elementAtOrNull(element.page)
          ?.render(
            x: 0,
            y: 0,
            width: width,
            height: height,
            fullWidth: width.toDouble(),
            fullHeight: height.toDouble(),
          );
      if (raster == null || currentRenderId != _renderId) {
        raster?.dispose();
        return;
      }

      ui.Image uiImage;
      if (element.invert) {
        var imgImage = raster.createImageNF();
        raster.dispose();
        final cmd = img.Command()
          ..image(imgImage)
          ..invert();
        final converted = await cmd.getImage();
        if (converted != null) imgImage = converted;
        uiImage = await convertImageToFlutterUi(imgImage);
      } else {
        uiImage = await raster.createImage();
        raster.dispose();
      }

      if (currentRenderId != _renderId) {
        uiImage.dispose();
        return;
      }

      image?.dispose();
      image = uiImage;
      renderedScale = scale;
    } catch (error, stackTrace) {
      talker.error(
        'Failed to render PDF element ${element.source}',
        error,
        stackTrace,
      );
      if (currentRenderId == _renderId) {
        image?.dispose();
        image = null;
        renderedScale = null;
      }
    }
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
    );
  }

  @override
  void dispose() {
    _renderId++;
    image?.dispose();
    image = null;
    renderedScale = null;
  }
}
