import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

@immutable
abstract class PadElement {
  final String layer;

  const PadElement({this.layer = ''});

  @mustCallSuper
  PadElement.fromJson(Map<String, dynamic> json) : layer = json['layer'] ?? '';

  @mustCallSuper
  Map<String, dynamic> toJson() => {
        'layer': layer,
      };

  void paint(Canvas canvas, [bool preview = false]);

  PadElement moveBy(Offset offset);

  Offset get position;

  PadElement moveTo(Offset value) {
    return moveBy(value - position);
  }

  bool hit(Offset offset, [double radius = 1.0]);

  Rect get rect;

  PadElement copyWith({String? layer});
}
