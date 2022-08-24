import 'package:butterfly/actions/background.dart';
import 'package:butterfly/actions/insert.dart';
import 'package:butterfly/actions/layers.dart';
import 'package:butterfly/actions/waypoints.dart';
import 'package:butterfly/api/shortcut_helper.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../actions/areas.dart';
import '../../actions/color_palette.dart';
import '../../cubits/transform.dart';
import '../../widgets/context_menu.dart';

class BackgroundContextMenu extends StatelessWidget {
  final ContextCloseFunction close;
  final Offset position;
  const BackgroundContextMenu(
      {super.key, required this.close, required this.position});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      if (state is! DocumentLoadSuccess) {
        return const Center(child: CircularProgressIndicator());
      }
      return ListView(
        shrinkWrap: true,
        children: [
          if (state.embedding?.editable ?? true)
            ListTile(
              leading: const Icon(PhosphorIcons.plusLight),
              title: Text(AppLocalizations.of(context)!.insert),
              subtitle: Text(context.getShortcut('N', altKey: true)),
              onTap: () {
                var transformCubit = context.read<TransformCubit>();
                Actions.invoke<InsertIntent>(
                    context,
                    InsertIntent(
                        context, transformCubit.state.localToGlobal(position)));
                close();
              },
            ),
          ListTile(
              leading: const Icon(PhosphorIcons.squaresFourLight),
              title: Text(AppLocalizations.of(context)!.layers),
              subtitle: Text(context.getShortcut('L')),
              onTap: () {
                close();
                Actions.maybeInvoke<LayersIntent>(
                    context, LayersIntent(context));
              }),
          ListTile(
            leading: const Icon(PhosphorIcons.monitorLight),
            title: Text(AppLocalizations.of(context)!.areas),
            subtitle: Text(context.getShortcut('A', shiftKey: true)),
            onTap: () {
              close();
              Actions.maybeInvoke<AreasIntent>(context, AreasIntent(context));
            },
          ),
          ListTile(
              leading: const Icon(PhosphorIcons.imageLight),
              title: Text(AppLocalizations.of(context)!.background),
              subtitle: Text(context.getShortcut('B')),
              onTap: () {
                close();
                Actions.maybeInvoke<BackgroundIntent>(
                    context, BackgroundIntent(context));
              }),
          ListTile(
              leading: const Icon(PhosphorIcons.mapPinLight),
              title: Text(AppLocalizations.of(context)!.waypoints),
              subtitle: Text(context.getShortcut('P', shiftKey: true)),
              onTap: () {
                close();
                Actions.maybeInvoke<WaypointsIntent>(
                    context, WaypointsIntent(context));
              }),
          if (state.embedding?.editable ?? true)
            ListTile(
                leading: const Icon(PhosphorIcons.paletteLight),
                title: Text(AppLocalizations.of(context)!.color),
                subtitle: Text(context.getShortcut('P')),
                onTap: () {
                  close();
                  Actions.maybeInvoke<ColorPaletteIntent>(
                      context, ColorPaletteIntent(context));
                }),
        ],
      );
    });
  }
}
