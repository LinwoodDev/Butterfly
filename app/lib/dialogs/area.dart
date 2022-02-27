import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/models/area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'image_export.dart';

class AreaContextMenu extends StatelessWidget {
  final VoidCallback close;
  final Offset position;
  final Area area;

  const AreaContextMenu(
      {Key? key,
      required this.close,
      required this.position,
      required this.area})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(
          height: 50,
          child: Center(child: Icon(PhosphorIcons.squareLight, size: 36)),
        ),
        ListTile(
          leading: const Icon(PhosphorIcons.exportLight),
          title: Text(AppLocalizations.of(context)!.export),
          onTap: () {
            close();
            var bloc = context.read<DocumentBloc>();
            showDialog(
                builder: (context) => ImageExportDialog(
                      bloc: bloc,
                      width: area.width.round(),
                      height: area.height.round(),
                      x: area.position.dx,
                      y: area.position.dy,
                      scale: 1,
                    ),
                context: context);
          },
        ),
        ListTile(
          leading: const Icon(PhosphorIcons.trashLight),
          title: Text(AppLocalizations.of(context)!.delete),
          onTap: () {
            close();
            var bloc = context.read<DocumentBloc>();
            var state = bloc.state;
            if (state is! DocumentLoadSuccess) return;
            bloc.add(AreaRemoved(state.document.areas.indexOf(area)));
          },
        )
      ],
    );
  }
}
