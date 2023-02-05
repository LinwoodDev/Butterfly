import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BackgroundTemplateHelper on BackgroundTemplate {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case BackgroundTemplate.plain:
        return AppLocalizations.of(context).plain;
      case BackgroundTemplate.ruled:
        return AppLocalizations.of(context).ruled;
      case BackgroundTemplate.quad:
        return AppLocalizations.of(context).quad;
      case BackgroundTemplate.music:
        return AppLocalizations.of(context).music;
      case BackgroundTemplate.plainDark:
        return AppLocalizations.of(context).plainDark;
      case BackgroundTemplate.ruledDark:
        return AppLocalizations.of(context).ruledDark;
      case BackgroundTemplate.quadDark:
        return AppLocalizations.of(context).quadDark;
      case BackgroundTemplate.musicDark:
        return AppLocalizations.of(context).musicDark;
    }
  }
}
