import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../widgets/header.dart';

class PagesDialog extends StatefulWidget {
  final List<Uint8List> pages;
  const PagesDialog({Key? key, this.pages = const []}) : super(key: key);

  @override
  State<PagesDialog> createState() => _PagesDialogState();
}

class _PagesDialogState extends State<PagesDialog> {
  List<int> selected = const [];

  @override
  void initState() {
    super.initState();
    selected = List.generate(widget.pages.length, (i) => i);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Header(
            title:
                Text(AppLocalizations.of(context)!.countPages(selected.length)),
            actions: [
              IconButton(
                  tooltip: AppLocalizations.of(context)!.invertSelection,
                  icon: const Icon(PhosphorIcons.selectionInverseLight),
                  onPressed: () {
                    setState(() {
                      // Remove all selected pages and add all other pages.
                      selected = List.generate(widget.pages.length, (i) => i)
                          .toSet()
                          .difference(selected.toSet())
                          .toList();
                    });
                  }),
            ],
          ),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              child: ListView.builder(
                itemCount: widget.pages.length,
                itemBuilder: (context, index) {
                  // Show border for selected pages
                  final border = selected.contains(index)
                      ? Border.all(
                          width: 4,
                          color: Theme.of(context).primaryColor,
                        )
                      : null;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selected = selected.contains(index)
                            ? selected.where((e) => e != index).toList()
                            : [...selected, index];
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(border: border),
                      child: Image.memory(widget.pages[index]),
                    ),
                  );
                },
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(AppLocalizations.of(context)!.cancel),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context)!.ok),
                  onPressed: () => Navigator.of(context).pop(selected),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
