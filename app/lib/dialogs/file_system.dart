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

  @override
  void initState() {
    _fileSystem = DocumentFileSystem.fromPlatform();
    loadDocuments();
    super.initState();
  }

  Future<void> loadDocuments() async {
    var documents = await _fileSystem
        .getAsset(_pathController.text)
        .then<List<AppDocumentAsset>>((value) => value is AppDocumentDirectory
            ? value.assets
            : value is AppDocumentFile
                ? [value]
                : []);
    setState(() => _documents = documents);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 800),
          child: Scaffold(
            appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.open),
                leading: IconButton(
                  icon: const Icon(PhosphorIcons.xLight),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                actions: [
                  IconButton(
                      icon: Icon(gridView
                          ? PhosphorIcons.listLight
                          : PhosphorIcons.gridFourLight),
                      onPressed: () => setState(() => gridView = !gridView)),
                ]),
            body: Column(
              children: [
                Material(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(children: [
                      IconButton(
                          icon: const Icon(PhosphorIcons.houseLight),
                          onPressed: () {
                            _pathController.text = '/';
                            loadDocuments();
                          }),
                      IconButton(
                        icon: const Icon(PhosphorIcons.arrowUpLight),
                        onPressed: () {
                          var path = _pathController.text;
                          if (path.isNotEmpty && path != '/') {
                            var index = path.lastIndexOf('/');
                            if (index != -1) {
                              _pathController.text = path.substring(0, index);
                              loadDocuments();
                            }
                          }
                        },
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: _pathController,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Flexible(child: gridView ? _buildGridView() : _buildListView()),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              label: Text(AppLocalizations.of(context)!.create),
              icon: const Icon(PhosphorIcons.plusLight),
              onPressed: () {
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
                                  labelText:
                                      AppLocalizations.of(context)!.name),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return AppLocalizations.of(context)!
                                      .shouldNotEmpty;
                                }
                                return null;
                              },
                              controller: _nameController,
                              autofocus: true,
                            ),
                            actions: [
                              TextButton(
                                child:
                                    Text(AppLocalizations.of(context)!.cancel),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              TextButton(
                                child:
                                    Text(AppLocalizations.of(context)!.create),
                                onPressed: () async {
                                  if (_createFormKey.currentState?.validate() ??
                                      false) {
                                    await _fileSystem.createDocument(
                                        _nameController.text,
                                        palettes:
                                            ColorPalette.getMaterialPalette(
                                                context));
                                    loadDocuments();
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ],
                          ),
                        ));
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView() => ListView.builder(
        itemCount: _documents.length,
        itemBuilder: (context, index) {
          var document = _documents[index];
          if (document is AppDocumentFile) {
            return ListTile(
              leading: const Icon(PhosphorIcons.fileLight),
              title: Text(document.name),
              subtitle: _buildRichText(document),
              onTap: () => _openAsset(document),
              trailing: _buildPopupMenu(document),
            );
          } else if (document is AppDocumentDirectory) {
            return ListTile(
              leading: const Icon(PhosphorIcons.folderLight),
              title: Text(_pathController.text.split('/').last),
              onTap: () => _openAsset(document),
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
      _pathController.text = '/' + asset.path;
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
                          _pathController.text, _nameController.text);
                      var state = widget.bloc.state as DocumentLoadSuccess;
                      if (document != null &&
                          state.path == _pathController.text) {
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

  Widget _buildGridView() => SingleChildScrollView(
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
                                PhosphorIcons.fileLight,
                                size: 32,
                              ),
                            ),
                            Flexible(
                              child: Text(document.path.split('/').last,
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
                              const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  PhosphorIcons.fileLight,
                                  size: 32,
                                ),
                              ),
                              Flexible(
                                child: Text(document.name,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildRichText(document),
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

  Widget _buildPopupMenu(AppDocumentAsset asset) => PopupMenuButton(
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
          if (asset is AppDocumentFile)
            PopupMenuItem(
              child: ListTile(
                  leading: const Icon(PhosphorIcons.copyLight),
                  title: Text(AppLocalizations.of(context)!.duplicate),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await _fileSystem.importDocument(asset.load());
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
      );

  RichText _buildRichText(AppDocumentFile file) => RichText(
        text: TextSpan(
            text: file.description,
            style: Theme.of(context).textTheme.caption,
            children: [
              const TextSpan(
                text: '\n',
              ),
              TextSpan(
                text: file.path,
              ),
              const TextSpan(
                text: '\n',
              ),
              if (file.updatedAt != null)
                TextSpan(
                  text:
                      AppLocalizations.of(context)!.updatedAt(file.updatedAt!),
                ),
              if (file.createdAt != null) ...[
                const TextSpan(
                  text: '\n',
                ),
                TextSpan(
                  text:
                      AppLocalizations.of(context)!.createdAt(file.createdAt!),
                ),
              ]
            ]),
      );
}
