import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:butterfly/models/elements/element.dart';
import 'package:flutter/cupertino.dart';

class ImageElement extends ElementLayer {
  final Uint8List pixels;
  final Offset position;
  final int width, height;

  const ImageElement(
      {required this.pixels, required this.width, required this.height, required this.position});
  static Future<ImageElement> fromImage(ui.Image image, Offset position) =>
      image.toByteData(format: ui.ImageByteFormat.rawRgba).then((value) => ImageElement(
          pixels: value?.buffer.asUint8List() ?? Uint8List(0),
          width: image.width,
          height: image.height,
          position: position));

  ImageElement.fromJson(Map<String, dynamic> json, [String? fileVersion])
      : pixels = Uint8List.fromList(List<int>.from(json['pixels'])),
        height = json['height'],
        width = json['width'],
        position = json['position'] != null
            ? Offset(json['position']['x'], json['position']['y'])
            : Offset.zero;

  @override
  Map<String, dynamic> toJson() => {
        'pixels': pixels.toList(),
        'height': height,
        'width': width,
        'type': 'image',
        'position': {'x': position.dx, 'y': position.dy}
      };
  ImageElement copyWith({Uint8List? pixels, int? width, int? height, Offset? position}) {
    return ImageElement(
        pixels: pixels ?? this.pixels,
        width: width ?? this.width,
        height: height ?? this.height,
        position: position ?? this.position);
  }

  @override
  bool hit(Offset offset) {
    return offset.dx >= position.dx &&
        offset.dy >= position.dy &&
        offset.dx <= position.dx + width &&
        offset.dy <= position.dy + height;
  }
}
