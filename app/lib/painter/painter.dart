import 'package:butterfly/models/elements/element.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class Painter {
  final String name;
  const Painter({this.name = ''});
  Painter.fromJson(Map<String, dynamic> json, [int? fileVersion]) : name = json['name'] ?? "";
  Map<String, dynamic> toJson() => {"name": name};
}

abstract class BuildedPainter extends Painter {
  const BuildedPainter({String name = ''}) : super(name: name);
  BuildedPainter.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : super.fromJson(json, fileVersion);

  ElementLayer buildLayer(Offset position, [double pressure = 0]);
}
