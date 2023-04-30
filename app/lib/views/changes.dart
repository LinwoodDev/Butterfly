import 'dart:async';

import 'package:butterfly/api/open.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

FutureOr<NoteData?> checkFileChanges(
    BuildContext context, AppDocumentEntity? entity) async {
  if (entity is! AppDocumentFile) return null;
  final data = entity.load();
  final metadata = data.getMetadata();
  if (metadata == null) return null;
  final version = metadata.fileVersion;
  if (version >= 0 &&
      (version > kFileVersion || version < kBreakingChangesVersion)) {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).breakingChangesTitle),
        scrollable: true,
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppLocalizations.of(context)
                  .breakingChangesMessage(version, kFileVersion)),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                label: Text(AppLocalizations.of(context).documentation),
                icon: const PhosphorIcon(PhosphorIconsLight.bookOpen),
                onPressed: () => openHelp(['migrating']),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(AppLocalizations.of(context).cancel)),
          TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(AppLocalizations.of(context).ok)),
        ],
      ),
    );
    if (result != true) return null;
  }
  return data;
}
