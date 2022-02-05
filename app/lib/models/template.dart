import 'package:butterfly/models/backgrounds/box.dart';
import 'package:butterfly/models/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/format_date_time.dart';
import '../cubits/settings.dart';

class DocumentTemplate {
  final AppDocument document;
  final String name;
  final String description;

  DocumentTemplate(
      {required this.document, required this.name, this.description = ''});

  static Future<List<DocumentTemplate>> getDefaults(
      BuildContext context) async {
    final name =
        await formatCurrentDateTime(context.read<SettingsCubit>().state.locale);
    return [
      DocumentTemplate(
          name: AppLocalizations.of(context)!.plain,
          document: AppDocument(
              name: name,
              createdAt: DateTime.now(),
              background: BackgroundTemplate.plain.create())),
      DocumentTemplate(
          name: AppLocalizations.of(context)!.plainDark,
          document: AppDocument(
              name: name,
              createdAt: DateTime.now(),
              background: BackgroundTemplate.plainDark.create()))
    ];
  }

  DocumentTemplate.fromJson(Map<String, dynamic> json)
      : document = AppDocument.fromJson(json['document']),
        name = json['name'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'document': document.toJson(),
        'name': name,
        'description': description,
      };

  DocumentTemplate copyWith({
    AppDocument? document,
    String? name,
    String? description,
  }) {
    return DocumentTemplate(
      document: document ?? this.document,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
