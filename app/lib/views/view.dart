import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/selection.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/elements/eraser.dart';
import 'package:butterfly/dialogs/elements/image.dart';
import 'package:butterfly/dialogs/elements/label.dart';
import 'package:butterfly/dialogs/elements/paint.dart';
import 'package:butterfly/dialogs/select.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/elements/eraser.dart';
import 'package:butterfly/models/elements/image.dart';
import 'package:butterfly/models/elements/label.dart';
import 'package:butterfly/models/elements/path.dart';
import 'package:butterfly/models/elements/pen.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
        bloc: widget.bloc,
        builder: (context, state) {
          if (state is! DocumentLoadSuccess) return Container();
          return SizedBox.expand(child:
              ClipRRect(child: LayoutBuilder(builder: (context, constraints) {
            List<ElementLayer> rayCast(Offset offset) {
              return state.document.content
                  .where((element) => element.hit(offset))
                  .toList();
            }

            ElementLayer? currentEditingLayer;
            return StatefulBuilder(builder: (context, setState) {
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
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ]),
                        ));
                  }
                  void createLayer(Offset localPosition, double pressure) {
                    var transform = context.read<TransformCubit>().state;
                    if (state.currentPainter is BuildedPainter) {
                      var painter = state.currentPainter as BuildedPainter;
                      setState(() => currentEditingLayer = painter.buildLayer(
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
                                  title: Text(
                                      AppLocalizations.of(context)!.enterText),
                                  content: TextField(
                                    controller: _textController,
                                    autofocus: true,
                                    onSubmitted: (text) => submit(),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text(
                                          AppLocalizations.of(context)!.cancel),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    TextButton(
                                        child: Text(
                                            AppLocalizations.of(context)!.ok),
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
                              pixels:
                                  bytes?.buffer.asUint8List() ?? Uint8List(0),
                              position:
                                  transform.localToGlobal(localPosition))));
                        });
                      });
                    }
                  }

                  var openView = false;

                  return GestureDetector(
                    onScaleUpdate: (details) {
                      if (state.editMode) return;
                      if (openView) openView = details.scale == 1;
                      var current = size + details.scale - 1;
                      var cubit = context.read<TransformCubit>();
                      cubit.scale(
                          current - cubit.state.size, details.focalPoint);
                    },
                    onScaleStart: (details) {
                      size = context.read<TransformCubit>().state.size;
                    },
                    child: Listener(
                        onPointerSignal: (pointerSignal) {
                          if (pointerSignal is PointerScrollEvent) {
                            var scale = pointerSignal.scrollDelta.dx +
                                pointerSignal.scrollDelta.dy;
                            scale /= -300;
                            var cubit = context.read<TransformCubit>();
                            cubit.scale(
                                scale,
                                cubit.state
                                    .localToGlobal(pointerSignal.position));
                          }
                        },
                        onPointerDown: (PointerDownEvent event) {
                          openView = true;
                          if (event.kind == PointerDeviceKind.stylus ||
                              state.editMode &&
                                  event.buttons != kMiddleMouseButton) {
                            createLayer(event.localPosition, event.pressure);
                          }
                        },
                        onPointerUp: (PointerUpEvent event) {
                          var transform = context.read<TransformCubit>().state;
                          if ((event.kind == PointerDeviceKind.stylus ||
                                  state.editMode) &&
                              currentEditingLayer != null) {
                            widget.bloc.add(LayerCreated(currentEditingLayer!));
                            setState(() => currentEditingLayer = null);
                          } else if (event.kind !=
                                  ui.PointerDeviceKind.stylus &&
                              !state.editMode) {
                            if (!openView) {
                              return;
                            }
                            var hits = rayCast(
                                transform.localToGlobal(event.localPosition));
                            if (hits.isNotEmpty) {
                              void showSelection() {
                                var selection =
                                    context.read<SelectionCubit>().state;
                                if (selection == null) return;
                                var index =
                                    state.document.content.indexOf(selection);
                                showModalBottomSheet(
                                        context: context,
                                    builder: (context) {
                                      if (selection is PenElement) {
                                        return PaintElementDialog(
                                            index: index,
                                            bloc: widget.bloc);
                                      }
                                      if (selection is EraserElement) {
                                        return EraserElementDialog(
                                            index: index,
                                            bloc: widget.bloc);
                                      }
                                      if (selection is LabelElement) {
                                        return LabelElementDialog(
                                            index: index,
                                            bloc: widget.bloc);
                                      }
                                      if (selection is ImageElement) {
                                        return ImageElementDialog(
                                            index: index,
                                            bloc: widget.bloc);
                                      }
                                      return Container();
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
                        onPointerMove: (PointerMoveEvent event) {
                          var transform = context.read<TransformCubit>().state;
                          if (!state.editMode &&
                                  event.kind != ui.PointerDeviceKind.stylus ||
                              event.buttons == kMiddleMouseButton) {
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
                              state.editMode)) {
                            if (currentEditingLayer == null) {
                              createLayer(event.localPosition, event.pressure);
                            }
                            if (state.currentPainter is PathEraserPainter) {
                              widget.bloc.add(LayersRemoved(rayCast(transform
                                      .localToGlobal(event.localPosition))
                                  .where((element) =>
                                      element is! EraserElement ||
                                      (state.currentPainter
                                              as PathEraserPainter)
                                          .canDeleteEraser)
                                  .toList()));
                            } else if (currentEditingLayer != null &&
                                currentEditingLayer is PathElement) {
                              // Add point to custom paint
                              var layer = currentEditingLayer as PathElement;
                              setState(() => currentEditingLayer =
                                  layer.copyWith(
                                      points: List.from(layer.points)
                                        ..add(PathPoint.fromOffset(
                                            transform.localToGlobal(
                                                event.localPosition),
                                            event.pressure))));
                            }
                          }
                        },
                        child: BlocBuilder<TransformCubit, CameraTransform>(
                          builder: (context, transform) {
                            return Stack(children: [
                              Container(color: Colors.white),
                              BlocBuilder<SelectionCubit, ElementLayer?>(
                                  builder: (context, selection) {
                                return CustomPaint(
                                  size: Size.infinite,
                                  foregroundPainter: ForegroundPainter(
                                      currentEditingLayer,
                                      transform,
                                      selection),
                                  painter: ViewPainter(state.document,
                                      transform: transform, images: images),
                                  isComplex: true,
                                  willChange: true,
                                );
                              }),
                              if (snapshot.connectionState ==
                                      ConnectionState.waiting &&
                                  images.isEmpty &&
                                  !kIsWeb)
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                      height: 20.0,
                                      width: 20.0,
                                    )),
                            ]);
                          },
                        )),
                  );
                },
              );
            });
          })));
        });
  }
}
