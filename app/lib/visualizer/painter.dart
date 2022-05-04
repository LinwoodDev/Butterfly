import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../models/painter.dart';

extension PainterVisualizer on Painter {
  String getName(BuildContext context) {
    if (this is PenPainter) {
      return AppLocalizations.of(context)!.pen;
    }
    if (this is LabelPainter) {
      return AppLocalizations.of(context)!.label;
    }
    if (this is PathEraserPainter) {
      return AppLocalizations.of(context)!.pathEraser;
    }
    if (this is EraserPainter) {
      return AppLocalizations.of(context)!.eraser;
    }
    if (this is AreaPainter) {
      return AppLocalizations.of(context)!.area;
    }
    if (this is AreaPainter) {
      return AppLocalizations.of(context)!.area;
    }
    if (this is LayerPainter) {
      return AppLocalizations.of(context)!.layer;
    }
    throw UnimplementedError();
  }

  IconData getIcon() {
    if (this is PenPainter) {
      return PhosphorIcons.penLight;
    }
    if (this is LabelPainter) {
      return PhosphorIcons.textTLight;
    }
    if (this is PathEraserPainter) {
      return PhosphorIcons.pathLight;
    }
    if (this is EraserPainter) {
      return PhosphorIcons.eraserLight;
    }
    if (this is AreaPainter) {
      return PhosphorIcons.squareLight;
    }
    if (this is LayerPainter) {
      return PhosphorIcons.squaresFourFill;
    }
    throw UnimplementedError();
  }
}
