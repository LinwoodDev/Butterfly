import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension PatternTemplateHelper on PatternTemplate {
  String getLocalizedName(BuildContext context) => switch (this) {
        PatternTemplate.plain => AppLocalizations.of(context).plain,
        PatternTemplate.ruled => AppLocalizations.of(context).ruled,
        PatternTemplate.quad => AppLocalizations.of(context).quad,
        PatternTemplate.music => AppLocalizations.of(context).music,
        PatternTemplate.plainDark => AppLocalizations.of(context).plainDark,
        PatternTemplate.ruledDark => AppLocalizations.of(context).ruledDark,
        PatternTemplate.quadDark => AppLocalizations.of(context).quadDark,
        PatternTemplate.musicDark => AppLocalizations.of(context).musicDark,
      };
}

extension AspectRatioPresetVisualizer on AspectRatioPreset {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case AspectRatioPreset.square:
        return AppLocalizations.of(context).square;
      case AspectRatioPreset.portrait:
        return AppLocalizations.of(context).pagePortrait;
      case AspectRatioPreset.landscape:
        return AppLocalizations.of(context).pageLandscape;
    }
  }
}
