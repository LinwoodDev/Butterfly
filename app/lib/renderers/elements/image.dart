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

    canvas.drawImageRect(
      image!,
      Rect.fromLTWH(0, 0, element.width.toDouble(), element.height.toDouble()),
      rect,
      paint,
    );
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
  Future<void> onVisible(
    CurrentIndexCubit currentIndexCubit,
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
    CurrentIndexCubit currentIndexCubit,
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
  ImageRenderer _transform({
    required Offset position,
    required double rotation,
    double scaleX = 1,
    double scaleY = 1,
  }) {
    return ImageRenderer(
      element.copyWith(
        position: position.toPoint(),
        rotation: rotation,
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
      final asset = Uri.parse(element.source);
      if ((!asset.isScheme('file') && asset.scheme.isNotEmpty) ||
          image == null) {
        return;
      }
      final imgImage = await convertFlutterUiToImage(image!);
      var cmd = img.Command()..image(imgImage);
      update(cmd);
      cmd.encodePng();
      final converted = await cmd.getBytes();
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
