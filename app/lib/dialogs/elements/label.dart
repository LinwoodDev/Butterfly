import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/elements/general.dart';
import 'package:butterfly/models/elements/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabelElementDialog extends StatelessWidget {
  final int index;
  final VoidCallback close;

  const LabelElementDialog({Key? key, required this.index, required this.close})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<DocumentBloc>();
    var element = (bloc.state as DocumentLoadSuccess).document.content[index]
        as LabelElement;
    return GeneralElementDialog(
      index: index,
      close: close,
      children: [
        ListTile(
            title: Text(AppLocalizations.of(context)!.edit),
            leading: const Icon(PhosphorIcons.textTLight),
            onTap: () {
              close();
              var _textController = TextEditingController(text: element.text);

              showDialog(
                  context: context,
                  builder: (context) {
                    void submit() {
                      Navigator.of(context).pop();
                      var layer = element.copyWith(text: _textController.text);
                      bloc.add(LayerChanged(index, layer));
                    }

                    return AlertDialog(
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
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                              child: Text(AppLocalizations.of(context)!.ok),
                              onPressed: submit)
                        ]);
                  });
            }),
      ],
    );
  }
}
