import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/background.dart';
import 'package:butterfly/dialogs/color_pick.dart';
import 'package:butterfly/dialogs/waypoints.dart';
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
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => BackgroundDialog(bloc: widget.bloc));
          },
        ),
        IconButton(
          icon: const Icon(PhosphorIcons.paletteLight),
          tooltip: AppLocalizations.of(context)!.color,
          onPressed: () => showDialog(
              context: context,
              builder: (context) => ColorPickerDialog(
                    bloc: widget.bloc,
                    viewMode: true,
                  )),
        ),
        IconButton(
            icon: const Icon(PhosphorIcons.mapPinLight),
            tooltip: AppLocalizations.of(context)!.waypoints,
            onPressed: () async {
              var transformCubit = context.read<TransformCubit>();
              showDialog(
                  context: context,
                  builder: (context) => WaypointsDialog(
                      bloc: widget.bloc, cameraCubit: transformCubit));
            }),
      ]);
    });
    /*IconButton(icon: const Icon(PhosphorIcons.printerLight), tooltip: "Print", onPressed: () {}),
      IconButton(
          icon: const Icon(PhosphorIcons.monitorPlayLight),
          tooltip: "Presentation",
          onPressed: () {})*/
  }
}
