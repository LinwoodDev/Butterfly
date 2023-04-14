import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/document_bloc.dart';
import 'pack.dart';

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
    final bloc = context.read<DocumentBloc>();
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      if (state is! DocumentLoaded) return const SizedBox();
      final document = state.document;
      return AlertDialog(
        title: Text(
          value == null
              ? AppLocalizations.of(context).addAsset
              : AppLocalizations.of(context).editAsset,
        ),
        scrollable: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 250,
                  child: DropdownMenu<String>(
                    label: Text(AppLocalizations.of(context).pack),
                    key: UniqueKey(),
                    dropdownMenuEntries: document.packs
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
                    width: 250,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
                  onPressed: () async {
                    final pack = await showDialog<ButterflyPack>(
                      context: context,
                      builder: (context) => const PackDialog(),
                    );
                    if (pack == null) return;
                    bloc.add(DocumentPackAdded(pack));
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
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
