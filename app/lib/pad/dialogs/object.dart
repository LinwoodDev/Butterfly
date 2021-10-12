import 'package:butterfly/models/elements/eraser.dart';
import 'package:butterfly/models/elements/label.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ObjectDialog extends StatelessWidget {
  final int index;
  final DocumentBloc bloc;
  const ObjectDialog({Key? key, required this.index, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<DocumentBloc, DocumentState>(
        builder: (context, state) {
          if (state is! DocumentLoadSuccess) return Container();
          IconData icon;
          if (state.document.content.length <= index) return Container();
          var element = state.document.content[index];
          if (element is LabelElement) {
            icon = PhosphorIcons.textTLight;
          } else if (element is EraserElement) {
            icon = PhosphorIcons.eraserLight;
          } else {
            icon = PhosphorIcons.penLight;
          }
          return SizedBox(
            height: 300,
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                  child: Center(child: Icon(icon, size: 36)),
                ),
                const Divider(thickness: 1),
                Expanded(
                    child: ListView(children: [
                  if (element is LabelElement)
                    ListTile(
                        title: Text(AppLocalizations.of(context)!.edit),
                        leading: const Icon(PhosphorIcons.textTLight),
                        onTap: () {
                          var _textController = TextEditingController(text: element.text);
                          void submit() {
                            Navigator.of(context).pop();
                            bloc.add(
                                LayerChanged(index, element.copyWith(text: _textController.text)));
                          }

                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                      title: Text(AppLocalizations.of(context)!.enterText),
                                      content: TextField(
                                        controller: _textController,
                                        autofocus: true,
                                        onSubmitted: (text) => submit(),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text(
                                              AppLocalizations.of(context)!.cancel.toUpperCase()),
                                          onPressed: () => Navigator.of(context).pop(),
                                        ),
                                        TextButton(
                                            child: Text(
                                                AppLocalizations.of(context)!.ok.toUpperCase()),
                                            onPressed: submit)
                                      ]));
                        }),
                  ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                    title: Text(AppLocalizations.of(context)!.areYouSure),
                                    content: Text(AppLocalizations.of(context)!.reallyDelete),
                                    actions: [
                                      TextButton(
                                        child: Text(AppLocalizations.of(context)!.no.toUpperCase()),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child:
                                            Text(AppLocalizations.of(context)!.yes.toUpperCase()),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          bloc.add(LayersRemoved([element]));
                                        },
                                      ),
                                    ]));
                      },
                      title: Text(AppLocalizations.of(context)!.delete),
                      leading: const Icon(PhosphorIcons.trashLight))
                ])),
              ],
            ),
          );
        },
      ),
    );
  }
}
