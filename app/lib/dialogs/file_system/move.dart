import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../api/file_system.dart';
import '../../models/document.dart';
import 'tree.dart';

class FileSystemAssetMoveDialog extends StatefulWidget {
  final bool duplicate;
  final AppDocumentAsset asset;
  const FileSystemAssetMoveDialog(
      {Key? key, this.duplicate = false, required this.asset})
      : super(key: key);

  @override
  State<FileSystemAssetMoveDialog> createState() =>
      _FileSystemAssetMoveDialogState();
}

class _FileSystemAssetMoveDialogState extends State<FileSystemAssetMoveDialog> {
  final TextEditingController _nameController = TextEditingController();
  late String selectedPath;
  final _fileSystem = DocumentFileSystem.fromPlatform();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.asset.fileName;
    selectedPath = widget.asset.parent;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        actions: [
          TextButton(
            child: Text(AppLocalizations.of(context)!.cancel),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text(AppLocalizations.of(context)!.ok),
            onPressed: () async {
              var newPath = selectedPath;
              if (selectedPath != '/') {
                newPath += '/';
              }
              newPath += _nameController.text;
              if (widget.duplicate) {
                await _fileSystem.duplicateAsset(widget.asset.path, newPath);
              } else {
                await _fileSystem.moveAsset(widget.asset.path, newPath);
              }
              Navigator.of(context).pop(newPath);
            },
          ),
        ],
        title: Text(widget.duplicate
            ? AppLocalizations.of(context)!.duplicate
            : AppLocalizations.of(context)!.move),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 500, maxHeight: 400),
                child: SingleChildScrollView(
                    child: FileSystemDirectoryTreeView(
                        path: '/',
                        onPathSelected: (path) => selectedPath = path,
                        initialExpanded: true))),
            TextField(
              decoration: InputDecoration(
                  filled: true, hintText: AppLocalizations.of(context)!.name),
              autofocus: true,
              controller: _nameController,
            ),
          ],
        ));
  }
}
