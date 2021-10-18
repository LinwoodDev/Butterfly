import 'package:butterfly/models/backgrounds/box.dart';
import 'package:butterfly/models/elements/eraser.dart';
import 'package:butterfly/painter/eraser.dart';
import 'package:butterfly/painter/painter.dart';
import 'package:butterfly/painter/path_eraser.dart';
import 'package:butterfly/painter/pen.dart';
import 'package:butterfly/painter/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
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
  final Map<String, List<Color>> palettes;

  static Map<String, List<Color>> getDefaultPalette(BuildContext context) => {
        AppLocalizations.of(context)!.defaultPalette: colors,
        AppLocalizations.of(context)!.highlighter: colors.map((e) => e.withOpacity(0.5)).toList()
      };

  static const colors = [
    Colors.white,
    Colors.pink,
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lime,
    Colors.green,
    Colors.teal,
    Colors.cyan,
    Colors.lightBlue,
    Colors.blue,
    Colors.indigo,
    Colors.blueGrey,
    Colors.purple,
    Colors.brown,
    Colors.grey,
    Colors.black
  ];

  const AppDocument(
      {required this.name,
      this.description = '',
      this.content = const [],
      this.background,
      this.palettes = const {},
      this.painters = const [PenPainter()]});

  AppDocument.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        palettes = (Map<String, dynamic>.from(json['palettes'] ?? {})).map<String, List<Color>>(
            (key, value) => MapEntry(key, value.map<Color>((color) => Color(color)).toList())),
        background = json['background'] == null
            ? null
            : BoxBackground.fromJson(json['background'], json['fileVersion']),
        painters = List<Map<String, dynamic>>.from(json['painters']).map<Painter>((e) {
          switch (e['type']) {
            case 'eraser':
              return EraserPainter.fromJson(e, json['fileVersion']);
            case 'path-eraser':
              return PathEraserPainter.fromJson(e, json['fileVersion']);
            case 'label':
              return LabelPainter.fromJson(e, json['fileVersion']);
            default:
              return PenPainter.fromJson(e, json['fileVersion']);
          }
        }).toList(),
        content = List<Map<String, dynamic>>.from(json['content']).map<ElementLayer>((e) {
          switch (e['type']) {
            case 'label':
              return LabelElement.fromJson(e, json['fileVersion']);
            case 'eraser':
              return EraserElement.fromJson(e, json['fileVersion']);
            default:
              return PaintElement.fromJson(e, json['fileVersion']);
          }
        }).toList();
  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "palettes": palettes.map((key, value) => MapEntry(key, value.map((e) => e.value).toList())),
        "painters": painters.map<Map<String, dynamic>>((e) => e.toJson()).toList(),
        "content": content.map<Map<String, dynamic>>((e) => e.toJson()).toList(),
        "background": background?.toJson(),
        "fileVersion": GetIt.I.get(instanceName: 'fileVersion')
      };
  AppDocument copyWith(
      {String? name,
      String? description,
      List<ElementLayer>? content,
      List<Painter>? painters,
      BoxBackground? background,
      Map<String, List<Color>>? palettes,
      bool removeBackground = false}) {
    return AppDocument(
        name: name ?? this.name,
        description: description ?? this.description,
        content: content ?? this.content,
        painters: painters ?? this.painters,
        palettes: palettes ?? this.palettes,
        background: removeBackground ? null : (background ?? this.background));
  }
}
