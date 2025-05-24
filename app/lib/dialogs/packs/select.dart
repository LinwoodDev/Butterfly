import 'package:butterfly/api/file_system.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

class SelectPackAssetDialog extends StatefulWidget {
  final PackAssetLocation? selected;
  final NamedItem? selectedItem;
  final Iterable<NamedItem> Function(NoteData) getItems;

  const SelectPackAssetDialog({
    super.key,
    this.selected,
    this.selectedItem,
    required this.getItems,
  });

  @override
  State<SelectPackAssetDialog> createState() => _SelectPackAssetDialogState();
}

class _SelectPackAssetDialogState extends State<SelectPackAssetDialog> {
  late final PackFileSystem _packSystem;
  Future<List<(String, NoteData)>>? _packsFuture;

  @override
  void initState() {
    super.initState();
    _packSystem = context.read<ButterflyFileSystem>().buildDefaultPackSystem();
    _packsFuture = _getPacks();
  }

  Future<List<(String, NoteData)>> _getPacks() async {
    final files = await _packSystem.getFiles();
    final packs = <(String, NoteData)>[];
    for (final file in files) {
      final pack = file.data!;
      packs.add((file.pathWithoutLeadingSlash, pack));
    }
    return packs;
  }

  List<PackItem> _getAssets(List<(String, NoteData)> packs) => packs.nonNulls
      .expand(
        (pack) =>
            widget.getItems(pack.$2).map((e) => e.toPack(pack.$2, pack.$1)),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<(String, NoteData)>>(
      future: _packsFuture,
      builder: (context, snapshot) {
        final packs = snapshot.data ?? <(String, NoteData)>[];
        return SizedBox(
          width: 300,
          height: 500,
          child: AlertDialog(
            title: Text(AppLocalizations.of(context).selectAsset),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: _getAssets(packs)
                  .map(
                    (e) => ListTile(
                      title: Text(e.key),
                      subtitle: Text(e.namespace),
                      onTap: () => Navigator.of(context).pop(e),
                      selected:
                          e.location == widget.selected ||
                          e.toNamed() == widget.selectedItem,
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
