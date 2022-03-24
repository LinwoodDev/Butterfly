import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editing.dart';
import 'package:butterfly/dialogs/area/context.dart';
import 'package:butterfly/dialogs/layer.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/transform.dart';
import '../../models/document.dart';
import '../../widgets/context_menu.dart';
import '../background/context.dart';

class GeneralElementDialog extends StatelessWidget {
  final int index;
  final VoidCallback close;
  final Offset position;
  final List<Widget> children;

  const GeneralElementDialog(
      {Key? key,
      this.children = const [],
      required this.position,
      required this.index,
      required this.close})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      var bloc = context.read<DocumentBloc>();
      var editingCubit = context.read<EditingCubit>();
      if (state is! DocumentLoadSuccess ||
          index < 0 ||
          index >= state.document.content.length) {
        return Container();
      }
      var element = state.document.content[index];
      return Column(mainAxisSize: MainAxisSize.min, children: [
        _GeneralElementDialogHeader(
            close: close,
            document: state.document,
            element: element,
            position: position),
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
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                      filled: true,
                                    )),
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
                                      bloc.add(ElementChanged(
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
                          ElementChanged(index, element.copyWith(layer: ''))),
                    ),
                    onTap: () {
                      close();
                      showDialog(
                          context: context,
                          builder: (context) => BlocProvider.value(
                              value: bloc,
                              child: LayerDialog(layer: element.layer)));
                    }),
            ListTile(
              title: Text(AppLocalizations.of(context)!.move),
              leading: const Icon(PhosphorIcons.arrowsOutCardinalLight),
              onTap: () {
                // Remove the element from the document
                bloc.add(ElementsRemoved([element]));
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
                                    bloc.add(ElementsRemoved([element]));
                                  },
                                ),
                              ]));
                },
                title: Text(AppLocalizations.of(context)!.delete),
                leading: const Icon(PhosphorIcons.trashLight)),
          ],
        ))
      ]);
    });
  }
}

class _GeneralElementDialogHeader extends StatelessWidget {
  final AppDocument document;
  final PadElement element;
  final Offset position;
  final VoidCallback close;
  const _GeneralElementDialogHeader(
      {Key? key,
      required this.document,
      required this.element,
      this.position = Offset.zero,
      required this.close})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    var area = document.areas.firstWhereOrNull((area) => element.inArea(area));

    var bloc = context.read<DocumentBloc>();
    var transformCubit = context.read<TransformCubit>();
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            icon,
            size: 32,
          ),
        ),
        Row(children: [
          if (area != null)
            IconButton(
              tooltip: area.name,
              onPressed: () {
                showContextMenu(
                    context: context,
                    position: position,
                    builder: (context, close) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(value: bloc),
                              BlocProvider.value(value: transformCubit),
                            ],
                            child: AreaContextMenu(
                              area: area,
                              close: close,
                              position: position,
                            )));
                close();
              },
              padding: const EdgeInsets.all(4.0),
              icon: const Icon(PhosphorIcons.squareLight, size: 32),
            ),
          IconButton(
            tooltip: AppLocalizations.of(context)!.document,
            icon: const Icon(PhosphorIcons.fileLight, size: 32),
            padding: const EdgeInsets.all(4.0),
            onPressed: () async {
              var bloc = context.read<DocumentBloc>();
              var transformCubit = context.read<TransformCubit>();
              var actor = context.findAncestorWidgetOfExactType<Actions>();
              showContextMenu(
                  context: context,
                  position: position,
                  builder: (ctx, close) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: bloc),
                          BlocProvider.value(value: transformCubit),
                        ],
                        child: Actions(
                            actions: actor?.actions ?? {},
                            child: BackgroundContextMenu(
                              close: close,
                              position: position,
                            )),
                      ));
              close();
            },
          ),
        ]),
      ]),
    );
  }
}
