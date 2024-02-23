import 'dart:async';

import 'package:butterfly/api/save.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:printing/printing.dart';

import '../../bloc/document_bloc.dart';
import '../name.dart';

class PdfExportDialog extends StatefulWidget {
  final List<AreaPreset> areas;
  final bool print;

  const PdfExportDialog({
    super.key,
    this.areas = const [],
    this.print = false,
  });

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
        child:
            BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
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
                                child: ExportPresetsDialog(areas: areas)));
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
                    )
                  ],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Flexible(
                            child: SingleChildScrollView(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: areas.mapIndexed((i, e) {
                                  final area = e.area ??
                                      state.page.getAreaByName(e.name);
                                  if (area == null) {
                                    return Container();
                                  }
                                  return FutureBuilder<ByteData?>(
                                    future: currentIndex.render(
                                      state.data,
                                      state.page,
                                      state.info,
                                      ImageExportOptions(
                                          width: area.width,
                                          height: area.height,
                                          quality: e.quality,
                                          x: area.position.x,
                                          y: area.position.y),
                                    ),
                                    builder: (context, snapshot) =>
                                        _AreaPreview(
                                      area: area,
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
                                      image:
                                          snapshot.data?.buffer.asUint8List(),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const Divider(),
                          Row(
                            children: [
                              Expanded(child: Container()),
                              TextButton(
                                child:
                                    Text(AppLocalizations.of(context).cancel),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              ElevatedButton(
                                child: Text(widget.print
                                    ? AppLocalizations.of(context).print
                                    : AppLocalizations.of(context).export),
                                onPressed: () async {
                                  Future<Uint8List> getBytes() async =>
                                      (await currentIndex.renderPDF(
                                              state.data, state.info,
                                              areas: areas, state: state))
                                          .save();
                                  if (widget.print) {
                                    await Printing.layoutPdf(
                                      onLayout: (_) => getBytes(),
                                    );
                                    Navigator.of(context).pop();
                                    return;
                                  }
                                  await exportPdf(context, await getBytes());
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          )
                        ]),
                  ),
                ),
              ]);
        }),
      ),
    );
  }
}

class _AreaPreview extends StatelessWidget {
  final Area area;
  final Uint8List? image;
  final VoidCallback onRemove;
  final double quality;
  final ValueChanged<double> onQualityChanged;

  const _AreaPreview(
      {required this.area,
      this.image,
      required this.onRemove,
      required this.quality,
      required this.onQualityChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: Column(children: [
            image == null
                ? const CircularProgressIndicator()
                : Image.memory(image!),
            const SizedBox(height: 8),
            Text(area.name),
            const SizedBox(height: 16),
            ExactSlider(
              value: quality,
              min: 1,
              max: 10,
              onChanged: onQualityChanged,
              header: Text(AppLocalizations.of(context).quality),
            ),
            OutlinedButton(
                onPressed: onRemove,
                child: Text(AppLocalizations.of(context).remove)),
          ]),
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 500, maxWidth: 300),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Header(title: Text(AppLocalizations.of(context).selectArea)),
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
            child: BlocBuilder<DocumentBloc, DocumentState>(
                buildWhen: (previous, current) =>
                    previous.page != current.page ||
                    previous.pageName != current.pageName,
                builder: (context, state) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.document
                          .getPages()
                          .expand(
                            (page) =>
                                (page == state.pageName
                                        ? state.page
                                        : widget.document.getPage(page))
                                    ?.areas
                                    .where((element) =>
                                        element.name.contains(_searchQuery))
                                    .map((e) {
                                  return ListTile(
                                    title: Text(e.name),
                                    subtitle: Text(page),
                                    onTap: () =>
                                        Navigator.of(context).pop((page, e)),
                                  );
                                }).toList() ??
                                <Widget>[],
                          )
                          .toList(),
                    )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Text(AppLocalizations.of(context).cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ]),
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
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Header(title: Text(AppLocalizations.of(context).presets), actions: [
            if (widget.areas != null)
              IconButton(
                onPressed: () async {
                  final bloc = context.read<DocumentBloc>();
                  final state = bloc.state;
                  if (state is! DocumentLoadSuccess) return;
                  final name = await showDialog<String>(
                    context: context,
                    builder: (context) => NameDialog(
                      validator: defaultNameValidator(context,
                          state.info.exportPresets.map((e) => e.name).toList()),
                    ),
                  );
                  if (name == null) return;
                  bloc.add(ExportPresetCreated(name, widget.areas!));
                },
                icon: const PhosphorIcon(PhosphorIconsLight.plus),
                tooltip: AppLocalizations.of(context).create,
              )
          ]),
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
            child: BlocBuilder<DocumentBloc, DocumentState>(
                builder: (context, state) {
              if (state is! DocumentLoadSuccess) return Container();
              return Column(mainAxisSize: MainAxisSize.min, children: [
                ...state.info.exportPresets
                    .where((element) => element.name.contains(_searchQuery))
                    .map((e) => Dismissible(
                          key: ObjectKey(e.name),
                          onDismissed: (direction) {
                            context
                                .read<DocumentBloc>()
                                .add(ExportPresetRemoved(e.name));
                          },
                          child: ListTile(
                            title: Text(e.name),
                            onTap: () => Navigator.of(context).pop(e),
                          ),
                        )),
                if (widget.areas == null)
                  ListTile(
                    title: Text(AppLocalizations.of(context).newContent),
                    onTap: () =>
                        Navigator.of(context).pop(const ExportPreset()),
                  )
              ]);
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Text(AppLocalizations.of(context).cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ]),
      ),
    );
  }
}
