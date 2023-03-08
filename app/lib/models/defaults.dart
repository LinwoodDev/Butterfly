import 'package:flutter/material.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DocumentDefaults {

  static List<DocumentTemplate> getDefaults(BuildContext context) => [
        DocumentTemplate(
            document: AppDocument(
                name: AppLocalizations.of(context).plain,
                createdAt: DateTime.now(),
                painters: createDefaultPainters(),
                background: BackgroundTemplate.plain.create())),
        DocumentTemplate(
            document: AppDocument(
                name: AppLocalizations.of(context).plainDark,
                createdAt: DateTime.now(),
                painters: createDefaultPainters(),
                background: BackgroundTemplate.plainDark.create()))
      ];
}
