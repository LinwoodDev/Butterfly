import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/models/element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../renderers/renderer.dart';
import '../bloc/document_bloc.dart';

class ElementsDialog extends StatelessWidget {
  final VoidCallback close;
  final List<Renderer<PadElement>> renderers;

  const ElementsDialog(
      {super.key, required this.close, required this.renderers});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Flexible(
          child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.move),
            leading: const Icon(PhosphorIcons.arrowsOutCardinalLight),
            onTap: () {
              close();
              context
                  .read<CurrentIndexCubit>()
                  .fetchHandler<HandHandler>()
                  ?.move(context, renderers, false);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.duplicate),
            leading: const Icon(PhosphorIcons.copyLight),
            onTap: () {
              close();
              context
                  .read<CurrentIndexCubit>()
                  .fetchHandler<HandHandler>()
                  ?.move(context, renderers, true);
            },
          ),
          ListTile(
              onTap: () {
                close();
                context.read<DocumentBloc>().add(
                    ElementsRemoved(renderers.map((r) => r.element).toList()));
              },
              title: Text(AppLocalizations.of(context)!.delete),
              leading: const Icon(PhosphorIcons.trashLight)),
          ListTile(
            onTap: () {
              close();
              final cubit = context.read<CurrentIndexCubit>();
              cubit.changeSelection(renderers.first);
              renderers.sublist(1).forEach((r) => cubit.insertSelection(r));
            },
            title: Text(AppLocalizations.of(context)!.properties),
            leading: const Icon(PhosphorIcons.fadersLight),
          ),
        ],
      ))
    ]);
  }
}
