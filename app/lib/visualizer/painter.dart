// ignore_for_file: prefer_const_constructors

import 'package:butterfly/visualizer/property.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
      presentation: (_) => loc.presentation,
    );
  }

  PhosphorIconData getIcon({bool filled = false}) {
    return map(
      hand: (_) => filled ? PhosphorIcons.fill.hand : PhosphorIcons.light.hand,
      import: (_) => filled
          ? PhosphorIcons.fill.arrowSquareIn
          : PhosphorIcons.light.arrowSquareIn,
      undo: (_) => filled
          ? PhosphorIcons.fill.arrowCounterClockwise
          : PhosphorIcons.light.arrowCounterClockwise,
      redo: (_) => filled
          ? PhosphorIcons.fill.arrowClockwise
          : PhosphorIcons.light.arrowClockwise,
      label: (_) =>
          filled ? PhosphorIcons.fill.textT : PhosphorIcons.light.textT,
      pen: (_) => filled ? PhosphorIcons.fill.pen : PhosphorIcons.light.pen,
      eraser: (_) =>
          filled ? PhosphorIcons.fill.eraser : PhosphorIcons.light.eraser,
      pathEraser: (_) =>
          filled ? PhosphorIcons.fill.path : PhosphorIcons.light.path,
      layer: (_) => filled
          ? PhosphorIcons.fill.squaresFour
          : PhosphorIcons.light.squaresFour,
      area: (_) =>
          filled ? PhosphorIcons.fill.monitor : PhosphorIcons.light.monitor,
      waypoint: (_) =>
          filled ? PhosphorIcons.fill.mapPin : PhosphorIcons.light.mapPin,
      laser: (_) =>
          filled ? PhosphorIcons.fill.cursor : PhosphorIcons.light.cursor,
      shape: (painter) => painter.property.shape.getIcon(filled: filled),
      stamp: (_) =>
          filled ? PhosphorIcons.fill.stamp : PhosphorIcons.light.stamp,
      presentation: (_) => filled
          ? PhosphorIcons.fill.presentation
          : PhosphorIcons.light.presentation,
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
