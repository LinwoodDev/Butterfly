import 'package:butterfly/dialogs/file_system/dialog.dart';
import 'package:butterfly/dialogs/file_system/menu.dart';
import 'package:butterfly/dialogs/file_system/rich_text.dart';
import 'package:butterfly/models/document.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FileSystemGridView extends StatelessWidget {
  final String selectedPath;
  final List<AppDocumentAsset> assets;
  final AssetOpenedCallback onOpened;
  final VoidCallback onRefreshed;
  const FileSystemGridView(
      {Key? key,
      required this.assets,
      required this.selectedPath,
      required this.onOpened,
      required this.onRefreshed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Scrollbar(
      child: Align(
          alignment: Alignment.topCenter,
          child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(assets.length, (index) {
                var document = assets[index];
                Widget child;
                if (document is! AppDocumentFile) {
                  child = Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              PhosphorIcons.folderLight,
                              size: 32,
                            ),
                          ),
                          Flexible(
                            child: Text(document.fileName,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline6),
                          ),
                        ])),
                  ]);
                } else {
                  child = Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                PhosphorIcons.fileLight,
                                size: 32,
                                color: document.path == selectedPath
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                              ),
                            ),
                            Flexible(
                              child: Text(document.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                          color: selectedPath == document.path
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : null)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DefaultTextStyle(
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: Theme.of(context)
                                        .listTileTheme
                                        .textColor),
                            child: FileSystemFileRichText(file: document)),
                      ),
                    ],
                  );
                }
                return ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 300, maxWidth: 300),
                    child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        margin: const EdgeInsets.all(5),
                        child: InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            onTap: () => onOpened(document),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(child: child),
                                  FileSystemAssetMenu(
                                    asset: document,
                                    onOpened: onOpened,
                                    onRefreshed: onRefreshed,
                                    selectedPath: selectedPath,
                                  )
                                ]))));
              }))),
    ));
  }
}
