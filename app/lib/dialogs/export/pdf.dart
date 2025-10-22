import 'package:butterfly/api/save.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:printing/printing.dart';

import '../../bloc/document_bloc.dart';

class PdfExportDialog extends StatefulWidget {
  final List<AreaPreset> areas;
  final bool print;

  const PdfExportDialog({super.key, this.areas = const [], this.print = false});

  @override
  State<PdfExportDialog> createState() => _PdfExportDialogState();
}

class _PdfExportDialogState extends State<PdfExportDialog> {
  final List<AreaPreset> areas = [];
  int quality = 1;

  @override
  void initState() {
    super.initState();
    areas.addAll(widget.areas);
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
                            child: ExportPresetsDialog(areas: areas),
                          ),
                        );
                        if (preset != null) {
                          setState(() {
                            areas.clear();
                            areas.addAll(preset.areas);
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
                            areas.add(AreaPreset(name: area.name, page: page));
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
                          child: areas.isEmpty
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
                                      ? AppLocalizations.of(context).print
                                      : AppLocalizations.of(context).export,
                                ),
                                onPressed: () async {
                                  await Printing.layoutPdf(
                                    onLayout: (_) async =>
                                        (await currentIndex.renderPDF(
                                          state.data,
                                          state.info,
                                          areas: areas,
                                          docState: state,
                                        )).save(),
                                  );
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
                                    await exportPdf(
                                      context,
                                      await (await currentIndex.renderPDF(
                                        state.data,
                                        state.info,
                                        areas: areas,
                                        docState: state,
                                      )).save(),
                                      true,
                                    );
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ElevatedButton(
                                child: Text(
                                  AppLocalizations.of(context).export,
                                ),
                                onPressed: () async {
                                  await exportPdf(
                                    context,
                                    await (await currentIndex.renderPDF(
                                      state.data,
                                      state.info,
                                      areas: areas,
                                      docState: state,
                                    )).save(),
                                  );
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

  Widget _buildEmptyState(DocumentLoaded state) {
    final pageAreas = state.page.areas;
    Widget pageButton = ElevatedButton.icon(
      label: Text(AppLocalizations.of(context).page),
      icon: const PhosphorIcon(PhosphorIconsLight.book),
      onPressed: pageAreas.isEmpty
          ? null
          : () {
              setState(() {
                areas.addAll(
                  pageAreas.map(
                    (e) => AreaPreset(name: e.name, page: state.pageName),
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
      icon: const PhosphorIcon(PhosphorIconsLight.file),
      onPressed: documentAreas.isEmpty
          ? null
          : () {
              setState(() {
                areas.addAll(documentAreas);
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
    return SingleChildScrollView(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: areas.mapIndexed((i, e) {
          final page =
              (e.page == state.pageName ? null : state.data.getPage(e.page)) ??
              state.page;
          final area = e.area ?? page.getAreaByName(e.name);
          if (area == null) {
            return Container();
          }
          return FutureBuilder<ByteData?>(
            future: currentIndex.render(
              state.data,
              page,
              state.info,
              ImageExportOptions(
                width: area.width,
                height: area.height,
                quality: e.quality,
                x: area.position.x,
                y: area.position.y,
              ),
            ),
            builder: (context, snapshot) => _AreaPreview(
              area: area,
              page: e.page,
              quality: e.quality,
              onRemove: () {
                setState(() {
                  areas.removeAt(i);
                });
              },
              onQualityChanged: (value) {
                setState(() {
                  areas[i] = e.copyWith(quality: value);
                });
              },
              onMoveLeft: i == 0
                  ? null
                  : () {
                      setState(() {
                        final temp = areas[i - 1];
                        areas[i - 1] = areas[i];
                        areas[i] = temp;
                      });
                    },
              onMoveRight: i >= areas.length - 1
                  ? null
                  : () {
                      setState(() {
                        final temp = areas[i + 1];
                        areas[i + 1] = areas[i];
                        areas[i] = temp;
                      });
                    },
              image: snapshot.data?.buffer.asUint8List(),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _AreaPreview extends StatelessWidget {
  final Area area;
  final Uint8List? image;
  final String page;
  final VoidCallback onRemove;
  final VoidCallback? onMoveLeft, onMoveRight;
  final double quality;
  final ValueChanged<double> onQualityChanged;

  const _AreaPreview({
    required this.area,
    this.image,
    required this.page,
    required this.onRemove,
    required this.onMoveLeft,
    required this.onMoveRight,
    required this.quality,
    required this.onQualityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        width: 200,
        height: 500,
        child: Column(
          children: [
            Expanded(
              child: image == null
                  ? const Align(child: CircularProgressIndicator())
                  : Image.memory(image!),
            ),
            const SizedBox(height: 8),
            Text(area.name),
            Text(page, style: TextTheme.of(context).bodySmall),
            ExactSlider(
              value: quality,
              min: 1,
              max: 10,
              onChanged: onQualityChanged,
              header: Text(AppLocalizations.of(context).quality),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: onMoveLeft,
                  icon: const PhosphorIcon(PhosphorIconsLight.arrowLeft),
                  tooltip: AppLocalizations.of(context).left,
                ),
                IconButton.filledTonal(
                  onPressed: onRemove,
                  tooltip: AppLocalizations.of(context).remove,
                  icon: const PhosphorIcon(PhosphorIconsLight.trash),
                ),
                IconButton(
                  onPressed: onMoveRight,
                  icon: const PhosphorIcon(PhosphorIconsLight.arrowRight),
                  tooltip: AppLocalizations.of(context).right,
                ),
              ],
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
                                : widget.document.getPages())
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
