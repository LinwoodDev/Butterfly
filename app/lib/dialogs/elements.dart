import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/area/context.dart';
import 'package:butterfly/dialogs/layer.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/models/element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/current_index.dart';
import '../../cubits/transform.dart';
import '../../renderers/renderer.dart';
import '../../widgets/context_menu.dart';
import '../background/context.dart';
import '../../visualizer/element.dart';

class ElementsDialog extends StatefulWidget {
  final List<Renderer<PadElement>> renderers;

  const ElementsDialog({super.key, required this.renderers});

  @override
  State<ElementsDialog> createState() => _ElementsDialogState();
}

class _ElementsDialogState extends State<ElementsDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
        Flexible(
            child: Material(
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context)!.move),
                leading: const Icon(PhosphorIcons.arrowsOutCardinalLight),
                onTap: () {
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.duplicate),
                leading: const Icon(PhosphorIcons.copyLight),
                onTap: () {
                },
              ),
              ListTile(
                  onTap: () {
                  },
                  title: Text(AppLocalizations.of(context)!.delete),
                  leading: const Icon(PhosphorIcons.trashLight)),
              ListTile(
                  onTap: () {
                  },
                  title: Text(AppLocalizations.of(context)!.properties),
                  leading: const Icon(PhosphorIcons.fadersLight),),
            ],
          ),
        ))
      ]);
    });
  }
}

class _GeneralElementDialogHeader extends StatelessWidget {
  final Renderer<PadElement> renderer;
  final Offset position;
  final ContextCloseFunction close;
  const _GeneralElementDialogHeader(
      {required this.renderer,
      this.position = Offset.zero,
      required this.close});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    final transformCubit = context.read<TransformCubit>();
    final currentIndexCubit = context.read<CurrentIndexCubit>();
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            renderer.element.getIcon(),
            size: 32,
          ),
        ),
        Row(children: [
          if (renderer.area != null)
            IconButton(
              tooltip: renderer.area!.name,
              onPressed: () {
                close();
                showContextMenu(
                    context: context,
                    position: position,
                    builder: (context, close) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(value: bloc),
                              BlocProvider.value(value: transformCubit),
                              BlocProvider.value(value: currentIndexCubit)
                            ],
                            child: AreaContextMenu(
                              area: renderer.area!,
                              close: close,
                              position: position,
                            )));
              },
              padding: const EdgeInsets.all(4.0),
              icon: const Icon(PhosphorIcons.monitorLight, size: 32),
            ),
          IconButton(
            tooltip: AppLocalizations.of(context)!.document,
            icon: const Icon(PhosphorIcons.fileLight, size: 32),
            padding: const EdgeInsets.all(4.0),
            onPressed: () async {
              var bloc = context.read<DocumentBloc>();
              var transformCubit = context.read<TransformCubit>();
              var actor = context.findAncestorWidgetOfExactType<Actions>();
              await close();
              showContextMenu(
                  context: context,
                  position: position,
                  builder: (ctx, close) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: bloc),
                          BlocProvider.value(value: transformCubit),
                          BlocProvider.value(value: currentIndexCubit)
                        ],
                        child: Actions(
                            actions: actor?.actions ?? {},
                            child: BackgroundContextMenu(
                              close: close,
                              position: position,
                            )),
                      ));
            },
          ),
        ]),
      ]),
    );
  }
}
