import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension ArangementVisualizer on Arangement {
  String getLocalizedName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    switch (this) {
      case Arangement.back:
        return loc.sendToBack;
      case Arangement.front:
        return loc.bringToFront;
      case Arangement.backward:
        return loc.sendBackward;
      case Arangement.forward:
        return loc.bringForward;
    }
  }

  IconGetter get icon {
    switch (this) {
      case Arangement.back:
        return PhosphorIcons.arrowDown;
      case Arangement.front:
        return PhosphorIcons.arrowUp;
      case Arangement.backward:
        return PhosphorIcons.arrowDownLeft;
      case Arangement.forward:
        return PhosphorIcons.arrowUpRight;
    }
  }
}
