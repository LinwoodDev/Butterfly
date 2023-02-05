import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
