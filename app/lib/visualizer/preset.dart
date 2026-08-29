import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension PatternTemplateHelper on PatternTemplate {
  String getLocalizedName(BuildContext context) => switch (this) {
    PatternTemplate.plain => AppLocalizations.of(context).plain,
    PatternTemplate.ruled => AppLocalizations.of(context).ruled,
    PatternTemplate.quad => AppLocalizations.of(context).quad,
    PatternTemplate.music => AppLocalizations.of(context).music,
    PatternTemplate.dotted => AppLocalizations.of(context).dotted,
    PatternTemplate.ruledSimple => AppLocalizations.of(context).ruledSimple,
    PatternTemplate.quadSimple => AppLocalizations.of(context).quadSimple,
    PatternTemplate.plainDark => AppLocalizations.of(context).plainDark,
    PatternTemplate.ruledDark => AppLocalizations.of(context).ruledDark,
    PatternTemplate.quadDark => AppLocalizations.of(context).quadDark,
    PatternTemplate.musicDark => AppLocalizations.of(context).musicDark,
    PatternTemplate.dottedDark => AppLocalizations.of(context).dottedDark,
    PatternTemplate.ruledSimpleDark => AppLocalizations.of(
      context,
    ).ruledSimpleDark,
    PatternTemplate.quadSimpleDark => AppLocalizations.of(
      context,
    ).quadSimpleDark,
  };
}

extension AspectRatioPresetVisualizer on AspectRatioPreset {
  String getLocalizedName(BuildContext context) => switch (this) {
    AspectRatioPreset.square => AppLocalizations.of(context).square,
    AspectRatioPreset.portrait => AppLocalizations.of(context).pagePortrait,
    AspectRatioPreset.landscape => AppLocalizations.of(context).pageLandscape,
  };

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    AspectRatioPreset.square =>
      filled ? PhosphorIconsFill.square : PhosphorIconsLight.square,
    AspectRatioPreset.portrait =>
      filled ? PhosphorIconsFill.userFocus : PhosphorIconsLight.userFocus,
    AspectRatioPreset.landscape =>
      filled ? PhosphorIconsFill.image : PhosphorIconsLight.image,
  };
}
