import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editing.dart';
import 'package:butterfly/dialogs/group.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GeneralElementDialog extends StatelessWidget {
  final int index;
  final VoidCallback close;
  final List<Widget> children;

  const GeneralElementDialog(
      {Key? key,
      this.children = const [],
      required this.index,
      required this.close})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      var bloc = context.read<DocumentBloc>();
      var editingCubit = context.read<EditingCubit>();
      var element = (state as DocumentLoadSuccess).document.content[index];
      return Column(mainAxisSize: MainAxisSize.min, children: [
        generateHeader(element),
        const Divider(),
        Flexible(
            child: ListView(
          shrinkWrap: true,
          children: [
            ...children,
            if (children.isNotEmpty) const Divider(),
            element.layer.isEmpty
                ? ListTile(
                    title: Text(AppLocalizations.of(context)!.layer),
                    leading: const Icon(PhosphorIcons.squaresFourLight),
                    subtitle: Text(AppLocalizations.of(context)!.notSet),
                    onTap: () {
                      close();
                      var _nameController =
                          TextEditingController(text: element.layer);
                      showDialog(
                          context: context,
                          useRootNavigator: true,
                          builder: (context) => AlertDialog(
                                title: Text(
                                    AppLocalizations.of(context)!.enterLayer),
                                content: TextField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText:
                                          AppLocalizations.of(context)!.layer),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text(
                                        AppLocalizations.of(context)!.cancel),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  TextButton(
                                    child:
                                        Text(AppLocalizations.of(context)!.ok),
                                    onPressed: () {
                                      bloc.add(LayerChanged(
                                          index,
                                          element.copyWith(
                                              layer: _nameController.text)));
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));
                    })
                : ListTile(
                    leading: const Icon(PhosphorIcons.squaresFourLight),
                    title: Text(element.layer),
                    trailing: IconButton(
                      icon: const Icon(PhosphorIcons.trashLight),
                      onPressed: () => bloc.add(
                          LayerChanged(index, element.copyWith(layer: ''))),
                    ),
                    onTap: () {
                      close();
                      showDialog(
                          context: context,
                          builder: (context) =>
                              GroupDialog(groupId: element.layer));
                    }),
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
                              title: Text(
                                  AppLocalizations.of(context)!.areYouSure),
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
                                  child:
                                      Text(AppLocalizations.of(context)!.yes),
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
    });
  }

  Widget generateHeader(PadElement element) {
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
