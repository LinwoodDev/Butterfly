import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension AssetFileTypeVisualizer on AssetFileType? {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case AssetFileType.note:
        return AppLocalizations.of(context).note;
      case AssetFileType.image:
        return AppLocalizations.of(context).image;
      case AssetFileType.pdf:
        return AppLocalizations.of(context).pdf;
      default:
        return '';
    }
  }

  PhosphorIconData getIcon({bool filled = false}) {
    switch (this) {
      case AssetFileType.note:
        return filled
            ? PhosphorIconsFill.fileText
            : PhosphorIconsLight.fileText;
      case AssetFileType.image:
        return filled ? PhosphorIconsFill.image : PhosphorIconsLight.image;
      case AssetFileType.pdf:
        return filled ? PhosphorIconsFill.filePdf : PhosphorIconsLight.filePdf;
      default:
        return filled ? PhosphorIconsFill.file : PhosphorIconsLight.file;
    }
  }
}
