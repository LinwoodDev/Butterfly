import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/document_bloc.dart';

class AssetDialog extends StatelessWidget {
  final PackAssetLocation? value;

  const AssetDialog({
    super.key,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    String? pack = value?.pack;
    String name = value?.name ?? '';
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      if (state is! DocumentLoaded) return const SizedBox.shrink();
      return AlertDialog(
        title: Text(
          value == null
              ? AppLocalizations.of(context).addAsset
              : AppLocalizations.of(context).editAsset,
        ),
        scrollable: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownMenu<String>(
              label: Text(AppLocalizations.of(context).pack),
              dropdownMenuEntries: state.document.packs
                  .map(
                    (e) => DropdownMenuEntry<String>(
                      value: e.name,
                      label: e.name,
                    ),
                  )
                  .toList(),
              onSelected: (value) {
                pack = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).name,
                filled: true,
              ),
              initialValue: name,
              onChanged: (value) {
                name = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context).cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (pack == null) return;
              Navigator.of(context).pop(PackAssetLocation(
                pack: pack!,
                name: name,
              ));
            },
            child: Text(AppLocalizations.of(context).ok),
          ),
        ],
      );
    });
  }
}
