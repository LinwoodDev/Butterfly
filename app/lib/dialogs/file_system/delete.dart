import 'package:butterfly/api/file_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FileSystemAssetDeleteDialog extends StatelessWidget {
  final String path;
  const FileSystemAssetDeleteDialog({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    var fileSystem = DocumentFileSystem.fromPlatform();
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.areYouSure),
      content: Text(AppLocalizations.of(context)!.reallyDelete),
      actions: [
        TextButton(
          child: Text(AppLocalizations.of(context)!.no),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text(AppLocalizations.of(context)!.yes),
          onPressed: () async {
            Navigator.of(context).pop(true);
            await fileSystem.deleteAsset(path);
          },
        )
      ],
    );
  }
}
