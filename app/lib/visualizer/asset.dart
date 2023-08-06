import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension AssetFileTypeVisualizer on AssetFileType? {
  String getLocalizedName(BuildContext context) => switch (this) {
        AssetFileType.note => AppLocalizations.of(context).note,
        AssetFileType.image => AppLocalizations.of(context).image,
        AssetFileType.pdf => AppLocalizations.of(context).pdf,
        AssetFileType.svg => AppLocalizations.of(context).svg,
        _ => ''
      };

  IconGetter get icon => switch (this) {
        AssetFileType.note => PhosphorIcons.fileText,
        AssetFileType.image => PhosphorIcons.image,
        AssetFileType.pdf => PhosphorIcons.filePdf,
        AssetFileType.svg => PhosphorIcons.fileSvg,
        _ => PhosphorIcons.file,
      };
}
