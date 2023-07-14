// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:butterfly/visualizer/property.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
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
      laser: (_) => loc.laser,
      shape: (_) => loc.shape,
      spacer: (_) => loc.spacer,
      stamp: (_) => loc.stamp,
      presentation: (_) => loc.presentation,
      fullSceen: (_) => loc.fullScreen,
      asset: (painter) => painter.type.getLocalizedName(context),
    );
  }

  IconGetter get icon => map(
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
        laser: (_) => PhosphorIcons.cursor,
        shape: (painter) => painter.property.shape.icon,
        spacer: (painter) => painter.axis == Axis2D.horizontal
            ? PhosphorIcons.splitHorizontal
            : PhosphorIcons.splitVertical,
        stamp: (_) => PhosphorIcons.stamp,
        presentation: (_) => PhosphorIcons.presentation,
        fullSceen: (_) => PhosphorIcons.arrowsOut,
        asset: (painter) => painter.type.icon,
      );

  List<String> get help {
    final page = mapOrNull(
      redo: (_) => 'redo',
      undo: (_) => 'undo',
      pen: (_) => 'pen',
      laser: (_) => 'laser',
      shape: (_) => 'shape',
      stamp: (_) => 'stamp',
      eraser: (_) => 'eraser',
      pathEraser: (_) => 'path_eraser',
      label: (_) => 'label',
      area: (_) => 'area',
      hand: (_) => 'hand',
      layer: (_) => 'layer',
      presentation: (_) => 'presentation',
    );
    if (page == null) return [];
    return ['painters', page];
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

extension ImportTypeVisualizer on ImportType {
  String getLocalizedName(BuildContext context) => switch (this) {
        ImportType.document => AppLocalizations.of(context).document,
        ImportType.image => AppLocalizations.of(context).image,
        ImportType.pdf => AppLocalizations.of(context).pdf,
        ImportType.svg => AppLocalizations.of(context).svg,
        ImportType.camera => AppLocalizations.of(context).camera,
      };

  IconGetter get icon => switch (this) {
        ImportType.document => PhosphorIcons.fileText,
        ImportType.image => PhosphorIcons.image,
        ImportType.pdf => PhosphorIcons.filePdf,
        ImportType.svg => PhosphorIcons.fileSvg,
        ImportType.camera => PhosphorIcons.camera,
      };

  bool isAvailable() => switch (this) {
        ImportType.camera =>
          kIsWeb || Platform.isWindows || Platform.isAndroid || Platform.isIOS,
        _ => true,
      };
}
