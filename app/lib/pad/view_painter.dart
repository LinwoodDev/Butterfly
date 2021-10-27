import 'dart:isolate';
import 'dart:typed_data';

import 'package:butterfly/models/backgrounds/box.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/elements/image.dart';
import 'package:butterfly/models/elements/label.dart';
import 'package:butterfly/models/elements/path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as image;

import 'cubits/transform.dart';

class DecodeParam {
  final Uint8List data;
  final int width, height;
  final double scale;
  final SendPort sendPort;
  DecodeParam(this.data, this.sendPort, this.width, this.height, this.scale);
}

image.Image loadImage(Uint8List data, int width, int height, double scale) {
  image.Image baseSizeImage = image.decodeImage(data) ?? image.Image(0, 0);
  image.Image resizeImage = image.copyResize(baseSizeImage,
      height: (height * scale).round(), width: (width * scale).round());
  return resizeImage;
}

void decodeIsolate(DecodeParam param) {
  var resizeImage = loadImage(param.data, param.width, param.height, param.scale);
  param.sendPort.send(resizeImage);
}

void paintElement(Canvas canvas, ElementLayer element,
    [Map<ElementLayer, ui.Image> images = const {}, Offset offset = Offset.zero]) {
  if (element is PathElement) {
    element.paint(canvas, offset);
  } else if (element is LabelElement) {
    TextSpan span = TextSpan(
        style: TextStyle(
            fontSize: element.property.size,
            color: element.property.color,
            fontWeight: element.property.fontWeight,
            letterSpacing: element.property.letterSpacing,
            decorationColor: element.property.decorationColor,
            decorationStyle: element.property.decorationStyle,
            decorationThickness: element.property.decorationThickness,
            decoration: TextDecoration.combine([
              if (element.property.underline) TextDecoration.underline,
              if (element.property.lineThrough) TextDecoration.lineThrough,
              if (element.property.overline) TextDecoration.overline,
            ])),
        text: element.text);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        textScaleFactor: 1.0);
    tp.layout();
    var position = element.position;
    position += offset;
    tp.paint(canvas, position);
  }
  if (element is ImageElement && images.containsKey(element)) {
    canvas.drawImage(images[element]!, element.position + offset, Paint()..strokeWidth = .05);
  }
}

class ForegroundPainter extends CustomPainter {
  ElementLayer? editingLayer;
  CameraTransform transform;
  ForegroundPainter(this.editingLayer, [this.transform = const CameraTransform()]);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(transform.size);
    if (editingLayer != null) paintElement(canvas, editingLayer!, {}, transform.position);
  }

  @override
  bool shouldRepaint(ForegroundPainter oldDelegate) =>
      oldDelegate.editingLayer != editingLayer || transform != transform;
}

class ViewPainter extends CustomPainter {
  AppDocument document;
  final bool renderBackground;
  final Map<ElementLayer, ui.Image> images;
  CameraTransform transform;

  ViewPainter(this.document,
      {this.renderBackground = true,
      this.transform = const CameraTransform(),
      this.images = const {}});

  Future<List<ui.Image>> loadImages() async {
    if (kIsWeb) {
      await Future.delayed(const Duration(milliseconds: 1));
    }
    for (var layer in document.content) {
      if (layer is ImageElement && !images.containsKey(layer)) {
        image.Image loadedImage;

        if (kIsWeb) {
          loadedImage = loadImage(layer.pixels, layer.width, layer.height, layer.scale);
        } else {
          var receivePort = ReceivePort();
          await Isolate.spawn(
              decodeIsolate,
              DecodeParam(
                  layer.pixels, receivePort.sendPort, layer.width, layer.height, layer.scale));
          loadedImage = await receivePort.first as image.Image;
        }

        // Get the processed image from the isolate.

        ui.Codec codec =
            await ui.instantiateImageCodec(Uint8List.fromList(image.encodePng(loadedImage)));
        ui.FrameInfo frameInfo = await codec.getNextFrame();
        images[layer] = frameInfo.image;
      }
    }
    images.removeWhere((key, value) => !document.content.contains(key));
    return images.entries.map((entry) => entry.value).toList();
  }

  @override
  void paint(Canvas canvas, Size size) {
    var background = document.background;
    print("PAINT!");
    if (background is BoxBackground && renderBackground) {
      canvas.drawColor(background.boxColor, BlendMode.srcOver);
      if (background.boxWidth > 0 && background.boxXCount > 0) {
        double x = transform.position.dy % background.boxHeight * transform.size;
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
        double y = transform.position.dy % background.boxHeight * transform.size;
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
            y += background.boxYSpace;
          }
          y += background.boxHeight * transform.size;
        }
      }
    }
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
    canvas.scale(transform.size, transform.size);
    document.content
        .asMap()
        .forEach((index, element) => paintElement(canvas, element, images, transform.position));
    canvas.restore();
  }

  @override
  bool shouldRepaint(ViewPainter oldDelegate) =>
      document != oldDelegate.document ||
      renderBackground != oldDelegate.renderBackground ||
      images != oldDelegate.images ||
      transform != transform;
}
