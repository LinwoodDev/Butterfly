import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

class PackImportConfirmationDialog extends StatelessWidget {
  final FileMetadata pack;

  const PackImportConfirmationDialog({super.key, required this.pack});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).sureImportPack),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(pack.name, style: TextTheme.of(context).titleLarge),
          Text(AppLocalizations.of(context).byAuthor(pack.author)),
          Text(pack.description),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(AppLocalizations.of(context).import),
        ),
      ],
    );
  }
}

class TemplateImportConfirmationDialog extends StatelessWidget {
  final FileMetadata template;

  const TemplateImportConfirmationDialog({super.key, required this.template});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).sureImportTemplate),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(template.name, style: TextTheme.of(context).titleLarge),
          Text(template.description),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(AppLocalizations.of(context).import),
        ),
      ],
    );
  }
}

class UnknownImportConfirmationDialog extends StatelessWidget {
  final String message;

  const UnknownImportConfirmationDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).errorWhileImporting),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).closeButtonLabel),
        ),
      ],
    );
  }
}
