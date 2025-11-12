import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension AssetFileTypeVisualizer on AssetFileType? {
  String getLocalizedName(BuildContext context) => switch (this) {
    AssetFileType.note ||
    AssetFileType.textNote => AppLocalizations.of(context).note,
    AssetFileType.image => AppLocalizations.of(context).image,
    AssetFileType.markdown => AppLocalizations.of(context).markdown,
    AssetFileType.pdf => AppLocalizations.of(context).pdf,
    AssetFileType.svg => AppLocalizations.of(context).svg,
    AssetFileType.xopp => 'Xournal++',
    AssetFileType.page => AppLocalizations.of(context).page,
    AssetFileType.archive => AppLocalizations.of(context).data,
    AssetFileType.rawText => AppLocalizations.of(context).text,
    null => AppLocalizations.of(context).unknownImportType,
  };

  IconGetter get icon => switch (this) {
    AssetFileType.note || AssetFileType.textNote => PhosphorIcons.fileText,
    AssetFileType.image => PhosphorIcons.image,
    AssetFileType.markdown => PhosphorIcons.textbox,
    AssetFileType.pdf => PhosphorIcons.filePdf,
    AssetFileType.svg => PhosphorIcons.fileSvg,
    AssetFileType.xopp => PhosphorIcons.notebook,
    AssetFileType.page => PhosphorIcons.book,
    AssetFileType.archive => PhosphorIcons.archive,
    _ => PhosphorIcons.file,
  };
}
