import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LayerDialog extends StatelessWidget {
  final String layer;
  final bool popupMenu;
  const LayerDialog({Key? key, required this.layer, this.popupMenu = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (popupMenu) {
      return PopupMenuButton(
          itemBuilder: (context) => _buildListTiles(context)
              .map((e) => PopupMenuItem(child: e, padding: EdgeInsets.zero))
              .toList());
    }
    return AlertDialog(
      title: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(PhosphorIcons.squaresFourLight),
          ),
          Text(layer),
        ],
      ),
      content: Column(
          mainAxisSize: MainAxisSize.min, children: _buildListTiles(context)),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel)),
      ],
    );
  }

  List<Widget> _buildListTiles(BuildContext context) => [
        ListTile(
          title: Text(AppLocalizations.of(context)!.rename),
          leading: const Icon(PhosphorIcons.textTLight),
          onTap: () {
            var _nameController = TextEditingController(text: layer);
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: Text(AppLocalizations.of(ctx)!.rename),
                      content: TextField(
                        controller: _nameController,
                        autofocus: true,
                        decoration: const InputDecoration(filled: true),
                      ),
                      actions: [
                        TextButton(
                          child: Text(AppLocalizations.of(ctx)!.cancel),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                        TextButton(
                          child: Text(AppLocalizations.of(ctx)!.ok),
                          onPressed: () {
                            Navigator.pop(ctx);
                            if (_nameController.text != layer) {
                              context.read<DocumentBloc>().add(
                                  LayerRenamed(layer, _nameController.text));
                              Navigator.pop(ctx);
                            }
                          },
                        ),
                      ],
                    ));
          },
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.deleteElements),
          leading: const Icon(PhosphorIcons.trashLight),
          onTap: () {
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: Text(AppLocalizations.of(ctx)!.deleteElements),
                      content:
                          Text(AppLocalizations.of(ctx)!.deleteElementsConfirm),
                      actions: [
                        TextButton(
                          child: Text(AppLocalizations.of(ctx)!.no),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                        TextButton(
                          child: Text(AppLocalizations.of(ctx)!.yes),
                          onPressed: () {
                            Navigator.pop(ctx);
                            context
                                .read<DocumentBloc>()
                                .add(LayerElementsDeleted(layer));
                            Navigator.pop(ctx);
                          },
                        ),
                      ],
                    ));
          },
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.remove),
          leading: const Icon(PhosphorIcons.xLight),
          onTap: () {
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: Text(AppLocalizations.of(ctx)!.remove),
                      content: Text(AppLocalizations.of(ctx)!.removeConfirm),
                      actions: [
                        TextButton(
                          child: Text(AppLocalizations.of(ctx)!.no),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                        TextButton(
                          child: Text(AppLocalizations.of(ctx)!.yes),
                          onPressed: () {
                            Navigator.pop(ctx);
                            context
                                .read<DocumentBloc>()
                                .add(LayerRemoved(layer));
                            Navigator.pop(ctx);
                          },
                        ),
                      ],
                    ));
          },
        ),
      ];
}
