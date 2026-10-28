part of '../renderer.dart';

class PdfRenderer extends Renderer<PdfElement> {
  final AsyncResource<({ui.Image image, double? scale})> _image;
  ui.Image? get image => _image.value?.image;
  double? get renderedScale => _image.value?.scale;
  bool get ownsImage => _image.ownsValue;

  PdfRenderer(
    super.element, [
    super.layer,
    ui.Image? image,
    double? renderedScale,
    bool ownsImage = true,
  ]) : _image = AsyncResource(
         disposeValue: (value) => value.image.dispose(),
         value: image == null ? null : (image: image, scale: renderedScale),
         ownsValue: ownsImage,
       );

  Offset get _signedSize {
    final constraints = element.constraints;
    var width = element.width;
    var height = element.height;
    if (constraints is ScaledElementConstraints) {
      width *= constraints.scaleX == 0 ? 1 : constraints.scaleX;
      height *= constraints.scaleY == 0 ? 1 : constraints.scaleY;
    } else if (constraints is FixedElementConstraints) {
      width = constraints.width == 0 ? width : constraints.width;
      height = constraints.height == 0 ? height : constraints.height;
    } else if (constraints is DynamicElementConstraints) {
      width = constraints.width;
      height = constraints.height;
      final ratio = constraints.aspectRatio;
      if (ratio != 0) {
        if (width == 0) width = height * ratio;
        if (height == 0) height = width / ratio;
      }
      if (constraints.includeArea) {
        final areaRect = area?.rect;
        if (areaRect == null) {
          width = element.width;
          height = element.height;
        } else {
          final right = element.position.x + element.width;
          final areaWidth = min(areaRect.right, right) - element.position.x;
          width = areaWidth == 0 ? element.width : areaWidth;
          final bottom = element.position.y + element.height;
          final areaHeight = min(areaRect.bottom, bottom) - element.position.y;
          height = areaHeight == 0 ? element.height : areaHeight;
        }
      }
      if (width == 0) width = element.width;
      if (height == 0) height = element.height;
    }
    return Offset(width, height);
  }

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
      final signedSize = _signedSize;
      canvas.save();
      canvas.translate(element.position.x, element.position.y);
      canvas.scale(signedSize.dx < 0 ? -1 : 1, signedSize.dy < 0 ? -1 : 1);
      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTWH(0, 0, signedSize.dx.abs(), signedSize.dy.abs()),
        paint,
      );
      canvas.restore();
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
    final signedSize = _signedSize;
    final flipX = signedSize.dx < 0;
    final flipY = signedSize.dy < 0;
    final svgTransform = flipX || flipY
        ? 'translate(${flipX ? rect.left + rect.right : 0} '
              '${flipY ? rect.top + rect.bottom : 0}) '
              'scale(${flipX ? -1 : 1} ${flipY ? -1 : 1})'
        : null;
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
            'transform': ?svgTransform,
          },
        );
  }

  @override
  void onHidden(
    EditorController editorController,
    DocumentLoaded blocState,
    CameraTransform renderTransform,
    ui.Size size,
  ) {
    _image.clear();
  }

  @override
  Future<void> onVisible(
    EditorController editorController,
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
    EditorController editorController,
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

    await _image.load(
      (task) async {
        final data = await assetService.getPdfDocument(
          element.source,
          document,
        );
        if (data == null || task.isCanceled) return null;

        var renderScale = scale;
        const double maxDimension = 2048.0;
        final renderRect = rect;
        if (renderRect.width * renderScale > maxDimension) {
          renderScale = maxDimension / renderRect.width;
        }
        if (renderRect.height * renderScale > maxDimension) {
          renderScale = maxDimension / renderRect.height;
        }

        final width = (renderRect.width * renderScale).toInt();
        final height = (renderRect.height * renderScale).toInt();
        if (width <= 0 || height <= 0) return null;

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
        if (raster == null) return null;
        late ui.Image uiImage;
        img.Image? imageToInvert;
        try {
          if (task.isCanceled) return null;
          if (element.invert) {
            imageToInvert = raster.createImageNF();
          } else {
            uiImage = await raster.createImage();
          }
        } finally {
          raster.dispose();
        }
        if (imageToInvert != null) {
          final cmd = img.Command()
            ..image(imageToInvert)
            ..invert();
          final converted = await cmd.getImage();
          if (task.isCanceled) return null;
          uiImage = await convertImageToFlutterUi(converted ?? imageToInvert);
        }
        return (image: uiImage, scale: scale);
      },
      onError: (error, stackTrace) {
        talker.error(
          'Failed to render PDF element ${element.source}',
          error,
          stackTrace,
        );
        _image.clear();
      },
    );
  }

  @override
  Rect get rect {
    final position = element.position.toOffset();
    return Rect.fromPoints(position, position + _signedSize);
  }

  @override
  PdfRenderer _transform({
    required Offset position,
    required double rotation,
    required double shear,
    double scaleX = 1,
    double scaleY = 1,
  }) {
    return PdfRenderer(
      element.copyWith(
        position: position.toPoint(),
        rotation: rotation,
        shear: shear,
        constraints: element.constraints.scale(scaleX, scaleY),
      ),
      layer,
      image,
      renderedScale,
      false,
    );
  }

  @override
  void dispose() {
    _image.dispose();
  }
}
