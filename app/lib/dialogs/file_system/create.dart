import 'package:butterfly/api/file_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/palette.dart';

class FileSystemAssetCreateDialog extends StatelessWidget {
  final bool isFolder;
  final String path;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _nameController = TextEditingController();
  final DocumentFileSystem fileSystem;

  FileSystemAssetCreateDialog(
      {super.key,
      this.isFolder = false,
      this.path = '',
      required this.fileSystem});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(AppLocalizations.of(context)!.create),
        content: TextFormField(
          decoration: InputDecoration(
              filled: true, labelText: AppLocalizations.of(context)!.name),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return AppLocalizations.of(context)!.shouldNotEmpty;
            }
            return null;
          },
          controller: _nameController,
          autofocus: true,
        ),
        actions: [
          TextButton(
            child: Text(AppLocalizations.of(context)!.cancel),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.create),
            onPressed: () async {
              final navigator = Navigator.of(context);
              if (_formKey.currentState?.validate() ?? false) {
                if (!isFolder) {
                  await fileSystem.createDocument(_nameController.text,
                      path: path,
                      palettes: ColorPalette.getMaterialPalette(context));
                } else {
                  await fileSystem
                      .createDirectory('$path/${_nameController.text}');
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
