import 'package:butterfly/models/backgrounds/box.dart';
import 'package:butterfly/models/elements/eraser.dart';
import 'package:butterfly/models/palette.dart';
import 'package:butterfly/models/painters/eraser.dart';
import 'package:butterfly/models/painters/image.dart';
import 'package:butterfly/models/painters/painter.dart';
import 'package:butterfly/models/painters/path_eraser.dart';
import 'package:butterfly/models/painters/pen.dart';
import 'package:butterfly/models/painters/label.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'elements/element.dart';
import 'elements/image.dart';
import 'elements/pen.dart';
import 'elements/label.dart';

@immutable
class AppDocument {
  final String name, description;
  //final List<PackCollection> packs;
  final List<ElementLayer> content;
  final List<Painter> painters;
  final BoxBackground? background;
  final List<ColorPalette> palettes;

  const AppDocument(
      {required this.name,
      this.description = '',
      this.content = const [],
      this.background,
      this.palettes = const [],
      this.painters = const [
        PenPainter(),
        EraserPainter(),
        LabelPainter(),
        ImagePainter()
      ]});

  factory AppDocument.fromJson(Map<String, dynamic> json) {
    var version = json['fileVersion'] is int
        ? json['fileVersion']
        : int.tryParse(json['fileVersion']) ??
            GetIt.I.get<int>(instanceName: "fileVersion");
    if (version >= 0 && version < 4) {
      json['palettes'] = List<dynamic>.from(
          Map<String, dynamic>.from(json['palettes'] ?? [])
              .entries
              .map<ColorPalette>((e) => ColorPalette(
                  colors: List<int>.from(e.value).map((e) => Color(e)).toList(),
                  name: e.key))
              .map((e) => e.toJson())
              .toList());
    }
    var name = json['name'];
    var description = json['description'];
    var palettes = (List<Map<String, dynamic>>.from(json['palettes'] ?? []))
        .map<ColorPalette>(
            (e) => ColorPalette.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    var background = json['background'] == null
        ? null
        : BoxBackground.fromJson(json['background'], version);
    var painters =
        List<Map<String, dynamic>>.from(json['painters']).map<Painter>((e) {
      switch (e['type']) {
        case 'eraser':
          return EraserPainter.fromJson(e, version);
        case 'path-eraser':
          return PathEraserPainter.fromJson(e, version);
        case 'label':
          return LabelPainter.fromJson(e, version);
        case 'image':
          return ImagePainter.fromJson(e, version);
        default:
          return PenPainter.fromJson(e, version);
      }
    }).toList();
    var content =
        List<Map<String, dynamic>>.from(json['content']).map<ElementLayer>((e) {
      switch (e['type']) {
        case 'label':
          return LabelElement.fromJson(e, version);
        case 'eraser':
          return EraserElement.fromJson(e, version);
        case 'image':
          return ImageElement.fromJson(e, version);
        default:
          return PenElement.fromJson(e, version);
      }
    }).toList();
    return AppDocument(
        name: name,
        background: background,
        content: content,
        description: description,
        painters: painters,
        palettes: palettes);
  }
  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "palettes": palettes.map((e) => e.toJson()).toList(),
        "painters":
            painters.map<Map<String, dynamic>>((e) => e.toJson()).toList(),
        "content":
            content.map<Map<String, dynamic>>((e) => e.toJson()).toList(),
        "background": background?.toJson(),
        "fileVersion": GetIt.I.get<int>(instanceName: 'fileVersion')
      };
  AppDocument copyWith(
      {String? name,
      String? description,
      List<ElementLayer>? content,
      List<Painter>? painters,
      BoxBackground? background,
      List<ColorPalette>? palettes,
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
