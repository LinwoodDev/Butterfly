import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/delete.dart';
import 'package:butterfly/helpers/async.dart';
import 'package:butterfly/services/batch_export.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_leap/material_leap.dart';
import 'package:material_ui/material_ui.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:synchronized/synchronized.dart';

part 'controls.dart';
part 'selection.dart';
part 'settings.dart';

Future<void> showExportDialog(
  BuildContext context, {
  DocumentBloc? bloc,
  ExportFormat? format,
  ExportOptions? options,
  List<AreaPreset>? areas,
}) {
  bloc ??= context.read<DocumentBloc>();
  final state = bloc.state;
  if (state is! DocumentLoaded) return Future.value();
  final transform = bloc.editorController.transformCubit.state;
  final size = MediaQuery.sizeOf(context);
  final source = DocumentExportSource(
    bloc,
    state,
    ImageExportOptions(
      width: size.width,
      height: size.height,
      x: transform.position.dx,
      y: transform.position.dy,
      scale: transform.size,
      rotation: transform.rotation,
    ),
  );
  final items = areas != null && areas.isNotEmpty
      ? source.fromPreset(ExportPreset(areas: areas))
      : options == null
      ? null
      : [
          ExportItem(
            NoteData.getPageNameFromRealName(state.pageName),
            state.pageName,
            options,
          ),
        ];
  return showDialog<void>(
    context: context,
    builder: (context) => BatchExportDialog(
      source: source,
      items: items,
      format: format ?? (options is SvgExportOptions ? .svg : .png),
    ),
  );
}

class BatchExportDialog extends StatefulWidget {
  final ExportSource source;
  final List<ExportItem>? items;
  final ExportFormat format;
  const BatchExportDialog({
    super.key,
    required this.source,
    this.items,
    this.format = .png,
  });
  @override
  State<BatchExportDialog> createState() => _BatchExportDialogState();
}

class _BatchExportDialogState extends State<BatchExportDialog> {
  ExportFormat _format = .png;
  int _selected = 0;
  bool _mobilePreviewExpanded = false;
  late final List<ExportItem> _items;
  List<ExportPreset> get _presets => widget.source.presets;
  final _previewRunner = LatestAsyncRunner();
  final _previewLock = Lock();
  _PaddingMode? _paddingMode;
  Uint8List? _previewImage;
  String? _error;
  bool _previewLoading = false;
  bool _exporting = false;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _items = (widget.items ?? [widget.source.view()])
        .map((e) => e.copy())
        .toList();
    _setFormat(widget.format);
  }

  @override
  void dispose() {
    _previewRunner.dispose();
    super.dispose();
  }

  void _update(VoidCallback change) {
    setState(() {
      change();
      _error = null;
    });
    _regeneratePreview();
  }

  void _regeneratePreview() {
    final item = _item?.copy();
    if (item == null) {
      _previewRunner.cancel();
      setState(() {
        _previewImage = null;
        _previewLoading = false;
      });
      return;
    }
    setState(() {
      _previewLoading = true;
      _previewImage = null;
    });
    _previewRunner.run(
      (task) => _previewLock.synchronized(() async {
        if (task.isCanceled) return null;
        return widget.source.renderPng(item, preview: true);
      }),
      onCompleted: (bytes) => setState(() {
        _previewLoading = false;
        _previewImage = bytes;
      }),
      onError: (error, stack) => setState(() {
        _previewLoading = false;
        _error = error.toString();
      }),
    );
  }

  ExportItem? get _item => _items.isEmpty ? null : _items[_selected];
  bool get _pdf => _format == .pdf;
  bool get _multiple => _pdf || _items.length != 1;
  void _change(ExportOptions options) => _update(() {
    final item = _item;
    if (item == null) return;
    final before = item.options;
    if (before.width != options.width ||
        before.height != options.height ||
        before.x != options.x ||
        before.y != options.y ||
        before.scale != options.scale ||
        before.rotation != options.rotation) {
      item.region = .custom;
    }
    item.options = options;
  });
  void _setFormat(ExportFormat format) => _update(() {
    _format = format;
    for (final item in _items) {
      final o = item.options;
      if (o is ImageExportOptions) item.rasterQuality = o.quality;
      item.options = format == .svg
          ? SvgExportOptions(
              width: o.width,
              height: o.height,
              x: o.x,
              y: o.y,
              scale: o.scale,
              rotation: o.rotation,
              padding: o.padding,
              renderBackground: o.renderBackground,
            )
          : o.toImageOptions().copyWith(quality: item.rasterQuality);
    }
  });
  Future<void> _add(ExportScope scope) async {
    try {
      var items = await widget.source.items(scope);
      if (!mounted) return;
      if (scope == .area) {
        final all = await widget.source.items(.allAreas);
        if (!mounted) return;
        if (all.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).noExportItems)),
          );
          return;
        }
        final selected = await showDialog<ExportItem>(
          context: context,
          builder: (context) =>
              _ExportAreaSelectionDialog(source: widget.source, items: all),
        );
        if (!mounted || selected == null) return;
        items = [selected];
      }
      if (items.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).noExportItems)),
        );
        return;
      }
      setState(() {
        _paddingMode = null;
        _selected = _items.length;
        _items.addAll(items);
        _mobilePreviewExpanded = false;
      });
      _setFormat(_format);
    } catch (error) {
      if (mounted) setState(() => _error = error.toString());
    }
  }

  List<AreaPreset> get _currentAreas => [
    for (final it in _items)
      AreaPreset(
        page: it.page,
        options: it.options,
        name: it.getLocalizedName(context),
        quality: it.options is ImageExportOptions
            ? it.options.toImageOptions().quality
            : it.rasterQuality,
        area: Area(
          name: it.getLocalizedName(context),
          position: math.Point(it.options.x, it.options.y),
          width: it.options.width,
          height: it.options.height,
        ),
      ),
  ];

  Future<void> _savePreset() async {
    final areas = _currentAreas;
    final name = await showDialog<String>(
      context: context,
      builder: (context) => NameDialog(
        validator: defaultNameValidator(
          context,
          _presets.map((e) => e.name).toList(),
        ),
      ),
    );
    if (name != null && mounted) {
      _update(
        () => widget.source.savePreset(ExportPreset(name: name, areas: areas)),
      );
    }
  }

  Future<void> _showPresets() async {
    final preset = await showDialog<ExportPreset>(
      context: context,
      builder: (context) =>
          _ExportPresetsDialog(source: widget.source, areas: _currentAreas),
    );
    if (!mounted) return;
    if (preset != null) {
      _loadPreset(preset);
    } else {
      _update(() {});
    }
  }

  void _loadPreset(ExportPreset preset) {
    try {
      final items = widget.source.fromPreset(preset);
      _update(() {
        _items
          ..clear()
          ..addAll(items);
        _selected = 0;
        _mobilePreviewExpanded = false;
      });
      _setFormat(_format);
    } catch (error) {
      setState(() => _error = error.toString());
    }
  }

  void _applyToAll() {
    final source = _item?.options;
    if (source == null) return;
    _update(() {
      for (final it in _items) {
        it.options = it.options.copyWith(
          scale: source.scale,
          rotation: source.rotation,
          padding: source.padding,
          renderBackground: source.renderBackground,
        );
        if (it.options case final ImageExportOptions o) {
          it.options = o.copyWith(quality: source.toImageOptions().quality);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) => _ExportDialogLayout(
    header: _ExportDialogHeader(
      presets: _presets,
      onPin:
          !_multiple &&
              widget.source.canPin &&
              _item != null &&
              (_format == .png || _format == .svg)
          ? () {
              widget.source.pin(_item!);
              Navigator.pop(context);
            }
          : null,
      onSavePreset: _items.isEmpty ? null : _savePreset,
      onManagePresets: _showPresets,
      onLoadPreset: _loadPreset,
      onAdd: _add,
    ),
    footer: _ExportDialogFooter(
      format: _format,
      item: _item,
      count: _items.length,
      fileName: exportFileName(widget.source, _items, _format),
      exporting: _exporting,
      onShare: _canExport ? () => _output(true) : null,
      onExport: _canExport ? () => _output(false) : null,
    ),
    selectionBuilder: (compact) => _selection(compact: compact),
    configurationBuilder: (compact) => _configuration(compact: compact),
    multiple: _multiple,
    exporting: _exporting,
    progress: _progress,
  );

  bool get _canExport =>
      _items.isNotEmpty && !_exporting && _constraint == null;

  Widget _selection({required bool compact}) => _ExportSelectionPane(
    source: widget.source,
    items: _items,
    selected: _selected,
    multiple: _multiple,
    compact: compact,
    expanded: _mobilePreviewExpanded,
    loading: _previewLoading,
    previewImage: _previewImage,
    onTogglePreview: () =>
        _update(() => _mobilePreviewExpanded = !_mobilePreviewExpanded),
    onSelect: (index) => _update(() {
      _selected = index;
      _paddingMode = null;
    }),
    onRemove: (index) => _update(() {
      final selected = _item;
      _items.removeAt(index);
      _selected = selected != null && _items.contains(selected)
          ? _items.indexOf(selected)
          : math.max(0, math.min(index, _items.length - 1));
    }),
    onReorder: (oldIndex, newIndex) => _update(() {
      final selected = _item;
      final item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
      _selected = _items.indexOf(selected!);
    }),
    onRegionChanged: _changeRegion,
  );

  Widget _configuration({required bool compact}) => _ExportConfigurationPane(
    item: _item,
    format: _format,
    compact: compact,
    error: _error ?? _constraint,
    paddingMode: _paddingMode,
    onPaddingModeChanged: (mode) => setState(() => _paddingMode = mode),
    onFormatChanged: _setFormat,
    onChanged: _change,
    onApplyToAll: _items.length > 1 ? _applyToAll : null,
  );

  Future<void> _changeRegion(ExportRegion region) async {
    if (_item == null) return;
    final selected = _item!;
    try {
      final next = region == .view
          ? widget.source.view()
          : await widget.source.page(selected.page);
      if (!mounted || !identical(selected, _item)) return;
      next.options = selected.options.copyWith(
        width: next.options.width,
        height: next.options.height,
        x: next.options.x,
        y: next.options.y,
        scale: next.options.scale,
        rotation: next.options.rotation,
      );
      next.rasterQuality = selected.rasterQuality;
      _update(() {
        _items[_selected] = next;
        _paddingMode = null;
      });
    } catch (error) {
      if (mounted) setState(() => _error = error.toString());
    }
  }

  String? get _constraint {
    for (final item in _items) {
      final size = exportPixelSize(item.options);
      if ((_format == .ico || _format == .cur) &&
          (size.width > 256 || size.height > 256)) {
        return AppLocalizations.of(context).iconExportSize;
      }
      if (_format == .pvr &&
          (size.width != size.height ||
              size.width < 8 ||
              (size.width.toInt() & (size.width.toInt() - 1)) != 0)) {
        return AppLocalizations.of(context).pvrExportSize;
      }
    }
    return null;
  }

  Future<void> _output(bool share) async {
    _previewRunner.cancel();
    setState(() {
      _exporting = true;
      _progress = 0;
      _error = null;
    });
    try {
      final output = await buildExport(
        widget.source,
        _items,
        _format,
        onProgress: (value) {
          if (mounted) setState(() => _progress = value);
        },
      );
      if (!mounted) return;
      await exportFile(
        context: context,
        bytes: output.bytes,
        mimeType: output.mimeType,
        uniformTypeIdentifier: output.uniformTypeIdentifier,
        fileName: output.fileName,
        label: AppLocalizations.of(context).export,
        share:
            share &&
            (_format != .svg ||
                _items.length > 1 ||
                kIsWeb ||
                !Platform.isWindows),
      );
      if (mounted) Navigator.pop(context);
    } catch (error) {
      if (mounted) setState(() => _error = error.toString());
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }
}
