import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PadSettingsDialog extends StatefulWidget {
  final DocumentBloc? bloc;

  const PadSettingsDialog({Key? key, this.bloc}) : super(key: key);
  @override
  _PadSettingsDialogState createState() => _PadSettingsDialogState();
}

class _PadSettingsDialogState extends State<PadSettingsDialog> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    _nameController.text = (widget.bloc!.state as DocumentLoadSuccess).document.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: DefaultTabController(
            length: 2,
            child: Container(
                constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
                child: Column(children: [
                  const TabBar(
                    tabs: [
                      Tab(icon: Icon(PhosphorIcons.fadersLight), text: "General"),
                      Tab(icon: Icon(PhosphorIcons.packageLight), text: "Packs")
                    ],
                  ),
                  Expanded(
                      child: TabBarView(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(labelText: "Name"))
                      ]),
                    ),
                    const Icon(Icons.directions_transit)
                  ])),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        ElevatedButton(
                            onPressed: () {
                              widget.bloc!.add(DocumentNameChanged(_nameController.text));
                              Navigator.of(context).pop();
                            },
                            child: Text("Ok", style: Theme.of(context).primaryTextTheme.button))
                      ]))
                ]))));
  }
}
