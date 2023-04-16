// ignore_for_file: prefer_const_constructors

import 'package:butterfly/visualizer/property.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../helpers/icon_helper.dart';

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

  IconGetter get icon {
    return map(
      hand: (_) => PhosphorIcons.hand,
      import: (_) => PhosphorIcons.arrowSquareIn,
      undo: (_) => PhosphorIcons.arrowCounterClockwise,
      redo: (_) => PhosphorIcons.arrowClockwise,
      label: (_) => PhosphorIcons.textT,
      pen: (_) => PhosphorIcons.pen,
      eraser: (_) => PhosphorIcons.eraser,
      pathEraser: (_) => PhosphorIcons.path,
      layer: (_) => PhosphorIcons.squaresFour,
      area: (_) => PhosphorIcons.monitor,
      waypoint: (_) => PhosphorIcons.mapPin,
      laser: (_) => PhosphorIcons.cursor,
      shape: (painter) => painter.property.shape.icon,
      stamp: (_) => PhosphorIcons.stamp,
      presentation: (_) => PhosphorIcons.presentation,
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
