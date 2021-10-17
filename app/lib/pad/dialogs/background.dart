import 'package:butterfly/models/backgrounds/box.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'color_pick.dart';

class BackgroundDialog extends StatefulWidget {
  final DocumentBloc bloc;
  const BackgroundDialog({Key? key, required this.bloc}) : super(key: key);

  @override
  _BackgroundDialogState createState() => _BackgroundDialogState();
}

class _BackgroundDialogState extends State<BackgroundDialog> {
  final boxWidthController = TextEditingController();
  final boxHeightController = TextEditingController();
  final boxXCountController = TextEditingController();
  final boxYCountController = TextEditingController();
  final boxXSpaceController = TextEditingController();
  final boxYSpaceController = TextEditingController();
  final boxXStrokeController = TextEditingController();
  final boxYStrokeController = TextEditingController();
  int? currentExpansionOpened = 0;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
      child: BlocProvider.value(
        value: widget.bloc,
        child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
          if (state is! DocumentLoadSuccess) return Container();
          var background = state.document.background;

          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.background),
              leading: const Icon(PhosphorIcons.imageLight),
            ),
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    Expanded(
                      child: StatefulBuilder(builder: (context, setState) {
                        if (background is BoxBackground) {
                          if (boxWidthController.text != background!.boxWidth.toStringAsFixed(2)) {
                            boxWidthController.text = background!.boxWidth.toStringAsFixed(2);
                          }
                          if (boxHeightController.text !=
                              background!.boxHeight.toStringAsFixed(2)) {
                            boxHeightController.text = background!.boxHeight.toStringAsFixed(2);
                          }
                          if (boxXCountController.text != background!.boxXCount.toString()) {
                            boxXCountController.text = background!.boxXCount.toString();
                          }
                          if (boxYCountController.text != background!.boxYCount.toString()) {
                            boxYCountController.text = background!.boxYCount.toString();
                          }
                          if (boxXSpaceController.text !=
                              background!.boxXSpace.toStringAsFixed(2)) {
                            boxXSpaceController.text = background!.boxXSpace.toStringAsFixed(2);
                          }
                          if (boxYSpaceController.text !=
                              background!.boxYSpace.toStringAsFixed(2)) {
                            boxYSpaceController.text = background!.boxYSpace.toStringAsFixed(2);
                          }
                          if (boxXStrokeController.text !=
                              background!.boxXStroke.toStringAsFixed(2)) {
                            boxXStrokeController.text = background!.boxXStroke.toStringAsFixed(2);
                          }
                          if (boxYStrokeController.text !=
                              background!.boxYStroke.toStringAsFixed(2)) {
                            boxYStrokeController.text = background!.boxYStroke.toStringAsFixed(2);
                          }
                        }

                        return ListView(children: [
                          CheckboxListTile(
                            value: background != null,
                            title: Text(AppLocalizations.of(context)!.background),
                            onChanged: (value) {
                              setState(
                                  () => background = value ?? true ? const BoxBackground() : null);
                            },
                          ),
                          const Divider(),
                          if (background is BoxBackground) ...[
                            ExpansionPanelList(
                                expansionCallback: (int item, bool status) {
                                  setState(() {
                                    currentExpansionOpened = !status ? item : null;
                                  });
                                },
                                children: [
                                  ExpansionPanel(
                                      isExpanded: currentExpansionOpened == 0,
                                      headerBuilder: (context, isExpanded) => Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(AppLocalizations.of(context)!.color,
                                                  style: Theme.of(context).textTheme.subtitle1),
                                            ],
                                          ),
                                      body: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          ListTile(
                                              onTap: () async {
                                                var value = await showDialog(
                                                    context: context,
                                                    builder: (context) => ColorPickerDialog(
                                                        defaultColor: background!.boxColor,
                                                        bloc: widget.bloc));
                                                if (value != null) {
                                                  setState(() => background = background!
                                                      .copyWith(boxColor: value as Color));
                                                }
                                              },
                                              leading: Container(
                                                  width: 30,
                                                  height: 30,
                                                  color: background!.boxColor),
                                              title:
                                                  Text(AppLocalizations.of(context)!.background)),
                                          ListTile(
                                              leading: Container(
                                                  width: 30,
                                                  height: 30,
                                                  color: background!.boxXColor),
                                              onTap: () async {
                                                var value = await showDialog(
                                                    context: context,
                                                    builder: (context) => ColorPickerDialog(
                                                        defaultColor: background!.boxXColor,
                                                        bloc: widget.bloc));
                                                if (value != null) {
                                                  setState(() => background = background!
                                                      .copyWith(boxXColor: value as Color));
                                                }
                                              },
                                              title: const Text("X")),
                                          ListTile(
                                              leading: Container(
                                                  width: 30,
                                                  height: 30,
                                                  color: background!.boxYColor),
                                              onTap: () async {
                                                var value = await showDialog(
                                                    context: context,
                                                    builder: (context) => ColorPickerDialog(
                                                        defaultColor: background!.boxYColor,
                                                        bloc: widget.bloc));
                                                if (value != null) {
                                                  setState(() => background = background!
                                                      .copyWith(boxYColor: value as Color));
                                                }
                                              },
                                              title: const Text("Y")),
                                        ]),
                                      )),
                                  ExpansionPanel(
                                      isExpanded: currentExpansionOpened == 1,
                                      headerBuilder: (context, isExpanded) => Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(AppLocalizations.of(context)!.strokeWidth,
                                                  style: Theme.of(context).textTheme.subtitle1),
                                            ],
                                          ),
                                      body: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          Row(children: [
                                            ConstrainedBox(
                                                constraints: const BoxConstraints(maxWidth: 100),
                                                child: TextField(
                                                  decoration: const InputDecoration(labelText: "X"),
                                                  controller: boxXStrokeController,
                                                  onChanged: (value) => setState(() => background =
                                                      background!.copyWith(
                                                          boxXStroke: double.tryParse(value))),
                                                )),
                                            Expanded(
                                              child: Slider(
                                                  value: background!.boxXStroke.clamp(0, 10),
                                                  min: 0,
                                                  max: 10,
                                                  onChanged: (value) => setState(() => background =
                                                      background!.copyWith(boxXStroke: value))),
                                            )
                                          ]),
                                          Row(children: [
                                            ConstrainedBox(
                                                constraints: const BoxConstraints(maxWidth: 100),
                                                child: TextField(
                                                  decoration: const InputDecoration(labelText: "Y"),
                                                  controller: boxYStrokeController,
                                                  onChanged: (value) => setState(() => background =
                                                      background!.copyWith(
                                                          boxYStroke: double.tryParse(value))),
                                                )),
                                            Expanded(
                                              child: Slider(
                                                  value: background!.boxYStroke.clamp(0, 10),
                                                  min: 0,
                                                  max: 10,
                                                  onChanged: (value) => setState(() => background =
                                                      background!.copyWith(boxYStroke: value))),
                                            )
                                          ])
                                        ]),
                                      )),
                                  ExpansionPanel(
                                      isExpanded: currentExpansionOpened == 2,
                                      headerBuilder: (context, isExpanded) => Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(AppLocalizations.of(context)!.box,
                                                  style: Theme.of(context).textTheme.subtitle1),
                                            ],
                                          ),
                                      body: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          Row(children: [
                                            ConstrainedBox(
                                                constraints: const BoxConstraints(maxWidth: 100),
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          AppLocalizations.of(context)!.width),
                                                  controller: boxWidthController,
                                                  onChanged: (value) => setState(() => background =
                                                      background!.copyWith(
                                                          boxWidth: double.tryParse(value))),
                                                )),
                                            Expanded(
                                              child: Slider(
                                                  value: background!.boxWidth.clamp(0, 200),
                                                  min: 0,
                                                  max: 200,
                                                  onChanged: (value) => setState(() => background =
                                                      background!.copyWith(boxWidth: value))),
                                            )
                                          ]),
                                          Row(children: [
                                            ConstrainedBox(
                                                constraints: const BoxConstraints(maxWidth: 100),
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          AppLocalizations.of(context)!.height),
                                                  controller: boxHeightController,
                                                  onChanged: (value) => setState(() => background =
                                                      background!.copyWith(
                                                          boxHeight: double.tryParse(value))),
                                                )),
                                            Expanded(
                                              child: Slider(
                                                  value: background!.boxHeight.clamp(0, 200),
                                                  min: 0,
                                                  max: 200,
                                                  onChanged: (value) => setState(() => background =
                                                      background!.copyWith(boxHeight: value))),
                                            )
                                          ])
                                        ]),
                                      )),
                                  ExpansionPanel(
                                      isExpanded: currentExpansionOpened == 3,
                                      headerBuilder: (context, isExpanded) => Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(AppLocalizations.of(context)!.count,
                                                  style: Theme.of(context).textTheme.subtitle1),
                                            ],
                                          ),
                                      body: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          Row(children: [
                                            ConstrainedBox(
                                                constraints: const BoxConstraints(maxWidth: 100),
                                                child: TextField(
                                                  decoration: const InputDecoration(labelText: "X"),
                                                  controller: boxXCountController,
                                                  onChanged: (value) => setState(() => background =
                                                      background!.copyWith(
                                                          boxXCount: int.tryParse(value))),
                                                )),
                                            Expanded(
                                              child: Slider(
                                                  value:
                                                      background!.boxXCount.clamp(0, 20).toDouble(),
                                                  min: 0,
                                                  max: 20,
                                                  divisions: 20,
                                                  onChanged: (value) => setState(() => background =
                                                      background!
                                                          .copyWith(boxXCount: value.toInt()))),
                                            )
                                          ]),
                                          Row(children: [
                                            ConstrainedBox(
                                                constraints: const BoxConstraints(maxWidth: 100),
                                                child: TextField(
                                                  decoration: const InputDecoration(labelText: "Y"),
                                                  controller: boxYCountController,
                                                  onChanged: (value) => setState(() => background =
                                                      background!.copyWith(
                                                          boxYCount: int.tryParse(value))),
                                                )),
                                            Expanded(
                                              child: Slider(
                                                  value:
                                                      background!.boxYCount.clamp(0, 20).toDouble(),
                                                  min: 0,
                                                  max: 20,
                                                  divisions: 20,
                                                  onChanged: (value) => setState(() => background =
                                                      background!
                                                          .copyWith(boxYCount: value.toInt()))),
                                            )
                                          ]),
                                        ]),
                                      )),
                                  ExpansionPanel(
                                      isExpanded: currentExpansionOpened == 4,
                                      headerBuilder: (context, isExpanded) => Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(AppLocalizations.of(context)!.space,
                                                  style: Theme.of(context).textTheme.subtitle1),
                                            ],
                                          ),
                                      body: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          Row(children: [
                                            ConstrainedBox(
                                                constraints: const BoxConstraints(maxWidth: 100),
                                                child: TextField(
                                                  decoration: const InputDecoration(labelText: "X"),
                                                  controller: boxXSpaceController,
                                                  onChanged: (value) => setState(() => background =
                                                      background!.copyWith(
                                                          boxXSpace: double.tryParse(value))),
                                                )),
                                            Expanded(
                                              child: Slider(
                                                  value: background!.boxXSpace.clamp(0, 100),
                                                  min: 0,
                                                  max: 100,
                                                  onChanged: (value) => setState(() => background =
                                                      background!.copyWith(boxXSpace: value))),
                                            )
                                          ]),
                                          Row(children: [
                                            ConstrainedBox(
                                                constraints: const BoxConstraints(maxWidth: 100),
                                                child: TextField(
                                                  decoration: const InputDecoration(labelText: "Y"),
                                                  controller: boxYSpaceController,
                                                  onChanged: (value) => setState(() => background =
                                                      background!.copyWith(
                                                          boxYSpace: double.tryParse(value))),
                                                )),
                                            Expanded(
                                              child: Slider(
                                                  value: background!.boxYSpace.clamp(0, 100),
                                                  min: 0,
                                                  max: 100,
                                                  onChanged: (value) => setState(() => background =
                                                      background!.copyWith(boxYSpace: value))),
                                            )
                                          ])
                                        ]),
                                      ))
                                ]),
                          ],
                        ]);
                      }),
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
          );
        }),
      ),
    ));
  }
}
