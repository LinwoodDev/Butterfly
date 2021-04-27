import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/project/folder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<AppDocument> _documents;

  @override
  void initState() {
    _documents = [
      AppDocument(name: "Document 0", description: "abc...")
        ..addFile(FolderProjectItem(name: "Folder 1"))
        ..addFile(FolderProjectItem(name: "Folder 2"))
        ..addFile(FolderProjectItem(name: "Folder 3"))
        ..addFile(FolderProjectItem(name: "Folder 4"))
        ..addFile(FolderProjectItem(name: "Folder 5"))
        ..addFile(FolderProjectItem(name: "Folder 6"))
        ..addFile(FolderProjectItem(name: "Folder 7"))
        ..addFile(FolderProjectItem(name: "Folder 9"))
        ..addFile(FolderProjectItem(name: "Folder 9")),
      AppDocument(name: "Document 1", description: "abc..."),
      AppDocument(name: "Document 1", description: "abc..."),
      AppDocument(name: "Document 1", description: "abc..."),
      AppDocument(name: "Document 1", description: "abc..."),
      AppDocument(name: "Document 1", description: "abc..."),
      AppDocument(name: "Document 1", description: "abc..."),
      AppDocument(name: "Document 1", description: "abc..."),
      AppDocument(name: "Document 1", description: "abc..."),
      AppDocument(name: "Document 1", description: "abc..."),
      AppDocument(name: "Document 1", description: "abc..."),
      AppDocument(name: "Document 1", description: "abc..."),
      AppDocument(name: "Document 1", description: "abc..."),
      AppDocument(name: "Document 1", description: "abc..."),
      AppDocument(name: "Document 2", description: "def...")
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Butterfly")),
        body: SizedBox.expand(
            child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 100, maxWidth: 1000),
                    child: Container(
                        child: Wrap(
                            alignment: WrapAlignment.center,
                            children: List.generate(_documents.length, (index) {
                              var document = _documents[index];
                              return Card(
                                  margin: EdgeInsets.all(5),
                                  child: InkWell(
                                      onTap: () => Modular.to.pushNamed("/pad/$index"),
                                      child: Padding(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          child: Column(children: [
                                            Text(document.name,
                                                style: Theme.of(context).textTheme.headline6),
                                            Text(document.description,
                                                style: Theme.of(context).textTheme.overline)
                                          ]))));
                            })))))),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(MdiIcons.plus),
          label: Text("New"),
          onPressed: () {},
        ));
  }
}
