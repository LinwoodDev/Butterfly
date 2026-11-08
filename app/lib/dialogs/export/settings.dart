part of 'batch.dart';

class _ExportConfigurationPane extends StatelessWidget {
  final ExportItem? item;
  final ExportFormat format;
  final String? error;
  final bool compact;
  final _PaddingMode? paddingMode;
  final ValueChanged<_PaddingMode?> onPaddingModeChanged;
  final ValueChanged<ExportFormat> onFormatChanged;
  final ValueChanged<ExportOptions> onChanged;
  final VoidCallback? onApplyToAll;
  const _ExportConfigurationPane({
    required this.item,
    required this.format,
    this.error,
    required this.compact,
    this.paddingMode,
    required this.onPaddingModeChanged,
    required this.onFormatChanged,
    required this.onChanged,
    this.onApplyToAll,
  });
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context), o = item?.options;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          SizedBox(
            height: kMinInteractiveDimension,
            child: Row(
              children: [
                Expanded(
                  child: Text(l.exportAs, style: theme.textTheme.titleSmall),
                ),
                MenuAnchor(
                  menuChildren: [
                    for (final group in {
                      l.images: [
                        ExportFormat.png,
                        ExportFormat.jpg,
                        ExportFormat.webp,
                      ],
                      l.vectorAndPdf: [ExportFormat.svg, ExportFormat.pdf],
                      l.otherImages: [
                        ExportFormat.tiff,
                        ExportFormat.gif,
                        ExportFormat.bmp,
                        ExportFormat.tga,
                        ExportFormat.ico,
                        ExportFormat.cur,
                        ExportFormat.pvr,
                      ],
                    }.entries)
                      SubmenuButton(
                        leadingIcon: PhosphorIcon(group.value.first.icon()),
                        menuChildren: [
                          for (final format in group.value)
                            MenuItemButton(
                              leadingIcon: PhosphorIcon(format.icon()),
                              trailingIcon: format == this.format
                                  ? const PhosphorIcon(PhosphorIconsLight.check)
                                  : null,
                              onPressed: () => onFormatChanged(format),
                              child: Text(format.label),
                            ),
                        ],
                        child: Text(group.key),
                      ),
                  ],
                  builder: (context, controller, child) => OutlinedButton.icon(
                    key: const ValueKey('export-format'),
                    onPressed: () => controller.isOpen
                        ? controller.close()
                        : controller.open(),
                    icon: PhosphorIcon(format.icon()),
                    label: Row(
                      mainAxisSize: .min,
                      children: [
                        Text(format.label),
                        const SizedBox(width: 8),
                        const PhosphorIcon(PhosphorIconsLight.caretDown),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                error!,
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ),
          const SizedBox(height: 24),
          if (o != null) ...[
            ...[
              OffsetListTile(
                key: ObjectKey(item),
                title: Text(l.size, style: theme.textTheme.bodyMedium),
                value: Offset(o.width, o.height),
                xLabel: l.width,
                yLabel: l.height,
                inline: true,
                spacing: 12,
                titleSpacing: 24,
                fractionDigits: 3,
                trimTrailingZeros: true,
                min: 1,
                contentPadding: EdgeInsets.zero,
                onChanged: (v) =>
                    onChanged(o.copyWith(width: v.dx, height: v.dy)),
              ),
              const SizedBox(height: 20),
            ],
            if (format != .svg)
              ExactSlider(
                inline: !compact,
                key: ValueKey('export-slider-${l.quality}'),
                header: Text(l.quality),
                headerWidth: 72,
                inputWidth: 64,
                clampValue: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                min: .1,
                max: 10,
                value: o.toImageOptions().quality,
                defaultValue: 1,
                sliderStep: .1,
                onChanged: (v) =>
                    onChanged(o.toImageOptions().copyWith(quality: v)),
              ),
            ...[
              const SizedBox(height: 12),
              CheckboxListTile(
                secondary: const PhosphorIcon(PhosphorIconsLight.circleHalf),
                title: Text(l.background),
                value: o.renderBackground,
                onChanged: (v) =>
                    onChanged(o.copyWith(renderBackground: v ?? true)),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1),
              ExpansionTile(
                leading: const PhosphorIcon(
                  PhosphorIconsLight.slidersHorizontal,
                ),
                title: Text(l.moreOptions),
                children: [
                  OffsetListTile(
                    key: ValueKey((item!, l.position)),
                    title: Text(l.position),
                    value: Offset(o.x, o.y),
                    xLabel: 'X',
                    yLabel: 'Y',
                    inline: !compact,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (v) => onChanged(o.copyWith(x: v.dx, y: v.dy)),
                  ),
                  ExactSlider(
                    inline: !compact,
                    key: ValueKey('export-slider-${l.scale}'),
                    header: Text(l.scale),
                    headerWidth: 72,
                    inputWidth: 64,
                    clampValue: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    min: .1,
                    max: 10,
                    value: o.scale,
                    defaultValue: 1,
                    sliderStep: .1,
                    onChanged: (v) => onChanged(o.copyWith(scale: v)),
                  ),
                  ExactSlider(
                    inline: !compact,
                    key: ValueKey('export-slider-${l.rotation}'),
                    header: Text(l.rotation),
                    headerWidth: 72,
                    inputWidth: 64,
                    clampValue: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    min: -180,
                    max: 180,
                    value: o.rotation * 180 / math.pi,
                    sliderStep: 1,
                    defaultValue: 0,
                    onChanged: (v) =>
                        onChanged(o.copyWith(rotation: v * math.pi / 180)),
                  ),
                  _ExportPaddingFields(
                    value: o.padding,
                    editMode: paddingMode,
                    compact: compact,
                    identity: item!,
                    onModeChanged: onPaddingModeChanged,
                    onChanged: (padding) =>
                        onChanged(o.copyWith(padding: padding)),
                  ),
                ],
              ),
            ],
            if (onApplyToAll != null)
              Align(
                alignment: .centerLeft,
                child: TextButton(
                  onPressed: onApplyToAll,
                  child: Text(l.applySettingsToAll),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

enum _PaddingMode { all, symmetric, perSide }

class _ExportPaddingFields extends StatelessWidget {
  final ExportPadding value;
  final _PaddingMode? editMode;
  final bool compact;
  final Object identity;
  final ValueChanged<ExportPadding> onChanged;
  final ValueChanged<_PaddingMode?> onModeChanged;
  const _ExportPaddingFields({
    required this.value,
    this.editMode,
    required this.compact,
    required this.identity,
    required this.onChanged,
    required this.onModeChanged,
  });
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context), p = value;
    final mode =
        editMode ??
        (p.top == p.right && p.top == p.bottom && p.top == p.left
            ? _PaddingMode.all
            : p.left == p.right && p.top == p.bottom
            ? _PaddingMode.symmetric
            : _PaddingMode.perSide);
    void change(ExportPadding padding) => onChanged(padding);
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: Text(l.padding)),
            DropdownButton<_PaddingMode>(
              value: mode,
              items: [
                for (final entry in {
                  _PaddingMode.all: l.forAll,
                  _PaddingMode.symmetric: l.symmetric,
                  _PaddingMode.perSide: l.perSide,
                }.entries)
                  DropdownMenuItem(value: entry.key, child: Text(entry.value)),
              ],
              onChanged: onModeChanged,
            ),
          ],
        ),
        if (mode == .all)
          ExactSlider(
            inline: !compact,
            key: ValueKey('export-slider-${l.padding}'),
            header: Text(l.padding),
            headerWidth: 72,
            inputWidth: 64,
            clampValue: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 4),
            min: 0,
            max: math.max(500, p.top),
            value: p.top,
            sliderStep: 1,
            defaultValue: 0,
            onChanged: (v) =>
                change(ExportPadding(top: v, right: v, bottom: v, left: v)),
          )
        else if (mode == .symmetric)
          OffsetListTile(
            key: ValueKey((identity, l.symmetric)),
            title: Text(l.symmetric),
            value: Offset(p.left, p.top),
            xLabel: l.horizontal,
            yLabel: l.vertical,
            inline: !compact,
            contentPadding: EdgeInsets.zero,
            onChanged: (v) => change(
              ExportPadding(
                left: math.max(0, v.dx),
                right: math.max(0, v.dx),
                top: math.max(0, v.dy),
                bottom: math.max(0, v.dy),
              ),
            ),
          )
        else ...[
          OffsetListTile(
            key: ValueKey((identity, l.horizontal)),
            title: Text(l.horizontal),
            value: Offset(p.left, p.right),
            xLabel: l.left,
            yLabel: l.right,
            inline: !compact,
            contentPadding: EdgeInsets.zero,
            onChanged: (v) => change(
              p.copyWith(left: math.max(0, v.dx), right: math.max(0, v.dy)),
            ),
          ),
          const SizedBox(height: 8),
          OffsetListTile(
            key: ValueKey((identity, l.vertical)),
            title: Text(l.vertical),
            value: Offset(p.top, p.bottom),
            xLabel: l.top,
            yLabel: l.bottom,
            inline: !compact,
            contentPadding: EdgeInsets.zero,
            onChanged: (v) => change(
              p.copyWith(top: math.max(0, v.dx), bottom: math.max(0, v.dy)),
            ),
          ),
        ],
      ],
    );
  }
}
