import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/background/context.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/models/element.dart';
import 'package:butterfly/widgets/context_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../renderers/renderer.dart';
import '../bloc/document_bloc.dart';
import '../services/import.dart';

class ElementsDialog extends StatelessWidget {
  final Offset position;
  final List<Renderer<PadElement>> renderers;

  const ElementsDialog(
      {super.key, required this.position, required this.renderers});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Flexible(
          child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context).move),
            leading: const Icon(PhosphorIcons.arrowsOutCardinalLight),
            onTap: () {
              Navigator.of(context).pop(true);
              context
                  .read<CurrentIndexCubit>()
                  .fetchHandler<HandHandler>()
                  ?.move(context.read<DocumentBloc>(), renderers, false);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).duplicate),
            leading: const Icon(PhosphorIcons.copyLight),
            onTap: () {
              Navigator.of(context).pop(true);
              context
                  .read<CurrentIndexCubit>()
                  .fetchHandler<HandHandler>()
                  ?.move(context.read<DocumentBloc>(), renderers, true);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).scale),
            leading: const Icon(PhosphorIcons.arrowsOutLight),
            onTap: () {
              Navigator.of(context).pop(false);
              context
                  .read<CurrentIndexCubit>()
                  .fetchHandler<HandHandler>()
                  ?.setScaleMode(context.read<DocumentBloc>());
            },
          ),
          ListTile(
              onTap: () {
                Navigator.of(context).pop(true);
                context.read<DocumentBloc>().add(
                    ElementsRemoved(renderers.map((r) => r.element).toList()));
              },
              title: Text(AppLocalizations.of(context).delete),
              leading: const Icon(PhosphorIcons.trashLight)),
          ListTile(
            onTap: () {
              Navigator.of(context).pop(true);
              final cubit = context.read<CurrentIndexCubit>();
              cubit.changeSelection(renderers.first);
              renderers.sublist(1).forEach((r) => cubit.insertSelection(r));
            },
            title: Text(AppLocalizations.of(context).properties),
            leading: const Icon(PhosphorIcons.fadersLight),
          ),
          ListTile(
            onTap: () {
              final currentIndexCubit = context.read<CurrentIndexCubit>();
              final bloc = context.read<DocumentBloc>();
              final transformCubit = context.read<TransformCubit>();
              final importService = context.read<ImportService>();
              final actions =
                  context.findAncestorWidgetOfExactType<Actions>()?.actions ??
                      {};
              Navigator.of(context).pop(true);
              showContextMenu(
                  context: context,
                  position: position,
                  builder: (ctx) => Actions(
                        actions: actions,
                        child: MultiBlocProvider(
                            providers: [
                              BlocProvider<CurrentIndexCubit>.value(
                                value: currentIndexCubit,
                              ),
                              BlocProvider<DocumentBloc>.value(
                                value: bloc,
                              ),
                              BlocProvider<TransformCubit>.value(
                                value: transformCubit,
                              ),
                            ],
                            child: RepositoryProvider.value(
                              value: importService,
                              child: BackgroundContextMenu(
                                position: position,
                              ),
                            )),
                      ));
            },
            title: Text(AppLocalizations.of(context).document),
            leading: const Icon(PhosphorIcons.fileTextLight),
          ),
        ],
      ))
    ]);
  }
}
