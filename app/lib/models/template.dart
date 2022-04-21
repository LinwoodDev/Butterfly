import 'package:butterfly/models/colors.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'background.dart';
import 'painter.dart';

part 'template.freezed.dart';
part 'template.g.dart';

@freezed
class DocumentTemplate with _$DocumentTemplate {
  String get name => document.name;
  String get description => document.description;

  const DocumentTemplate._();

  const factory DocumentTemplate(
      {required AppDocument document,
      @Default('/') String folder}) = _DocumentTemplate;

  static List<DocumentTemplate> getDefaults(BuildContext context) => [
        DocumentTemplate(
            document: AppDocument(
                name: AppLocalizations.of(context)!.plain,
                createdAt: DateTime.now(),
                background: BackgroundTemplate.plain.create())),
        DocumentTemplate(
            document: AppDocument(
                name: AppLocalizations.of(context)!.plainDark,
                createdAt: DateTime.now(),
                painters: [
                  const PenPainter(property: PenProperty(color: kColorWhite)),
                  const PathEraserPainter(),
                  const LabelPainter(
                      property: LabelProperty(color: kColorWhite)),
                ],
                background: BackgroundTemplate.plainDark.create()))
      ];

  factory DocumentTemplate.fromJson(Map<String, dynamic> json) =>
      _$DocumentTemplateFromJson(json);
}
