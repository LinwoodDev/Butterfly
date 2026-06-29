import 'dart:math';

import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/views/navigator/constants.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
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
  canvas.save();
  final center = renderer.rect?.center;
  if (center != null) {
    canvas.translate(center.dx, center.dy);
  }
  canvas.rotate(renderer.rotation * (pi / 180));
  if (center != null) {
    canvas.translate(-center.dx, -center.dy);
  }
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
  canvas.restore();
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
  final rendererList = renderers.toList();
  final groups = <String, List<PenRenderer>>{};
  for (final renderer in rendererList.whereType<PenRenderer>()) {
    final combineId = renderer.element.combineId;
    if (combineId != null) {
      groups.putIfAbsent(combineId, () => []).add(renderer);
    }
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
    canvas.saveLayer(null, Paint());
    for (final groupedRenderer in groups[combineId]!) {
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
    canvas.scale(transform.size);
    canvas.translate(-transform.position.dx, -transform.position.dy);
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
    var bounds =
        transform.position &
        ((Size(size.width - kNavigationRailWidth, size.height)) /
            transform.size);
    if (navigatorPosition == NavigatorPosition.left) {
      bounds = bounds.translate(kNavigationRailWidth / transform.size, 0);
    }
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
    var areaRect = currentArea?.rect;
    if (areaRect != null) {
      areaRect = Rect.fromPoints(
        transform.globalToLocal(areaRect.topLeft),
        transform.globalToLocal(areaRect.bottomRight),
      );
    }
    if (renderBackground) {
      canvas.drawColor(Colors.white, BlendMode.src);
      for (final e in cameraViewport.backgrounds) {
        e.build(canvas, size, document, page, info, transform, colorScheme);
      }
    }
    final belowLayerImage = cameraViewport.belowLayerImage;
    final bakedRect = cameraViewport.toRect();
    final bakedDst = Rect.fromPoints(
      transform.globalToLocal(bakedRect.topLeft),
      transform.globalToLocal(bakedRect.bottomRight),
    );
    if (renderBakedLayers && belowLayerImage != null) {
      canvas.drawImageRect(
        belowLayerImage,
        Offset.zero &
            Size(
              belowLayerImage.width.toDouble(),
              belowLayerImage.height.toDouble(),
            ),
        bakedDst,
        Paint(),
      );
    }
    final areaSelectionWidth = 5 * transform.size;
    if (areaRect != null) {
      final currentAreaColor = currentArea?.color?.toColor();
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..color = currentAreaColor ?? colorScheme?.primary ?? Colors.green
        ..strokeWidth = areaSelectionWidth;
      canvas.drawRect(areaRect.inflate(areaSelectionWidth / 2), paint);
      for (final area in page.areas.sortedBy((a) => a == currentArea ? 1 : 0)) {
        if (areaRect.overlaps(area.rect)) continue;
        var rect = area.rect;
        rect = Rect.fromPoints(
          transform.globalToLocal(rect.topLeft),
          transform.globalToLocal(rect.bottomRight),
        );
        final areaPaint = Paint()
          ..style = PaintingStyle.stroke
          ..color =
              area.color?.toColor() ?? colorScheme?.secondary ?? Colors.grey
          ..strokeWidth = areaSelectionWidth;
        canvas.drawRect(
          rect.inflate(areaSelectionWidth / 2),
          area == currentArea ? paint : areaPaint,
        );
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
          bakedDst,
          Paint(),
        );
      } catch (_) {}
    }
    canvas.scale(transform.size, transform.size);
    canvas.translate(-transform.position.dx, -transform.position.dy);

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
    canvas.translate(transform.position.dx, transform.position.dy);
    canvas.scale(1 / transform.size, 1 / transform.size);
    final aboveLayerImage = cameraViewport.aboveLayerImage;
    if (renderBakedLayers && aboveLayerImage != null) {
      canvas.drawImageRect(
        aboveLayerImage,
        Offset.zero &
            Size(
              aboveLayerImage.width.toDouble(),
              aboveLayerImage.height.toDouble(),
            ),
        bakedDst,
        Paint(),
      );
    }
  }

  @override
  bool shouldRepaint(ViewPainter oldDelegate) {
    final shouldRepaint =
        document != oldDelegate.document ||
        page != oldDelegate.page ||
        info != oldDelegate.info ||
        renderBackground != oldDelegate.renderBackground ||
        renderBaked != oldDelegate.renderBaked ||
        renderBakedLayers != oldDelegate.renderBakedLayers ||
        transform != oldDelegate.transform ||
        cameraViewport != oldDelegate.cameraViewport ||
        !setEquals(invisibleLayers, oldDelegate.invisibleLayers) ||
        currentArea != oldDelegate.currentArea ||
        colorScheme != oldDelegate.colorScheme;
    return shouldRepaint;
  }
}
