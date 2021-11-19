import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum InputType { multiDraw, moveFirst, moveLast, onlyStylus }

extension InputTypeExtension on InputType {
  String toLocalizedString(BuildContext context) {
    switch (this) {
      case InputType.multiDraw:
        return AppLocalizations.of(context)!.multiDraw;
      case InputType.moveFirst:
        return AppLocalizations.of(context)!.moveFirst;
      case InputType.moveLast:
        return AppLocalizations.of(context)!.moveLast;
      case InputType.onlyStylus:
        return AppLocalizations.of(context)!.onlyStylus;
    }
  }
}
