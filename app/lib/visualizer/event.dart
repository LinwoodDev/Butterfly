import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension ArangementVisualizer on Arrangement {
  String getLocalizedName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return switch (this) {
      Arrangement.back => loc.sendToBack,
      Arrangement.front => loc.bringToFront,
      Arrangement.backward => loc.sendBackward,
      Arrangement.forward => loc.bringForward,
    };
  }

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    Arrangement.back =>
      filled ? PhosphorIconsFill.arrowDown : PhosphorIconsLight.arrowDown,
    Arrangement.front =>
      filled ? PhosphorIconsFill.arrowUp : PhosphorIconsLight.arrowUp,
    Arrangement.backward =>
      filled ? PhosphorIconsFill.arrowLeft : PhosphorIconsLight.arrowLeft,
    Arrangement.forward =>
      filled ? PhosphorIconsFill.arrowRight : PhosphorIconsLight.arrowRight,
  };
}
