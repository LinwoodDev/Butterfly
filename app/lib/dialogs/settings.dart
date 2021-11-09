import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PadSettingsDialog extends StatefulWidget {
  final DocumentBloc? bloc;

  const PadSettingsDialog({Key? key, this.bloc}) : super(key: key);
  @override
  _PadSettingsDialogState createState() => _PadSettingsDialogState();
}

class _PadSettingsDialogState extends State<PadSettingsDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    _nameController.text =
        (widget.bloc!.state as DocumentLoadSuccess).document.name;
    _descriptionController.text =
        (widget.bloc!.state as DocumentLoadSuccess).document.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Dialog(
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                      title:
                          Text(AppLocalizations.of(context)!.projectSettings),
                      leading: const Icon(PhosphorIcons.wrenchLight)),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(children: [
                            TextFormField(
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return AppLocalizations.of(context)!
                                        .shouldNotEmpty;
                                  }
                                  return null;
                                },
                                controller: _nameController,
                                decoration: InputDecoration(
                                    labelText:
                                        AppLocalizations.of(context)!.name,
                                    filled: true)),
                            const SizedBox(height: 20),
                            TextField(
                                minLines: 3,
                                maxLines: 5,
                                controller: _descriptionController,
                                decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!
                                        .description,
                                    border: const OutlineInputBorder())),
                          ]),
                        ),
                        //const Icon(Icons.directions_transit)
                      ),
                      const Divider(),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(AppLocalizations.of(context)!.cancel)),
                        ElevatedButton(
                            onPressed: () {
                              if (!(_formKey.currentState?.validate() ??
                                  false)) {
                                return;
                              }
                              widget.bloc!.add(DocumentDescriptorChanged(
                                  name: _nameController.text,
                                  description: _descriptionController.text));
                              Navigator.of(context).pop();
                            },
                            child: Text(AppLocalizations.of(context)!.ok))
                      ])
                    ]),
                  )))),
    );
  }
}
