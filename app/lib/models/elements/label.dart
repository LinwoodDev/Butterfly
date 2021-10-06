import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'element.dart';

class LabelElement extends ElementLayer {
  final String text;
  final Color color;
  final double size;
  final Offset position;

  LabelElement(
      {this.text = "",
      this.size = 12,
      this.position = const Offset(0, 0),
      this.color = Colors.black});
  LabelElement.fromJson(Map<String, dynamic> json)
      : text = json['text'] ?? "",
        size = json['size'] ?? 12,
        position = json['position'] != null
            ? Offset(json['position']['x'], json['position']['y'])
            : const Offset(0, 0),
        color = json['color'] == null ? Colors.black : Color(json['color']),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'type': 'label',
        'text': text,
        'size': size,
        'color': color.value,
        'position': {'x': position.dx, 'y': position.dy},
      };

  @override
  bool hit(Offset offset) =>
      offset.dx >= position.dx &&
      offset.dy >= position.dy &&
      offset.dx <= position.dx + size &&
      offset.dy <= position.dy + size;
}
