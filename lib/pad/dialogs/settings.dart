import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

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
    _nameController.text = (widget.bloc!.state as DocumentLoadSuccess).document.name!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: DefaultTabController(
            length: 2,
            child: Container(
                constraints: BoxConstraints(maxWidth: 600, maxHeight: 800),
                child: Column(children: [
                  TabBar(
                    tabs: [
                      Tab(icon: Icon(Mdi.tune), text: "General"),
                      Tab(icon: Icon(Mdi.packageVariantClosed), text: "Packs")
                    ],
                  ),
                  Expanded(
                      child: Container(
                          child: TabBarView(children: [
                    Column(children: [
                      TextField(
                          controller: _nameController,
                          decoration: InputDecoration(labelText: "Name"))
                    ]),
                    Icon(Icons.directions_transit)
                  ]))),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        RaisedButton(
                            onPressed: () {
                              widget.bloc!.add(DocumentNameChanged(_nameController.text));
                              Navigator.of(context).pop();
                            },
                            child: Text("Ok", style: Theme.of(context).primaryTextTheme.button),
                            color: Theme.of(context).primaryColor)
                      ]))
                ]))));
  }
}
