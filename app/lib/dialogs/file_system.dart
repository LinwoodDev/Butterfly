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
  List<AppDocumentFile> _documents = [];
  bool gridView = true;
  late DocumentFileSystem _fileSystem;
  final GlobalKey<FormState> _createFormKey = GlobalKey();

  @override
  void initState() {
    _fileSystem = DocumentFileSystem.fromPlatform();
    loadDocuments();
    super.initState();
  }

  Future<void> loadDocuments() async {
    var documents = await _fileSystem.getDocuments();
    setState(() => _documents = documents);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
          child: Scaffold(
            appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.open),
                leading: const Icon(PhosphorIcons.folderLight),
                actions: [
                  IconButton(
                      icon: Icon(gridView
                          ? PhosphorIcons.listLight
                          : PhosphorIcons.gridFourLight),
                      onPressed: () => setState(() => gridView = !gridView)),
                ]),
            body: gridView ? _buildGridView() : _buildListView(),
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
                                onPressed: () {
                                  if (_createFormKey.currentState?.validate() ??
                                      false) {
                                    _fileSystem.createDocument(
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
          return ListTile(
              title: Text(document.name),
              subtitle: Text(document.description),
              onTap: () => _openDocument(document.path),
              trailing: IconButton(
                icon: const Icon(PhosphorIcons.trashLight),
                onPressed: () => _deleteDialog(document.path),
              ));
        },
      );

  void _openDocument(String path) => Navigator.of(context).pop(path);

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
                  _fileSystem.deleteDocument(path);
                  loadDocuments();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));

  Widget _buildGridView() => SingleChildScrollView(
      child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 100, maxWidth: 1000),
              child: Wrap(
                  alignment: WrapAlignment.center,
                  children: List.generate(_documents.length, (index) {
                    var document = _documents[index];
                    return Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          InkWell(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              onTap: () => _openDocument(document.path),
                              child: Container(
                                  width: 300,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Column(children: [
                                    Text(document.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    Text(document.description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline)
                                  ]))),
                          IconButton(
                              icon: const Icon(PhosphorIcons.trashLight),
                              onPressed: () => _deleteDialog(document.path))
                        ],
                      ),
                    );
                  })))));
}
