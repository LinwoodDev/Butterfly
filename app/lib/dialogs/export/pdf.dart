import 'dart:math';

import 'package:butterfly/api/save.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/dialogs/load.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/document_bloc.dart';

class PdfExportDialog extends StatefulWidget {
  final List<AreaPreset> areas;
  final bool print;

  const PdfExportDialog({super.key, this.areas = const [], this.print = false});

  @override
  State<PdfExportDialog> createState() => _PdfExportDialogState();
}

class _PdfExportDialogState extends State<PdfExportDialog> {
  final List<({Key key, AreaPreset preset})> _areas = [];
  int quality = 1;

  @override
  void initState() {
    super.initState();
    _areas.addAll(widget.areas.map((e) => (key: UniqueKey(), preset: e)));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 700),
        child: BlocBuilder<DocumentBloc, DocumentState>(
          buildWhen: (previous, current) =>
              previous.currentIndexCubit != current.currentIndexCubit ||
              previous.page != current.page ||
              previous.pageName != current.pageName,
          builder: (context, state) {
            if (state is! DocumentLoadSuccess) {
              return const Center(child: CircularProgressIndicator());
            }
            final currentIndex = state.currentIndexCubit;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Header(
                  title: Text(AppLocalizations.of(context).exportPdf),
                  actions: [
                    IconButton(
                      icon: const PhosphorIcon(PhosphorIconsLight.list),
                      tooltip: AppLocalizations.of(context).presets,
                      onPressed: () async {
                        final preset = await showDialog<ExportPreset>(
                          context: context,
                          builder: (ctx) => BlocProvider.value(
                            value: context.read<DocumentBloc>(),
                            child: ExportPresetsDialog(
                              areas: _areas.map((e) => e.preset).toList(),
                            ),
                          ),
                        );
                        if (preset != null) {
                          setState(() {
                            _areas.clear();
                            _areas.addAll(
                              preset.areas.map(
                                (e) => (key: UniqueKey(), preset: e),
                              ),
                            );
                          });
                        }
                      },
                    ),
                    IconButton(
                      onPressed: () async {
                        final result = await showDialog<(String, Area)>(
                          context: context,
                          builder: (_) => BlocProvider.value(
                            value: context.read<DocumentBloc>(),
                            child: _AreaSelectionDialog(document: state.data),
                          ),
                        );
                        if (result != null) {
                          final (page, area) = result;
                          setState(() {
                            _areas.add((
                              key: UniqueKey(),
                              preset: AreaPreset(name: area.name, page: page),
                            ));
                          });
                        }
                      },
                      icon: const PhosphorIcon(PhosphorIconsLight.plus),
                      tooltip: AppLocalizations.of(context).add,
                    ),
                  ],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Flexible(
                          child: _areas.isEmpty
                              ? _buildEmptyState(state)
                              : _buildAreasList(state, currentIndex),
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            TextButton(
                              child: Text(
                                MaterialLocalizations.of(
                                  context,
                                ).cancelButtonLabel,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            if (widget.print) ...[
                              ElevatedButton(
                                child: Text(
                                  widget.print
                                      ? AppLocalizations.of(context).share
                                      : AppLocalizations.of(context).export,
                                ),
                                onPressed: () async {
                                  await _export(true);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ] else ...[
                              if (supportsShare())
                                ElevatedButton(
                                  child: Text(
                                    AppLocalizations.of(context).share,
                                  ),
                                  onPressed: () async {
                                    await _export(true);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ElevatedButton(
                                child: Text(
                                  AppLocalizations.of(context).export,
                                ),
                                onPressed: () async {
                                  await _export(false);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _export(bool share) async {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final loading = showLoadingDialog(context);
    try {
      final pdf = await state.currentIndexCubit.renderPDF(
        state,
        areas: _areas.map((e) => e.preset).toList(),
        onProgress: (progress) => loading?.setProgress(progress),
      );
      if (pdf == null) {
        throw Exception('Failed to generate PDF.');
      }
      await exportPdf(context, pdf, share);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context).error),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: Text(MaterialLocalizations.of(context).okButtonLabel),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } finally {
      loading?.close();
    }
  }

  Widget _buildEmptyState(DocumentLoaded state) {
    final pageAreas = state.page.areas;
    Widget pageButton = ElevatedButton.icon(
      label: Text(AppLocalizations.of(context).page),
      icon: const PhosphorIcon(PhosphorIconsLight.book),
      onPressed: pageAreas.isEmpty
          ? null
          : () {
              setState(() {
                _areas.addAll(
                  pageAreas.map(
                    (e) => (
                      key: UniqueKey(),
                      preset: AreaPreset(name: e.name, page: state.pageName),
                    ),
                  ),
                );
              });
            },
    );
    if (pageAreas.isEmpty) {
      pageButton = Tooltip(
        message: AppLocalizations.of(context).noElements,
        child: pageButton,
      );
    }
    final documentAreas = state.data
        .getPages(true)
        .expand(
          (e) =>
              (state.pageName == e ? state.page : state.data.getPage(e))?.areas
                  .map((area) => AreaPreset(name: area.name, page: e))
                  .toList() ??
              <AreaPreset>[],
        )
        .toList();
    Widget documentButton = ElevatedButton.icon(
      label: Text(AppLocalizations.of(context).document),
      icon: const PhosphorIcon(
        PhosphorIconsLight.file,
        textDirection: TextDirection.ltr,
      ),
      onPressed: documentAreas.isEmpty
          ? null
          : () {
              setState(() {
                _areas.addAll(
                  documentAreas.map((e) => (key: UniqueKey(), preset: e)),
                );
              });
            },
    );
    if (documentAreas.isEmpty) {
      documentButton = Tooltip(
        message: AppLocalizations.of(context).noElements,
        child: documentButton,
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context).noElements,
          textAlign: TextAlign.center,
          style: TextTheme.of(context).headlineMedium,
        ),
        Align(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: const Divider(),
          ),
        ),
        Text(
          AppLocalizations.of(context).pdfEmptyDescription,
          textAlign: TextAlign.center,
          style: TextTheme.of(context).bodyMedium,
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 4,
          children: [pageButton, documentButton],
        ),
      ],
    );
  }

  Widget _buildAreasList(DocumentLoaded state, CurrentIndexCubit currentIndex) {
    return ReorderableListView.builder(
      itemCount: _areas.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = _areas.removeAt(oldIndex);
          _areas.insert(newIndex, item);
        });
      },
      itemBuilder: (context, i) {
        final wrapper = _areas[i];
        final e = wrapper.preset;
        final page =
            (e.page == state.pageName ? null : state.data.getPage(e.page)) ??
            state.page;
        final area = e.area ?? page.getAreaByName(e.name);
        if (area == null) {
          return Container(key: wrapper.key);
        }
        const maxImageWidth = 400;
        final imageFuture = currentIndex.render(
          state.data,
          page,
          state.info,
          ImageExportOptions(
            width: area.width,
            height: area.height,
            quality: min(e.quality, maxImageWidth / area.width),
            x: area.position.x,
            y: area.position.y,
          ),
        );
        return FutureBuilder<ByteData?>(
          key: wrapper.key,
          future: imageFuture,
          builder: (context, snapshot) => _AreaPreview(
            area: area,
            page: e.page,
            quality: e.quality,
            isCurrentPage: e.page == state.pageName,
            onRemove: () {
              setState(() {
                _areas.removeAt(i);
              });
            },
            onQualityChanged: (value) {
              setState(() {
                _areas[i] = (
                  key: wrapper.key,
                  preset: e.copyWith(quality: value),
                );
              });
            },
            image: snapshot.data?.buffer.asUint8List(),
          ),
        );
      },
    );
  }
}

class _AreaPreview extends StatelessWidget {
  final Area area;
  final Uint8List? image;
  final String page;
  final VoidCallback onRemove;
  final double quality;
  final bool isCurrentPage;
  final ValueChanged<double> onQualityChanged;

  const _AreaPreview({
    required this.area,
    this.image,
    required this.page,
    required this.onRemove,
    required this.quality,
    required this.isCurrentPage,
    required this.onQualityChanged,
  });

  @override
  Widget build(BuildContext context) {
    var pageName = NoteData.getPageNameFromRealName(page);
    if (pageName.isEmpty) {
      pageName = AppLocalizations.of(context).untitled;
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 500;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: isSmall
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: image == null
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Image.memory(image!, fit: BoxFit.contain),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  area.name.isEmpty
                                      ? AppLocalizations.of(context).untitled
                                      : area.name,
                                  style: TextTheme.of(context).titleMedium,
                                ),
                                Text(
                                  pageName,
                                  style: TextTheme.of(context).bodySmall
                                      ?.copyWith(
                                        color: isCurrentPage
                                            ? ColorScheme.of(context).primary
                                            : null,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: onRemove,
                            icon: const PhosphorIcon(PhosphorIconsLight.trash),
                            tooltip: AppLocalizations.of(context).remove,
                          ),
                          const SizedBox(width: 32),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ExactSlider(
                        value: quality,
                        min: 1,
                        max: 10,
                        onChanged: onQualityChanged,
                        contentPadding: EdgeInsets.zero,
                        header: Text(AppLocalizations.of(context).quality),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      SizedBox(
                        width: 192,
                        height: 108,
                        child: image == null
                            ? const Center(child: CircularProgressIndicator())
                            : Image.memory(image!, fit: BoxFit.contain),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              area.name.isEmpty
                                  ? AppLocalizations.of(context).untitled
                                  : area.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              pageName,
                              style: TextTheme.of(context).bodySmall?.copyWith(
                                color: isCurrentPage
                                    ? ColorScheme.of(context).primary
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 4),
                            ExactSlider(
                              value: quality,
                              min: 1,
                              max: 10,
                              onChanged: onQualityChanged,
                              contentPadding: EdgeInsets.zero,
                              header: Text(
                                AppLocalizations.of(context).quality,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: onRemove,
                        icon: const PhosphorIcon(PhosphorIconsLight.trash),
                        tooltip: AppLocalizations.of(context).remove,
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class _AreaSelectionDialog extends StatefulWidget {
  final NoteData document;

  const _AreaSelectionDialog({required this.document});

  @override
  State<_AreaSelectionDialog> createState() => _AreaSelectionDialogState();
}

class _AreaSelectionDialogState extends State<_AreaSelectionDialog> {
  String _searchQuery = '';
  bool _onlyCurrentPage = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 500, maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Header(
              title: Text(AppLocalizations.of(context).selectArea),
              actions: [
                IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.book),
                  selectedIcon: const PhosphorIcon(PhosphorIconsFill.book),
                  tooltip: AppLocalizations.of(context).onlyCurrentPage,
                  onPressed: () {
                    setState(() {
                      _onlyCurrentPage = !_onlyCurrentPage;
                    });
                  },
                  isSelected: _onlyCurrentPage,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).search,
                  filled: true,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            Flexible(
              child: Material(
                type: MaterialType.transparency,
                child: BlocBuilder<DocumentBloc, DocumentState>(
                  buildWhen: (previous, current) =>
                      previous.page != current.page ||
                      previous.pageName != current.pageName,
                  builder: (context, state) => ListView(
                    shrinkWrap: true,
                    children:
                        (_onlyCurrentPage
                                ? [state.pageName ?? '']
                                : widget.document.getPages(true))
                            .expand(
                              (page) =>
                                  (page == state.pageName
                                          ? state.page
                                          : widget.document.getPage(page))
                                      ?.areas
                                      .where(
                                        (element) =>
                                            element.name.contains(_searchQuery),
                                      )
                                      .map((e) {
                                        return ListTile(
                                          title: Text(e.name),
                                          subtitle: Text(page),
                                          key: ObjectKey(e.name),
                                          onTap: () => Navigator.of(
                                            context,
                                          ).pop((page, e)),
                                        );
                                      })
                                      .toList() ??
                                  <Widget>[],
                            )
                            .toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: Text(
                  MaterialLocalizations.of(context).cancelButtonLabel,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExportPresetsDialog extends StatefulWidget {
  final List<AreaPreset>? areas;

  const ExportPresetsDialog({this.areas, super.key});

  @override
  State<ExportPresetsDialog> createState() => _ExportPresetsDialogState();
}

class _ExportPresetsDialogState extends State<ExportPresetsDialog> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 500, maxWidth: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Header(
              title: Text(AppLocalizations.of(context).presets),
              actions: [
                if (widget.areas != null)
                  IconButton(
                    onPressed: () async {
                      final bloc = context.read<DocumentBloc>();
                      final state = bloc.state;
                      if (state is! DocumentLoadSuccess) return;
                      final name = await showDialog<String>(
                        context: context,
                        builder: (context) => NameDialog(
                          validator: defaultNameValidator(
                            context,
                            state.info.exportPresets
                                .map((e) => e.name)
                                .toList(),
                          ),
                        ),
                      );
                      if (name == null) return;
                      bloc.add(ExportPresetCreated(name, widget.areas!));
                    },
                    icon: const PhosphorIcon(PhosphorIconsLight.plus),
                    tooltip: LeapLocalizations.of(context).create,
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).search,
                  filled: true,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            Flexible(
              child: Material(
                type: MaterialType.transparency,
                child: BlocBuilder<DocumentBloc, DocumentState>(
                  buildWhen: (previous, current) =>
                      previous.info?.exportPresets !=
                      current.info?.exportPresets,
                  builder: (context, state) {
                    if (state is! DocumentLoadSuccess) return Container();
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        ...state.info.exportPresets
                            .where(
                              (element) => element.name.contains(_searchQuery),
                            )
                            .map(
                              (e) => Dismissible(
                                key: ObjectKey(e.name),
                                onDismissed: (direction) {
                                  context.read<DocumentBloc>().add(
                                    ExportPresetRemoved(e.name),
                                  );
                                },
                                child: ListTile(
                                  title: Text(e.name),
                                  onTap: () => Navigator.of(context).pop(e),
                                ),
                              ),
                            ),
                        if (widget.areas == null) ...[
                          const Divider(),
                          ListTile(
                            title: Text(
                              AppLocalizations.of(context).newContent,
                            ),
                            onTap: () =>
                                Navigator.of(context).pop(const ExportPreset()),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: Text(
                  MaterialLocalizations.of(context).cancelButtonLabel,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
