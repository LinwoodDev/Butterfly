import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/views/navigator/constants.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';

import 'cubits/transform.dart';
import 'selections/selection.dart';

void _paintRenderer(
  Canvas canvas,
  Size size,
  NoteData document,
  DocumentPage page,
  DocumentInfo info,
  CameraTransform transform,
  ColorScheme? colorScheme,
  Renderer renderer, {
  bool foreground = false,
  bool combined = false,
}) {
  final transformed = renderer.transformCanvas(canvas);
  if (combined && renderer is PenRenderer) {
    renderer.buildCombined(canvas);
  } else {
    renderer.build(
      canvas,
      size,
      document,
      page,
      info,
      transform,
      colorScheme,
      foreground,
    );
  }
  if (transformed) canvas.restore();
}

Rect? _rendererBounds(Renderer renderer) => renderer.expandedRect;

Rect? _groupBounds(Iterable<Renderer> renderers) {
  Rect? bounds;
  for (final renderer in renderers) {
    final rect = _rendererBounds(renderer);
    if (rect == null) return null;
    bounds = bounds?.expandToInclude(rect) ?? rect;
  }
  return bounds;
}

void _paintRenderers(
  Canvas canvas,
  Size size,
  NoteData document,
  DocumentPage page,
  DocumentInfo info,
  CameraTransform transform,
  ColorScheme? colorScheme,
  Iterable<Renderer> renderers, {
  bool foreground = false,
}) {
  final rendererList = renderers is List<Renderer>
      ? renderers
      : renderers.toList();
  Map<String, List<PenRenderer>>? groups;
  for (final renderer in rendererList.whereType<PenRenderer>()) {
    final combineId = renderer.element.combineId;
    if (combineId != null) {
      (groups ??= {}).putIfAbsent(combineId, () => []).add(renderer);
    }
  }
  if (groups == null) {
    for (final renderer in rendererList) {
      _paintRenderer(
        canvas,
        size,
        document,
        page,
        info,
        transform,
        colorScheme,
        renderer,
        foreground: foreground,
      );
    }
    return;
  }
  final paintedGroups = <String>{};
  for (final renderer in rendererList) {
    final combineId = renderer is PenRenderer
        ? renderer.element.combineId
        : null;
    if (combineId == null) {
      _paintRenderer(
        canvas,
        size,
        document,
        page,
        info,
        transform,
        colorScheme,
        renderer,
        foreground: foreground,
      );
      continue;
    }
    if (!paintedGroups.add(combineId)) continue;
    final group = groups[combineId]!;
    if (group.length == 1) {
      _paintRenderer(
        canvas,
        size,
        document,
        page,
        info,
        transform,
        colorScheme,
        group.first,
        foreground: foreground,
        combined: true,
      );
      continue;
    }
    canvas.saveLayer(_groupBounds(group), Paint());
    for (final groupedRenderer in group) {
      _paintRenderer(
        canvas,
        size,
        document,
        page,
        info,
        transform,
        colorScheme,
        groupedRenderer,
        foreground: foreground,
        combined: true,
      );
    }
    canvas.restore();
  }
}

class ForegroundPainter extends CustomPainter {
  final ColorScheme colorScheme;
  final NoteData document;
  final DocumentPage page;
  final DocumentInfo info;
  final List<Renderer> renderers;
  final CameraTransform transform;
  final Selection? selection;
  final NavigatorPosition navigatorPosition;

  ForegroundPainter(
    this.renderers,
    this.document,
    this.page,
    this.info,
    this.colorScheme, [
    this.transform = const CameraTransform(),
    this.selection,
    this.navigatorPosition = NavigatorPosition.left,
  ]);

  @override
  void paint(Canvas canvas, Size size) {
    final sel = selection;
    if (renderers.isEmpty && sel == null) return;
    transform.applyToCanvas(canvas);
    _paintRenderers(
      canvas,
      size,
      document,
      page,
      info,
      transform,
      colorScheme,
      renderers,
      foreground: true,
    );
    if (sel is ElementSelection) {
      _drawSelection(canvas, size, sel);
    }
  }

  void _drawSelection(Canvas canvas, Size size, ElementSelection selection) {
    final rect = selection.expandedRect;
    if (rect == null) return;
    // Don't allow drawing outside the bounds of the viewport.
    var viewport =
        Offset.zero & Size(size.width - kNavigationRailWidth, size.height);
    if (navigatorPosition == NavigatorPosition.left) {
      viewport = viewport.translate(kNavigationRailWidth, 0);
    }
    final bounds = transform.localToGlobalRect(viewport);
    final intersection = rect.intersect(bounds);
    if (intersection.isEmpty) return;
    canvas.drawRRect(
      RRect.fromRectAndRadius(intersection, const Radius.circular(2)),
      Paint()
        ..style = PaintingStyle.stroke
        ..color = colorScheme.primary
        ..strokeWidth = 5 / transform.size,
    );
  }

  @override
  bool shouldRepaint(ForegroundPainter oldDelegate) =>
      oldDelegate.renderers != renderers ||
      oldDelegate.transform != transform ||
      oldDelegate.selection != selection ||
      oldDelegate.colorScheme != colorScheme;
}

class ViewPainter extends CustomPainter {
  final NoteData document;
  final DocumentPage page;
  final DocumentInfo info;
  final Area? currentArea;
  final bool renderBackground, renderBaked, renderBakedLayers;
  final CameraViewport cameraViewport;
  final CameraTransform transform;
  final ColorScheme? colorScheme;
  final Set<String>? invisibleLayers;

  const ViewPainter(
    this.document,
    this.page,
    this.info, {
    this.currentArea,
    this.invisibleLayers,
    this.renderBackground = true,
    this.renderBaked = true,
    this.renderBakedLayers = true,
    required this.cameraViewport,
    this.colorScheme,
    this.transform = const CameraTransform(),
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (renderBackground) {
      canvas.drawColor(Colors.white, BlendMode.src);
    }
    canvas.save();
    transform.applyToCanvas(canvas);
    if (renderBackground) {
      for (final e in cameraViewport.backgrounds) {
        e.build(canvas, size, document, page, info, transform, colorScheme);
      }
    }
    final belowLayerImage = cameraViewport.belowLayerImage;
    final bakedRect = cameraViewport.toRect();
    if (renderBakedLayers && belowLayerImage != null) {
      canvas.drawImageRect(
        belowLayerImage,
        Offset.zero &
            Size(
              belowLayerImage.width.toDouble(),
              belowLayerImage.height.toDouble(),
            ),
        bakedRect,
        Paint(),
      );
    }
    final areaRect = currentArea?.rect;
    final areaSelectionWidth = 5 / transform.size;
    if (areaRect != null) {
      final visibleRect = transform.localToGlobalRect(Offset.zero & size);
      final currentAreaColor = currentArea?.color?.toColor();
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..color = currentAreaColor ?? colorScheme?.primary ?? Colors.green
        ..strokeWidth = areaSelectionWidth;
      canvas.drawRect(areaRect.inflate(areaSelectionWidth / 2), paint);
      for (final area in page.areas) {
        if (area == currentArea || !area.rect.overlaps(visibleRect)) continue;
        if (areaRect.overlaps(area.rect)) continue;
        final areaPaint = Paint()
          ..style = PaintingStyle.stroke
          ..color =
              area.color?.toColor() ?? colorScheme?.secondary ?? Colors.grey
          ..strokeWidth = areaSelectionWidth;
        canvas.drawRect(area.rect.inflate(areaSelectionWidth / 2), areaPaint);
      }
      canvas.clipRect(areaRect);
    }
    final image = cameraViewport.image;
    if (image != null &&
        renderBaked &&
        (cameraViewport.bakedElements.isNotEmpty ||
            cameraViewport.visibleUnbakedElements.isNotEmpty)) {
      // Draw our baked image, scaling it down with drawImageRect.
      try {
        canvas.drawImageRect(
          image,
          Offset.zero & Size(image.width.toDouble(), image.height.toDouble()),
          bakedRect,
          Paint(),
        );
      } catch (_) {}
    }
    final renderers = cameraViewport.visibleUnbakedElements.where((renderer) {
      final state = cameraViewport.rendererStates[renderer.id];
      return !(invisibleLayers?.contains(renderer.layer) ?? false) &&
          state != RendererState.hidden;
    });
    _paintRenderers(
      canvas,
      size,
      document,
      page,
      info,
      transform,
      colorScheme,
      renderers,
    );
    final aboveLayerImage = cameraViewport.aboveLayerImage;
    if (renderBakedLayers && aboveLayerImage != null) {
      canvas.drawImageRect(
        aboveLayerImage,
        Offset.zero &
            Size(
              aboveLayerImage.width.toDouble(),
              aboveLayerImage.height.toDouble(),
            ),
        bakedRect,
        Paint(),
      );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(ViewPainter oldDelegate) {
    final shouldRepaint =
        !identical(document, oldDelegate.document) ||
        !identical(page, oldDelegate.page) ||
        !identical(info, oldDelegate.info) ||
        renderBackground != oldDelegate.renderBackground ||
        renderBaked != oldDelegate.renderBaked ||
        renderBakedLayers != oldDelegate.renderBakedLayers ||
        transform != oldDelegate.transform ||
        !identical(cameraViewport, oldDelegate.cameraViewport) ||
        (!identical(invisibleLayers, oldDelegate.invisibleLayers) &&
            !setEquals(invisibleLayers, oldDelegate.invisibleLayers)) ||
        !identical(currentArea, oldDelegate.currentArea) ||
        colorScheme != oldDelegate.colorScheme;
    return shouldRepaint;
  }
}
