import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum PackAssetType { component, style }

class SelectPackAssetDialog extends StatelessWidget {
  final PackAssetType type;
  final PackAssetLocation? selected;
  final AppDocument document;

  const SelectPackAssetDialog({
    super.key,
    required this.type,
    required this.document,
    this.selected,
  });

  List<PackAssetLocation> _getAssets() {
    final packs = document.packs;
    switch (type) {
      case PackAssetType.component:
        return packs
            .expand((pack) => pack.components
                .map((e) => PackAssetLocation(pack: pack.name, name: e.name)))
            .toList();
      case PackAssetType.style:
        return packs
            .expand((pack) => pack.styles
                .map((e) => PackAssetLocation(pack: pack.name, name: e.name)))
            .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).selectAsset),
      content: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _getAssets()
              .map((e) => ListTile(
                    title: Text(e.name),
                    subtitle: Text(e.pack),
                    onTap: () => Navigator.of(context).pop(e),
                    selected: e == selected,
                  ))
              .toList(),
        ),
      ),
      scrollable: true,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
      ],
    );
  }
}
