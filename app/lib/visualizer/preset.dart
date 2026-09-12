import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension PatternTemplateHelper on PatternTemplate {
  String getLocalizedName(BuildContext context) => switch (this) {
    .plain => AppLocalizations.of(context).plain,
    .ruled => AppLocalizations.of(context).ruled,
    .quad => AppLocalizations.of(context).quad,
    .music => AppLocalizations.of(context).music,
    .dotted => AppLocalizations.of(context).dotted,
    .ruledSimple => AppLocalizations.of(context).ruledSimple,
    .quadSimple => AppLocalizations.of(context).quadSimple,
    .plainDark => AppLocalizations.of(context).plainDark,
    .ruledDark => AppLocalizations.of(context).ruledDark,
    .quadDark => AppLocalizations.of(context).quadDark,
    .musicDark => AppLocalizations.of(context).musicDark,
    .dottedDark => AppLocalizations.of(context).dottedDark,
    .ruledSimpleDark => AppLocalizations.of(context).ruledSimpleDark,
    .quadSimpleDark => AppLocalizations.of(context).quadSimpleDark,
  };
}

extension AspectRatioPresetVisualizer on AspectRatioPreset {
  String getLocalizedName(BuildContext context) => switch (this) {
    .square => AppLocalizations.of(context).square,
    .portrait => AppLocalizations.of(context).pagePortrait,
    .landscape => AppLocalizations.of(context).pageLandscape,
  };

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    .square => filled ? PhosphorIconsFill.square : PhosphorIconsLight.square,
    .portrait =>
      filled ? PhosphorIconsFill.userFocus : PhosphorIconsLight.userFocus,
    .landscape => filled ? PhosphorIconsFill.image : PhosphorIconsLight.image,
  };
}
