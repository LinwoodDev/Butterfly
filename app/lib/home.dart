import 'dart:async';
import 'dart:convert';

import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/palette.dart';
import 'package:butterfly/pad/dialogs/open.dart';
import 'package:butterfly/pad/dialogs/save.dart';
import 'package:butterfly/settings/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AppDocument> _documents = [];
  bool gridView = true;
  final GlobalKey<FormState> _createFormKey = GlobalKey();

  @override
  void initState() {
    loadDocuments();
    super.initState();
  }

  Future<void> loadDocuments() {
    return SharedPreferences.getInstance().then<void>((prefs) async {
      var loaded = await Future.wait(
          List<String>.from(prefs.getStringList("documents") ?? [])
              .map<Future<AppDocument>>((e) async {
        var data = jsonDecode(e);
        var fileVersion = data["fileVersion"] is int?
            ? data["fileVersion"]
            : int.tryParse(data["fileVersion"]) ?? -1;
        if (fileVersion > GetIt.I.get<int>(instanceName: "fileVersion")) {
          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                      title: Text(AppLocalizations.of(context)!.whatToDo),
                      content: Text(AppLocalizations.of(context)!
                          .createdInNewerVersion(
                              data["name"], data["fileVersion"])),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(AppLocalizations.of(context)!.ignore)),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context,
                                  builder: (context) => SaveDialog(data: e));
                            },
                            child: Text(AppLocalizations.of(context)!.backup)),
                      ]));
        }
        return AppDocument.fromJson(data);
      }).toList());
      saveDocuments();
      setState(() => _documents = loaded);
    });
  }

  Future<void> saveDocuments() {
    return SharedPreferences.getInstance().then((prefs) => prefs.setStringList(
        "documents", _documents.map((e) => jsonEncode(e.toJson())).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Butterfly"), actions: [
        IconButton(
            icon: Icon(gridView
                ? PhosphorIcons.listLight
                : PhosphorIcons.gridFourLight),
            onPressed: () => setState(() => gridView = !gridView)),
        IconButton(
          icon: const Icon(PhosphorIcons.folderOpenLight),
          tooltip: AppLocalizations.of(context)!.open,
          onPressed: () {
            showDialog(
                    builder: (context) => const OpenDialog(), context: context)
                .then((content) {
              if (content == null) return;
              setState(() {
                _documents.add(AppDocument.fromJson(jsonDecode(content)));
                saveDocuments();
              });
            });
          },
        ),
        IconButton(
            icon: const Icon(PhosphorIcons.gearLight),
            tooltip: AppLocalizations.of(context)?.settings,
            onPressed: () => showDialog(
                context: context,
                builder: (context) => Dialog(
                    child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxHeight: 400, maxWidth: 600),
                        child: const SettingsPage(isDialog: true)))))
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
                          onPressed: () {
                            if (_createFormKey.currentState?.validate() ??
                                false) {
                              setState(() => _documents.add(AppDocument(
                                  name: _nameController.text,
                                  palettes: ColorPalette.getMaterialPalette(
                                      context))));
                              saveDocuments();
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    ),
                  ));
        },
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
              onTap: () => _openDocument(index),
              trailing: IconButton(
                icon: const Icon(PhosphorIcons.trashLight),
                onPressed: () => _deleteDialog(index),
              ));
        },
      );

  void _openDocument(int index) =>
      Modular.to.pushNamed("/pad/$index").then((value) {
        if (mounted) loadDocuments();
      });
  void _deleteDialog(int index) => showDialog(
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
                  setState(() => _documents.removeAt(index));
                  saveDocuments();
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
                              onTap: () => _openDocument(index),
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
                              onPressed: () => _deleteDialog(index))
                        ],
                      ),
                    );
                  })))));
}
