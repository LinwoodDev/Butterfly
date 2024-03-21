import 'dart:math';

import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
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
  final Renderer<UtilitiesState>? tool;

  ForegroundPainter(
      this.renderers, this.document, this.page, this.info, this.colorScheme,
      [this.transform = const CameraTransform(), this.selection, this.tool]);

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
          canvas, size, document, page, info, transform, colorScheme, true);
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
      /*
      final minX =
          -transform.position.dx + 20 / ((transform.size - 1) / 1.5 + 1);
      final maxX = minX + size.width / transform.size - 40 / transform.size;
      final minY = -transform.position.dy + 20;
      final maxY = minY + size.height / transform.size - 40 / transform.size;
      */
      _drawSelection(canvas, selection);
    }
    if (tool != null) {
      tool!.build(
          canvas, size, document, page, info, transform, colorScheme, true);
    }
  }

  void _drawSelection(Canvas canvas, ElementSelection selection) {
    final rect = selection.expandedRect;
    if (rect == null) return;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            rect.inflate(5 / transform.size), const Radius.circular(5)),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = colorScheme.primary
          ..strokeWidth = 5 / transform.size);
  }

  @override
  bool shouldRepaint(ForegroundPainter oldDelegate) =>
      oldDelegate.renderers != renderers ||
      oldDelegate.transform != transform ||
      oldDelegate.selection != selection ||
      oldDelegate.tool != tool ||
      oldDelegate.colorScheme != colorScheme;
}

class ViewPainter extends CustomPainter {
  final NoteData document;
  final DocumentPage page;
  final DocumentInfo info;
  final Area? currentArea;
  final bool renderBackground, renderBaked;
  final CameraViewport cameraViewport;
  final CameraTransform transform;
  final ColorScheme? colorScheme;
  final List<String> invisibleLayers;
  final Map<Renderer, RendererState> states;

  const ViewPainter(
    this.document,
    this.page,
    this.info, {
    this.currentArea,
    this.invisibleLayers = const [],
    this.states = const {},
    this.renderBackground = true,
    this.renderBaked = true,
    required this.cameraViewport,
    this.colorScheme,
    this.transform = const CameraTransform(),
  });

  @override
  void paint(Canvas canvas, Size size) {
    var areaRect = currentArea?.rect;
    if (areaRect != null) {
      areaRect = Rect.fromPoints(transform.globalToLocal(areaRect.topLeft),
          transform.globalToLocal(areaRect.bottomRight));
    }
    if (areaRect != null) {
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              areaRect.inflate(5), const Radius.circular(5)),
          Paint()
            ..style = PaintingStyle.stroke
            ..color = colorScheme?.primary ?? Colors.black
            ..strokeWidth = 5 * transform.size
            ..blendMode = BlendMode.srcOver);
      canvas.clipRect(areaRect.inflate(5));
    }
    if (renderBackground) {
      for (final e in cameraViewport.backgrounds) {
        e.build(canvas, size, document, page, info, transform, colorScheme);
      }
    }
    if (cameraViewport.bakedElements.isNotEmpty && renderBaked) {
      final image = cameraViewport.image;
      final bakedSizeDiff =
          (transform.size - cameraViewport.scale) / cameraViewport.scale;
      final pos = transform.globalToLocal(cameraViewport.toOffset());

      // Draw our baked image, scaling it down with drawImageRect.
      if (image != null) {
        canvas.drawImageRect(
          image,
          Offset.zero & Size(image.width.toDouble(), image.height.toDouble()),
          pos & size * (1 + bakedSizeDiff),
          Paint(),
        );
      }
    }
    canvas.scale(transform.size, transform.size);
    canvas.translate(-transform.position.dx, -transform.position.dy);
    for (final renderer in cameraViewport.unbakedElements) {
      final state = states[renderer];
      if (!invisibleLayers.contains(renderer.element.layer) &&
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
            canvas, size, document, page, info, transform, colorScheme, false);
        if (center != null) {
          canvas.translate(center.dx, center.dy);
        }
        canvas.rotate(-radian);
        if (center != null) {
          canvas.translate(-center.dx, -center.dy);
        }
      }
    }
  }

  @override
  bool shouldRepaint(ViewPainter oldDelegate) {
    const mapEq = MapEquality();
    final shouldRepaint = page != oldDelegate.page ||
        renderBackground != oldDelegate.renderBackground ||
        transform != oldDelegate.transform ||
        cameraViewport != oldDelegate.cameraViewport ||
        colorScheme != oldDelegate.colorScheme ||
        !mapEq.equals(states, oldDelegate.states);
    return shouldRepaint;
  }
}
