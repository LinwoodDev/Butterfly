import 'package:flutter/material.dart';

import 'painter.dart';

class LabelPainter extends Painter {
  final Color color;
  final double size;

  const LabelPainter({this.color = Colors.black, this.size = 12, String name = ''})
      : super(name: name);
  LabelPainter.fromJson(Map<String, dynamic> json)
      : color = json['color'] == null ? Colors.black : Color(json['color']),
        size = json['size'] ?? 12,
        super.fromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      super.toJson()..addAll({"type": "label", "color": color, "size": size});
}
