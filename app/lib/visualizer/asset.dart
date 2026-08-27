import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
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
    AssetFileType.oneNote || AssetFileType.oneNotePackage => 'OneNote',
    AssetFileType.page => AppLocalizations.of(context).page,
    AssetFileType.archive => AppLocalizations.of(context).data,
    AssetFileType.rawText => AppLocalizations.of(context).text,
    null => AppLocalizations.of(context).unknownImportType,
  };

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    AssetFileType.note || AssetFileType.textNote =>
      filled ? PhosphorIconsFill.fileText : PhosphorIconsLight.fileText,
    AssetFileType.image =>
      filled ? PhosphorIconsFill.image : PhosphorIconsLight.image,
    AssetFileType.markdown =>
      filled ? PhosphorIconsFill.textbox : PhosphorIconsLight.textbox,
    AssetFileType.pdf =>
      filled ? PhosphorIconsFill.filePdf : PhosphorIconsLight.filePdf,
    AssetFileType.svg =>
      filled ? PhosphorIconsFill.fileSvg : PhosphorIconsLight.fileSvg,
    AssetFileType.xopp =>
      filled ? PhosphorIconsFill.notebook : PhosphorIconsLight.notebook,
    AssetFileType.oneNote || AssetFileType.oneNotePackage =>
      filled ? PhosphorIconsFill.notebook : PhosphorIconsLight.notebook,
    AssetFileType.page =>
      filled ? PhosphorIconsFill.book : PhosphorIconsLight.book,
    AssetFileType.archive =>
      filled ? PhosphorIconsFill.archive : PhosphorIconsLight.archive,
    _ => filled ? PhosphorIconsFill.file : PhosphorIconsLight.file,
  };
}
