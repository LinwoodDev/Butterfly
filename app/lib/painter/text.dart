import 'package:flutter/material.dart';

import 'painter.dart';

class TextPainter extends Painter {
  final Color color;
  final int size;

  const TextPainter({this.color = Colors.black, this.size = 12});
  TextPainter.fromJson(Map<String, dynamic> json)
      : color = json['color'] ?? Colors.black,
        size = json['size'] ?? 12;
  @override
  Map<String, dynamic> toJson() => {"type": "text", "color": color, "size": size};
}
