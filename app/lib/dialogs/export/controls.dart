part of 'batch.dart';

class _ExportDialogLayout extends StatelessWidget {
  final Widget header, footer;
  final Widget Function(bool compact) selectionBuilder, configurationBuilder;
  final bool multiple, exporting;
  final double progress;
  const _ExportDialogLayout({
    required this.header,
    required this.footer,
    required this.selectionBuilder,
    required this.configurationBuilder,
    required this.multiple,
    required this.exporting,
    required this.progress,
  });
  @override
  Widget build(BuildContext context) => PopScope(
    canPop: !exporting,
    child: AbsorbPointer(
      absorbing: exporting,
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width < 730 ? 12 : 32,
          vertical: 16,
        ),
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1040, maxHeight: 720),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            children: [
              header,
              const Divider(height: 1),
              Flexible(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 650) {
                      return SingleChildScrollView(
                        key: const ValueKey('export-mobile-scroll'),
                        child: Column(
                          crossAxisAlignment: .stretch,
                          children: [
                            selectionBuilder(true),
                            configurationBuilder(true),
                          ],
                        ),
                      );
                    }
                    return SizedBox(
                      height: math.min(
                        constraints.maxHeight,
                        multiple ? 540.0 : 400.0,
                      ),
                      child: Row(
                        crossAxisAlignment: .stretch,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Material(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerLow,
                              child: SingleChildScrollView(
                                key: const ValueKey('export-preview-scroll'),
                                child: selectionBuilder(false),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: SingleChildScrollView(
                              key: const ValueKey('export-settings-scroll'),
                              child: configurationBuilder(false),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Divider(height: 1),
              if (exporting) LinearProgressIndicator(value: progress),
              footer,
            ],
          ),
        ),
      ),
    ),
  );
}

class _ExportDialogHeader extends StatelessWidget {
  final List<ExportPreset> presets;
  final VoidCallback? onPin, onSavePreset;
  final VoidCallback onManagePresets;
  final ValueChanged<ExportPreset> onLoadPreset;
  final ValueChanged<ExportScope> onAdd;
  const _ExportDialogHeader({
    required this.presets,
    this.onPin,
    this.onSavePreset,
    required this.onManagePresets,
    required this.onLoadPreset,
    required this.onAdd,
  });
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Header(
      centerTitle: false,
      title: Text(l.export),
      leading: const PhosphorIcon(PhosphorIconsLight.export),
      actions: [
        if (MediaQuery.sizeOf(context).width >= 650) ...[
          IconButton(
            tooltip: l.help,
            icon: const PhosphorIcon(PhosphorIconsLight.sealQuestion),
            onPressed: () => openHelp(['exporting']),
          ),
          if (onPin != null)
            IconButton(
              tooltip: l.pin,
              icon: const PhosphorIcon(PhosphorIconsLight.pushPin),
              onPressed: onPin,
            ),
        ] else
          MenuAnchor(
            menuChildren: [
              MenuItemButton(
                leadingIcon: const PhosphorIcon(
                  PhosphorIconsLight.sealQuestion,
                ),
                onPressed: () => openHelp(['exporting']),
                child: Text(l.help),
              ),
              if (onPin != null)
                MenuItemButton(
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.pushPin),
                  onPressed: onPin,
                  child: Text(l.pin),
                ),
            ],
            builder: (context, controller, child) => IconButton(
              tooltip: l.moreOptions,
              icon: const PhosphorIcon(PhosphorIconsLight.dotsThreeVertical),
              onPressed: () =>
                  controller.isOpen ? controller.close() : controller.open(),
            ),
          ),
        MenuAnchor(
          menuChildren: [
            for (final preset in presets)
              MenuItemButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.bookmark),
                onPressed: () => onLoadPreset(preset),
                child: Text(preset.name),
              ),
            if (presets.isNotEmpty) const Divider(),
            MenuItemButton(
              leadingIcon: const PhosphorIcon(PhosphorIconsLight.plus),
              onPressed: onSavePreset,
              child: Text(l.saveExportSelection),
            ),
            MenuItemButton(
              leadingIcon: const PhosphorIcon(PhosphorIconsLight.gear),
              onPressed: onManagePresets,
              child: Text(l.managePresets),
            ),
          ],
          builder: (context, controller, child) => IconButton(
            tooltip: l.presets,
            icon: const PhosphorIcon(PhosphorIconsLight.bookmark),
            onPressed: () =>
                controller.isOpen ? controller.close() : controller.open(),
          ),
        ),
        MenuAnchor(
          menuChildren: [
            for (final entry in const {
              ExportScope.view: PhosphorIconsLight.userRectangle,
              ExportScope.page: PhosphorIconsLight.file,
              ExportScope.area: PhosphorIconsLight.selection,
            }.entries)
              MenuItemButton(
                leadingIcon: PhosphorIcon(entry.value),
                onPressed: () => onAdd(entry.key),
                child: Text(entry.key.getLocalizedName(context)),
              ),
            const Divider(),
            for (final entry in const {
              ExportScope.allPages: PhosphorIconsLight.files,
              ExportScope.pageAreas: PhosphorIconsLight.selectionAll,
              ExportScope.allAreas: PhosphorIconsLight.selection,
            }.entries)
              MenuItemButton(
                leadingIcon: PhosphorIcon(entry.value),
                onPressed: () => onAdd(entry.key),
                child: Text(entry.key.getLocalizedName(context)),
              ),
          ],
          builder: (context, controller, child) => IconButton(
            tooltip: l.addExport,
            icon: const PhosphorIcon(PhosphorIconsLight.plus),
            onPressed: () =>
                controller.isOpen ? controller.close() : controller.open(),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class _ExportDialogFooter extends StatelessWidget {
  final ExportFormat format;
  final ExportItem? item;
  final int count;
  final String fileName;
  final bool exporting;
  final VoidCallback? onShare, onExport;
  const _ExportDialogFooter({
    required this.format,
    required this.item,
    required this.count,
    required this.fileName,
    required this.exporting,
    this.onShare,
    this.onExport,
  });
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Padding(
      padding: const .all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final information = Row(
            children: [
              PhosphorIcon(format.icon()),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      fileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      (format == .pdf)
                          ? '${l.pdfExportSummary(count)} · $_pixelSize'
                          : '${l.imageExportSummary(count, format.label)} · $_pixelSize',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          );
          final share = TextButton(onPressed: onShare, child: Text(l.share));
          final export = FilledButton.icon(
            onPressed: onExport,
            icon: exporting
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const PhosphorIcon(PhosphorIconsLight.export),
            label: Text(l.export),
          );
          if (constraints.maxWidth < 650) {
            return Column(
              crossAxisAlignment: .stretch,
              children: [
                information,
                const SizedBox(height: 12),
                Row(
                  children: [
                    share,
                    const SizedBox(width: 12),
                    Expanded(child: export),
                  ],
                ),
              ],
            );
          }
          return Row(
            children: [
              Expanded(child: information),
              const SizedBox(width: 16),
              share,
              const SizedBox(width: 8),
              export,
            ],
          );
        },
      ),
    );
  }

  String get _pixelSize {
    final o = item?.options;
    if (o == null) return '';
    final size = exportPixelSize(
      format == .svg ? o.toImageOptions().copyWith(quality: 1) : o,
    );
    return '${size.width.toInt()} × ${size.height.toInt()} px';
  }
}

class _ExportPresetsDialog extends StatefulWidget {
  final ExportSource source;
  final List<AreaPreset> areas;
  const _ExportPresetsDialog({required this.source, required this.areas});
  @override
  State<_ExportPresetsDialog> createState() => _ExportPresetsDialogState();
}

class _ExportPresetsDialogState extends State<_ExportPresetsDialog> {
  String _search = '';
  @override
  Widget build(BuildContext context) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300, maxHeight: 500),
      child: Column(
        mainAxisSize: .min,
        children: [
          Header(
            title: Text(AppLocalizations.of(context).presets),
            actions: [
              IconButton(
                tooltip: LeapLocalizations.of(context).create,
                icon: const PhosphorIcon(PhosphorIconsLight.plus),
                onPressed: () async {
                  final name = await showDialog<String>(
                    context: context,
                    builder: (context) => NameDialog(
                      validator: defaultNameValidator(
                        context,
                        widget.source.presets.map((e) => e.name).toList(),
                      ),
                    ),
                  );
                  if (name != null && mounted) {
                    setState(
                      () => widget.source.savePreset(
                        ExportPreset(name: name, areas: widget.areas),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          Padding(
            padding: const .all(8),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).search,
                filled: true,
              ),
              onChanged: (v) => setState(() => _search = v),
            ),
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                for (final p in widget.source.presets.where(
                  (e) => e.name.contains(_search),
                ))
                  ListTile(
                    title: Text(p.name),
                    onTap: () => Navigator.pop(context, p),
                    trailing: IconButton(
                      tooltip: AppLocalizations.of(context).remove,
                      icon: const PhosphorIcon(PhosphorIconsLight.trash),
                      onPressed: () async {
                        final delete = await showDialog<bool>(
                          context: context,
                          builder: (context) => const DeleteDialog(),
                        );
                        if (delete == true && mounted) {
                          setState(() => widget.source.removePreset(p.name));
                        }
                      },
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const .all(8),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
          ),
        ],
      ),
    ),
  );
}

extension _ExportFormatVisualizer on ExportFormat {
  PhosphorIconData icon() => switch (this) {
    .svg => PhosphorIconsLight.fileSvg,
    .pdf => PhosphorIconsLight.filePdf,
    _ => PhosphorIconsLight.image,
  };
}

extension _ExportScopeVisualizer on ExportScope {
  String getLocalizedName(BuildContext context) {
    final l = AppLocalizations.of(context);
    return switch (this) {
      .view => l.currentView,
      .page => l.currentPage,
      .area => l.area,
      .allPages => l.allPagesInNote,
      .pageAreas => l.allAreasOnPage,
      .allAreas => l.allAreasInNote,
    };
  }
}

extension _ExportItemVisualizer on ExportItem {
  String getLocalizedName(BuildContext context) => region == .view
      ? AppLocalizations.of(context).currentView
      : name.isNotEmpty
      ? name
      : region == .page
      ? AppLocalizations.of(context).currentPage
      : AppLocalizations.of(context).custom;
}

extension _ExportSourceVisualizer on ExportSource {
  String getPageName(String id) =>
      pages.where((e) => e.$2 == id).firstOrNull?.$1 ?? id;
}
