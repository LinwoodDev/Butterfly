import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../models/document.dart';

extension AssetFileTypeVisualizer on AssetFileType? {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case AssetFileType.note:
        return AppLocalizations.of(context)!.note;
      case AssetFileType.image:
        return AppLocalizations.of(context)!.image;
      case AssetFileType.pdf:
        return AppLocalizations.of(context)!.pdf;
      default:
        return '';
    }
  }

  IconData getIcon({bool filled = false}) {
    switch (this) {
      case AssetFileType.note:
        return filled
            ? PhosphorIcons.fileTextFill
            : PhosphorIcons.fileTextLight;
      case AssetFileType.image:
        return filled ? PhosphorIcons.imageFill : PhosphorIcons.imageLight;
      case AssetFileType.pdf:
        return filled ? PhosphorIcons.filePdfFill : PhosphorIcons.filePdfLight;
      default:
        return filled ? PhosphorIcons.fileFill : PhosphorIcons.fileLight;
    }
  }
}
