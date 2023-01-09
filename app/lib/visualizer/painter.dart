// ignore_for_file: prefer_const_constructors

import 'package:butterfly/visualizer/property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../models/painter.dart';

extension PainterVisualizer on Painter {
  String getLocalizedName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return map(
      hand: (_) => loc.hand,
      import: (_) => loc.import,
      undo: (_) => loc.undo,
      redo: (_) => loc.redo,
      label: (_) => loc.label,
      pen: (_) => loc.pen,
      eraser: (_) => loc.eraser,
      pathEraser: (_) => loc.pathEraser,
      layer: (_) => loc.layer,
      area: (_) => loc.area,
      waypoint: (_) => loc.waypoint,
      laser: (_) => loc.laser,
      shape: (_) => loc.shape,
      stamp: (_) => loc.stamp,
    );
  }

  IconData getIcon({bool filled = false}) {
    return map(
      hand: (_) => filled ? PhosphorIcons.handFill : PhosphorIcons.handLight,
      import: (_) => filled
          ? PhosphorIcons.arrowSquareInFill
          : PhosphorIcons.arrowSquareInLight,
      undo: (_) => filled
          ? PhosphorIcons.arrowCounterClockwiseFill
          : PhosphorIcons.arrowCounterClockwiseLight,
      redo: (_) => filled
          ? PhosphorIcons.arrowClockwiseFill
          : PhosphorIcons.arrowClockwiseLight,
      label: (_) => filled ? PhosphorIcons.textTFill : PhosphorIcons.textTLight,
      pen: (_) => filled ? PhosphorIcons.penFill : PhosphorIcons.penLight,
      eraser: (_) =>
          filled ? PhosphorIcons.eraserFill : PhosphorIcons.eraserLight,
      pathEraser: (_) =>
          filled ? PhosphorIcons.pathFill : PhosphorIcons.pathLight,
      layer: (_) => filled
          ? PhosphorIcons.squaresFourFill
          : PhosphorIcons.squaresFourLight,
      area: (_) =>
          filled ? PhosphorIcons.monitorFill : PhosphorIcons.monitorLight,
      waypoint: (_) =>
          filled ? PhosphorIcons.mapPinFill : PhosphorIcons.mapPinLight,
      laser: (_) =>
          filled ? PhosphorIcons.cursorFill : PhosphorIcons.cursorLight,
      shape: (painter) => painter.property.shape.getIcon(filled: filled),
      stamp: (_) => filled ? PhosphorIcons.stampFill : PhosphorIcons.stampLight,
    );
  }

  bool isAction() {
    return maybeMap(
      import: (_) => true,
      undo: (_) => true,
      redo: (_) => true,
      orElse: () => false,
    );
  }
}
