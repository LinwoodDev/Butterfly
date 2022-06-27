import 'package:butterfly/visualizer/property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../models/element.dart';

extension ElementVisualizer on PadElement {
  String getLocalizedName(BuildContext context) {
    if (this is PenElement) {
      return AppLocalizations.of(context)!.pen;
    }
    if (this is LabelElement) {
      return AppLocalizations.of(context)!.label;
    }
    if (this is EraserElement) {
      return AppLocalizations.of(context)!.eraser;
    }
    if (this is ImageElement) {
      return AppLocalizations.of(context)!.image;
    }
    if (this is ShapeElement) {
      return AppLocalizations.of(context)!.shape;
    }
    throw UnimplementedError();
  }

  IconData getIcon() {
    if (this is PenElement) {
      return PhosphorIcons.penLight;
    }
    if (this is LabelElement) {
      return PhosphorIcons.textTLight;
    }
    if (this is EraserElement) {
      return PhosphorIcons.eraserLight;
    }
    if (this is ImageElement) {
      return PhosphorIcons.imageLight;
    }
    if (this is ShapeElement) {
      final shape = (this as ShapeElement).shape;
      return shape.getIcon();
    }
    throw UnimplementedError();
  }
}
