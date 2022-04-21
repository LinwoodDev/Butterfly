import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/header.dart';

class PadSettingsDialog extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  PadSettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.read<DocumentBloc>().state as DocumentLoadSuccess;
    _nameController.text = state.document.name;
    _descriptionController.text = state.document.description;
    return Form(
      key: _formKey,
      child: Dialog(
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600, maxHeight: 500),
              child: Column(
                children: [
                  Header(
                      title:
                          Text(AppLocalizations.of(context)!.projectSettings),
                      leading: const Icon(PhosphorIcons.wrenchLight)),
                  Flexible(
                    child: Padding(
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(
                                      AppLocalizations.of(context)!.cancel)),
                              ElevatedButton(
                                  onPressed: () {
                                    if (!(_formKey.currentState?.validate() ??
                                        false)) {
                                      return;
                                    }
                                    context.read<DocumentBloc>().add(
                                        DocumentDescriptorChanged(
                                            name: _nameController.text,
                                            description:
                                                _descriptionController.text));
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(AppLocalizations.of(context)!.ok))
                            ])
                      ]),
                    ),
                  ),
                ],
              ))),
    );
  }
}
