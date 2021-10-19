import 'package:butterfly/models/elements/element.dart';
import 'package:flutter/cupertino.dart';

class ImageElement extends ElementLayer {
  final ImageType type;
  final String data;
  final int width, height;

  const ImageElement(this.type, this.data, this.width, this.height);

  ImageElement.fromJson(Map<String, dynamic> json)
      : type = ImageType.values[json['type']],
        data = json['data'],
        height = json['height'],
        width = json['width'];

  @override
  Map<String, dynamic> toJson() => {
        'type': type.index,
        'data': data,
      };
  ImageElement copyWith({ImageType? type, String? data, int? width, int? height}) {
    return ImageElement(
        type ?? this.type, data ?? this.data, width ?? this.width, height ?? this.height);
  }

  @override
  bool hit(Offset offset) {
    // TODO: implement hit
    throw UnimplementedError();
  }
}

enum ImageType { png, jpg }
