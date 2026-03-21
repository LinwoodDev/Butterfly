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
import '../delete.dart';

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
  bool? _exportingShare;

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
                    if (_areas.isNotEmpty)
                      IconButton(
                        icon: const PhosphorIcon(PhosphorIconsLight.floppyDisk),
                        tooltip: AppLocalizations.of(context).save,
                        onPressed: () async {
                          final bloc = context.read<DocumentBloc>();
                          final currentState = bloc.state;
                          if (currentState is! DocumentLoadSuccess) return;
                          final name = await showDialog<String>(
                            context: context,
                            builder: (context) => NameDialog(
                              validator: defaultNameValidator(
                                context,
                                currentState.info.exportPresets
                                    .map((e) => e.name)
                                    .toList(),
                              ),
                            ),
                          );
                          if (name != null) {
                            bloc.add(
                              ExportPresetCreated(
                                name,
                                _areas.map((e) => e.preset).toList(),
                              ),
                            );
                          }
                        },
                      ),
                    IconButton(
                      tooltip: AppLocalizations.of(context).presets,
                      icon: const PhosphorIcon(PhosphorIconsLight.bookmark),
                      onPressed: () async {
                        final result = await showDialog<ExportPreset>(
                          context: context,
                          builder: (ctx) => BlocProvider.value(
                            value: context.read<DocumentBloc>(),
                            child: ExportPresetsDialog(
                              areas: _areas.map((e) => e.preset).toList(),
                            ),
                          ),
                        );
                        if (result != null) {
                          setState(() {
                            _areas.clear();
                            _areas.addAll(
                              result.areas.map(
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
                                onPressed: _exportingShare != null
                                    ? null
                                    : () async {
                                        await _export(true);
                                        if (mounted) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                child: _exportingShare == true
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        widget.print
                                            ? AppLocalizations.of(context).share
                                            : AppLocalizations.of(
                                                context,
                                              ).export,
                                      ),
                              ),
                            ] else ...[
                              if (supportsShare())
                                ElevatedButton(
                                  onPressed: _exportingShare != null
                                      ? null
                                      : () async {
                                          await _export(true);
                                          if (mounted) {
                                            Navigator.of(context).pop();
                                          }
                                        },
                                  child: _exportingShare == true
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Text(
                                          AppLocalizations.of(context).share,
                                        ),
                                ),
                              ElevatedButton(
                                onPressed: _exportingShare != null
                                    ? null
                                    : () async {
                                        await _export(false);
                                        if (mounted) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                child: _exportingShare == false
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(AppLocalizations.of(context).export),
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
    if (_exportingShare != null) return;
    setState(() => _exportingShare = share);
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
      if (mounted) setState(() => _exportingShare = null);
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
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [pageButton, const SizedBox(width: 8), documentButton],
        ),
      ],
    );
  }

  Widget _buildAreasList(DocumentLoaded state, CurrentIndexCubit currentIndex) {
    return ReorderableListView.builder(
      buildDefaultDragHandles: false,
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
        const maxImageDimension = 1000;
        final maxSide = max(area.width, area.height);
        final imageFuture = currentIndex.render(
          state.data,
          page,
          state.info,
          ImageExportOptions(
            width: area.width,
            height: area.height,
            quality: min(e.quality, maxImageDimension / maxSide),
            x: area.position.x,
            y: area.position.y,
          ),
          docState: state,
        );
        return FutureBuilder<ByteData?>(
          key: wrapper.key,
          future: imageFuture,
          builder: (context, snapshot) => _AreaPreview(
            index: i,
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
  final int index;
  final Area area;
  final Uint8List? image;
  final String page;
  final VoidCallback onRemove;
  final double quality;
  final bool isCurrentPage;
  final ValueChanged<double> onQualityChanged;

  const _AreaPreview({
    required this.index,
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ReorderableDragStartListener(
              index: index,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  PhosphorIconsLight.dotsSixVertical,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: image == null
                  ? const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Image.memory(image!, fit: BoxFit.contain),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    area.name.isEmpty
                        ? AppLocalizations.of(context).untitled
                        : area.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    pageName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isCurrentPage
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 150,
              child: ExactSlider(
                value: quality,
                min: 1,
                max: 10,
                onChangeEnd: onQualityChanged,
                contentPadding: EdgeInsets.zero,
                header: Text(
                  AppLocalizations.of(context).quality,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onRemove,
              icon: const PhosphorIcon(PhosphorIconsLight.trash),
              tooltip: AppLocalizations.of(context).remove,
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
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
                                        final pageName =
                                            NoteData.getPageNameFromRealName(
                                              page,
                                            );
                                        return ListTile(
                                          title: Text(e.name),
                                          subtitle: Text(
                                            pageName.isEmpty
                                                ? AppLocalizations.of(
                                                    context,
                                                  ).untitled
                                                : pageName,
                                            style: TextTheme.of(context)
                                                .bodySmall
                                                ?.copyWith(
                                                  color: page == state.pageName
                                                      ? ColorScheme.of(
                                                          context,
                                                        ).primary
                                                      : null,
                                                ),
                                          ),
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
                                confirmDismiss: (direction) async {
                                  return await showDialog<bool>(
                                    context: context,
                                    builder: (context) => const DeleteDialog(),
                                  );
                                },
                                onDismissed: (direction) {
                                  context.read<DocumentBloc>().add(
                                    ExportPresetRemoved(e.name),
                                  );
                                },
                                child: ListTile(
                                  title: Text(e.name),
                                  onTap: () => Navigator.of(context).pop(e),
                                  trailing: IconButton(
                                    icon: const PhosphorIcon(
                                      PhosphorIconsLight.trash,
                                    ),
                                    tooltip: AppLocalizations.of(
                                      context,
                                    ).remove,
                                    color: Theme.of(context).colorScheme.error,
                                    onPressed: () async {
                                      if (await showDialog<bool>(
                                            context: context,
                                            builder: (context) =>
                                                const DeleteDialog(),
                                          ) ==
                                          true) {
                                        if (context.mounted) {
                                          context.read<DocumentBloc>().add(
                                            ExportPresetRemoved(e.name),
                                          );
                                        }
                                      }
                                    },
                                  ),
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
