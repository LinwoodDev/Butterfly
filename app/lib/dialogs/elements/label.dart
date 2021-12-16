import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editing.dart';
import 'package:butterfly/cubits/selection.dart';
import 'package:butterfly/dialogs/elements/general.dart';
import 'package:butterfly/models/elements/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LabelElementDialog extends StatelessWidget {
  final int index;
  final DocumentBloc bloc;
  final VoidCallback onClose;
  final SelectionCubit selectionCubit;
  final EditingCubit editingCubit;

  const LabelElementDialog(
      {Key? key,
      required this.index,
      required this.bloc,
      required this.onClose,
      required this.selectionCubit,
      required this.editingCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var element = (bloc.state as DocumentLoadSuccess).document.content[index]
        as LabelElement;
    return GeneralElementDialog(
      index: index,
      onClose: onClose,
      selectionCubit: selectionCubit,
      editingCubit: editingCubit,
      bloc: bloc,
      children: [
        ListTile(
            title: Text(AppLocalizations.of(context)!.edit),
            leading: const Icon(PhosphorIcons.textTLight),
            onTap: () {
              var _textController = TextEditingController(text: element.text);
              void submit() {
                onClose();
                var layer = element.copyWith(text: _textController.text);
                bloc.add(LayerChanged(index, layer));
                selectionCubit.change(layer);
              }

              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                          title: Text(AppLocalizations.of(context)!.enterText),
                          content: TextField(
                            controller: _textController,
                            autofocus: true,
                            keyboardType: TextInputType.multiline,
                            minLines: 3,
                            maxLines: 5,
                            onSubmitted: (text) => submit(),
                          ),
                          actions: [
                            TextButton(
                              child: Text(AppLocalizations.of(context)!.cancel),
                              onPressed: () => onClose(),
                            ),
                            TextButton(
                                child: Text(AppLocalizations.of(context)!.ok),
                                onPressed: submit)
                          ]));
            }),
      ],
    );
  }
}
