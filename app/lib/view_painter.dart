import 'dart:ui' as ui;

import 'package:butterfly/models/backgrounds/box.dart';
import 'package:butterfly/models/baked_viewport.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/elements/image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'cubits/transform.dart';
import 'models/area.dart';

Future<ui.Image> loadImage(ImageElement layer) {
  return decodeImageFromList(layer.pixels);
}

void paintElement(Canvas canvas, PadElement element,
    [Map<PadElement, ui.Image> images = const {}, bool preview = false]) {
  if (element is ImageElement) {
    if (images.containsKey(element)) {
      // Resize image to scale of the element
      // Get image from element pixels
      var image = images[element];
      if (image == null) return;
      var scale = element.scale;
      var width = image.width * scale;
      var height = image.height * scale;
      var paint = Paint()..isAntiAlias = true;
      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTWH(element.position.dx, element.position.dy, width, height),
        paint,
      );
    }
  } else {
    element.paint(canvas, preview);
  }
}

class ForegroundPainter extends CustomPainter {
  final Map<int, PadElement> editingLayer;
  final CameraTransform transform;
  final PadElement? selection;
  final List<Area> areas;

  ForegroundPainter(this.editingLayer,
      [this.transform = const CameraTransform(),
      this.selection,
      this.areas = const []]);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(transform.size);
    canvas.translate(transform.position.dx, transform.position.dy);
    for (var element in editingLayer.entries) {
      paintElement(canvas, element.value, {}, true);
    }
    if (selection != null) {
      /*
      final minX =
          -transform.position.dx + 20 / ((transform.size - 1) / 1.5 + 1);
      final maxX = minX + size.width / transform.size - 40 / transform.size;
      final minY = -transform.position.dy + 20;
      final maxY = minY + size.height / transform.size - 40 / transform.size;
      */
      var rect = selection!.rect;
      rect = Rect.fromLTRB(rect.left, rect.top, rect.right, rect.bottom);
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
    if (areas.isNotEmpty) {
      // With background and border
      var paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10 / transform.size;
      var backgroundPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.blue.withOpacity(0.5);
      for (var area in areas) {
        canvas.drawRRect(
            RRect.fromRectAndRadius(area.rect, const Radius.circular(5)),
            paint);
        canvas.drawRRect(
            RRect.fromRectAndRadius(area.rect, const Radius.circular(5)),
            backgroundPaint);
      }
    }
  }

  @override
  bool shouldRepaint(ForegroundPainter oldDelegate) =>
      oldDelegate.editingLayer != editingLayer ||
      oldDelegate.transform != transform ||
      oldDelegate.selection != selection ||
      oldDelegate.areas != areas;
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
  final List<PadElement> elements;
  final BakedViewport? bakedViewport;
  final Map<PadElement, ui.Image> images;
  final CameraTransform transform;

  ViewPainter(
    this.document, {
    this.currentArea,
    this.renderBackground = true,
    this.elements = const [],
    this.bakedViewport,
    this.transform = const CameraTransform(),
    this.images = const {},
  });

  @override
  void paint(Canvas canvas, Size size) {
    var background = document.background;
    var areaRect = currentArea?.rect;
    if (areaRect != null) {
      areaRect = Rect.fromPoints(transform.globalToLocal(areaRect.topLeft),
          transform.globalToLocal(areaRect.bottomRight));
    }
    if (areaRect != null) {
      canvas.drawColor(background?.boxColor ?? Colors.blue, BlendMode.srcOver);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              areaRect.inflate(5), const Radius.circular(5)),
          Paint()
            ..style = PaintingStyle.stroke
            ..color = Colors.black
            ..strokeWidth = 10 / transform.size);
      canvas.clipRect(areaRect);
    }
    if (background is BoxBackground && renderBackground) {
      canvas.drawColor(background.boxColor, BlendMode.srcOver);
      if (background.boxWidth > 0 && background.boxXCount > 0) {
        var relativeWidth = background.boxWidth * transform.size;
        var relativeSpace = background.boxXSpace * transform.size;
        int xCount = (transform.position.dx /
                    (background.boxWidth * background.boxXCount +
                        background.boxXSpace))
                .floor() +
            1;
        double x = -xCount *
                (background.boxWidth * background.boxXCount +
                    background.boxXSpace) +
            transform.position.dx;
        x *= transform.size;

        int count = 0;
        while (x < size.width) {
          canvas.drawLine(
              Offset(x, 0),
              Offset(x, size.height),
              Paint()
                ..strokeWidth = background.boxXStroke * transform.size
                ..color = background.boxXColor);
          count++;
          if (count >= background.boxXCount) {
            count = 0;
            x += relativeSpace;
          }
          x += relativeWidth;
        }
      }
      if (background.boxHeight > 0 && background.boxYCount > 0) {
        var relativeHeight = background.boxHeight * transform.size;
        var relativeSpace = background.boxYSpace * transform.size;
        int yCount = (transform.position.dy /
                    (background.boxHeight * background.boxYCount +
                        background.boxYSpace))
                .floor() +
            1;
        double y = -yCount *
                (background.boxHeight * background.boxYCount +
                    background.boxYSpace) +
            transform.position.dy;
        y *= transform.size;

        int count = 0;
        while (y < size.height) {
          canvas.drawLine(
              Offset(0, y),
              Offset(size.width, y),
              Paint()
                ..strokeWidth = background.boxYStroke * transform.size
                ..color = background.boxYColor);
          count++;
          if (count >= background.boxYCount) {
            count = 0;
            y += relativeSpace;
          }
          y += relativeHeight;
        }
      }
    }
    if (!(bakedViewport?.wasDisposed ?? true)) {
      var image = bakedViewport!.image;
      var bakedSizeDiff =
          (transform.size - bakedViewport!.scale) / bakedViewport!.scale;
      var pos = transform.globalToLocal(-bakedViewport!.toOffset());

      // Draw our baked image, scaling it down with drawImageRect.
      canvas.drawImageRect(
        image,
        Offset.zero & Size(image.width.toDouble(), image.height.toDouble()),
        pos &
            Size(image.width * (1 + bakedSizeDiff),
                image.height * (1 + bakedSizeDiff)),
        Paint(),
      );
    }
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
    canvas.scale(transform.size, transform.size);
    canvas.translate(transform.position.dx, transform.position.dy);
    for (var element in elements) {
      paintElement(canvas, element, images);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(ViewPainter oldDelegate) =>
      document != oldDelegate.document ||
      renderBackground != oldDelegate.renderBackground ||
      transform != oldDelegate.transform ||
      images != oldDelegate.images ||
      bakedViewport != oldDelegate.bakedViewport ||
      elements != oldDelegate.elements;
}
