import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/area/context.dart';
import 'package:butterfly/dialogs/layer.dart';
import 'package:butterfly/models/element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/transform.dart';
import '../../renderers/renderer.dart';
import '../../widgets/context_menu.dart';
import '../background/context.dart';

class GeneralElementDialog extends StatelessWidget {
  final Renderer<PadElement> renderer;
  final VoidCallback close;
  final Offset position;
  final List<Widget> children;

  const GeneralElementDialog(
      {Key? key,
      this.children = const [],
      required this.position,
      required this.renderer,
      required this.close})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      if (state is! DocumentLoadSuccess) return Container();
      var bloc = context.read<DocumentBloc>();
      return Column(mainAxisSize: MainAxisSize.min, children: [
        _GeneralElementDialogHeader(
            close: close, renderer: renderer, position: position),
        const Divider(),
        Flexible(
            child: ListView(
          shrinkWrap: true,
          children: [
            ...children,
            if (children.isNotEmpty) const Divider(),
            renderer.element.layer.isEmpty
                ? ListTile(
                    title: Text(AppLocalizations.of(context)!.layer),
                    leading: const Icon(PhosphorIcons.squaresFourLight),
                    subtitle: Text(AppLocalizations.of(context)!.notSet),
                    onTap: () {
                      close();
                      var nameController =
                          TextEditingController(text: renderer.element.layer);
                      showDialog(
                          context: context,
                          useRootNavigator: true,
                          builder: (context) => AlertDialog(
                                title: Text(
                                    AppLocalizations.of(context)!.enterLayer),
                                content: TextField(
                                  controller: nameController,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText:
                                          AppLocalizations.of(context)!.name),
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
                                      bloc.add(ElementChanged(
                                          renderer.element,
                                          renderer.element.copyWith(
                                              layer: nameController.text)));
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));
                    })
                : ListTile(
                    leading: const Icon(PhosphorIcons.squaresFourLight),
                    title: Text(renderer.element.layer),
                    trailing: IconButton(
                      icon: const Icon(PhosphorIcons.trashLight),
                      onPressed: () => bloc.add(ElementChanged(renderer.element,
                          renderer.element.copyWith(layer: ''))),
                    ),
                    onTap: () {
                      close();
                      showDialog(
                          context: context,
                          builder: (context) => BlocProvider.value(
                              value: bloc,
                              child:
                                  LayerDialog(layer: renderer.element.layer)));
                    }),
            ListTile(
              title: Text(AppLocalizations.of(context)!.move),
              leading: const Icon(PhosphorIcons.arrowsOutCardinalLight),
              onTap: () {
                // Remove the element from the document
                bloc.add(ElementsRemoved([renderer.element]));
                state.fetchHand()?.move(context, renderer);
                close();
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.duplicate),
              leading: const Icon(PhosphorIcons.copyLight),
              onTap: () {
                state.fetchHand()?.move(context, renderer, true);
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
                                    bloc.add(
                                        ElementsRemoved([renderer.element]));
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
  final Renderer renderer;
  final Offset position;
  final VoidCallback close;
  const _GeneralElementDialogHeader(
      {Key? key,
      required this.renderer,
      this.position = Offset.zero,
      required this.close})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (renderer.element.toJson()['type']) {
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
          if (renderer.area != null)
            IconButton(
              tooltip: renderer.area!.name,
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
                              area: renderer.area!,
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
