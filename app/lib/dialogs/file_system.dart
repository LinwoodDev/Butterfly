import 'dart:async';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FileSystemDialog extends StatefulWidget {
  final DocumentBloc bloc;

  const FileSystemDialog({Key? key, required this.bloc}) : super(key: key);

  @override
  _FileSystemDialogState createState() => _FileSystemDialogState();
}

class _FileSystemDialogState extends State<FileSystemDialog> {
  List<AppDocumentAsset> _documents = [];
  bool gridView = true;
  late DocumentFileSystem _fileSystem;
  final TextEditingController _pathController =
      TextEditingController(text: '/');
  final GlobalKey<FormState> _createFormKey = GlobalKey();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _fileSystem = DocumentFileSystem.fromPlatform();
    loadDocuments();
    super.initState();
  }

  Future<void> loadDocuments() async {
    var documents = await _fileSystem
        .getAsset(_pathController.text)
        .then<List<AppDocumentAsset>>((value) => (value is AppDocumentDirectory
            ? value.assets
            : value is AppDocumentFile
                ? [value]
                : []));
    // Filter by _searchController.text
    if (_searchController.text.isNotEmpty) {
      documents = documents
          .where((element) =>
              element.path
                  .substring(element.path.lastIndexOf('/') + 1)
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()) ||
              (element is AppDocumentFile
                  ? element.name
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase())
                  : false))
          .toList();
    }
    if (mounted) {
      setState(() => _documents = documents);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 800),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.open),
                leading: IconButton(
                  icon: const Icon(PhosphorIcons.xLight),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                actions: [
                  IconButton(
                    onPressed: () => loadDocuments(),
                    icon: const Icon(PhosphorIcons.arrowClockwiseLight),
                  ),
                  IconButton(
                      icon: Icon(gridView
                          ? PhosphorIcons.listLight
                          : PhosphorIcons.gridFourLight),
                      onPressed: () => setState(() => gridView = !gridView)),
                ]),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LayoutBuilder(builder: (context, constraints) {
                  var isMobile = constraints.maxWidth < 600;
                  var pathInput = Row(
                    children: [
                      IconButton(
                          icon: const Icon(PhosphorIcons.houseLight),
                          onPressed: () {
                            _pathController.text = '/';
                            loadDocuments();
                          }),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            onSubmitted: (value) async {
                              _openAsset(await _fileSystem.getAsset(value) ??
                                  await _fileSystem.getRootDirectory());
                            },
                            controller: _pathController,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(PhosphorIcons.arrowUpLight),
                        onPressed: () {
                          var path = _pathController.text;
                          if (path.isNotEmpty && path != '/') {
                            var index = path.lastIndexOf('/');
                            if (index != -1) {
                              _pathController.text = path.substring(0, index);
                              if (_pathController.text.isEmpty) {
                                _pathController.text = '/';
                              }
                              loadDocuments();
                            }
                          }
                        },
                      ),
                    ],
                  );
                  var searchInput = Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        filled: true,
                        prefixIcon: Icon(PhosphorIcons.magnifyingGlassLight),
                      ),
                      onChanged: (value) {
                        loadDocuments();
                      },
                      controller: _searchController,
                    ),
                  );
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              pathInput,
                              searchInput,
                            ],
                          )
                        : SizedBox(
                            height: 50,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Flexible(
                                    flex: 5,
                                    child: pathInput,
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: searchInput,
                                  ),
                                ]),
                          ),
                  );
                }),
                const Divider(),
                Flexible(
                    child: BlocBuilder<DocumentBloc, DocumentState>(
                        bloc: widget.bloc,
                        builder: (context, state) {
                          var selectedPath = '';
                          if (state is DocumentLoadSuccess) {
                            selectedPath = state.path ?? '';
                          }
                          return gridView
                              ? _buildGridView(selectedPath)
                              : _buildListView(selectedPath);
                        })),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              label: Text(AppLocalizations.of(context)!.create),
              icon: const Icon(PhosphorIcons.plusLight),
              onPressed: () async {
                await showModalBottomSheet<ThemeMode>(
                    context: context,
                    builder: (context) {
                      return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListView(shrinkWrap: true, children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: Text(
                                AppLocalizations.of(context)!.create,
                                style: Theme.of(context).textTheme.headline5,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ListTile(
                                title: Text(AppLocalizations.of(context)!.file),
                                leading: const Icon(PhosphorIcons.fileLight),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _createAsset();
                                }),
                            ListTile(
                                title:
                                    Text(AppLocalizations.of(context)!.folder),
                                leading: const Icon(PhosphorIcons.folderLight),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _createAsset(isFolder: true);
                                }),
                            const SizedBox(height: 32),
                          ]));
                    });
              },
            ),
          ),
        ),
      ),
    );
  }

  void _createAsset({bool isFolder = false}) {
    var _nameController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => Form(
              key: _createFormKey,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: Text(AppLocalizations.of(context)!.create),
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
                    child: Text(AppLocalizations.of(context)!.create),
                    onPressed: () async {
                      if (_createFormKey.currentState?.validate() ?? false) {
                        {
                          var path = _pathController.text;
                          if (path == '/') {
                            path = '';
                          }
                          if (!isFolder) {
                            await _fileSystem.createDocument(
                                _nameController.text,
                                path: path,
                                palettes:
                                    ColorPalette.getMaterialPalette(context));
                          } else {
                            await _fileSystem.createDirectory(
                                path + '/' + _nameController.text);
                          }
                        }
                        loadDocuments();
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ));
  }

  Widget _buildListView(String selectedPath) => ListView.builder(
        itemCount: _documents.length,
        itemBuilder: (context, index) {
          var document = _documents[index];
          if (document is AppDocumentFile) {
            return ListTile(
              leading: const Icon(PhosphorIcons.fileLight),
              title: Text(document.name),
              selected: document.path == selectedPath,
              subtitle: _buildRichText(document),
              onTap: () => _openAsset(document),
              trailing: _buildPopupMenu(document),
            );
          } else if (document is AppDocumentDirectory) {
            return ListTile(
              selected: document.path == selectedPath,
              leading: const Icon(PhosphorIcons.folderLight),
              title: Text(document.fileName),
              onTap: () => _openAsset(document),
              trailing: _buildPopupMenu(document),
            );
          } else {
            return Container();
          }
        },
      );

  void _openAsset(AppDocumentAsset asset) {
    if (asset is AppDocumentFile) {
      Navigator.of(context).pop(asset.path);
    } else {
      _pathController.text = asset.path;
      loadDocuments();
    }
  }

  void _renameDialog(String path) {
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
                    if (_nameController.text != _pathController.text) {
                      var document = await _fileSystem.renameAsset(
                          path, _nameController.text);
                      var state = widget.bloc.state as DocumentLoadSuccess;
                      if (document != null && state.path == path) {
                        widget.bloc.clearHistory();
                        widget.bloc.emit(state.copyWith(path: path));
                      }
                      loadDocuments();
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  void _deleteDialog(String path) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.areYouSure),
            content: Text(AppLocalizations.of(context)!.reallyDelete),
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.no),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.yes),
                onPressed: () {
                  _fileSystem.deleteAsset(path);
                  loadDocuments();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));

  Widget _buildGridView(String selectedPath) => SingleChildScrollView(
          child: Scrollbar(
        child: Align(
            alignment: Alignment.topCenter,
            child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List.generate(_documents.length, (index) {
                  var document = _documents[index];
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
                              child: _buildRichText(document)),
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
                              onTap: () => _openAsset(document),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(child: child),
                                    _buildPopupMenu(document)
                                  ]))));
                }))),
      ));

  Widget _buildPopupMenu(AppDocumentAsset asset) => IconTheme.merge(
        data: Theme.of(context).iconTheme,
        child: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(PhosphorIcons.folderOpenLight),
                title: Text(AppLocalizations.of(context)!.open),
                onTap: () {
                  Navigator.of(context).pop();
                  _openAsset(asset);
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
                    await showDialog(
                        context: context,
                        builder: (context) {
                          var selectedPath = '/';
                          return AlertDialog(
                              actions: [
                                TextButton(
                                  child: Text(
                                      AppLocalizations.of(context)!.cancel),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                TextButton(
                                  child: Text(AppLocalizations.of(context)!.ok),
                                  onPressed: () async {
                                    var newPath = selectedPath;
                                    if (selectedPath != '/') {
                                      newPath += '/';
                                    }
                                    newPath += asset.fileName;
                                    await _fileSystem.duplicateAsset(
                                        asset.path, newPath);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                              title:
                                  Text(AppLocalizations.of(context)!.duplicate),
                              content: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxWidth: 500, maxHeight: 400),
                                  child: SingleChildScrollView(
                                      child: _FolderTreeView(
                                          path: '/',
                                          onPathSelected: (path) =>
                                              selectedPath = path,
                                          initialExpanded: true))));
                        });
                    loadDocuments();
                  }),
              padding: EdgeInsets.zero,
            ),
            PopupMenuItem(
              child: ListTile(
                  leading: const Icon(PhosphorIcons.arrowsOutCardinalLight),
                  title: Text(AppLocalizations.of(context)!.move),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await showDialog(
                        context: context,
                        builder: (context) {
                          var selectedPath = '/';
                          return AlertDialog(
                              actions: [
                                TextButton(
                                  child: Text(
                                      AppLocalizations.of(context)!.cancel),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                TextButton(
                                  child: Text(AppLocalizations.of(context)!.ok),
                                  onPressed: () async {
                                    var newPath = selectedPath;
                                    if (selectedPath != '/') {
                                      newPath += '/';
                                    }
                                    newPath += asset.fileName;
                                    await _fileSystem.moveAsset(
                                        asset.path, newPath);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                              title: Text(AppLocalizations.of(context)!.move),
                              content: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxWidth: 500, maxHeight: 400),
                                  child: SingleChildScrollView(
                                      child: _FolderTreeView(
                                          path: '/',
                                          onPathSelected: (path) =>
                                              selectedPath = path,
                                          initialExpanded: true))));
                        });
                    loadDocuments();
                  }),
              padding: EdgeInsets.zero,
            ),
            PopupMenuItem(
              child: ListTile(
                  leading: const Icon(PhosphorIcons.textTLight),
                  title: Text(AppLocalizations.of(context)!.rename),
                  onTap: () {
                    Navigator.of(context).pop();
                    _renameDialog(asset.path);
                  }),
              padding: EdgeInsets.zero,
            ),
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(PhosphorIcons.trashLight),
                title: Text(AppLocalizations.of(context)!.delete),
                onTap: () {
                  Navigator.of(context).pop();
                  _deleteDialog(asset.path);
                },
              ),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      );

  Widget _buildRichText(AppDocumentFile file) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(file.path),
          if (file.createdAt != null)
            Text(AppLocalizations.of(context)!.createdAt(file.createdAt!)),
          if (file.updatedAt != null)
            Text(AppLocalizations.of(context)!.updatedAt(file.updatedAt!)),
        ]);
  }
}

typedef PathSelectedCallback = void Function(String path);

class _FolderTreeView extends StatefulWidget {
  final String path, selectedPath;
  final PathSelectedCallback onPathSelected;
  final bool initialExpanded;

  const _FolderTreeView(
      {Key? key,
      required this.path,
      required this.onPathSelected,
      this.initialExpanded = false,
      this.selectedPath = '/'})
      : super(key: key);

  @override
  _FolderTreeViewState createState() => _FolderTreeViewState();
}

class _FolderTreeViewState extends State<_FolderTreeView> {
  late DocumentFileSystem _fileSystem;
  bool _expanded = false;
  late Future<AppDocumentDirectory> _directoryFuture;
  String _selected = '/';

  @override
  void initState() {
    super.initState();
    _fileSystem = DocumentFileSystem.fromPlatform();
    _expanded = widget.initialExpanded;
    _selected = widget.selectedPath;
    _directoryFuture = load();
  }

  Future<AppDocumentDirectory> load() {
    return _fileSystem
        .getAsset(widget.path)
        .then((value) => value as AppDocumentDirectory);
  }

  @override
  void didUpdateWidget(covariant _FolderTreeView oldWidget) {
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
          if (snapshot.hasData) {
            var directory = snapshot.data!;
            var children = directory.assets.whereType<AppDocumentDirectory>();
            var name = directory.path.split('/').last;
            if (name.isEmpty) {
              name = '/';
            }
            return Column(children: [
              ListTile(
                leading: _expanded
                    ? const Icon(PhosphorIcons.folderOpenLight)
                    : const Icon(PhosphorIcons.folderLight),
                title: Text(name),
                trailing: _selected == widget.path
                    ? const Icon(PhosphorIcons.check)
                    : null,
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
                    widget.onPathSelected(directory.path);
                  }
                },
                selected: _selected == widget.path,
              ),
              if (_expanded)
                Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Column(
                      children: List.generate(
                        children.length,
                        (index) {
                          var current = children.elementAt(index);
                          return _FolderTreeView(
                              path: current.path,
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
}
