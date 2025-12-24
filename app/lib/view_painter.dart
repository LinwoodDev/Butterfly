import 'dart:math';

import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/logger.dart';
import 'package:butterfly/views/navigator/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'cubits/transform.dart';
import 'selections/selection.dart';

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
    canvas.scale(transform.size);
    canvas.translate(-transform.position.dx, -transform.position.dy);
    for (var renderer in renderers) {
      final center = renderer.rect?.center;
      final radian = renderer.rotation * (pi / 180);
      if (center != null) {
        canvas.translate(center.dx, center.dy);
      }
      canvas.rotate(radian);
      if (center != null) {
        canvas.translate(-center.dx, -center.dy);
      }
      renderer.build(
        canvas,
        size,
        document,
        page,
        info,
        transform,
        colorScheme,
        true,
      );
      if (center != null) {
        canvas.translate(center.dx, center.dy);
      }
      canvas.rotate(-radian);
      if (center != null) {
        canvas.translate(-center.dx, -center.dy);
      }
    }
    final selection = this.selection;
    if (selection is ElementSelection) {
      _drawSelection(canvas, size, selection);
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
    talker.verbose(
      'Rendering: Baked ${cameraViewport.image != null}, unbaked elements: ${cameraViewport.unbakedElements.length} with size ${cameraViewport.width}x${cameraViewport.height}',
    );
    var areaRect = currentArea?.rect;
    final layers = page.layers;
    if (areaRect != null) {
      areaRect = Rect.fromPoints(
        transform.globalToLocal(areaRect.topLeft),
        transform.globalToLocal(areaRect.bottomRight),
      );
    }
    if (areaRect != null) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(areaRect.inflate(5), const Radius.circular(5)),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = colorScheme?.primary ?? Colors.black
          ..strokeWidth = 5 * transform.size
          ..blendMode = BlendMode.srcOver,
      );
      canvas.clipRect(areaRect.inflate(5));
    }
    if (renderBackground) {
      for (final e in cameraViewport.backgrounds) {
        e.build(canvas, size, document, page, info, transform, colorScheme);
      }
    }
    final belowLayerImage = cameraViewport.belowLayerImage;
    final bakedSizeDiff =
        (transform.size - cameraViewport.scale) / cameraViewport.scale;
    final bakedSize = cameraViewport.toSize();
    final pos = transform.globalToLocal(cameraViewport.toOffset());
    final bakedDst = pos & bakedSize * (1 + bakedSizeDiff);
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
    if (cameraViewport.bakedElements.isNotEmpty && renderBaked) {
      final image = cameraViewport.image;

      // Draw our baked image, scaling it down with drawImageRect.
      if (image != null) {
        try {
          canvas.drawImageRect(
            image,
            Offset.zero & Size(image.width.toDouble(), image.height.toDouble()),
            bakedDst,
            Paint(),
          );
        } catch (_) {}
      }
    }
    canvas.scale(transform.size, transform.size);
    canvas.translate(-transform.position.dx, -transform.position.dy);
    // Sort by layer order, if null layer is at the end.
    final renderers = cameraViewport.unbakedElements.sorted((a, b) {
      final aLayer = a.layer;
      final bLayer = b.layer;
      if (aLayer == null) {
        return 1;
      }
      if (bLayer == null) {
        return -1;
      }
      final compared = layers
          .indexWhere((e) => e.id == aLayer)
          .compareTo(layers.indexWhere((e) => e.id == bLayer));
      if (compared != 0) return compared;
      return cameraViewport.unbakedElements
          .indexWhere((e) => e.id == a.id)
          .compareTo(
            cameraViewport.unbakedElements.indexWhere((e) => e.id == b.id),
          );
    });
    for (final renderer in renderers) {
      final state = cameraViewport.rendererStates[renderer.id];
      if (!(invisibleLayers?.contains(renderer.layer) ?? false) &&
          state != RendererState.hidden) {
        final center = renderer.rect?.center;
        final radian = renderer.rotation * (pi / 180);
        if (center != null) {
          canvas.translate(center.dx, center.dy);
        }
        canvas.rotate(radian);
        if (center != null) {
          canvas.translate(-center.dx, -center.dy);
        }
        renderer.build(
          canvas,
          size,
          document,
          page,
          info,
          transform,
          colorScheme,
          false,
        );
        if (center != null) {
          canvas.translate(center.dx, center.dy);
        }
        canvas.rotate(-radian);
        if (center != null) {
          canvas.translate(-center.dx, -center.dy);
        }
      }
    }
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
        page != oldDelegate.page ||
        renderBackground != oldDelegate.renderBackground ||
        transform != oldDelegate.transform ||
        cameraViewport != oldDelegate.cameraViewport ||
        colorScheme != oldDelegate.colorScheme;
    return shouldRepaint;
  }
}
