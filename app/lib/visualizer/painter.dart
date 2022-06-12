// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../models/painter.dart';

extension PainterVisualizer on Painter {
  String getLocalizedName(BuildContext context) {
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
    if (this is LaserPainter) {
      return AppLocalizations.of(context)!.laser;
    }
    throw UnimplementedError();
  }

  IconData getIcon({bool filled = false}) {
    if (this is PenPainter) {
      return filled ? PhosphorIcons.penFill : PhosphorIcons.penLight;
    }
    if (this is LabelPainter) {
      return filled ? PhosphorIcons.textTFill : PhosphorIcons.textTLight;
    }
    if (this is PathEraserPainter) {
      return filled ? PhosphorIcons.pathFill : PhosphorIcons.pathLight;
    }
    if (this is EraserPainter) {
      return filled ? PhosphorIcons.eraserFill : PhosphorIcons.eraserLight;
    }
    if (this is AreaPainter) {
      return filled ? PhosphorIcons.squareFill : PhosphorIcons.squareLight;
    }
    if (this is LayerPainter) {
      return filled
          ? PhosphorIcons.squaresFourFill
          : PhosphorIcons.squaresFourLight;
    }
    if (this is LaserPainter) {
      return filled ? PhosphorIcons.cursorFill : PhosphorIcons.cursorLight;
    }
    throw UnimplementedError();
  }

  static List<Painter> getAllPainters() => [
        PenPainter(),
        PathEraserPainter(),
        LabelPainter(),
        EraserPainter(),
        LayerPainter(),
        AreaPainter(),
        LaserPainter()
      ];
}
