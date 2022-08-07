import 'dart:io';
import 'dart:typed_data';

import 'package:butterfly/models/area.dart';
import 'package:butterfly/widgets/header.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../api/open_image.dart';
import '../bloc/document_bloc.dart';

class PdfExportDialog extends StatefulWidget {
  final List<String> areas;

  const PdfExportDialog({
    super.key,
    this.areas = const [],
  });

  @override
  State<PdfExportDialog> createState() => _PdfExportDialogState();
}

class _PdfExportDialogState extends State<PdfExportDialog> {
  final List<String> areas = [];
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
          final areaObjects = areas
              .map((e) => state.document.getAreaByName(e))
              .whereType<Area>();
          return Column(mainAxisSize: MainAxisSize.min, children: [
            Header(
              title: Text(AppLocalizations.of(context)!.exportPdf),
              actions: [
                IconButton(
                  onPressed: () async {
                    final area = await showDialog<String>(
                      context: context,
                      builder: (context) => _AreaSelectionDialog(
                          areas: state.document.areas
                              .map((element) => element.name)
                              .toList()),
                    );
                    if (area != null) {
                      setState(() {
                        areas.add(area);
                      });
                    }
                  },
                  icon: const Icon(PhosphorIcons.plusLight),
                  tooltip: AppLocalizations.of(context)!.add,
                )
              ],
            ),
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Flexible(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: areaObjects.map((e) {
                        return FutureBuilder<ByteData?>(
                          future: currentIndex.render(state.document,
                              width: e.width.ceil(),
                              height: e.height.ceil(),
                              x: e.position.dx,
                              y: e.position.dy),
                          builder: (context, snapshot) => _AreaPreview(
                              area: e,
                              onRemove: () {
                                setState(() {
                                  areas.remove(e.name);
                                });
                              },
                              image: snapshot.data?.buffer.asUint8List()),
                        );
                      }).toList(),
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      TextButton(
                        child: Text(AppLocalizations.of(context)!.cancel),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      ElevatedButton(
                        child: Text(AppLocalizations.of(context)!.export),
                        onPressed: () async {
                          final localization = AppLocalizations.of(context)!;
                          Navigator.of(context).pop();
                          final document = await currentIndex
                              .renderPDF(state.document, areas: areas);
                          final data = await document.save();
                          if (!kIsWeb &&
                              (Platform.isWindows ||
                                  Platform.isLinux ||
                                  Platform.isMacOS)) {
                            var path = await FilePicker.platform.saveFile(
                              type: FileType.custom,
                              allowedExtensions: ['pdf'],
                              fileName: 'export.pdf',
                              dialogTitle: localization.export,
                            );
                            if (path != null) {
                              var file = File(path);
                              if (!(await file.exists())) {
                                file.create(recursive: true);
                              }
                              await file
                                  .writeAsBytes(data.buffer.asUint8List());
                            }
                          } else {
                            openPdf(data.buffer.asUint8List());
                          }
                        },
                      ),
                    ],
                  )
                ]),
              ),
            )
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

  const _AreaPreview({required this.area, this.image, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 100),
            child: image == null
                ? const CircularProgressIndicator()
                : Image.memory(image!),
          ),
          const SizedBox(height: 8),
          Text(area.name),
          OutlinedButton(
              onPressed: onRemove,
              child: Text(AppLocalizations.of(context)!.remove)),
        ]),
      ),
    );
  }
}

class _AreaSelectionDialog extends StatefulWidget {
  final List<String> areas;

  const _AreaSelectionDialog({required this.areas});

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
          Header(title: Text(AppLocalizations.of(context)!.selectArea)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.search,
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.areas
                  .where((element) => element.contains(_searchQuery))
                  .map((e) {
                return ListTile(
                  title: Text(e),
                  onTap: () => Navigator.of(context).pop(e),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ]),
      ),
    );
  }
}
