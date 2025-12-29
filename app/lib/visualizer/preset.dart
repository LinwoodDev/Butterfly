import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension PatternTemplateHelper on PatternTemplate {
  String getLocalizedName(BuildContext context) => switch (this) {
    PatternTemplate.plain => AppLocalizations.of(context).plain,
    PatternTemplate.ruled => AppLocalizations.of(context).ruled,
    PatternTemplate.quad => AppLocalizations.of(context).quad,
    PatternTemplate.music => AppLocalizations.of(context).music,
    PatternTemplate.dotted => AppLocalizations.of(context).dotted,
    PatternTemplate.plainDark => AppLocalizations.of(context).plainDark,
    PatternTemplate.ruledDark => AppLocalizations.of(context).ruledDark,
    PatternTemplate.quadDark => AppLocalizations.of(context).quadDark,
    PatternTemplate.musicDark => AppLocalizations.of(context).musicDark,
    PatternTemplate.dottedDark => AppLocalizations.of(context).dottedDark,
  };
}

extension AspectRatioPresetVisualizer on AspectRatioPreset {
  String getLocalizedName(BuildContext context) => switch (this) {
    AspectRatioPreset.square => AppLocalizations.of(context).square,
    AspectRatioPreset.portrait => AppLocalizations.of(context).pagePortrait,
    AspectRatioPreset.landscape => AppLocalizations.of(context).pageLandscape,
  };

  IconGetter get icon => switch (this) {
    AspectRatioPreset.square => PhosphorIcons.square,
    AspectRatioPreset.portrait => PhosphorIcons.userFocus,
    AspectRatioPreset.landscape => PhosphorIcons.image,
  };
}
