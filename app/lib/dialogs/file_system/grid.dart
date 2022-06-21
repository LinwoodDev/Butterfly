import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/dialogs/file_system/dialog.dart';
import 'package:butterfly/dialogs/file_system/menu.dart';
import 'package:butterfly/models/document.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FileSystemGridView extends StatelessWidget {
  final String selectedPath;
  final List<AppDocumentAsset> assets;
  final AssetOpenedCallback onOpened;
  final VoidCallback onRefreshed;
  final DocumentFileSystem fileSystem;
  const FileSystemGridView(
      {super.key,
      required this.assets,
      required this.selectedPath,
      required this.onOpened,
      required this.onRefreshed,
      required this.fileSystem});

  @override
  Widget build(BuildContext context) {
    final files = assets.whereType<AppDocumentFile>().toList();
    final directories = assets.whereType<AppDocumentDirectory>().toList();
    return SingleChildScrollView(
        child: Scrollbar(
      child: Column(children: [
        Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(directories.length, (index) {
              final directory = directories[index];
              return ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          onTap: () => onOpened(directory),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        PhosphorIcons.folderLight,
                                        size: 32,
                                      ),
                                    ),
                                    Expanded(
                                      child: Tooltip(
                                        message: directory.path,
                                        child: Text(directory.fileName,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6),
                                      ),
                                    ),
                                    FileSystemAssetMenu(
                                      selectedPath: selectedPath,
                                      asset: directory,
                                      onOpened: onOpened,
                                      onRefreshed: onRefreshed,
                                      fileSystem: fileSystem,
                                    )
                                  ]),
                                ],
                              )))));
            })),
        Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(files.length, (index) {
              final file = files[index];
              return ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          onTap: () => onOpened(file),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      PhosphorIcons.fileLight,
                                      size: 32,
                                    ),
                                  ),
                                  Expanded(
                                    child: Tooltip(
                                      message: file.path,
                                      child: Text(file.fileNameWithoutExtension,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              ?.copyWith(
                                                  color:
                                                      selectedPath == file.path
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .primary
                                                          : null)),
                                    ),
                                  ),
                                  FileSystemAssetMenu(
                                      fileSystem: fileSystem,
                                      selectedPath: selectedPath,
                                      asset: file,
                                      onOpened: onOpened,
                                      onRefreshed: onRefreshed)
                                ]),
                                Text(file.name,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.subtitle2),
                                Text(file.description,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.labelSmall),
                              ],
                            ),
                          ))));
            })),
      ]),
    ));
  }
}
