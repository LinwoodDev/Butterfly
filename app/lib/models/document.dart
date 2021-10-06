import 'package:butterfly/models/backgrounds/box.dart';
import 'package:butterfly/models/elements/eraser.dart';
import 'package:butterfly/painter/eraser.dart';
import 'package:butterfly/painter/painter.dart';
import 'package:butterfly/painter/path_eraser.dart';
import 'package:butterfly/painter/pen.dart';
import 'package:butterfly/painter/label.dart';
import 'package:flutter/widgets.dart';

import 'elements/element.dart';
import 'elements/paint.dart';
import 'elements/label.dart';

@immutable
class AppDocument {
  final String name, description;
  //final List<PackCollection> packs;
  final List<ElementLayer> content;
  final List<Painter> painters;
  final BoxBackground? background;

  const AppDocument(
      {required this.name,
      this.description = '',
      this.content = const [],
      this.background,
      this.painters = const [PenPainter()]});

  AppDocument.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        background = json['background'] == null ? null : BoxBackground.fromJson(json['background']),
        painters = List<Map<String, dynamic>>.from(json['painters']).map<Painter>((e) {
          switch (e['type']) {
            case 'eraser':
              return EraserPainter.fromJson(e);
            case 'path-eraser':
              return PathEraserPainter.fromJson(e);
            case 'label':
              return LabelPainter.fromJson(e);
            default:
              return PenPainter.fromJson(e);
          }
        }).toList(),
        content = List<Map<String, dynamic>>.from(json['content']).map<ElementLayer>((e) {
          switch (e['type']) {
            case 'label':
              return LabelElement.fromJson(e);
            case 'eraser':
              return EraserElement.fromJson(e);
            default:
              return PaintElement.fromJson(e);
          }
        }).toList();
  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "painters": painters.map<Map<String, dynamic>>((e) => e.toJson()).toList(),
        "content": content.map<Map<String, dynamic>>((e) => e.toJson()).toList(),
        "background": background?.toJson()
      };
  AppDocument copyWith(
      {String? name,
      String? description,
      List<ElementLayer>? content,
      List<Painter>? painters,
      BoxBackground? background}) {
    return AppDocument(
        name: name ?? this.name,
        description: description ?? this.description,
        content: content ?? this.content,
        painters: painters ?? this.painters,
        background: background ?? this.background);
  }
}
