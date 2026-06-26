import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';

class SelectPagesDialog extends StatefulWidget {
  final List<(String name, String id)> pages;
  final Iterable<String> initialSelected;

  const SelectPagesDialog({
    super.key,
    required this.pages,
    this.initialSelected = const [],
  });

  @override
  State<SelectPagesDialog> createState() => _SelectPagesDialogState();
}

class _SelectPagesDialogState extends State<SelectPagesDialog> {
  final List<String> _selected = [];
  late final TextEditingController _rangeController;
  String? _rangeError;

  @override
  void initState() {
    super.initState();
    final pageIds = widget.pages.map((e) => e.$2).toSet();
    _selected.addAll(widget.initialSelected.where(pageIds.contains));
    _rangeController = TextEditingController();
  }

  @override
  void dispose() {
    _rangeController.dispose();
    super.dispose();
  }

  void _applyRange(String value) {
    final selectedIndexes = parsePageSelection(value, widget.pages.length);
    setState(() {
      if (selectedIndexes == null) {
        _rangeError = AppLocalizations.of(context).error;
        return;
      }
      _rangeError = null;
      _selected
        ..clear()
        ..addAll(selectedIndexes.map((index) => widget.pages[index].$2));
    });
  }

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
          TextField(
            controller: _rangeController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).pages,
              hintText: '1-3, 5',
              errorText: _rangeError,
              filled: true,
            ),
            onChanged: _applyRange,
            onSubmitted: _applyRange,
          ),
          ...widget.pages.asMap().entries.map(
            (entry) => CheckboxListTile(
              title: Text(
                entry.value.$1.isEmpty
                    ? AppLocalizations.of(context).page
                    : entry.value.$1,
              ),
              subtitle: Text(
                AppLocalizations.of(context).pageIndex(entry.key + 1),
              ),
              value: _selected.contains(entry.value.$2),
              onChanged: (v) {
                setState(() {
                  if (v == true) {
                    _selected.add(entry.value.$2);
                  } else {
                    _selected.remove(entry.value.$2);
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

List<int>? parsePageSelection(String value, int pageCount) {
  final normalized = value
      .trim()
      .replaceAll('[', '')
      .replaceAll(']', '')
      .replaceAll('\u2013', '-')
      .replaceAll('\u2014', '-');
  if (normalized.isEmpty) return const [];
  final selected = <int>{};
  for (final part in normalized.split(RegExp(r'[,;]'))) {
    final token = part.trim();
    if (token.isEmpty) return null;
    final bounds = token.split('-').map((e) => e.trim()).toList();
    if (bounds.length > 2 || bounds.any((e) => e.isEmpty)) return null;
    final start = int.tryParse(bounds.first);
    final end = int.tryParse(bounds.last);
    if (start == null || end == null) return null;
    if (start < 1 || end < 1 || start > pageCount || end > pageCount) {
      return null;
    }
    final lower = start < end ? start : end;
    final upper = start < end ? end : start;
    for (var index = lower - 1; index < upper; index++) {
      selected.add(index);
    }
  }
  return List.generate(
    pageCount,
    (index) => index,
  ).where(selected.contains).toList();
}
