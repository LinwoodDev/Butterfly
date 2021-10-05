import 'package:flutter/painting.dart';

abstract class ElementLayer {
  ElementLayer();
  ElementLayer.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();

  bool hit(Offset offset);
}
