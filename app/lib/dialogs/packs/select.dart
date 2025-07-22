import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;

import '../../bloc/document_bloc.dart';
import 'asset.dart';

enum PackAssetType { component, style, palette }

class SelectPackAssetDialog extends StatelessWidget {
  final PackAssetType type;
  final PackAssetLocation? selected;

  const SelectPackAssetDialog({super.key, required this.type, this.selected});

  List<PackAssetLocation> _getAssets(NoteData document) => document
      .getPacks()
      .map((e) => document.getPack(e))
      .nonNulls
      .expand(
        (pack) => switch (type) {
          PackAssetType.component => pack.getComponents(),
          PackAssetType.style => pack.getStyles(),
          PackAssetType.palette => pack.getPalettes(),
        }.map((e) => PackAssetLocation(pack.name!, e)),
      )
      .toList();

  NoteData _createAsset(NoteData pack, String name) => switch (type) {
    PackAssetType.component => pack.setComponent(
      ButterflyComponent(name: name),
    ),
    PackAssetType.style => pack.setStyle(text.TextStyleSheet(name: name)),
    PackAssetType.palette => pack.setPalette(ColorPalette(name: name)),
  };

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    return BlocBuilder<DocumentBloc, DocumentState>(
      builder: (context, state) {
        if (state is! DocumentLoaded) return const SizedBox();
        return SizedBox(
          width: 300,
          height: 500,
          child: AlertDialog(
            title: Row(
              children: [
                Flexible(child: Text(AppLocalizations.of(context).selectAsset)),
                const SizedBox(width: 8),
                IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
                  tooltip: AppLocalizations.of(context).addAsset,
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
                      final pack = state.data.getPack(result.pack);
                      if (pack == null) return;
                      bloc.add(
                        PackUpdated(
                          pack.name!,
                          _createAsset(pack, result.name),
                        ),
                      );
                      Navigator.of(context).pop(result);
                    }
                  },
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: _getAssets(state.data)
                  .map(
                    (e) => ListTile(
                      title: Text(e.name),
                      subtitle: Text(e.pack),
                      onTap: () => Navigator.of(context).pop(e),
                      selected: e == selected,
                    ),
                  )
                  .toList(),
            ),
            scrollable: true,
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  MaterialLocalizations.of(context).cancelButtonLabel,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
