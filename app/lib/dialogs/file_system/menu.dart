import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/file_system/delete.dart';
import 'package:butterfly/dialogs/file_system/move.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/document_bloc.dart';
import '../name.dart';
import 'dialog.dart';

class FileSystemAssetMenu extends StatelessWidget {
  final AssetOpenedCallback onOpened;
  final VoidCallback onRefreshed;
  final AppDocumentEntity asset;
  final DocumentFileSystem fileSystem;
  final AssetLocation? selectedPath;

  const FileSystemAssetMenu(
      {super.key,
      required this.selectedPath,
      required this.asset,
      required this.onOpened,
      required this.fileSystem,
      required this.onRefreshed});

  Future<void> _showRenameDialog(BuildContext context, String path) async {
    final fileName = path.split('/').last;
    final parent = path.substring(0, path.length - fileName.length - 1);
    final bloc = context.read<DocumentBloc>();
    final oldName = fileName.substring(0, fileName.length - '.bfly'.length);
    final name = await showDialog<String>(
      context: context,
      builder: (context) => NameDialog(
        value: oldName,
      ),
    );
    if (name == null) return;
    var document = await fileSystem.renameAsset(path, '$parent/$name.bfly');
    if (oldName != selectedPath?.pathWithLeadingSlash) {
      var state = bloc.state;
      if (state is! DocumentLoadSuccess) return;
      if (document != null && state.location.path == path) {
        state.currentIndexCubit.setSaveState(
            location: AssetLocation(remote: state.location.remote, path: path));
      }
      onRefreshed();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool? hasSynced;
    final settingsCubit = context.read<SettingsCubit>();
    final settings = settingsCubit.state;
    final remote = fileSystem.remote;
    if (!kIsWeb && remote != null) {
      final storage = settings.getRemote(remote.identifier);
      hasSynced = storage?.cachedDocuments.contains(asset.pathWithLeadingSlash);
      if (!(hasSynced ?? false) &&
          (storage?.hasDocumentCached(asset.pathWithLeadingSlash) ?? false)) {
        hasSynced = null;
      }
    }
    return IconTheme.merge(
      data: Theme.of(context).iconTheme,
      child: PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            padding: EdgeInsets.zero,
            child: ListTile(
              leading: PhosphorIcon(PhosphorIcons.light.folderOpen),
              title: Text(AppLocalizations.of(context).open),
              onTap: () {
                Navigator.of(context).pop();
                onOpened(asset);
              },
            ),
          ),
          if (!kIsWeb && remote != null)
            PopupMenuItem(
              padding: EdgeInsets.zero,
              child: ListTile(
                title: Text(hasSynced == null
                    ? AppLocalizations.of(context).folderSynced
                    : hasSynced
                        ? AppLocalizations.of(context).synced
                        : AppLocalizations.of(context).notSynced),
                leading: hasSynced == null
                    ? PhosphorIcon(PhosphorIcons.bold.cloud)
                    : hasSynced
                        ? PhosphorIcon(PhosphorIcons.fill.cloud)
                        : PhosphorIcon(PhosphorIcons.light.cloud),
                onTap: () {
                  Navigator.of(context).pop();
                  if (hasSynced == true) {
                    settingsCubit.removeCache(
                        remote.identifier, asset.pathWithLeadingSlash);
                  } else {
                    settingsCubit.addCache(
                        remote.identifier, asset.pathWithLeadingSlash);
                  }
                  onRefreshed();
                },
              ),
            ),
          PopupMenuItem(
            padding: EdgeInsets.zero,
            child: ListTile(
                leading: PhosphorIcon(PhosphorIcons.light.copy),
                title: Text(AppLocalizations.of(context).duplicate),
                onTap: () async {
                  Navigator.of(context).pop();
                  var newPath = await showDialog<String>(
                    context: context,
                    builder: (context) => FileSystemAssetMoveDialog(
                        fileSystem: fileSystem,
                        asset: asset,
                        moveMode: MoveMode.duplicate),
                  );
                  if (newPath == null) return;
                  onRefreshed();
                }),
          ),
          PopupMenuItem(
            padding: EdgeInsets.zero,
            child: ListTile(
                leading: PhosphorIcon(PhosphorIcons.light.arrowsOutCardinal),
                title: Text(AppLocalizations.of(context).move),
                onTap: () async {
                  final bloc = context.read<DocumentBloc>();
                  Navigator.of(context).pop();
                  final newPath = await showDialog<String>(
                    context: context,
                    builder: (context) => FileSystemAssetMoveDialog(
                        fileSystem: fileSystem,
                        asset: asset,
                        moveMode: MoveMode.move),
                  );
                  if (newPath == null) return;
                  onRefreshed();
                  // Change path if current document is moved
                  var state = bloc.state;
                  if (state is! DocumentLoadSuccess) return;
                  if (state.location.path == asset.pathWithLeadingSlash) {
                    state.currentIndexCubit.setSaveState(
                        location: AssetLocation(
                            remote: state.location.remote, path: newPath));
                  }
                }),
          ),
          PopupMenuItem(
            padding: EdgeInsets.zero,
            child: ListTile(
                leading: PhosphorIcon(PhosphorIcons.light.textT),
                title: Text(AppLocalizations.of(context).rename),
                onTap: () {
                  Navigator.of(context).pop();
                  _showRenameDialog(context, asset.pathWithLeadingSlash);
                }),
          ),
          PopupMenuItem(
            padding: EdgeInsets.zero,
            child: ListTile(
              leading: PhosphorIcon(PhosphorIcons.light.trash),
              title: Text(AppLocalizations.of(context).delete),
              onTap: () async {
                Navigator.of(context).pop();
                var success = await showDialog<bool>(
                    context: context,
                    builder: (context) => FileSystemAssetDeleteDialog(
                          path: asset.pathWithLeadingSlash,
                          fileSystem: fileSystem,
                        ));
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
