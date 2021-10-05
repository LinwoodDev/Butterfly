import 'dart:convert';

import 'package:butterfly/models/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AppDocument> _documents = [];

  @override
  void initState() {
    loadDocuments();
    super.initState();
  }

  Future<void> loadDocuments() {
    return SharedPreferences.getInstance().then((prefs) => setState(() => _documents =
        List<String>.from(prefs.getStringList("documents") ?? [])
            .map((e) => AppDocument.fromJson(jsonDecode(e)))
            .toList()));
  }

  Future<void> saveDocuments() {
    return SharedPreferences.getInstance().then((prefs) =>
        prefs.setStringList("documents", _documents.map((e) => jsonEncode(e.toJson())).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Butterfly"), actions: [
        IconButton(
            icon: const Icon(PhosphorIcons.gearLight),
            onPressed: () => Modular.to.pushNamed("/settings/"))
      ]),
      body: SingleChildScrollView(
          child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 100, maxWidth: 1000),
                  child: Wrap(
                      alignment: WrapAlignment.center,
                      children: List.generate(_documents.length, (index) {
                        var document = _documents[index];
                        return Card(
                            margin: const EdgeInsets.all(5),
                            child: InkWell(
                                onTap: () => Modular.to.pushNamed("/pad/$index"),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    child: Column(children: [
                                      Text(document.name,
                                          style: Theme.of(context).textTheme.headline6),
                                      Text(document.description,
                                          style: Theme.of(context).textTheme.overline)
                                    ]))));
                      }))))),
      floatingActionButton: FloatingActionButton(
        child: const Icon(PhosphorIcons.plusLight),
        onPressed: () {
          var _nameController = TextEditingController();
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Enter the name of the document"),
                    content: TextField(
                      controller: _nameController,
                    ),
                    actions: [
                      TextButton(
                        child: const Text("CANCEL"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: const Text("CREATE"),
                        onPressed: () {
                          setState(() => _documents.add(AppDocument(name: _nameController.text)));
                          saveDocuments();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));
        },
      ),
    );
  }
}
