import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DocumentDefaults {
  static Future<List<DocumentTemplate>> getDefaults(
          BuildContext context) async =>
      [
        DocumentTemplate(
            document: AppDocument(
                name: AppLocalizations.of(context).plain,
                packs: [await getCorePack()],
                createdAt: DateTime.now(),
                painters: createDefaultPainters(),
                background: BackgroundTemplate.plain.create())),
        DocumentTemplate(
            document: AppDocument(
                name: AppLocalizations.of(context).plainDark,
                packs: [await getCorePack()],
                createdAt: DateTime.now(),
                painters: createDefaultPainters(),
                background: BackgroundTemplate.plainDark.create()))
      ];

  static Future<ButterflyPack> getCorePack() async => const PackJsonConverter()
      .fromJson(json.decode(await rootBundle.loadString('defaults/pack.bfly')));

  static String translate(BuildContext context, String key) {
    if (key.startsWith('\\/')) return key.substring(1);
    if (!key.startsWith('\$')) return key;
    final keyWithoutDollar = key.substring(1);
    switch (keyWithoutDollar) {
      case 'plain':
        return AppLocalizations.of(context).plain;
      case 'plainDark':
        return AppLocalizations.of(context).plainDark;
      default:
        break;
    }
    if (keyWithoutDollar.startsWith('headline')) {
      return AppLocalizations.of(context).headline +
          keyWithoutDollar.substring(8);
    }
    return key;
  }
}
