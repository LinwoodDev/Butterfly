import 'package:butterfly/actions/insert.dart';
import 'package:butterfly/api/shortcut_helper.dart';
import 'package:butterfly/models/area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/transform.dart';

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
          leading: const Icon(PhosphorIcons.plusLight),
          title: Text(AppLocalizations.of(context)!.insert),
          subtitle: Text(context.getShortcut('E')),
          onTap: () {
            var transformCubit = context.read<TransformCubit>();
            close();
            Actions.maybeInvoke<InsertIntent>(
                context,
                InsertIntent(
                    context, transformCubit.state.localToGlobal(position)));
          },
        ),
      ],
    );
  }
}
