part of 'batch.dart';

class _ExportSelectionPane extends StatelessWidget {
  final ExportSource source;
  final List<ExportItem> items;
  final int selected;
  final bool multiple, compact, expanded, loading;
  final Uint8List? previewImage;
  final VoidCallback onTogglePreview;
  final ValueChanged<int> onSelect, onRemove;
  final void Function(int oldIndex, int newIndex) onReorder;
  final ValueChanged<ExportRegion> onRegionChanged;
  const _ExportSelectionPane({
    required this.source,
    required this.items,
    required this.selected,
    required this.multiple,
    required this.compact,
    required this.expanded,
    required this.loading,
    this.previewImage,
    required this.onTogglePreview,
    required this.onSelect,
    required this.onRemove,
    required this.onReorder,
    required this.onRegionChanged,
  });
  ExportItem? get item => items.isEmpty ? null : items[selected];
  String _pageName(String id) => source.getPageName(id);
  @override
  Widget build(BuildContext context) {
    final item = this.item;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            compact ? 20 : 24,
            20,
            compact ? 20 : 24,
            multiple
                ? 0
                : compact
                ? 20
                : 24,
          ),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              if (item == null)
                Padding(
                  padding: const .all(20),
                  child: Text(AppLocalizations.of(context).noExportItems),
                )
              else if (compact) ...[
                Row(
                  children: [
                    Tooltip(
                      message: expanded
                          ? AppLocalizations.of(context).collapsePreview
                          : AppLocalizations.of(context).expandPreview,
                      child: InkWell(
                        onTap: () => onTogglePreview(),
                        child: SizedBox(width: 76, child: _preview(68)),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            item.getLocalizedName(context),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall,
                          ),
                          if (_pageName(item.page).isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              _pageName(item.page),
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                if (!multiple) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(AppLocalizations.of(context).exportRegion),
                      ),
                      _regionSelector(context),
                    ],
                  ),
                ],
                if (expanded) ...[const SizedBox(height: 16), _preview(180)],
              ] else ...[
                SizedBox(
                  height: kMinInteractiveDimension,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.getLocalizedName(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      if (!multiple) _regionSelector(context),
                    ],
                  ),
                ),
                if (_pageName(item.page).isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(_pageName(item.page), style: theme.textTheme.bodySmall),
                ],
                const SizedBox(height: 20),
                _preview(220),
              ],
              if (multiple) ...[
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context).exportItems,
                      style: theme.textTheme.titleSmall,
                    ),
                    const Spacer(),
                    Text('${items.length}', style: theme.textTheme.bodySmall),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ],
          ),
        ),
        if (multiple)
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
            child: ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              buildDefaultDragHandles: false,
              itemCount: items.length,
              onReorderItem: (oldIndex, newIndex) =>
                  onReorder(oldIndex, newIndex),
              itemBuilder: (context, index) => Padding(
                key: ObjectKey(items[index]),
                padding: const EdgeInsets.only(bottom: 4),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  minLeadingWidth: 16,
                  selected: index == selected,
                  leading: Text(
                    '${index + 1}',
                    style: theme.textTheme.bodySmall,
                  ),
                  title: Text(
                    items[index].getLocalizedName(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle:
                      _pageName(items[index].page).isEmpty ||
                          items[index].region == .page ||
                          items[index].getLocalizedName(context) ==
                              _pageName(items[index].page)
                      ? null
                      : Text(_pageName(items[index].page)),
                  onTap: () => onSelect(index),
                  trailing: Row(
                    mainAxisSize: .min,
                    children: [
                      IconButton(
                        tooltip: AppLocalizations.of(context).remove,
                        icon: const PhosphorIcon(PhosphorIconsLight.x),
                        onPressed: () => onRemove(index),
                      ),
                      ReorderableDragStartListener(
                        index: index,
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: PhosphorIcon(
                            PhosphorIconsLight.dotsSixVertical,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _regionSelector(BuildContext context) => SegmentedButton<ExportRegion>(
    key: const ValueKey('export-region'),
    showSelectedIcon: false,
    emptySelectionAllowed: true,
    segments: [
      ButtonSegment(
        value: .view,
        tooltip: AppLocalizations.of(context).currentView,
        icon: const PhosphorIcon(PhosphorIconsLight.userRectangle),
      ),
      ButtonSegment(
        value: .page,
        tooltip: AppLocalizations.of(context).currentPage,
        icon: const PhosphorIcon(PhosphorIconsLight.file),
      ),
    ],
    selected: {
      if (item?.region == .view || item?.region == .page) item!.region,
    },
    onSelectionChanged: (values) {
      if (values.isNotEmpty) onRegionChanged(values.first);
    },
  );

  Widget _preview(double height) {
    return SizedBox(
      height: height,
      child: Card.filled(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: loading
              ? const Center(child: CircularProgressIndicator())
              : previewImage == null
              ? const Center(child: PhosphorIcon(PhosphorIconsLight.image))
              : Image.memory(
                  previewImage!,
                  fit: BoxFit.contain,
                  gaplessPlayback: true,
                ),
        ),
      ),
    );
  }
}

class _ExportAreaSelectionDialog extends StatelessWidget {
  final ExportSource source;
  final List<ExportItem> items;
  const _ExportAreaSelectionDialog({required this.source, required this.items});
  @override
  Widget build(BuildContext context) => SimpleDialog(
    title: Text(AppLocalizations.of(context).area),
    children: [
      for (final item in items)
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context, item),
          child: ListTile(
            title: Text(item.getLocalizedName(context)),
            subtitle: Text(source.getPageName(item.page)),
          ),
        ),
    ],
  );
}
