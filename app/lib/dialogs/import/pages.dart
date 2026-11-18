import 'dart:ui' as ui;

import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/widgets/color_field.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../pages.dart';

const _defaultScalePercent = 100.0;

@immutable
class PageDialogCallback {
  final List<int> pages;
  final bool spreadToPages, createAreas, createExportPreset, invert;
  final SRGBColor background;
  final String name;
  final double scale;

  const PageDialogCallback(
    this.pages,
    this.spreadToPages,
    this.createAreas,
    this.createExportPreset,
    this.background,
    this.invert,
    this.name, {
    required this.scale,
  });
}

class ImportPagesDialog extends StatefulWidget {
  final List<ui.Image> pages;
  final String? name;

  const ImportPagesDialog({super.key, required this.pages, this.name});

  @override
  State<ImportPagesDialog> createState() => _ImportPagesDialogState();
}

class _ImportPagesDialogState extends State<ImportPagesDialog> {
  final Set<int> _selected = {};
  final _thumbnailScroll = ScrollController();
  bool _spreadToPages = false,
      _createAreas = true,
      _createExportPreset = true,
      _invert = false;
  SRGBColor _background = BasicColors.whiteTransparent;
  String _name = '';
  double _scalePercent = _defaultScalePercent;

  Iterable<int> get _pageIndexes => widget.pages.asMap().keys;

  @override
  void initState() {
    super.initState();
    _selected.addAll(_pageIndexes);
    _name = widget.name ?? '';
    _spreadToPages = context.read<SettingsCubit>().state.spreadPages;
  }

  @override
  void dispose() {
    _thumbnailScroll.dispose();
    super.dispose();
  }

  Future<void> _selectPages() async {
    final loc = AppLocalizations.of(context);
    final selected = await showDialog<List<String>>(
      context: context,
      builder: (context) => SelectPagesDialog(
        pages: [
          for (final index in _pageIndexes)
            (loc.pageIndex(index + 1), '$index'),
        ],
        initialSelected: _selected.map((index) => '$index'),
      ),
    );
    if (!mounted || selected == null) return;
    setState(() {
      _selected
        ..clear()
        ..addAll(selected.map(int.parse));
    });
  }

  void _submit() => Navigator.pop(
    context,
    PageDialogCallback(
      _pageIndexes.where(_selected.contains).toList(),
      _spreadToPages,
      _createAreas,
      _createExportPreset,
      _background,
      _invert,
      _name,
      scale: _scalePercent / 100,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width < 730 ? 12 : 32,
        vertical: 16,
      ),
      constraints: const BoxConstraints(maxWidth: 940, maxHeight: 660),
      clipBehavior: .antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          crossAxisAlignment: .stretch,
          children: [
            Header(
              centerTitle: false,
              leading: const PhosphorIcon(PhosphorIconsLight.filePdf),
              title: Text(loc.importPdf),
            ),
            const Divider(height: 1),
            Expanded(
              child: constraints.maxWidth < 680
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: .stretch,
                        children: [
                          _buildPagePane(context, compact: true),
                          const Divider(height: 1),
                          _buildSettings(context),
                        ],
                      ),
                    )
                  : Row(
                      crossAxisAlignment: .stretch,
                      children: [
                        Expanded(
                          child: _buildPagePane(context, compact: false),
                        ),
                        SizedBox(
                          width: 320,
                          child: SingleChildScrollView(
                            primary: false,
                            child: _buildSettings(context),
                          ),
                        ),
                      ],
                    ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: OverflowBar(
                alignment: .end,
                overflowAlignment: .end,
                spacing: 8,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      MaterialLocalizations.of(context).cancelButtonLabel,
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: _selected.isEmpty ? null : _submit,
                    icon: const PhosphorIcon(PhosphorIconsLight.arrowSquareIn),
                    label: Text(loc.import),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPagePane(BuildContext context, {required bool compact}) {
    final colorScheme = ColorScheme.of(context);
    final loc = AppLocalizations.of(context);
    final allSelected = _selected.length == widget.pages.length;
    return Material(
      color: colorScheme.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 4, 8, 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    loc.pdfImportSelectionCount(
                      _selected.length,
                      widget.pages.length,
                    ),
                    style: TextTheme.of(context).titleSmall,
                  ),
                ),
                IconButton(
                  tooltip: allSelected ? loc.deselect : loc.selectAll,
                  icon: PhosphorIcon(
                    allSelected
                        ? PhosphorIconsLight.selectionSlash
                        : PhosphorIconsLight.selectionAll,
                  ),
                  onPressed: widget.pages.isEmpty
                      ? null
                      : () => setState(() {
                          _selected.clear();
                          if (!allSelected) _selected.addAll(_pageIndexes);
                        }),
                ),
                IconButton(
                  tooltip: loc.invertSelection,
                  icon: const PhosphorIcon(PhosphorIconsLight.selectionInverse),
                  onPressed: widget.pages.isEmpty
                      ? null
                      : () => setState(() {
                          final inverted = _pageIndexes.toSet().difference(
                            _selected,
                          );
                          _selected
                            ..clear()
                            ..addAll(inverted);
                        }),
                ),
                IconButton(
                  tooltip: loc.selectPages,
                  icon: const PhosphorIcon(PhosphorIconsLight.listNumbers),
                  onPressed: widget.pages.isEmpty ? null : _selectPages,
                ),
              ],
            ),
          ),
          if (compact)
            SizedBox(
              height: 152,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context)
                    .copyWith(scrollbars: false),
                child: Scrollbar(
                  controller: _thumbnailScroll,
                  child: ListView.separated(
                    controller: _thumbnailScroll,
                    scrollDirection: .horizontal,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                    itemCount: widget.pages.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemBuilder: (context, index) => SizedBox(
                      width: 118,
                      child: _buildThumbnail(context, index),
                    ),
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: GridView.builder(
                primary: false,
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 205,
                  mainAxisExtent: 196,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: widget.pages.length,
                itemBuilder: _buildThumbnail,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildThumbnail(BuildContext context, int index) {
    final label = AppLocalizations.of(context).pageIndex(index + 1);
    final selected = _selected.contains(index);
    void setSelected(bool? value) => setState(() {
      if (value == true) {
        _selected.add(index);
      } else {
        _selected.remove(index);
      }
    });

    return Card.filled(
      margin: EdgeInsets.zero,
      clipBehavior: .antiAlias,
      child: InkWell(
        canRequestFocus: false,
        excludeFromSemantics: true,
        onTap: () => setSelected(!selected),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: _background.toColor()),
                    child: RawImage(
                      image: widget.pages[index],
                      fit: .contain,
                      invertColors: _invert,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ExcludeSemantics(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: .ellipsis,
                        style: TextTheme.of(context).bodySmall,
                      ),
                    ),
                  ),
                  Checkbox(
                    value: selected,
                    onChanged: setSelected,
                    semanticLabel: label,
                    materialTapTargetSize: .shrinkWrap,
                    visualDensity: .compact,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettings(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          ExactSlider(
            header: Text(loc.pdfScale, style: TextTheme.of(context).titleSmall),
            label: '%',
            value: _scalePercent,
            defaultValue: _defaultScalePercent,
            min: 10,
            max: 1000,
            sliderStep: 1,
            fractionDigits: 0,
            clampValue: true,
            inline: false,
            onChanged: (value) => setState(() => _scalePercent = value),
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: InputDecoration(
              labelText: LeapLocalizations.of(context).name,
              filled: true,
            ),
            initialValue: _name,
            onChanged: (value) => _name = value,
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: .zero,
            secondary: const PhosphorIcon(PhosphorIconsLight.files),
            value: _spreadToPages,
            onChanged: (value) => setState(() => _spreadToPages = value),
            title: Text(loc.spreadToPages),
          ),
          const Divider(height: 1),
          ExpansionTile(
            tilePadding: .zero,
            leading: const PhosphorIcon(PhosphorIconsLight.slidersHorizontal),
            title: Text(loc.moreOptions),
            children: [
              CheckboxListTile(
                contentPadding: .zero,
                value: _createAreas,
                onChanged: (value) => setState(() => _createAreas = value!),
                title: Text(loc.createAreas),
              ),
              CheckboxListTile(
                contentPadding: .zero,
                value: _createExportPreset,
                onChanged: (value) =>
                    setState(() => _createExportPreset = value!),
                title: Text(loc.pdfImportCreateExportPreset),
              ),
              const Divider(height: 1),
              ColorField(
                value: _background.withValues(a: 255),
                custom: true,
                onChanged: (value) => setState(() {
                  _background = value.withValues(a: _background.a);
                }),
                title: Text(loc.background),
              ),
              ExactSlider(
                header: Text(loc.alpha),
                value: _background.a.toDouble(),
                fractionDigits: 0,
                min: 0,
                max: 255,
                sliderStep: 1,
                defaultValue: 255,
                clampValue: true,
                inline: false,
                onChanged: (value) => setState(() {
                  _background = _background.withValues(a: value.toInt());
                }),
              ),
              CheckboxListTile(
                contentPadding: .zero,
                value: _invert,
                onChanged: (value) => setState(() => _invert = value!),
                title: Text(loc.invert),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
