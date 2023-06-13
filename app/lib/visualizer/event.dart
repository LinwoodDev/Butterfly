import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension ArangementVisualizer on Arrangement {
  String getLocalizedName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    switch (this) {
      case Arrangement.back:
        return loc.sendToBack;
      case Arrangement.front:
        return loc.bringToFront;
      case Arrangement.backward:
        return loc.sendBackward;
      case Arrangement.forward:
        return loc.bringForward;
    }
  }

  IconGetter get icon {
    switch (this) {
      case Arrangement.back:
        return PhosphorIcons.arrowDown;
      case Arrangement.front:
        return PhosphorIcons.arrowUp;
      case Arrangement.backward:
        return PhosphorIcons.arrowDownLeft;
      case Arrangement.forward:
        return PhosphorIcons.arrowUpRight;
    }
  }
}
