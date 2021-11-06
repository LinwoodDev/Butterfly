import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

@immutable
abstract class ElementLayer {
  const ElementLayer();

  const ElementLayer.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

  void paint(Canvas canvas,
      [Offset offset = Offset.zero, bool preview = false]);

  bool hit(Offset offset);

  Rect get rect;
}
