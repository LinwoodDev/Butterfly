import 'dart:async';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/file_system/create.dart';
import 'package:butterfly/dialogs/file_system/grid.dart';
import 'package:butterfly/dialogs/file_system/list.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

typedef AssetOpenedCallback = void Function(AppDocumentAsset path);

class FileSystemDialog extends StatefulWidget {
  final DocumentBloc bloc;

  const FileSystemDialog({super.key, required this.bloc});

  @override
  _FileSystemDialogState createState() => _FileSystemDialogState();
}

class _FileSystemDialogState extends State<FileSystemDialog> {
  List<AppDocumentAsset> _documents = [];
  bool gridView = true;
  late DocumentFileSystem _fileSystem;
  final TextEditingController _pathController =
      TextEditingController(text: '/');
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
          child: Column(
            children: [
              Header(
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
                    TextButton.icon(
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    ListTile(
                                        title: Text(
                                            AppLocalizations.of(context)!.file),
                                        leading:
                                            const Icon(PhosphorIcons.fileLight),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _createAsset();
                                        }),
                                    ListTile(
                                        title: Text(
                                            AppLocalizations.of(context)!
                                                .folder),
                                        leading: const Icon(
                                            PhosphorIcons.folderLight),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _createAsset(isFolder: true);
                                        }),
                                    const SizedBox(height: 32),
                                  ]));
                            });
                      },
                    ),
                  ]),
              Flexible(
                child: Column(
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
                                  _openAsset(
                                      await _fileSystem.getAsset(value) ??
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
                                  _pathController.text =
                                      path.substring(0, index);
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            filled: true,
                            prefixIcon:
                                Icon(PhosphorIcons.magnifyingGlassLight),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
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
                                  ? FileSystemGridView(
                                      selectedPath: selectedPath,
                                      assets: _documents,
                                      onOpened: _openAsset,
                                      onRefreshed: loadDocuments,
                                    )
                                  : FileSystemListView(
                                      selectedPath: selectedPath,
                                      assets: _documents,
                                      onOpened: _openAsset,
                                      onRefreshed: loadDocuments,
                                    );
                            })),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createAsset({bool isFolder = false}) async {
    var path = _pathController.text;
    if (path == '/') {
      path = '';
    }
    var success = await showDialog(
            context: context,
            builder: (context) =>
                FileSystemAssetCreateDialog(isFolder: isFolder, path: path))
        as bool?;
    if (success ?? false) {
      loadDocuments();
    }
  }

  void _openAsset(AppDocumentAsset asset) {
    if (asset is AppDocumentFile) {
      Navigator.of(context).pop(asset.path);
    } else {
      _pathController.text = asset.path;
      loadDocuments();
    }
  }
}
