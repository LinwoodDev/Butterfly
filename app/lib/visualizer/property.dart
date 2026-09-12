import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

extension PathShapeVisualizer on PathShape {
  PhosphorIconData icon({bool filled = false}) => switch (this) {
    CircleShape _ =>
      filled ? PhosphorIconsFill.circle : PhosphorIconsLight.circle,
    RectangleShape _ =>
      filled ? PhosphorIconsFill.square : PhosphorIconsLight.square,
    LineShape _ =>
      filled ? PhosphorIconsFill.lineSegment : PhosphorIconsLight.lineSegment,
    TriangleShape _ =>
      filled ? PhosphorIconsFill.triangle : PhosphorIconsLight.triangle,
  };

  String getLocalizedName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return switch (this) {
      CircleShape _ => loc.circle,
      RectangleShape _ => loc.rectangle,
      LineShape _ => loc.line,
      TriangleShape _ => loc.triangle,
    };
  }
}

extension StrokeStyleVisualizer on StrokeStyle {
  String getLocalizedName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return switch (this) {
      .solid => loc.solid,
      .dotted => loc.dotted,
    };
  }

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    .solid => filled ? PhosphorIconsFill.minus : PhosphorIconsLight.minus,
    .dotted => filled ? PhosphorIconsFill.dotsSix : PhosphorIconsLight.dotsSix,
  };
}

extension HitElementModeVisualizer on HitElementMode {
  String getLocalizedName(BuildContext context, {required bool isEraser}) {
    final loc = AppLocalizations.of(context);
    if (isEraser) {
      return switch (this) {
        .none => loc.eraseShapeModeNone,
        .touchEdges => loc.eraseShapeModeTouchEdges,
        .touchAnywhere => loc.eraseShapeModeTouchAnywhere,
        _ => loc.notSet, // this shouldn't happen
      };
    } else {
      return switch (this) {
        .full => loc.fullSelection,
        .touchEdges => loc.selectElementModeTouchEdges,
        .touchAnywhere => loc.selectElementModeTouchAnywhere,
        _ => loc.notSet, // this shouldn't happen
      };
    }
  }
}
