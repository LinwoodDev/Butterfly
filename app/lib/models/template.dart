import 'package:butterfly/models/backgrounds/box.dart';
import 'package:butterfly/models/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DocumentTemplate {
  final AppDocument document;
  final String folder;
  String get name => document.name;
  String get description => document.description;

  DocumentTemplate({required this.document, this.folder = '/'});

  static List<DocumentTemplate> getDefaults(BuildContext context) => [
        DocumentTemplate(
            document: AppDocument(
                name: AppLocalizations.of(context)!.plain,
                createdAt: DateTime.now(),
                background: BackgroundTemplate.plain.create())),
        DocumentTemplate(
            document: AppDocument.dark(
                name: AppLocalizations.of(context)!.plainDark,
                createdAt: DateTime.now(),
                background: BackgroundTemplate.plainDark.create()))
      ];

  DocumentTemplate.fromJson(Map<String, dynamic> json)
      : document = AppDocument.fromJson(json['document']),
        folder = json['folder'] ?? '/';

  Map<String, dynamic> toJson() => {
        'document': document.toJson(),
        'folder': folder,
      };

  DocumentTemplate copyWith({AppDocument? document, String? folder}) {
    return DocumentTemplate(
      document: document ?? this.document,
      folder: folder ?? this.folder,
    );
  }
}
