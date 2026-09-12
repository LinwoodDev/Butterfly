import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension AssetFileTypeVisualizer on AssetFileType? {
  String getLocalizedName(BuildContext context) => switch (this) {
    .note || .textNote => AppLocalizations.of(context).note,
    .image => AppLocalizations.of(context).image,
    .markdown => AppLocalizations.of(context).markdown,
    .pdf => AppLocalizations.of(context).pdf,
    .svg => AppLocalizations.of(context).svg,
    .xopp => 'Xournal++',
    .oneNote || AssetFileType.oneNotePackage => 'OneNote',
    .page => AppLocalizations.of(context).page,
    .archive => AppLocalizations.of(context).data,
    .rawText => AppLocalizations.of(context).text,
    null => AppLocalizations.of(context).unknownImportType,
  };

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    .note || AssetFileType.textNote =>
      filled ? PhosphorIconsFill.fileText : PhosphorIconsLight.fileText,
    .image => filled ? PhosphorIconsFill.image : PhosphorIconsLight.image,
    .markdown =>
      filled ? PhosphorIconsFill.textbox : PhosphorIconsLight.textbox,
    .pdf => filled ? PhosphorIconsFill.filePdf : PhosphorIconsLight.filePdf,
    .svg => filled ? PhosphorIconsFill.fileSvg : PhosphorIconsLight.fileSvg,
    .xopp => filled ? PhosphorIconsFill.notebook : PhosphorIconsLight.notebook,
    .oneNote || AssetFileType.oneNotePackage =>
      filled ? PhosphorIconsFill.notebook : PhosphorIconsLight.notebook,
    .page => filled ? PhosphorIconsFill.book : PhosphorIconsLight.book,
    .archive => filled ? PhosphorIconsFill.archive : PhosphorIconsLight.archive,
    _ => filled ? PhosphorIconsFill.file : PhosphorIconsLight.file,
  };
}
