import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PadSettingsDialog extends StatefulWidget {
  final DocumentBloc? bloc;

  const PadSettingsDialog({Key? key, this.bloc}) : super(key: key);
  @override
  _PadSettingsDialogState createState() => _PadSettingsDialogState();
}

class _PadSettingsDialogState extends State<PadSettingsDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _nameController.text = (widget.bloc!.state as DocumentLoadSuccess).document.name;
    _descriptionController.text = (widget.bloc!.state as DocumentLoadSuccess).document.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: DefaultTabController(
            length: 1,
            child: Container(
                constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
                child: Column(children: [
                  TabBar(
                    tabs: [
                      Tab(
                          icon: const Icon(PhosphorIcons.fadersLight),
                          text: AppLocalizations.of(context)!.general),
                      //Tab(icon: Icon(PhosphorIcons.packageLight), text: "Packs")
                    ],
                  ),
                  Expanded(
                      child: TabBarView(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        TextField(
                            controller: _nameController,
                            decoration:
                                InputDecoration(labelText: AppLocalizations.of(context)!.name)),
                        TextField(
                            minLines: 3,
                            maxLines: 5,
                            controller: _descriptionController,
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.description)),
                      ]),
                    ),
                    //const Icon(Icons.directions_transit)
                  ])),
                  const Divider(),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        ElevatedButton(
                            onPressed: () {
                              widget.bloc!.add(DocumentDescriptorChanged(
                                  name: _nameController.text,
                                  description: _descriptionController.text));
                              Navigator.of(context).pop();
                            },
                            child: Text(AppLocalizations.of(context)!.ok,
                                style: Theme.of(context).primaryTextTheme.button))
                      ]))
                ]))));
  }
}
