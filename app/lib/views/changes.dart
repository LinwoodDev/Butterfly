import 'dart:async';

import 'package:butterfly/api/open.dart';
import 'package:butterfly/main.dart';
import 'package:butterfly/models/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

FutureOr<AppDocument?> checkFileChanges(
    BuildContext context, AppDocumentEntity? entity) async {
  if (entity is! AppDocumentFile) return null;
  final info = entity.getDocumentInfo();
  if (info == null) return null;
  final version = info.fileVersion;
  if (version >= 0 &&
      (version > kFileVersion || version < kBreakingChangesVersion)) {
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.breakingChangesTitle),
        scrollable: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)!
                .breakingChangesMessage(version, kFileVersion)),
            OutlinedButton.icon(
              label: Text(AppLocalizations.of(context)!.documentation),
              icon: const Icon(PhosphorIcons.bookOpenLight),
              onPressed: () => openHelp(['migrating']),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: Text(AppLocalizations.of(context)!.cancel)),
          TextButton(
              onPressed: () => Navigator.of(context).pop(info.load()),
              child: Text(AppLocalizations.of(context)!.ok)),
        ],
      ),
    );
    if (result == null) return null;
  }
  return info.load();
}
