import 'dart:isolate';
import 'dart:ui' as ui;

import 'package:butterfly/models/backgrounds/box.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/elements/image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'cubits/transform.dart';

class DecodeParam {
  final ImageElement element;
  final SendPort sendPort;

  DecodeParam(this.element, this.sendPort);
}

Future<ui.Image> loadImage(ImageElement layer) {
  return decodeImageFromList(layer.pixels);
}

void paintElement(Canvas canvas, ElementLayer element,
    [Map<ElementLayer, ui.Image> images = const {}, bool preview = false]) {
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
  final Map<int, ElementLayer> editingLayer;
  final CameraTransform transform;
  final ElementLayer? selection;

  ForegroundPainter(this.editingLayer,
      [this.transform = const CameraTransform(), this.selection]);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(transform.size);
    canvas.translate(transform.position.dx, transform.position.dy);
    for (var element in editingLayer.entries) {
      paintElement(canvas, element.value, {}, true);
    }
    if (selection != null) {
      var rect = selection!.rect;
      canvas.drawRRect(
          RRect.fromRectAndRadius(rect.inflate(5), const Radius.circular(5)),
          Paint()
            ..style = PaintingStyle.stroke
            ..shader = ui.Gradient.linear(
              rect.topLeft,
              rect.bottomRight,
              [Colors.red, Colors.yellow],
            )
            ..strokeWidth = 5);
    }
  }

  @override
  bool shouldRepaint(ForegroundPainter oldDelegate) =>
      oldDelegate.editingLayer != editingLayer ||
      oldDelegate.transform != transform ||
      oldDelegate.selection != selection;
}

Future<Map<ElementLayer, ui.Image>> loadImages(AppDocument document,
    [Map<ElementLayer, ui.Image> loadedImages = const {}]) async {
  var images = Map<ElementLayer, ui.Image>.from(loadedImages);
  if (kIsWeb && document.content.any((element) => element is ImageElement)) {
    await Future.delayed(const Duration(seconds: 1));
  }
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
  final bool renderBackground;
  final Map<ElementLayer, ui.Image> images;
  final CameraTransform transform;

  ViewPainter(this.document,
      {this.renderBackground = true,
      this.transform = const CameraTransform(),
      Map<ElementLayer, ui.Image>? images})
      : images = images ?? <ElementLayer, ui.Image>{};

  @override
  void paint(Canvas canvas, Size size) {
    var background = document.background;
    if (background is BoxBackground && renderBackground) {
      canvas.drawColor(background.boxColor, BlendMode.srcOver);
      if (background.boxWidth > 0 && background.boxXCount > 0) {
        double x =
            (transform.position.dx % background.boxWidth * transform.size);
        int count = 0;
        while (x < size.width) {
          canvas.drawLine(
              Offset(x, 0),
              Offset(x, size.height),
              Paint()
                ..strokeWidth = background.boxXStroke
                ..color = background.boxXColor);
          count++;
          if (count >= background.boxXCount) {
            count = 0;
            x += background.boxXSpace;
          }
          x += background.boxWidth * transform.size;
        }
      }
      if (background.boxHeight > 0 && background.boxYCount > 0) {
        double y =
            (transform.position.dy % background.boxHeight * transform.size);
        int count = 0;
        while (y < size.width) {
          canvas.drawLine(
              Offset(0, y),
              Offset(size.width, y),
              Paint()
                ..strokeWidth = background.boxYStroke
                ..color = background.boxYColor);
          count++;
          if (count >= background.boxYCount) {
            count = 0;
            y += background.boxYSpace * transform.size;
          }
          y += background.boxHeight * transform.size;
        }
      }
    }
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
    canvas.scale(transform.size, transform.size);
    canvas.translate(transform.position.dx, transform.position.dy);
    document.content
        .asMap()
        .forEach((index, element) => paintElement(canvas, element, images));
    canvas.restore();
  }

  @override
  bool shouldRepaint(ViewPainter oldDelegate) =>
      document != oldDelegate.document ||
      renderBackground != oldDelegate.renderBackground ||
      transform != oldDelegate.transform ||
      images != oldDelegate.images;
}
