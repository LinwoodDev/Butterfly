import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editing.dart';
import 'package:butterfly/cubits/selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GeneralElementDialog extends StatelessWidget {
  final int index;
  final DocumentBloc bloc;
  final SelectionCubit selectionCubit;
  final EditingCubit editingCubit;
  final VoidCallback close;
  final List<Widget> children;

  const GeneralElementDialog(
      {Key? key,
      this.children = const [],
      required this.index,
      required this.bloc,
      required this.selectionCubit,
      required this.editingCubit,
      required this.close})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var element = (bloc.state as DocumentLoadSuccess).document.content[index];
    return Column(mainAxisSize: MainAxisSize.min, children: [
      generateHeader(),
      const Divider(),
      Flexible(
          child: ListView(
        shrinkWrap: true,
        children: [
          ...children,
          if (children.isNotEmpty) const Divider(),
          ListTile(
            title: Text(AppLocalizations.of(context)!.move),
            leading: const Icon(PhosphorIcons.arrowsOutCardinalLight),
            onTap: () {
              // Remove the element from the document
              bloc.add(LayersRemoved([element]));
              editingCubit.move(element);
              close();
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.duplicate),
            leading: const Icon(PhosphorIcons.copyLight),
            onTap: () {
              editingCubit.move(element);
              close();
            },
          ),
          ListTile(
              onTap: () {
                close();
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                            title:
                                Text(AppLocalizations.of(context)!.areYouSure),
                            content: Text(
                                AppLocalizations.of(context)!.reallyDelete),
                            actions: [
                              TextButton(
                                child: Text(AppLocalizations.of(context)!.no),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: Text(AppLocalizations.of(context)!.yes),
                                onPressed: () {
                                  Navigator.pop(context);
                                  bloc.add(LayersRemoved([element]));
                                },
                              ),
                            ]));
              },
              title: Text(AppLocalizations.of(context)!.delete),
              leading: const Icon(PhosphorIcons.trashLight))
        ],
      ))
    ]);
  }

  Widget generateHeader() {
    var element = (bloc.state as DocumentLoadSuccess).document.content[index];
    IconData icon;
    switch (element.toJson()['type']) {
      case 'label':
        icon = PhosphorIcons.textTLight;
        break;
      case 'image':
        icon = PhosphorIcons.imageLight;
        break;
      case 'eraser':
        icon = PhosphorIcons.eraserLight;
        break;
      default:
        icon = PhosphorIcons.penLight;
        break;
    }

    return SizedBox(
      height: 50,
      child: Center(child: Icon(icon, size: 36)),
    );
  }
}
