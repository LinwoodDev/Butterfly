import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'background.dart';
import 'converter.dart';

part 'template.g.dart';
part 'template.freezed.dart';

@freezed
class DocumentTemplate with _$DocumentTemplate {
  String get name => document.name;
  String get description => document.description;

  const DocumentTemplate._();

  const factory DocumentTemplate(
      {@DocumentJsonConverter() required AppDocument document,
      @Default('/') String folder}) = _DocumentTemplate;

  static List<DocumentTemplate> getDefaults(BuildContext context) => [
        DocumentTemplate(
            document: AppDocument(
                name: AppLocalizations.of(context).plain,
                createdAt: DateTime.now(),
                painters: createDefaultPainters(),
                palettes: ColorPalette.getMaterialPalette(context),
                background: BackgroundTemplate.plain.create())),
        DocumentTemplate(
            document: AppDocument(
                name: AppLocalizations.of(context).plainDark,
                createdAt: DateTime.now(),
                painters: createDefaultPainters(),
                palettes: ColorPalette.getMaterialPalette(context),
                background: BackgroundTemplate.plainDark.create()))
      ];

  factory DocumentTemplate.fromJson(Map<String, dynamic> json) =>
      _$DocumentTemplateFromJson(json);
}
