import 'dart:ui';

import 'package:butterfly/models/elements/element.dart';

abstract class PositionedElement extends PadElement {
  @override
  final Offset position;

  const PositionedElement({this.position = Offset.zero, String layer = ''})
      : super(layer: layer);
  PositionedElement.fromJson(Map<String, dynamic> json)
      : position = json['position'] != null
            ? Offset(json['position']['x'], json['position']['y'])
            : const Offset(0, 0);

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      'position': {'x': position.dx, 'y': position.dy},
    });

  @override
  PositionedElement copyWith({String? layer, Offset? position});
}
