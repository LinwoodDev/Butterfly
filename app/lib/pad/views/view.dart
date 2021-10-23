import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/elements/eraser.dart';
import 'package:butterfly/models/elements/image.dart';
import 'package:butterfly/models/elements/label.dart';
import 'package:butterfly/models/elements/pen.dart';
import 'package:butterfly/models/elements/path.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/cubits/transform.dart';
import 'package:butterfly/pad/dialogs/elements/eraser.dart';
import 'package:butterfly/pad/dialogs/elements/image.dart';
import 'package:butterfly/pad/dialogs/elements/label.dart';
import 'package:butterfly/pad/dialogs/elements/paint.dart';
import 'package:butterfly/painter/image.dart';
import 'package:butterfly/painter/painter.dart';
import 'package:butterfly/painter/path_eraser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:butterfly/painter/label.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_painter.dart';

class MainViewViewport extends StatefulWidget {
  final DocumentBloc bloc;

  const MainViewViewport({Key? key, required this.bloc}) : super(key: key);
  @override
  _MainViewViewportState createState() => _MainViewViewportState();
}

class _MainViewViewportState extends State<MainViewViewport> {
  bool _moveEnabled = false, _viewMode = false;
  late TransformationController _controller;
  GlobalKey transformKey = GlobalKey();
  ElementLayer? currentEditingLayer;
  ViewPainter? painter;

  @override
  void initState() {
    super.initState();
    _controller = TransformationController();
    _controller.addListener(() {
      context.read<TransformCubit>().emit(_controller.value);
      _viewMode = false;
    });
    var state = context.read<DocumentBloc>().state as DocumentLoadSuccess;
    painter ??= ViewPainter(state.document, currentEditingLayer);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
        bloc: widget.bloc,
        builder: (context, state) {
          if (state is! DocumentLoadSuccess) return Container();
          return FutureBuilder(
              future: painter?.loadImages(),
              builder: (context, snapshot) {
                painter?.document = state.document;
                painter?.editingLayer = currentEditingLayer;
                return LayoutBuilder(builder: (context, constraints) {
                  final viewportSize =
                      Size(constraints.maxWidth, constraints.maxHeight);
                  List<ElementLayer> raycast(Offset offset) {
                    return state.document.content
                        .where((element) => element.hit(offset))
                        .toList();
                  }

                  return SizedBox.expand(child:
                      BlocBuilder<TransformCubit, Matrix4>(
                          builder: (context, transform) {
                    var translation = -transform.getTranslation();
                    var scale = transform.up.y;
                    //scale *= scale;
                    var paintViewport = Size(
                        (translation.x + viewportSize.width * 2) / scale,
                        (translation.y + viewportSize.height * 2) / scale);
                    _controller.value = transform;
                    return Listener(
                      onPointerSignal: (pointerSignal) {
                        if (pointerSignal is PointerScrollEvent) {
                          // Scale the matrix
                          var scale = 1 - pointerSignal.scrollDelta.dy / 100;
                          var currentScale = transform.up.y;
                          scale *= currentScale;
                          scale = scale.clamp(0.25, 5);
                          scale /= currentScale;
                          context.read<TransformCubit>().emit(
                              Matrix4.copy(transform)
                                ..scale(scale, scale, scale));
                        }
                      },
                      onPointerDown: (PointerDownEvent event) {
                        if (event.kind == PointerDeviceKind.stylus ||
                            state.editMode) {
                          if (state.currentPainter is BuildedPainter) {
                            var painter =
                                state.currentPainter as BuildedPainter;
                            setState(() => currentEditingLayer =
                                painter.buildLayer(
                                    _controller.toScene(event.localPosition),
                                    event.pressure));
                          }
                          if (state.currentPainter is LabelPainter) {
                            var painter = state.currentPainter as LabelPainter;
                            var _textController = TextEditingController();
                            void submit() {
                              Navigator.of(context).pop();
                              widget.bloc.add(LayerCreated(LabelElement(
                                  property: painter.property,
                                  text: _textController.text,
                                  position: _controller
                                      .toScene(event.localPosition))));
                            }

                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                        title: Text(
                                            AppLocalizations.of(context)!
                                                .enterText),
                                        content: TextField(
                                          controller: _textController,
                                          autofocus: true,
                                          onSubmitted: (text) => submit(),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .cancel),
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                          ),
                                          TextButton(
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .ok),
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
                                content = File(e.path ?? "").readAsBytesSync();
                              }
                              ui.decodeImageFromList(content, (image) async {
                                var bytes = await image.toByteData(
                                    format: ui.ImageByteFormat.png);
                                widget.bloc.add(LayerCreated(ImageElement(
                                    height: image.height,
                                    width: image.width,
                                    pixels: bytes?.buffer.asUint8List() ??
                                        Uint8List(0),
                                    position: _controller
                                        .toScene(event.localPosition))));
                              });
                            });
                          }
                        } else {
                          setState(() {
                            _moveEnabled = true;
                            _viewMode = true;
                          });
                        }
                      },
                      onPointerUp: (PointerUpEvent event) {
                        if ((event.kind == PointerDeviceKind.stylus ||
                                state.editMode) &&
                            currentEditingLayer != null) {
                          widget.bloc.add(LayerCreated(currentEditingLayer!));
                          setState(() => currentEditingLayer = null);
                        } else if (_viewMode && !state.editMode) {
                          _viewMode = false;
                          var hits =
                              raycast(_controller.toScene(event.localPosition));
                          var hit = hits.isEmpty ? null : hits.last;
                          if (hit != null) {
                            var index = state.document.content.indexOf(hit);
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  if (hit is PenElement) {
                                    return PaintElementDialog(
                                        index: index, bloc: widget.bloc);
                                  }
                                  if (hit is EraserElement) {
                                    return EraserElementDialog(
                                        index: index, bloc: widget.bloc);
                                  }
                                  if (hit is LabelElement) {
                                    return LabelElementDialog(
                                        index: index, bloc: widget.bloc);
                                  }
                                  if (hit is ImageElement) {
                                    return ImageElementDialog(
                                        index: index, bloc: widget.bloc);
                                  }
                                  return Container();
                                });
                          }
                        }
                        setState(() => _moveEnabled = false);
                      },
                      behavior: HitTestBehavior.translucent,
                      onPointerMove: (PointerMoveEvent event) {
                        if ((event.kind == PointerDeviceKind.stylus ||
                            state.editMode)) {
                          if (state.currentPainter is PathEraserPainter) {
                            widget.bloc.add(LayersRemoved(raycast(
                                    _controller.toScene(event.localPosition))
                                .where((element) =>
                                    element is! EraserElement ||
                                    (state.currentPainter as PathEraserPainter)
                                        .canDeleteEraser)
                                .toList()));
                          } else if (currentEditingLayer != null &&
                              currentEditingLayer is PathElement) {
                            // Add point to custom paint
                            var layer = currentEditingLayer as PathElement;
                            setState(() => currentEditingLayer = layer.copyWith(
                                points: List.from(layer.points)
                                  ..add(PathPoint.fromOffset(
                                      _controller.toScene(event.localPosition),
                                      event.pressure))));
                          }
                        }
                      },
                      child: Stack(children: [
                        InteractiveViewer(
                          constrained: false,
                          transformationController: _controller,
                          panEnabled: _moveEnabled,
                          minScale: 0.25,
                          maxScale: 5,
                          scaleEnabled: _moveEnabled,
                          child: Container(
                            color: Colors.white,
                            child: CustomPaint(
                              key: transformKey,
                              size: paintViewport,
                              painter: painter,
                            ),
                          ),
                        ),
                        if (snapshot.connectionState == ConnectionState.waiting)
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                child: const CircularProgressIndicator(),
                                height: 20.0,
                                width: 20.0,
                              )),
                      ]),
                    );
                  }));
                });
              });
        });
  }
}
