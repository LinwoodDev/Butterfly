import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension ArangementVisualizer on Arrangement {
  String getLocalizedName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return switch (this) {
      .back => loc.sendToBack,
      .front => loc.bringToFront,
      .backward => loc.sendBackward,
      .forward => loc.bringForward,
    };
  }

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    .back =>
      filled ? PhosphorIconsFill.arrowDown : PhosphorIconsLight.arrowDown,
    .front => filled ? PhosphorIconsFill.arrowUp : PhosphorIconsLight.arrowUp,
    .backward =>
      filled ? PhosphorIconsFill.arrowLeft : PhosphorIconsLight.arrowLeft,
    .forward =>
      filled ? PhosphorIconsFill.arrowRight : PhosphorIconsLight.arrowRight,
  };
}
