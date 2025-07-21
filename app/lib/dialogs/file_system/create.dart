import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/l10n/leap_localizations.dart';

class FileSystemAssetCreateDialog extends StatefulWidget {
  final bool isFolder;
  final String path;
  final DocumentFileSystem fileSystem;

  const FileSystemAssetCreateDialog({
    super.key,
    this.isFolder = false,
    this.path = '',
    required this.fileSystem,
  });

  @override
  State<FileSystemAssetCreateDialog> createState() =>
      _FileSystemAssetCreateDialogState();
}

class _FileSystemAssetCreateDialogState
    extends State<FileSystemAssetCreateDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(LeapLocalizations.of(context).create),
        content: TextFormField(
          decoration: InputDecoration(
            filled: true,
            labelText: LeapLocalizations.of(context).name,
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return LeapLocalizations.of(context).shouldNotEmpty;
            }
            return null;
          },
          controller: _nameController,
          autofocus: true,
        ),
        actions: [
          TextButton(
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text(LeapLocalizations.of(context).create),
            onPressed: () async {
              final navigator = Navigator.of(context);
              if (_formKey.currentState?.validate() ?? false) {
                final newPath = '${widget.path}/${_nameController.text}';
                if (!widget.isFolder) {
                  await widget.fileSystem.createFile(
                    newPath,
                    DocumentDefaults.createDocument().toFile(),
                  );
                } else {
                  await widget.fileSystem.createDirectory(newPath);
                }
              }
              navigator.pop(true);
            },
          ),
        ],
      ),
    );
  }
}
