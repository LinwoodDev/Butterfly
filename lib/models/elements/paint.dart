import 'package:butterfly/models/elements/type.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class PaintElement extends ElementLayer {
  PaintElement({@required String name, String description})
      : super(name: name, description: description);
  PaintElement.fromJson(Map<String, dynamic> json)
      : super(name: json['name'], description: json['description']);
  @override
  IconData get icon => Mdi.palette;

  @override
  LayerType get type => LayerType.paint;
}
