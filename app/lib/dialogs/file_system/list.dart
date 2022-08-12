import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/dialogs/file_system/dialog.dart';
import 'package:butterfly/dialogs/file_system/menu.dart';
import 'package:butterfly/dialogs/file_system/rich_text.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/visualizer/asset.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FileSystemListView extends StatelessWidget {
  final AssetLocation? selectedPath;
  final List<AppDocumentAsset> assets;
  final AssetOpenedCallback onOpened;
  final VoidCallback onRefreshed;
  final DocumentFileSystem fileSystem;
  const FileSystemListView(
      {super.key,
      required this.assets,
      required this.selectedPath,
      required this.onOpened,
      required this.onRefreshed,
      required this.fileSystem});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: assets.length,
      itemBuilder: (context, index) {
        var document = assets[index];
        if (document is AppDocumentFile) {
          return ListTile(
            leading: Icon(document.fileType.getIcon()),
            title: Text(document.name),
            selected: document.location == selectedPath,
            subtitle: FileSystemFileRichText(
              file: document,
            ),
            onTap: () => onOpened(document),
            trailing: FileSystemAssetMenu(
                fileSystem: fileSystem,
                asset: document,
                selectedPath: selectedPath,
                onOpened: onOpened,
                onRefreshed: onRefreshed),
          );
        } else if (document is AppDocumentDirectory) {
          return ListTile(
            selected: document.location == selectedPath,
            leading: const Icon(PhosphorIcons.folderLight),
            title: Text(document.fileNameWithoutExtension),
            onTap: () => onOpened(document),
            trailing: FileSystemAssetMenu(
              fileSystem: fileSystem,
              asset: document,
              selectedPath: selectedPath,
              onOpened: onOpened,
              onRefreshed: onRefreshed,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
