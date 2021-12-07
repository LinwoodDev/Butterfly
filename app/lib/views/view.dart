import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editing.dart';
import 'package:butterfly/cubits/selection.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/elements/general.dart';
import 'package:butterfly/dialogs/elements/image.dart';
import 'package:butterfly/dialogs/elements/label.dart';
import 'package:butterfly/dialogs/select.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/elements/eraser.dart';
import 'package:butterfly/models/elements/image.dart';
import 'package:butterfly/models/elements/label.dart';
import 'package:butterfly/models/elements/path.dart';
import 'package:butterfly/models/input_type.dart';
import 'package:butterfly/models/painters/image.dart';
import 'package:butterfly/models/painters/label.dart';
import 'package:butterfly/models/painters/painter.dart';
import 'package:butterfly/models/painters/path_eraser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view_painter.dart';

class MainViewViewport extends StatefulWidget {
  final DocumentBloc bloc;

  const MainViewViewport({Key? key, required this.bloc}) : super(key: key);

  @override
  _MainViewViewportState createState() => _MainViewViewportState();
}

class _MainViewViewportState extends State<MainViewViewport> {
  Map<ElementLayer, ui.Image> images = {};
  double size = 1.0;
  GlobalKey paintKey = GlobalKey();
  SharedPreferences? _prefs;

  @override
  void initState() {
    SharedPreferences.getInstance()
        .then((value) => setState(() => _prefs = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
        bloc: widget.bloc,
        builder: (context, state) {
          if (state is! DocumentLoadSuccess || _prefs == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return BlocProvider(
            create: (context) => EditingCubit(),
            child: SizedBox.expand(child:
                ClipRRect(child: LayoutBuilder(builder: (context, constraints) {
              List<ElementLayer> rayCast(Offset offset) {
                return state.document.content.reversed
                    .where((element) => element.hit(offset))
                    .where((element) =>
                        !state.document.handProperty.includeEraser
                            ? element is! EraserElement
                            : true)
                    .toList();
              }

              void createLayer(
                  int pointer, Offset localPosition, double pressure) {
                var transform = context.read<TransformCubit>().state;
                if (state.currentPainter is BuildedPainter) {
                  var painter = state.currentPainter as BuildedPainter;
                  context.read<EditingCubit>().put(
                      pointer,
                      painter.buildLayer(
                          transform.localToGlobal(localPosition), pressure));
                }
                if (state.currentPainter is LabelPainter) {
                  var painter = state.currentPainter as LabelPainter;
                  var _textController = TextEditingController();
                  void submit() {
                    Navigator.of(context).pop();
                    widget.bloc.add(LayerCreated(LabelElement(
                        property: painter.property,
                        text: _textController.text,
                        position: transform.localToGlobal(localPosition))));
                  }

                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                              title:
                                  Text(AppLocalizations.of(context)!.enterText),
                              content: TextField(
                                controller: _textController,
                                autofocus: true,
                                minLines: 3,
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                onSubmitted: (text) => submit(),
                              ),
                              actions: [
                                TextButton(
                                  child: Text(
                                      AppLocalizations.of(context)!.cancel),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                TextButton(
                                    child:
                                        Text(AppLocalizations.of(context)!.ok),
                                    onPressed: submit)
                              ]));
                }
                if (state.currentPainter is ImagePainter) {
                  FilePicker.platform
                      .pickFiles(type: FileType.image)
                      .then((files) {
                    if (files?.files.isEmpty ?? true) return;
                    var e = files!.files.first;
                    var content = e.bytes ?? Uint8List(0);
                    if (!kIsWeb) {
                      content = File(e.path ?? '').readAsBytesSync();
                    }
                    ui.decodeImageFromList(content, (image) async {
                      var bytes = await image.toByteData(
                          format: ui.ImageByteFormat.png);
                      widget.bloc.add(LayerCreated(ImageElement(
                          height: image.height,
                          width: image.width,
                          pixels: bytes?.buffer.asUint8List() ?? Uint8List(0),
                          position: transform.localToGlobal(localPosition))));
                    });
                  });
                }
              }

              var openView = false;

              return GestureDetector(
                  onScaleUpdate: (details) {
                    if (state.currentPainter != null) return;
                    if (openView) openView = details.scale == 1;
                    var cubit = context.read<TransformCubit>();
                    var lastSize = cubit.state.size;
                    var current = size + (details.scale - 1) * (lastSize);
                    cubit.zoom(current - lastSize, details.focalPoint);
                  },
                  onScaleStart: (details) {
                    size = context.read<TransformCubit>().state.size;
                  },
                  child: Listener(
                      onPointerSignal: (pointerSignal) {
                        if (pointerSignal is PointerScrollEvent) {
                          var scale = pointerSignal.scrollDelta.dx +
                              pointerSignal.scrollDelta.dy;
                          scale /= -500;
                          var cubit = context.read<TransformCubit>();
                          scale *= cubit.state.size;
                          cubit.zoom(scale, pointerSignal.position);
                        }
                      },
                      onPointerDown: (PointerDownEvent event) {
                        var cubit = context.read<EditingCubit>();
                        var input =
                            InputType.values[_prefs?.getInt('input') ?? 0];
                        if (state.currentPainter != null &&
                            event.buttons != kMiddleMouseButton &&
                            input.canCreate(
                                event.pointer, cubit.first(), event.kind)) {
                          createLayer(event.pointer, event.localPosition,
                              event.pressure);
                        } else {
                          openView = true;
                        }
                      },
                      onPointerUp: (PointerUpEvent event) {
                        var cubit = context.read<EditingCubit>();
                        if (cubit.isMoving) {
                          var movingLayer = cubit.getAndResetMove();
                          if (movingLayer != null) {
                            widget.bloc.add(LayerCreated(movingLayer));
                          }
                        }
                        var currentLayer = cubit.getAndReset(event.pointer);
                        var transform = context.read<TransformCubit>().state;
                        var input =
                            InputType.values[_prefs?.getInt('input') ?? 0];

                        if (input.canCreate(
                                event.pointer, cubit.first(), event.kind) &&
                            currentLayer != null) {
                          widget.bloc.add(LayerCreated(currentLayer));
                        } else {
                          if (!openView) {
                            return;
                          }
                          var hits = rayCast(
                              transform.localToGlobal(event.localPosition));
                          if (hits.isNotEmpty) {
                            void showSelection() {
                              var selectionCubit =
                                  context.read<SelectionCubit>();
                              var editingCubit = context.read<EditingCubit>();
                              var selection = selectionCubit.state;
                              var bloc = widget.bloc;
                              if (selection == null) return;
                              var index =
                                  state.document.content.indexOf(selection);
                              showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        if (selection is LabelElement) {
                                          return LabelElementDialog(
                                            selectionCubit: selectionCubit,
                                            index: index,
                                            bloc: widget.bloc,
                                            editingCubit: editingCubit,
                                          );
                                        }
                                        if (selection is ImageElement) {
                                          return ImageElementDialog(
                                              editingCubit: editingCubit,
                                              selectionCubit: selectionCubit,
                                              index: index,
                                              bloc: widget.bloc);
                                        }
                                        return GeneralElementDialog(
                                            index: index,
                                            bloc: bloc,
                                            selectionCubit: selectionCubit,
                                            editingCubit: editingCubit);
                                      })
                                  .then((value) =>
                                      context.read<SelectionCubit>().reset());
                            }

                            context.read<SelectionCubit>().change(hits.first);
                            if (hits.length == 1) {
                              showSelection();
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => SelectLayerDialog(
                                      cubit:
                                          this.context.read<SelectionCubit>(),
                                      layers: hits)).then((value) {
                                if (value != true) {
                                  this.context.read<SelectionCubit>().reset();
                                } else {
                                  showSelection();
                                }
                              });
                            }
                          }
                        }
                      },
                      behavior: HitTestBehavior.translucent,
                      onPointerHover: (event) {
                        var editingCubit = context.read<EditingCubit>();
                        var transform = context.read<TransformCubit>().state;
                        if (editingCubit.isMoving) {
                          var position = event.localPosition;
                          editingCubit
                              .moveTo(transform.localToGlobal(position));
                        }
                      },
                      onPointerMove: (PointerMoveEvent event) {
                        var cubit = context.read<EditingCubit>();
                        var currentLayer = cubit.get(event.pointer);
                        var transform = context.read<TransformCubit>().state;
                        var input =
                            InputType.values[_prefs?.getInt('input') ?? 0];
                        if (cubit.isMoving) return;
                        if (!input.canCreate(
                                event.pointer, cubit.first(), event.kind) ||
                            event.buttons == kMiddleMouseButton ||
                            state.currentPainter == null) {
                          if (openView) {
                            openView =
                                (event.delta / transform.size) == Offset.zero;
                          }
                          context
                              .read<TransformCubit>()
                              .move(event.delta / transform.size);
                          return;
                        }
                        if ((event.kind == PointerDeviceKind.stylus ||
                            state.currentPainter != null)) {
                          if (state.currentPainter is PathEraserPainter) {
                            widget.bloc.add(LayersRemoved(rayCast(transform
                                    .localToGlobal(event.localPosition))
                                .where((element) =>
                                    element is! EraserElement ||
                                    (state.currentPainter as PathEraserPainter)
                                        .includeEraser)
                                .toList()));
                          } else if (currentLayer != null &&
                              currentLayer is PathElement) {
                            // Add point to custom paint
                            context.read<EditingCubit>().change(
                                event.pointer,
                                currentLayer.copyWith(
                                    points: List.from(currentLayer.points)
                                      ..add(PathPoint.fromOffset(
                                          transform.localToGlobal(
                                              event.localPosition),
                                          event.pressure))));
                          }
                        }
                      },
                      child: Builder(builder: (context) {
                        return FutureBuilder<Map<ElementLayer, ui.Image>>(
                          future: loadImages(state.document, images),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              images = snapshot.data!;
                            } else if (kIsWeb) {
                              return Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.loading,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      )
                                    ]),
                                  ));
                            }
                            return BlocBuilder<TransformCubit, CameraTransform>(
                              builder: (context, transform) {
                                return Stack(children: [
                                  Container(color: Colors.white),
                                  BlocBuilder<EditingCubit,
                                      Map<int, ElementLayer>>(
                                    builder: (context, editing) => BlocBuilder<
                                            SelectionCubit, ElementLayer?>(
                                        builder: (context, selection) {
                                      return CustomPaint(
                                        size: Size.infinite,
                                        foregroundPainter: ForegroundPainter(
                                            editing, transform, selection),
                                        painter: ViewPainter(state.document,
                                            transform: transform,
                                            images: images),
                                        isComplex: true,
                                        willChange: true,
                                      );
                                    }),
                                  ),
                                  if (snapshot.connectionState ==
                                          ConnectionState.waiting &&
                                      images.isEmpty &&
                                      !kIsWeb)
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          margin: const EdgeInsets.all(8),
                                          child:
                                              const CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                          height: 20.0,
                                          width: 20.0,
                                        )),
                                ]);
                              },
                            );
                          },
                        );
                      })));
            }))),
          );
        });
  }
}
