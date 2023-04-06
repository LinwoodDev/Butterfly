import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;

import '../../bloc/document_bloc.dart';
import 'asset.dart';

enum PackAssetType { component, style, palette }

class SelectPackAssetDialog extends StatelessWidget {
  final PackAssetType type;
  final PackAssetLocation? selected;

  const SelectPackAssetDialog({
    super.key,
    required this.type,
    this.selected,
  });

  List<PackAssetLocation> _getAssets(AppDocument document) {
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
      case PackAssetType.palette:
        return packs
            .expand((pack) => pack.palettes
                .map((e) => PackAssetLocation(pack: pack.name, name: e.name)))
            .toList();
    }
  }

  ButterflyPack _createAsset(ButterflyPack pack, String name) {
    switch (type) {
      case PackAssetType.component:
        return pack.copyWith(
          components: [
            ...pack.components,
            ButterflyComponent(name: name),
          ],
        );
      case PackAssetType.style:
        return pack.copyWith(
          styles: [
            ...pack.styles,
            text.TextStyleSheet(name: name),
          ],
        );
      case PackAssetType.palette:
        return pack.copyWith(
          palettes: [
            ...pack.palettes,
            ColorPalette(name: name),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      if (state is! DocumentLoaded) return const SizedBox();
      return AlertDialog(
        title: Row(
          children: [
            Flexible(child: Text(AppLocalizations.of(context).selectAsset)),
            const SizedBox(width: 8),
            IconButton(
              icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
              onPressed: () async {
                final result = await showDialog<PackAssetLocation>(
                  context: context,
                  builder: (context) => BlocProvider.value(
                    value: bloc,
                    child: const AssetDialog(),
                  ),
                );
                if (result == null) return;
                if (context.mounted) {
                  final pack = state.document.getPack(result.pack);
                  if (pack == null) return;
                  final newPack = _createAsset(pack, result.name);
                  bloc.add(DocumentPackUpdated(newPack.name, newPack));
                  Navigator.of(context).pop(result);
                }
              },
            ),
          ],
        ),
        content: SizedBox(
          width: 300,
          height: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _getAssets(state.document)
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
    });
  }
}
