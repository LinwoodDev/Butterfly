import 'package:flutter/material.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DocumentDefaults {
  static const materialColors = [
    Colors.white,
    Colors.pink,
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lime,
    Colors.green,
    Colors.teal,
    Colors.cyan,
    Colors.lightBlue,
    Colors.blue,
    Colors.indigo,
    Colors.blueGrey,
    Colors.purple,
    Colors.brown,
    Colors.grey,
    Colors.black
  ];
  static List<ColorPalette> getMaterialPalette(BuildContext context) => [
        ColorPalette(
            name: AppLocalizations.of(context).defaultPalette,
            colors: materialColors.map((e) => e.value).toList()),
      ];
  static List<DocumentTemplate> getDefaults(BuildContext context) => [
        DocumentTemplate(
            document: AppDocument(
                name: AppLocalizations.of(context).plain,
                createdAt: DateTime.now(),
                painters: createDefaultPainters(),
                palettes: DocumentDefaults.getMaterialPalette(context),
                background: BackgroundTemplate.plain.create())),
        DocumentTemplate(
            document: AppDocument(
                name: AppLocalizations.of(context).plainDark,
                createdAt: DateTime.now(),
                painters: createDefaultPainters(),
                palettes: DocumentDefaults.getMaterialPalette(context),
                background: BackgroundTemplate.plainDark.create()))
      ];
}
