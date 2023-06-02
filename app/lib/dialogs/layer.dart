import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/delete.dart';
import 'package:butterfly/dialogs/name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LayerDialog extends StatelessWidget {
  final String layer;
  final bool popupMenu;
  const LayerDialog({super.key, required this.layer, this.popupMenu = false});

  @override
  Widget build(BuildContext context) {
    if (popupMenu) {
      return MenuAnchor(
          builder: defaultMenuButton(),
          menuChildren: _buildMenuItems(context).toList());
    }
    return AlertDialog(
      title: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: PhosphorIcon(PhosphorIconsLight.squaresFour),
          ),
          Text(layer),
        ],
      ),
      content: Column(
          mainAxisSize: MainAxisSize.min, children: _buildMenuItems(context)),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context).cancel)),
      ],
    );
  }

  List<Widget> _buildMenuItems(BuildContext context) => [
        ListTile(
          title: Text(AppLocalizations.of(context).rename),
          leading: const PhosphorIcon(PhosphorIconsLight.textT),
          onTap: () async {
            final bloc = context.read<DocumentBloc>();
            final name = await showDialog<String>(
              context: context,
              builder: (context) => NameDialog(
                value: layer,
              ),
            );
            if (name == null) return;
            bloc.add(LayerRenamed(layer, name));
          },
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).deleteElements),
          leading: const PhosphorIcon(PhosphorIconsLight.trash),
          onTap: () async {
            final bloc = context.read<DocumentBloc>();
            final result = await showDialog<bool>(
                context: context, builder: (context) => const DeleteDialog());
            if (result != true) return;
            bloc.add(LayerElementsDeleted(layer));
            if (context.mounted) Navigator.pop(context);
          },
        ),
        MenuItemButton(
          leadingIcon: const PhosphorIcon(PhosphorIconsLight.x),
          onPressed: () {
            context.read<DocumentBloc>().add(LayerRemoved(layer));
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context).remove),
        ),
      ];
}
