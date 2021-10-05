import 'package:butterfly/models/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<AppDocument> _documents;

  @override
  void initState() {
    _documents = const [
      AppDocument(name: "Document 0", description: "abc..."),
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
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(PhosphorIcons.plusLight),
          label: const Text("New"),
          onPressed: () {},
        ));
  }
}
