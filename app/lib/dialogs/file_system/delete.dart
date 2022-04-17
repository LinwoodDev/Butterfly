import 'package:butterfly/api/file_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FileSystemAssetDeleteDialog extends StatelessWidget {
  final String path;
  const FileSystemAssetDeleteDialog({Key? key, required this.path})
      : super(key: key);

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
        TextButton(
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
