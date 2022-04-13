import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/elements/general.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../models/element.dart';
import '../painters/label.dart';

class LabelElementDialog extends StatelessWidget {
  final LabelRenderer renderer;
  final VoidCallback close;
  final Offset position;

  const LabelElementDialog(
      {Key? key,
      required this.renderer,
      required this.close,
      required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<DocumentBloc>();
    return GeneralElementDialog(
      renderer: renderer,
      close: close,
      position: position,
      children: [
        ListTile(
            title: Text(AppLocalizations.of(context)!.edit),
            leading: const Icon(PhosphorIcons.textTLight),
            onTap: () async {
              close();
              var newElement = await showDialog(
                  context: context,
                  builder: (_) => BlocProvider.value(
                      value: bloc,
                      child:
                          EditLabelElementDialog(element: renderer.element)));
              if (newElement != null) {
                bloc.add(ElementChanged(renderer.element, newElement));
              }
            }),
      ],
    );
  }
}

class EditLabelElementDialog extends StatelessWidget {
  final LabelElement element;
  final TextEditingController _textController = TextEditingController();
  EditLabelElementDialog({Key? key, this.element = const LabelElement()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var property = element.property;
    _textController.text = element.text;
    void submit() => Navigator.of(context)
        .pop(element.copyWith(text: _textController.text, property: property));
    return Dialog(
        child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 500),
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(PhosphorIcons.textTLight),
          title: Text(AppLocalizations.of(context)!.enterText),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Expanded(
                child: ListView(shrinkWrap: true, children: [
              TextField(
                controller: _textController,
                autofocus: true,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(filled: true),
                onSubmitted: (value) => submit(),
              ),
              LabelPropertyView(
                initialValue: property,
                onChanged: (value) => property = value,
              ),
            ])),
            const Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                  onPressed: submit,
                  child: Text(AppLocalizations.of(context)!.ok))
            ])
          ]),
        ),
      ),
    ));
  }
}
