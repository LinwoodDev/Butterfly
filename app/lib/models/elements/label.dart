import 'package:flutter/painting.dart';

import 'element.dart';

class LabelElement extends ElementLayer {
  final String text;
  final double size;
  final Offset position;

  LabelElement({this.text = "", this.size = 12, this.position = const Offset(0, 0)});
  LabelElement.fromJson(Map<String, dynamic> json)
      : text = json['text'] ?? "",
        size = json['size'] ?? 12,
        position = json['position'] != null
            ? Offset(json['position']['x'], json['position']['y'])
            : const Offset(0, 0),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'type': 'label',
        'text': text,
        'size': size,
        'position': {'x': position.dx, 'y': position.dy},
      };

  @override
  bool hit(Offset offset) =>
      offset.dx >= position.dx &&
      offset.dy >= position.dy &&
      offset.dx <= position.dx + size &&
      offset.dy <= position.dy + size;
}
