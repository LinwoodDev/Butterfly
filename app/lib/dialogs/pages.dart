import 'dart:math' as math;

import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
  final Set<String> _selected = {};
  late final TextEditingController _rangeController;
  String? _rangeError;

  @override
  void initState() {
    super.initState();
    final pageIds = widget.pages.map((e) => e.$2).toSet();
    _selected.addAll(widget.initialSelected.where(pageIds.contains));
    _rangeController = TextEditingController();
    _syncRangeText();
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

  void _syncRangeText() {
    final selectedIndexes = widget.pages
        .asMap()
        .entries
        .where((entry) => _selected.contains(entry.value.$2))
        .map((entry) => entry.key);
    final text = formatPageSelection(selectedIndexes);
    if (_rangeController.text == text) return;
    _rangeController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  void _updateSelected(void Function() update) {
    setState(() {
      update();
      _rangeError = null;
      _syncRangeText();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final colorScheme = ColorScheme.of(context);
    final selectionCount = _selected.length;
    final everythingSelected = selectionCount == widget.pages.length;
    return AlertDialog(
      title: Text(loc.selectPages),
      contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      content: SizedBox(
        width: 520,
        height: math.min(MediaQuery.sizeOf(context).height * 0.65, 560),
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  spacing: 12,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            loc.countPages(selectionCount),
                            style: TextTheme.of(context).titleMedium,
                          ),
                        ),
                        IconButton(
                          icon: PhosphorIcon(
                            everythingSelected
                                ? PhosphorIconsLight.selectionSlash
                                : PhosphorIconsLight.selectionAll,
                          ),
                          tooltip: everythingSelected
                              ? loc.deselect
                              : loc.selectAll,
                          onPressed: () => _updateSelected(() {
                            _selected.clear();
                            if (!everythingSelected) {
                              _selected.addAll(widget.pages.map((e) => e.$2));
                            }
                          }),
                        ),
                      ],
                    ),
                    TextField(
                      controller: _rangeController,
                      decoration: InputDecoration(
                        prefixIcon: const PhosphorIcon(
                          PhosphorIconsLight.listNumbers,
                        ),
                        labelText: loc.pages,
                        hintText: '1-3, 5',
                        errorText: _rangeError,
                        filled: true,
                        isDense: true,
                        suffixIcon: _rangeController.text.isEmpty
                            ? null
                            : IconButton(
                                icon: const PhosphorIcon(PhosphorIconsLight.x),
                                tooltip: MaterialLocalizations.of(
                                  context,
                                ).deleteButtonTooltip,
                                onPressed: () =>
                                    _updateSelected(_selected.clear),
                              ),
                      ),
                      onChanged: _applyRange,
                      onSubmitted: _applyRange,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Material(
                type: MaterialType.transparency,
                child: ListView.separated(
                  itemCount: widget.pages.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final page = widget.pages[index];
                    final id = page.$2;
                    return CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(page.$1.isEmpty ? loc.page : page.$1),
                      subtitle: Text(loc.pageIndex(index + 1)),
                      value: _selected.contains(id),
                      onChanged: (v) {
                        _updateSelected(() {
                          if (v == true) {
                            _selected.add(id);
                          } else {
                            _selected.remove(id);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(
          onPressed: _selected.isEmpty
              ? null
              : () => Navigator.pop(
                  context,
                  widget.pages
                      .where((page) => _selected.contains(page.$2))
                      .map((page) => page.$2)
                      .toList(),
                ),
          child: Text(loc.select),
        ),
      ],
    );
  }
}

String formatPageSelection(Iterable<int> indexes) {
  final sorted = indexes.toSet().toList()..sort();
  if (sorted.isEmpty) return '';
  final ranges = <String>[];
  var start = sorted.first;
  var previous = start;
  for (final index in sorted.skip(1)) {
    if (index == previous + 1) {
      previous = index;
      continue;
    }
    ranges.add(_formatPageRange(start, previous));
    start = previous = index;
  }
  ranges.add(_formatPageRange(start, previous));
  return ranges.join(', ');
}

String _formatPageRange(int start, int end) {
  final first = start + 1;
  final last = end + 1;
  return first == last ? '$first' : '$first-$last';
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
