import 'dart:ui' as ui;

import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/element.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'cubits/transform.dart';
import 'models/area.dart';

Future<ui.Image> loadImage(ImageElement layer) {
  return decodeImageFromList(layer.pixels);
}

class ForegroundPainter extends CustomPainter {
  final List<Renderer> renderers;
  final CameraTransform transform;
  final List<Rect> selection;

  ForegroundPainter(
    this.renderers, [
    this.transform = const CameraTransform(),
    this.selection = const [],
  ]);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(transform.size);
    canvas.translate(transform.position.dx, transform.position.dy);
    for (var element in renderers) {
      element.build(canvas, size, transform, true);
    }
    for (var rect in selection) {
      /*
      final minX =
          -transform.position.dx + 20 / ((transform.size - 1) / 1.5 + 1);
      final maxX = minX + size.width / transform.size - 40 / transform.size;
      final minY = -transform.position.dy + 20;
      final maxY = minY + size.height / transform.size - 40 / transform.size;
      */
      canvas.drawRRect(
          RRect.fromRectAndRadius(rect.inflate(5), const Radius.circular(5)),
          Paint()
            ..style = PaintingStyle.stroke
            ..shader = ui.Gradient.linear(
              rect.topLeft,
              rect.bottomRight,
              [Colors.red, Colors.yellow],
            )
            ..strokeWidth = 10 / transform.size);
    }
  }

  @override
  bool shouldRepaint(ForegroundPainter oldDelegate) =>
      oldDelegate.renderers != renderers ||
      oldDelegate.transform != transform ||
      oldDelegate.selection != selection;
}

Future<Map<PadElement, ui.Image>> loadImages(AppDocument document,
    [Map<PadElement, ui.Image> loadedImages = const {}]) async {
  var images = Map<PadElement, ui.Image>.from(loadedImages);
  if (kIsWeb && document.content.any((element) => element is ImageElement)) {}
  for (var layer in document.content) {
    if (layer is ImageElement && !images.containsKey(layer)) {
      images[layer] = await loadImage(layer);
    }
  }
  images.removeWhere((key, value) => !document.content.contains(key));
  return images;
}

class ViewPainter extends CustomPainter {
  final AppDocument document;
  final Area? currentArea;
  final bool renderBackground;
  final CameraViewport cameraViewport;
  final CameraTransform transform;

  ViewPainter(
    this.document, {
    this.currentArea,
    this.renderBackground = true,
    required this.cameraViewport,
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
            ..color = Colors.blue
            ..strokeWidth = 1 * transform.size
            ..blendMode = BlendMode.srcOver);
      canvas.clipRect(areaRect.inflate(5));
    }
    if (renderBackground) {
      cameraViewport.background.build(canvas, size, transform);
    }
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
    if (cameraViewport.bakedElements.isNotEmpty) {
      var image = cameraViewport.image;
      var bakedSizeDiff =
          (transform.size - cameraViewport.scale) / cameraViewport.scale;
      var pos = transform.globalToLocal(-cameraViewport.toOffset());

      // Draw our baked image, scaling it down with drawImageRect.
      if (image != null) {
        canvas.drawImageRect(
          image,
          Offset.zero & Size(image.width.toDouble(), image.height.toDouble()),
          pos &
              Size(image.width * (1 + bakedSizeDiff),
                  image.height * (1 + bakedSizeDiff)),
          Paint(),
        );
      }
    }
    canvas.scale(transform.size, transform.size);
    canvas.translate(transform.position.dx, transform.position.dy);
    for (var renderer in cameraViewport.unbakedElements) {
      renderer.build(canvas, size, transform, false);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(ViewPainter oldDelegate) =>
      document != oldDelegate.document ||
      renderBackground != oldDelegate.renderBackground ||
      transform != oldDelegate.transform ||
      cameraViewport != oldDelegate.cameraViewport;
}
