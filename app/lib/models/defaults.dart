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

  static String translate(String key, Map<String, String> translations) {
    if (key.startsWith('\\/')) return key.substring(1);
    if (!key.startsWith('\$')) return key;
    final keyWithoutDollar = key.substring(1);
    return translations[keyWithoutDollar] ?? keyWithoutDollar;
  }

  static Map<String, String> getParagraphTranslations(BuildContext context) => {
        'h1': AppLocalizations.of(context).headline(1),
        'h2': AppLocalizations.of(context).headline(2),
        'h3': AppLocalizations.of(context).headline(3),
        'h4': AppLocalizations.of(context).headline(4),
        'h5': AppLocalizations.of(context).headline(5),
        'h6': AppLocalizations.of(context).headline(6),
        'p': AppLocalizations.of(context).paragraph,
        'quote': AppLocalizations.of(context).quote,
        'code': AppLocalizations.of(context).code,
        'blockquote': AppLocalizations.of(context).blockquote,
      };

  static String translateParagraph(String key, BuildContext context) =>
      translate(key, getParagraphTranslations(context));

  static Map<String, String> getBlockTranslations(BuildContext context) => {
        'a': AppLocalizations.of(context).link,
        'checkbox': AppLocalizations.of(context).checkbox,
        'del': AppLocalizations.of(context).deleted,
        'em': AppLocalizations.of(context).emphasis,
        'img': AppLocalizations.of(context).image,
        'listBullet': AppLocalizations.of(context).listBullet,
        'strong': AppLocalizations.of(context).strong,
      };

  static String translateBlock(String key, BuildContext context) =>
      translate(key, getBlockTranslations(context));
}
