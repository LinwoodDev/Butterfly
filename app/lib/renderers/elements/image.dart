part of '../renderer.dart';

class ImageRenderer extends Renderer<ImageElement> {
  ui.Image? image;
  bool ownsImage;

  ImageRenderer(
    super.element, [
    super.layer,
    this.image,
    this.ownsImage = true,
  ]);

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
          width = areaWidth <= 0 ? element.width : areaWidth;
          final bottom = element.position.y + element.height;
          final areaHeight = min(areaRect.bottom, bottom) - element.position.y;
          height = areaHeight <= 0 ? element.height : areaHeight;
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
    if (shouldUpdate) {
      if (ownsImage) {
        image?.dispose();
      }
      image = null;
    }
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
    if (image == null) {
      // Render placeholder
      final paint = Paint()
        ..color = Colors.grey
        ..style = PaintingStyle.fill;
      canvas.drawRect(rect, paint);
      return;
    }
    var paint = Paint()
      ..filterQuality = FilterQuality.medium
      ..isAntiAlias = true;

    final signedSize = _signedSize;
    canvas.save();
    canvas.translate(element.position.x, element.position.y);
    canvas.scale(signedSize.dx < 0 ? -1 : 1, signedSize.dy < 0 ? -1 : 1);
    canvas.drawImageRect(
      image!,
      Rect.fromLTWH(0, 0, element.width, element.height),
      Rect.fromLTWH(0, 0, signedSize.dx.abs(), signedSize.dy.abs()),
      paint,
    );
    canvas.restore();
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
  Future<void> onVisible(
    EditorController editorController,
    DocumentLoaded blocState,
    CameraTransform renderTransform,
    ui.Size size,
  ) async {
    if (image != null) return;
    try {
      image = await blocState.assetService.getImage(
        element.source,
        blocState.data,
      );
      ownsImage = true;
    } catch (_) {}
  }

  @override
  void onHidden(
    EditorController editorController,
    DocumentLoaded blocState,
    CameraTransform renderTransform,
    ui.Size size,
  ) {
    if (ownsImage) {
      image?.dispose();
    }
    image = null;
  }

  @override
  Rect get rect {
    final position = element.position.toOffset();
    return Rect.fromPoints(position, position + _signedSize);
  }

  @override
  ImageRenderer _transform({
    required Offset position,
    required double rotation,
    required double shear,
    double scaleX = 1,
    double scaleY = 1,
  }) {
    return ImageRenderer(
      element.copyWith(
        position: position.toPoint(),
        rotation: rotation,
        shear: shear,
        constraints: element.constraints.scale(scaleX, scaleY),
      ),
      layer,
      image,
      false,
    );
  }

  @override
  void dispose() {
    if (ownsImage) {
      image?.dispose();
    }
    image = null;
  }

  @override
  Map<RendererOperation, RendererOperationCallback> getOperations() {
    Future<void> updateImage(
      DocumentBloc bloc,
      void Function(img.Command) update,
    ) async {
      final asset = Uri.tryParse(element.source);
      if (asset == null ||
          (!asset.isScheme('file') && asset.scheme.isNotEmpty) ||
          image == null) {
        return;
      }
      final imgImage = await convertFlutterUiToImage(image!);
      var cmd = img.Command()..image(imgImage);
      update(cmd);
      cmd.encodePng();
      final converted = await cmd.getBytesThread();
      if (converted == null) return;
      bloc.add(AssetUpdated(asset.path, converted));
    }

    return {
      RendererOperation.invert: (bloc, context) =>
          updateImage(bloc, (cmd) => cmd.invert()),
      RendererOperation.background: (bloc, context) =>
          updateImage(bloc, (cmd) => cmd.filter(updateImageBackground())),
      RendererOperation.grayscale: (bloc, context) =>
          updateImage(bloc, (cmd) => cmd.grayscale()),
      RendererOperation.flipHorizontal: (bloc, context) => updateImage(
        bloc,
        (cmd) => cmd.flip(direction: img.FlipDirection.horizontal),
      ),
      RendererOperation.flipVertical: (bloc, context) => updateImage(
        bloc,
        (cmd) => cmd.flip(direction: img.FlipDirection.vertical),
      ),
    };
  }
}
