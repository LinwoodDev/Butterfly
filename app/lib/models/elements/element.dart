import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

@immutable
abstract class PadElement {
  final String group;
  const PadElement({this.group = ''});

  PadElement.fromJson(Map<String, dynamic> json) : group = json['group'] ?? '';

  Map<String, dynamic> toJson();

  void paint(Canvas canvas, [bool preview = false]);

  PadElement moveBy(Offset offset);

  Offset get position;

  PadElement moveTo(Offset value) {
    return moveBy(value - position);
  }

  bool hit(Offset offset);

  Rect get rect;
}
