import 'package:butterfly/actions/background.dart';
import 'package:butterfly/actions/color_palette.dart';
import 'package:butterfly/actions/waypoints.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ViewToolbar extends StatefulWidget {
  final DocumentBloc bloc;

  const ViewToolbar({Key? key, required this.bloc}) : super(key: key);

  @override
  _ViewToolbarState createState() => _ViewToolbarState();
}

class _ViewToolbarState extends State<ViewToolbar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      if (state is! DocumentLoadSuccess) {
        return Container();
      }
      return Row(children: [
        IconButton(
            icon: const Icon(PhosphorIcons.imageLight),
            tooltip: AppLocalizations.of(context)!.background,
            onPressed: () => Actions.maybeInvoke<BackgroundIntent>(
                context, BackgroundIntent(context))),
        IconButton(
            icon: const Icon(PhosphorIcons.paletteLight),
            tooltip: AppLocalizations.of(context)!.color,
            onPressed: () => Actions.maybeInvoke<ColorPaletteIntent>(
                context, ColorPaletteIntent(context))),
        IconButton(
            icon: const Icon(PhosphorIcons.mapPinLight),
            tooltip: AppLocalizations.of(context)!.waypoints,
            onPressed: () => Actions.maybeInvoke<WaypointsIntent>(
                context, WaypointsIntent(context))),
      ]);
    });
    /*IconButton(icon: const Icon(PhosphorIcons.printerLight), tooltip: "Print", onPressed: () {}),
      IconButton(
          icon: const Icon(PhosphorIcons.monitorPlayLight),
          tooltip: "Presentation",
          onPressed: () {})*/
  }
}
