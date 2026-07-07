import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';

class MoveToLayerDialog extends StatefulWidget {
  final List<String> elementIds;

  const MoveToLayerDialog({super.key, required this.elementIds});

  @override
  State<MoveToLayerDialog> createState() => MoveToLayerDialogState();
}

class MoveToLayerDialogState extends State<MoveToLayerDialog> {
  @override
  Widget build(BuildContext context) {
    final layers = context.read<DocumentBloc>().state.page?.layers;
    return AlertDialog(
      title: Text(AppLocalizations.of(context).moveToLayer),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            layers?.reversed
                .map(
                  (layer) => ListTile(
                    title: Text(
                      layer.name.isEmpty
                          ? AppLocalizations.of(context).layer
                          : layer.name,
                    ),
                    onTap: () {
                      context.read<DocumentBloc>().add(
                        ElementsLayerMoved(widget.elementIds, layer.id ?? ''),
                      );
                      Navigator.pop(context);
                    },
                  ),
                )
                .toList() ??
            [],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        TextButton(
          onPressed: () async {
            final result = await showDialog<String>(
              context: context,
              builder: (context) => NameDialog(
                validator: defaultNameValidator(
                  context,
                  layers?.map((e) => e.name).toList() ?? [],
                ),
              ),
            );
            if (result != null) {
              context.read<DocumentBloc>().add(
                ElementsLayerConverted(widget.elementIds, result),
              );
            }
            if (mounted) Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context).createLayer),
        ),
      ],
    );
  }
}
