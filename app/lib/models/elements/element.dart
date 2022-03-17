import 'dart:typed_data';

import 'package:butterfly/models/elements/eraser.dart';
import 'package:butterfly/models/elements/image.dart';
import 'package:butterfly/models/elements/label.dart';
import 'package:butterfly/models/elements/pen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../area.dart';

@immutable
abstract class PadElement {
  final String layer;

  const PadElement({this.layer = ''});

  @mustCallSuper
  PadElement.fromJson(Map<String, dynamic> json) : layer = json['layer'] ?? '';

  @mustCallSuper
  Map<String, dynamic> toJson() => {'layer': layer, 'type': type.name};

  void paint(Canvas canvas, [bool preview = false]);

  PadElement moveBy(Offset offset);

  Offset get position;

  PadElement moveTo(Offset value) {
    return moveBy(value - position);
  }

  bool hit(Offset offset, [double radius = 1.0]);

  Rect get rect;

  ElementType get type;

  bool inArea(Area area) => area.rect.overlaps(rect);

  PadElement copyWith({String? layer});
}

enum ElementType { pen, eraser, image, label }

extension ElementTypeExtension on ElementType {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case ElementType.pen:
        return AppLocalizations.of(context)!.pen;
      case ElementType.eraser:
        return AppLocalizations.of(context)!.eraser;
      case ElementType.image:
        return AppLocalizations.of(context)!.image;
      case ElementType.label:
        return AppLocalizations.of(context)!.label;
    }
  }

  PadElement create({String layer = '', Offset position = Offset.zero}) {
    switch (this) {
      case ElementType.pen:
        return PenElement(layer: layer);
      case ElementType.eraser:
        return EraserElement(layer: layer);
      case ElementType.image:
        return ImageElement(
            pixels: Uint8List.fromList([]),
            width: 0,
            height: 0,
            position: position);
      case ElementType.label:
        return LabelElement(layer: layer, position: position);
    }
  }
}
