import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../api/file_system.dart';

typedef PathSelectedCallback = void Function(String path);

class FileSystemDirectoryTreeView extends StatefulWidget {
  final String path, selectedPath;
  final PathSelectedCallback onPathSelected;
  final bool initialExpanded;
  final DocumentFileSystem fileSystem;

  const FileSystemDirectoryTreeView(
      {super.key,
      required this.path,
      required this.onPathSelected,
      required this.fileSystem,
      this.initialExpanded = false,
      this.selectedPath = '/'});

  @override
  FileSystemDirectoryTreeViewState createState() =>
      FileSystemDirectoryTreeViewState();
}

class FileSystemDirectoryTreeViewState
    extends State<FileSystemDirectoryTreeView> {
  bool _expanded = false;
  late Future<AppDocumentDirectory> _directoryFuture;
  String _selected = '/';

  @override
  void initState() {
    super.initState();
    _expanded = widget.initialExpanded;
    _selected = widget.selectedPath;
    _directoryFuture = load();
  }

  Future<AppDocumentDirectory> load() {
    return widget.fileSystem
        .getAsset(widget.path)
        .then((value) => value as AppDocumentDirectory);
  }

  @override
  void didUpdateWidget(covariant FileSystemDirectoryTreeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) {
      setState(() => _directoryFuture = load());
    }
    if (oldWidget.selectedPath != widget.selectedPath) {
      setState(() => _selected = widget.selectedPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppDocumentDirectory>(
        future: _directoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            var directory = snapshot.data!;
            var children = directory.assets.whereType<AppDocumentDirectory>();
            var name = directory.pathWithLeadingSlash.split('/').last;
            if (name.isEmpty) {
              name = '/';
            }
            return Column(mainAxisSize: MainAxisSize.min, children: [
              ListTile(
                leading: _expanded
                    ? const PhosphorIcon(PhosphorIconsLight.folderOpen)
                    : const PhosphorIcon(PhosphorIconsLight.folder),
                title: Text(name),
                trailing: IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.folderPlus),
                  onPressed: _newFolder,
                ),
                onTap: () {
                  if (_selected == widget.path) {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  } else {
                    setState(() {
                      _expanded = true;
                      _selected = widget.path;
                    });
                    widget.onPathSelected(directory.pathWithLeadingSlash);
                  }
                },
                selected: _selected == widget.path,
              ),
              if (_expanded)
                Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        children.length,
                        (index) {
                          var current = children.elementAt(index);
                          return FileSystemDirectoryTreeView(
                              fileSystem: widget.fileSystem,
                              path: current.pathWithLeadingSlash,
                              selectedPath: _selected,
                              onPathSelected: (value) {
                                setState(() {
                                  _selected = value;
                                  _expanded = true;
                                });
                                widget.onPathSelected(value);
                              });
                        },
                      ),
                    ))
            ]);
          }
          return Container();
        });
  }

  Future<void> _newFolder() async {
    final TextEditingController controller = TextEditingController();
    final success = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context).newFolder),
                content: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: AppLocalizations.of(context).name,
                  ),
                  controller: controller,
                  onSubmitted: (value) {
                    Navigator.of(context).pop(true);
                  },
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(AppLocalizations.of(context).cancel)),
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(AppLocalizations.of(context).create))
                ],
              );
            }) ??
        false;
    if (!success) {
      return;
    }
    final name = controller.text;
    if (name.isEmpty) {
      return;
    }
    final path = widget.path.endsWith('/')
        ? '${widget.path}$name'
        : '${widget.path}/$name';
    await widget.fileSystem.createDirectory(path);
    setState(() {
      _directoryFuture = load();
    });
  }
}
