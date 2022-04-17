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
    final fileSystem = DocumentFileSystem.fromPlatform();
    final fileName = path.split('/').last;
    final parent = path.substring(0, path.length - fileName.length - 1);
    final nameController = TextEditingController(
        text: fileName.substring(0, fileName.length - '.bfly'.length));
    final bloc = context.read<DocumentBloc>();
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
                controller: nameController,
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
                    Navigator.of(context).pop();
                    if (nameController.text != selectedPath) {
                      var document = await fileSystem.renameAsset(
                          path, '$parent/${nameController.text}.bfly');
                      var state = bloc.state;
                      if (state is! DocumentLoadSuccess) return;
                      if (document != null && state.path == path) {
                        bloc.clearHistory();
                        bloc.emit(state.copyWith(path: path));
                      }
                      onRefreshed();
                    }
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
            padding: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(PhosphorIcons.folderOpenLight),
              title: Text(AppLocalizations.of(context)!.open),
              onTap: () {
                Navigator.of(context).pop();
                onOpened(asset);
              },
            ),
          ),
          PopupMenuItem(
            padding: EdgeInsets.zero,
            child: ListTile(
                leading: const Icon(PhosphorIcons.copyLight),
                title: Text(AppLocalizations.of(context)!.duplicate),
                onTap: () async {
                  Navigator.of(context).pop();
                  var newPath = await showDialog(
                    context: context,
                    builder: (context) => FileSystemAssetMoveDialog(
                        asset: asset, duplicate: true),
                  ) as String?;
                  if (newPath == null) return;
                  onRefreshed();
                }),
          ),
          PopupMenuItem(
            padding: EdgeInsets.zero,
            child: ListTile(
                leading: const Icon(PhosphorIcons.arrowsOutCardinalLight),
                title: Text(AppLocalizations.of(context)!.move),
                onTap: () async {
                  final bloc = context.read<DocumentBloc>();
                  Navigator.of(context).pop();
                  final newPath = await showDialog(
                    context: context,
                    builder: (context) =>
                        FileSystemAssetMoveDialog(asset: asset),
                  ) as String?;
                  if (newPath == null) return;
                  onRefreshed();
                  // Change path if current document is moved
                  var state = bloc.state;
                  if (state is! DocumentLoadSuccess) return;
                  if (state.path == asset.path) {
                    bloc.clearHistory();
                    bloc.emit(state.copyWith(path: newPath));
                  }
                }),
          ),
          PopupMenuItem(
            padding: EdgeInsets.zero,
            child: ListTile(
                leading: const Icon(PhosphorIcons.textTLight),
                title: Text(AppLocalizations.of(context)!.rename),
                onTap: () {
                  Navigator.of(context).pop();
                  _showRenameDialog(context, asset.path);
                }),
          ),
          PopupMenuItem(
            padding: EdgeInsets.zero,
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
          ),
        ],
      ),
    );
  }
}
