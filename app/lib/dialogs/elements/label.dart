import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/elements/general.dart';
import 'package:butterfly/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../models/element.dart';
import '../../selections/selection.dart';
import '../../widgets/context_menu.dart';
import '../constraints.dart';

class LabelElementDialog extends StatelessWidget {
  final int index;
  final ContextCloseFunction close;
  final Offset position;

  const LabelElementDialog(
      {super.key,
      required this.index,
      required this.close,
      required this.position});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<DocumentBloc>();
    return GeneralElementDialog<LabelElement>(
      index: index,
      close: close,
      position: position,
      builder: (context, renderer, onChanged) => [
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
                onChanged(newElement);
              }
            }),
        ListTile(
          title: Text(AppLocalizations.of(context)!.constraints),
          leading: const Icon(PhosphorIcons.selectionLight),
          onTap: () async {
            await close();
            showContextMenu(
                context: context,
                position: position,
                builder: (context, close) => ConstraintContextMenu(
                    initialConstraint: renderer.element.constraint,
                    close: close,
                    onChanged: (constraint) {
                      close();
                      onChanged(
                          renderer.element.copyWith(constraint: constraint));
                    }));
          },
        ),
      ],
    );
  }
}

class EditLabelElementDialog extends StatelessWidget {
  final LabelElement element;
  final TextEditingController _textController = TextEditingController();
  EditLabelElementDialog({super.key, this.element = const LabelElement()});

  @override
  Widget build(BuildContext context) {
    var property = element.property;
    _textController.text = element.text;
    void submit() => Navigator.of(context)
        .pop(element.copyWith(text: _textController.text, property: property));
    return Dialog(
        child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 500),
      child: Column(
        children: [
          Header(
            leading: const Icon(PhosphorIcons.textTLight),
            title: Text(AppLocalizations.of(context)!.enterText),
          ),
          Flexible(
            child: Padding(
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
                  ElevatedButton(
                      onPressed: submit,
                      child: Text(AppLocalizations.of(context)!.ok))
                ])
              ]),
            ),
          ),
        ],
      ),
    ));
  }
}
