import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:butterfly/models/backgrounds/box.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/views/view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:butterfly/api/open_image.dart'
    if (dart.library.io) 'package:butterfly/api/open_image_io.dart'
    if (dart.library.js) 'package:butterfly/api/open_image_html.dart';

class ViewToolbar extends StatefulWidget {
  final DocumentBloc bloc;
  const ViewToolbar({Key? key, required this.bloc}) : super(key: key);

  @override
  _ViewToolbarState createState() => _ViewToolbarState();
}

class _ViewToolbarState extends State<ViewToolbar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      if (state is! DocumentLoadSuccess) {
        return Container();
      }
      return Row(children: [
        IconButton(
          icon: const Icon(PhosphorIcons.imageLight),
          tooltip: "Background",
          onPressed: () {
            final boxWidthController = TextEditingController();
            final boxHeightController = TextEditingController();
            final boxXCountController = TextEditingController();
            final boxYCountController = TextEditingController();
            final boxXSpaceController = TextEditingController();
            final boxYSpaceController = TextEditingController();
            var background = state.document.background;
            showDialog(
                context: context,
                builder: (context) => Dialog(
                        child: Container(
                      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
                      child: Scaffold(
                        appBar: AppBar(title: const Text("Background")),
                        body: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 115),
                            child: Column(
                              children: [
                                Expanded(
                                  child: StatefulBuilder(builder: (context, setState) {
                                    if (background is BoxBackground) {
                                      if (boxWidthController.text !=
                                          background!.boxWidth.toStringAsFixed(2)) {
                                        boxWidthController.text =
                                            background!.boxWidth.toStringAsFixed(2);
                                      }
                                      if (boxHeightController.text !=
                                          background!.boxHeight.toStringAsFixed(2)) {
                                        boxHeightController.text =
                                            background!.boxHeight.toStringAsFixed(2);
                                      }
                                      if (boxXCountController.text !=
                                          background!.boxXCount.toStringAsFixed(2)) {
                                        boxXCountController.text =
                                            background!.boxXCount.toStringAsFixed(2);
                                      }
                                      if (boxYCountController.text !=
                                          background!.boxYCount.toStringAsFixed(2)) {
                                        boxYCountController.text =
                                            background!.boxYCount.toStringAsFixed(2);
                                      }
                                      if (boxXSpaceController.text !=
                                          background!.boxXSpace.toStringAsFixed(2)) {
                                        boxXSpaceController.text =
                                            background!.boxXSpace.toStringAsFixed(2);
                                      }
                                      if (boxYSpaceController.text !=
                                          background!.boxYSpace.toStringAsFixed(2)) {
                                        boxYSpaceController.text =
                                            background!.boxYSpace.toStringAsFixed(2);
                                      }
                                    }

                                    return ListView(children: [
                                      CheckboxListTile(
                                        value: background != null,
                                        title: const Text("Box background"),
                                        onChanged: (value) {
                                          setState(() => background =
                                              value ?? true ? const BoxBackground() : null);
                                        },
                                      ),
                                      const Divider(),
                                      if (background is BoxBackground) ...[
                                        Row(children: [
                                          ConstrainedBox(
                                              constraints: const BoxConstraints(maxWidth: 100),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    labelText: AppLocalizations.of(context)!
                                                        .strokeMultiplier),
                                                controller: boxWidthController,
                                                onChanged: (value) => setState(() => background =
                                                    background!.copyWith(
                                                        boxWidth: double.tryParse(value))),
                                              )),
                                          Expanded(
                                            child: Slider(
                                                value: background!.boxWidth.clamp(0, 15),
                                                min: 0,
                                                max: 15,
                                                onChanged: (value) => setState(() => background =
                                                    background!.copyWith(boxWidth: value))),
                                          )
                                        ]),
                                        Row(children: [
                                          ConstrainedBox(
                                              constraints: const BoxConstraints(maxWidth: 100),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    labelText: AppLocalizations.of(context)!
                                                        .strokeMultiplier),
                                                controller: boxHeightController,
                                                onChanged: (value) => setState(() => background =
                                                    background!.copyWith(
                                                        boxHeight: double.tryParse(value))),
                                              )),
                                          Expanded(
                                            child: Slider(
                                                value: background!.boxHeight.clamp(0, 15),
                                                min: 0,
                                                max: 15,
                                                onChanged: (value) => setState(() => background =
                                                    background!.copyWith(boxHeight: value))),
                                          )
                                        ]),
                                        Row(children: [
                                          ConstrainedBox(
                                              constraints: const BoxConstraints(maxWidth: 100),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    labelText: AppLocalizations.of(context)!
                                                        .strokeMultiplier),
                                                controller: boxXCountController,
                                                onChanged: (value) => setState(() => background =
                                                    background!
                                                        .copyWith(boxXCount: int.tryParse(value))),
                                              )),
                                          Expanded(
                                            child: Slider(
                                                value:
                                                    background!.boxXCount.clamp(0, 15).toDouble(),
                                                min: 0,
                                                max: 15,
                                                divisions: 15,
                                                onChanged: (value) => setState(() => background =
                                                    background!
                                                        .copyWith(boxXCount: value.toInt()))),
                                          )
                                        ]),
                                        Row(children: [
                                          ConstrainedBox(
                                              constraints: const BoxConstraints(maxWidth: 100),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    labelText: AppLocalizations.of(context)!
                                                        .strokeMultiplier),
                                                controller: boxYCountController,
                                                onChanged: (value) => setState(() => background =
                                                    background!
                                                        .copyWith(boxYCount: int.tryParse(value))),
                                              )),
                                          Expanded(
                                            child: Slider(
                                                value:
                                                    background!.boxYCount.clamp(0, 15).toDouble(),
                                                min: 0,
                                                max: 15,
                                                divisions: 15,
                                                onChanged: (value) => setState(() => background =
                                                    background!
                                                        .copyWith(boxYCount: value.toInt()))),
                                          )
                                        ]),
                                        Row(children: [
                                          ConstrainedBox(
                                              constraints: const BoxConstraints(maxWidth: 100),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    labelText: AppLocalizations.of(context)!
                                                        .strokeMultiplier),
                                                controller: boxXSpaceController,
                                                onChanged: (value) => setState(() => background =
                                                    background!.copyWith(
                                                        boxXSpace: double.tryParse(value))),
                                              )),
                                          Expanded(
                                            child: Slider(
                                                value: background!.boxXSpace.clamp(0, 15),
                                                min: 0,
                                                max: 15,
                                                onChanged: (value) => setState(() => background =
                                                    background!.copyWith(boxXSpace: value))),
                                          )
                                        ]),
                                        Row(children: [
                                          ConstrainedBox(
                                              constraints: const BoxConstraints(maxWidth: 100),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    labelText: AppLocalizations.of(context)!
                                                        .strokeMultiplier),
                                                controller: boxYSpaceController,
                                                onChanged: (value) => setState(() => background =
                                                    background!.copyWith(
                                                        boxYSpace: double.tryParse(value))),
                                              )),
                                          Expanded(
                                            child: Slider(
                                                value: background!.boxYSpace.clamp(0, 15),
                                                min: 0,
                                                max: 15,
                                                onChanged: (value) => setState(() => background =
                                                    background!.copyWith(boxYSpace: value))),
                                          )
                                        ])
                                      ],
                                    ]);
                                  }),
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          primary: Theme.of(context).colorScheme.error),
                                      child: Text(AppLocalizations.of(context)!.delete),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                    actions: [
                                                      TextButton(
                                                        child:
                                                            Text(AppLocalizations.of(context)!.no),
                                                        onPressed: () =>
                                                            Navigator.of(context).pop(),
                                                      ),
                                                    ],
                                                    title: Text(
                                                        AppLocalizations.of(context)!.areYouSure),
                                                    content: Text(AppLocalizations.of(context)!
                                                        .reallyDelete)));
                                      },
                                    ),
                                    Expanded(child: Container()),
                                    TextButton(
                                      child: Text(AppLocalizations.of(context)!.cancel),
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                    ElevatedButton(
                                      child: Text(AppLocalizations.of(context)!.ok),
                                      onPressed: () {
                                        widget.bloc.add(DocumentBackgroundChanged(background));
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ),
                    )));
          },
        ),
        IconButton(
            icon: const Icon(PhosphorIcons.arrowSquareOutLight),
            tooltip: "Export",
            onPressed: () async {
              var recorder = PictureRecorder();
              var canvas = Canvas(recorder);
              PathPainter(state.document, null).paint(canvas, const Size(1000, 1000));
              var picture = recorder.endRecording();
              var image = await picture.toImage(1000, 1000);
              image.toByteData(format: ImageByteFormat.png).then((data) {
                if (data == null) {
                  return;
                }
                openImage(data.buffer.asUint8List());
              });
            }),
        IconButton(
            icon: const Icon(PhosphorIcons.floppyDiskLight),
            tooltip: "Save",
            onPressed: () async {
              if (kIsWeb || Platform.isAndroid || Platform.isWindows) {
                Clipboard.setData(ClipboardData(text: jsonEncode(state.document.toJson())));
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text(AppLocalizations.of(context)!.copyTitle),
                          content: Text(AppLocalizations.of(context)!.copyMessage),
                          actions: [
                            TextButton(
                              child: Text(AppLocalizations.of(context)!.ok),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ));
              } else {
                FilePicker.platform.saveFile(
                    fileName: "butterfly.json",
                    type: FileType.custom,
                    allowedExtensions: ["json"]).then((value) {
                  if (value == null) {
                    return;
                  }
                  File(value).writeAsStringSync(jsonEncode(state.document.toJson()));
                });
              }
            }),
      ]);
    });
    /*IconButton(icon: const Icon(PhosphorIcons.printerLight), tooltip: "Print", onPressed: () {}),
      IconButton(
          icon: const Icon(PhosphorIcons.monitorPlayLight),
          tooltip: "Presentation",
          onPressed: () {})*/
  }
}
