import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/dialogs/file_system/delete.dart';
import 'package:butterfly/dialogs/file_system/move.dart';
import 'package:butterfly/models/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/document_bloc.dart';
import 'dialog.dart';

class FileSystemAssetMenu extends StatelessWidget {
  final AssetOpenedCallback onOpened;
  final VoidCallback onRefreshed;
  final AppDocumentAsset asset;
  final String selectedPath;

  const FileSystemAssetMenu(
      {Key? key,
      required this.selectedPath,
      required this.asset,
      required this.onOpened,
      required this.onRefreshed})
      : super(key: key);

  void _showRenameDialog(BuildContext context, String path) {
    var fileSystem = DocumentFileSystem.fromPlatform();
    var _nameController = TextEditingController(text: path);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.rename),
              content: TextFormField(
                decoration: InputDecoration(
                    filled: true,
                    labelText: AppLocalizations.of(context)!.name),
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
                TextButton(
                  child: Text(AppLocalizations.of(context)!.rename),
                  onPressed: () async {
                    if (_nameController.text != selectedPath) {
                      var document = await fileSystem.renameAsset(
                          path, _nameController.text);
                      var bloc = context.read<DocumentBloc>();
                      var state = bloc.state;
                      if (state is! DocumentLoadSuccess) return;
                      if (document != null && state.path == path) {
                        bloc.clearHistory();
                        bloc.emit(state.copyWith(path: path));
                      }
                      onRefreshed();
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme.merge(
      data: Theme.of(context).iconTheme,
      child: PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: ListTile(
              leading: const Icon(PhosphorIcons.folderOpenLight),
              title: Text(AppLocalizations.of(context)!.open),
              onTap: () {
                Navigator.of(context).pop();
                onOpened(asset);
              },
            ),
            padding: EdgeInsets.zero,
          ),
          PopupMenuItem(
            child: ListTile(
                leading: const Icon(PhosphorIcons.copyLight),
                title: Text(AppLocalizations.of(context)!.duplicate),
                onTap: () async {
                  Navigator.of(context).pop();
                  var newPath = await showDialog(
                    context: context,
                    builder: (context) => FileSystemAssetMoveDialog(
                        asset: asset, duplicate: true),
                  );
                  if (newPath != null) onRefreshed();
                }),
            padding: EdgeInsets.zero,
          ),
          PopupMenuItem(
            child: ListTile(
                leading: const Icon(PhosphorIcons.arrowsOutCardinalLight),
                title: Text(AppLocalizations.of(context)!.move),
                onTap: () async {
                  Navigator.of(context).pop();
                  var success = await showDialog(
                    context: context,
                    builder: (context) =>
                        FileSystemAssetMoveDialog(asset: asset),
                  );
                  if (success ?? false) onRefreshed();
                }),
            padding: EdgeInsets.zero,
          ),
          PopupMenuItem(
            child: ListTile(
                leading: const Icon(PhosphorIcons.textTLight),
                title: Text(AppLocalizations.of(context)!.rename),
                onTap: () {
                  Navigator.of(context).pop();
                  _showRenameDialog(context, asset.path);
                }),
            padding: EdgeInsets.zero,
          ),
          PopupMenuItem(
            child: ListTile(
              leading: const Icon(PhosphorIcons.trashLight),
              title: Text(AppLocalizations.of(context)!.delete),
              onTap: () async {
                Navigator.of(context).pop();
                var success = await showDialog(
                    context: context,
                    builder: (context) =>
                        FileSystemAssetDeleteDialog(path: asset.path)) as bool?;
                if (success ?? false) {
                  onRefreshed();
                }
              },
            ),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
