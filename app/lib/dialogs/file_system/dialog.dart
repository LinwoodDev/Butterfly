import 'dart:async';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/file_system/create.dart';
import 'package:butterfly/dialogs/file_system/grid.dart';
import 'package:butterfly/dialogs/file_system/list.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/widgets/header.dart';
import 'package:butterfly/widgets/remote_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

typedef AssetOpenedCallback = void Function(AppDocumentAsset path);

class FileSystemDialog extends StatefulWidget {
  final DocumentBloc bloc;

  const FileSystemDialog({super.key, required this.bloc});

  @override
  _FileSystemDialogState createState() => _FileSystemDialogState();
}

class _FileSystemDialogState extends State<FileSystemDialog> {
  bool gridView = true;
  late DocumentFileSystem _fileSystem;
  final TextEditingController _pathController =
      TextEditingController(text: '/');
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _fileSystem =
        context.read<SettingsCubit>().state.getDefaultDocumentFileSystem();
    super.initState();
  }

  Future<List<AppDocumentAsset>> _loadDocuments() async {
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
              element.pathWithLeadingSlash
                  .substring(element.pathWithLeadingSlash.lastIndexOf('/') + 1)
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()) ||
              (element is AppDocumentFile
                  ? element.name
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase())
                  : false))
          .toList();
    }
    return documents;
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
                      onPressed: () => setState(() {}),
                      icon: const Icon(PhosphorIcons.arrowClockwiseLight),
                    ),
                    IconButton(
                        icon: Icon(gridView
                            ? PhosphorIcons.listLight
                            : PhosphorIcons.gridFourLight),
                        onPressed: () => setState(() => gridView = !gridView)),
                    IconButton(
                      tooltip: AppLocalizations.of(context)!.create,
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
                          RemoteButton(
                            currentRemote: _fileSystem.remote?.identifier ?? '',
                            onChanged: (value) {
                              _pathController.text = '/';
                              _fileSystem = DocumentFileSystem.fromPlatform(
                                  remote: value);
                              setState(() {});
                            },
                          ),
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
                                  setState(() {});
                                }
                              }
                            },
                          ),
                        ],
                      );
                      var searchInput = Row(children: [
                        Flexible(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: 300),
                            child: Padding(
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
                                  setState(() {});
                                },
                                controller: _searchController,
                              ),
                            ),
                          ),
                        ),
                      ]);
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
                        child: FutureBuilder<List<AppDocumentAsset>>(
                            future: _loadDocuments(),
                            builder: (context, snapshot) {
                              return BlocBuilder<DocumentBloc, DocumentState>(
                                  bloc: widget.bloc,
                                  builder: (context, state) {
                                    var selectedPath = '';
                                    if (state is DocumentLoadSuccess) {
                                      selectedPath = state.location.path;
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Align(
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    if (snapshot.hasError) {
                                      return ListView(children: [
                                        Text(
                                          AppLocalizations.of(context)!.error,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        Text(
                                          snapshot.error.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ]);
                                    }
                                    final assets = snapshot.data ?? [];
                                    void onRefreshed() {
                                      setState(() {});
                                    }

                                    return gridView
                                        ? FileSystemGridView(
                                            selectedPath: selectedPath,
                                            assets: assets,
                                            fileSystem: _fileSystem,
                                            onOpened: _openAsset,
                                            onRefreshed: onRefreshed,
                                          )
                                        : FileSystemListView(
                                            selectedPath: selectedPath,
                                            assets: assets,
                                            fileSystem: _fileSystem,
                                            onOpened: _openAsset,
                                            onRefreshed: onRefreshed,
                                          );
                                  });
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
        builder: (context) => FileSystemAssetCreateDialog(
            isFolder: isFolder, path: path, fileSystem: _fileSystem)) as bool?;
    if (success ?? false) {
      setState(() {});
    }
  }

  void _openAsset(AppDocumentAsset asset) {
    if (asset is AppDocumentFile) {
      final remote = _fileSystem.remote;
      if (remote != null) {
        GoRouter.of(context).push(
            '/remote/${Uri.encodeComponent(remote.identifier)}/${Uri.encodeComponent(asset.pathWithoutLeadingSlash)}');
      } else {
        GoRouter.of(context).push(
            '/local/${Uri.encodeComponent(asset.pathWithoutLeadingSlash)}');
      }
    } else {
      _pathController.text = asset.pathWithoutLeadingSlash;
      setState(() {});
    }
  }
}
