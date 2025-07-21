import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
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

  IconGetter get icon => switch (this) {
    Arrangement.back => PhosphorIcons.arrowDown,
    Arrangement.front => PhosphorIcons.arrowUp,
    Arrangement.backward => PhosphorIcons.arrowDownLeft,
    Arrangement.forward => PhosphorIcons.arrowUpRight,
  };
}
