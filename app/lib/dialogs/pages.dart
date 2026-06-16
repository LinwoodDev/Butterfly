import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';

class SelectPagesDialog extends StatefulWidget {
  final List<(String name, String id)> pages;

  const SelectPagesDialog({super.key, required this.pages});

  @override
  State<SelectPagesDialog> createState() => _SelectPagesDialogState();
}

class _SelectPagesDialogState extends State<SelectPagesDialog> {
  final List<String> _selected = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).selectPages),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: Text(AppLocalizations.of(context).selectAll),
            value: _selected.length == widget.pages.length,
            onChanged: (v) {
              setState(() {
                if (v == true) {
                  _selected.clear();
                  _selected.addAll(widget.pages.map((e) => e.$2));
                } else {
                  _selected.clear();
                }
              });
            },
          ),
          ...widget.pages.map(
            (page) => CheckboxListTile(
              title: Text(
                page.$1.isEmpty ? AppLocalizations.of(context).page : page.$1,
              ),
              value: _selected.contains(page.$2),
              onChanged: (v) {
                setState(() {
                  if (v == true) {
                    _selected.add(page.$2);
                  } else {
                    _selected.remove(page.$2);
                  }
                });
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(
          onPressed: _selected.isEmpty
              ? null
              : () => Navigator.pop(context, _selected),
          child: Text(AppLocalizations.of(context).select),
        ),
      ],
    );
  }
}
