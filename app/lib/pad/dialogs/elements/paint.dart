import 'package:butterfly/models/elements/paint.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PaintElementDialog extends StatelessWidget {
  final int index;
  final DocumentBloc bloc;
  const PaintElementDialog({Key? key, required this.index, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<DocumentBloc, DocumentState>(
        builder: (context, state) {
          if (state is! DocumentLoadSuccess) return Container();
          if (state.document.content.length <= index) return Container();
          var element = state.document.content[index] as PaintElement;
          return SizedBox(
            height: 300,
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                  child: Center(child: Icon(PhosphorIcons.penLight, size: 36)),
                ),
                const Divider(thickness: 1),
                Expanded(
                    child: ListView(children: [
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
