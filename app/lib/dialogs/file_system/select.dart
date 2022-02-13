import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../api/file_system.dart';
import '../../models/document.dart';
import 'tree.dart';

class FileSystemMoveDialog extends StatefulWidget {
  final bool duplicate;
  final AppDocumentAsset asset;
  const FileSystemMoveDialog(
      {Key? key, this.duplicate = false, required this.asset})
      : super(key: key);

  @override
  State<FileSystemMoveDialog> createState() => _FileSystemMoveDialogState();
}

class _FileSystemMoveDialogState extends State<FileSystemMoveDialog> {
  final TextEditingController _nameController = TextEditingController();
  late String selectedPath;
  final _fileSystem = DocumentFileSystem.fromPlatform();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.asset.fileName;
    selectedPath = widget.asset.directory;
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
              newPath += widget.asset.fileName;
              if (widget.duplicate) {
                await _fileSystem.duplicateAsset(widget.asset.path, newPath);
              } else {
                await _fileSystem.moveAsset(widget.asset.path, newPath);
              }
              Navigator.of(context).pop();
            },
          ),
        ],
        title: Text(AppLocalizations.of(context)!.move),
        content: Column(
          children: [
            Expanded(
              child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: 500, maxHeight: 400),
                  child: SingleChildScrollView(
                      child: FileSystemDirectoryTreeView(
                          path: '/',
                          onPathSelected: (path) => selectedPath = path,
                          initialExpanded: true))),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.name,
              ),
              controller: _nameController,
            ),
          ],
        ));
  }
}
