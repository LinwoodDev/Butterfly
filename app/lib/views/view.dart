import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editing.dart';
import 'package:butterfly/cubits/selection.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/background/context.dart';
import 'package:butterfly/dialogs/elements/general.dart';
import 'package:butterfly/dialogs/elements/image.dart';
import 'package:butterfly/dialogs/elements/label.dart';
import 'package:butterfly/dialogs/select.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/elements/eraser.dart';
import 'package:butterfly/models/elements/image.dart';
import 'package:butterfly/models/elements/label.dart';
import 'package:butterfly/models/elements/path.dart';
import 'package:butterfly/models/painters/image.dart';
import 'package:butterfly/models/painters/label.dart';
import 'package:butterfly/models/painters/layer.dart';
import 'package:butterfly/models/painters/painter.dart';
import 'package:butterfly/models/painters/path_eraser.dart';
import 'package:butterfly/models/painters/pen.dart';
import 'package:butterfly/widgets/context_menu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../view_painter.dart';

class MainViewViewport extends StatefulWidget {
  const MainViewViewport({Key? key}) : super(key: key);

  @override
  _MainViewViewportState createState() => _MainViewViewportState();
}

class _RayCastParams {
  final Offset position;
  final bool includeEraser;
  final List<PadElement> elements;
  final List<String> invisibleLayers;

  _RayCastParams(
      this.position, this.elements, this.invisibleLayers, this.includeEraser);
}

List<int> _executeRayCast(_RayCastParams params) {
  var result = <int>[];
  params.elements
      .asMap()
      .entries
      .where((element) =>
          !params.invisibleLayers.contains(element.value.layer) &&
          element.value.hit(params.position) &&
          (element.value is! EraserElement || params.includeEraser))
      .forEach((element) => result.add(element.key));
  return result;
}

class _MainViewViewportState extends State<MainViewViewport> {
  Map<PadElement, ui.Image> images = {};
  double size = 1.0;
  GlobalKey paintKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      if (state is! DocumentLoadSuccess) {
        return const Center(child: CircularProgressIndicator());
      }
      return SizedBox.expand(child:
          ClipRRect(child: LayoutBuilder(builder: (context, constraints) {
        List<PadElement> rayCast(Offset offset, bool includeEraser) {
          var content = state.document.content;
          return _executeRayCast(_RayCastParams(offset, content.toList(),
                  state.invisibleLayers.toList(), includeEraser))
              .map((e) => content[e])
              .toList();
        }

        void createElement(int pointer, Offset localPosition, double pressure) {
          var transform = context.read<TransformCubit>().state;
          if (state.currentPainter is BuildedPainter) {
            var painter = state.currentPainter as BuildedPainter;
            double zoom = 1;
            if (painter is PenPainter) {
              zoom = painter.zoomDependent ? transform.size : 1;
            }
            context.read<EditingCubit>().put(
                pointer,
                painter.buildElement(transform.localToGlobal(localPosition),
                    pressure, zoom, state.currentLayer));
          }
          if (state.currentPainter is LabelPainter) {
            var painter = state.currentPainter as LabelPainter;
            var _textController = TextEditingController();
            void submit() {
              Navigator.of(context).pop();
              context.read<DocumentBloc>().add(ElementCreated(LabelElement(
                  property: painter.property,
                  text: _textController.text,
                  layer: state.currentLayer,
                  position: transform.localToGlobal(localPosition))));
            }

            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                        title: Text(AppLocalizations.of(context)!.enterText),
                        content: TextField(
                          controller: _textController,
                          autofocus: true,
                          minLines: 3,
                          maxLines: 5,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.multiline,
                          onSubmitted: (text) => submit(),
                        ),
                        actions: [
                          TextButton(
                            child: Text(AppLocalizations.of(context)!.cancel),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                              child: Text(AppLocalizations.of(context)!.ok),
                              onPressed: submit)
                        ]));
          }
          if (state.currentPainter is ImagePainter) {
            FilePicker.platform.pickFiles(type: FileType.image).then((files) {
              if (files?.files.isEmpty ?? true) return;
              var e = files!.files.first;
              var content = e.bytes ?? Uint8List(0);
              if (!kIsWeb) {
                content = File(e.path ?? '').readAsBytesSync();
              }
              ui.decodeImageFromList(content, (image) async {
                var bytes =
                    await image.toByteData(format: ui.ImageByteFormat.png);
                context.read<DocumentBloc>().add(ElementCreated(ImageElement(
                    height: image.height,
                    width: image.width,
                    layer: state.currentLayer,
                    pixels: bytes?.buffer.asUint8List() ?? Uint8List(0),
                    position: transform.localToGlobal(localPosition))));
              });
            });
          }
        }

        var openView = false;

        return GestureDetector(
            onScaleUpdate: (details) {
              if (state.currentPainter != null || details.scale == 1) return;
              if (openView) openView = details.scale == 1;
              var cubit = context.read<TransformCubit>();
              var current = details.scale;
              current = current - size;
              current += 1;
              cubit.zoom(current, details.localFocalPoint);
              size = details.scale;
            },
            onScaleStart: (details) {
              size = 1;
            },
            child: Listener(
                onPointerSignal: (pointerSignal) {
                  if (pointerSignal is PointerScrollEvent) {
                    var scale = pointerSignal.scrollDelta.dx +
                        pointerSignal.scrollDelta.dy;
                    scale /= -250;
                    scale += 1;
                    var cubit = context.read<TransformCubit>();
                    cubit.zoom(scale, pointerSignal.localPosition);
                  }
                },
                onPointerDown: (PointerDownEvent event) {
                  var cubit = context.read<EditingCubit>();
                  var input = context.read<SettingsCubit>().state.inputType;
                  if (state.currentPainter != null &&
                      event.buttons != kMiddleMouseButton &&
                      input.canCreate(
                          event.pointer, cubit.first(), event.kind)) {
                    createElement(
                        event.pointer, event.localPosition, event.pressure);
                  } else {
                    openView = true;
                  }
                },
                onPointerUp: (PointerUpEvent event) async {
                  var cubit = context.read<EditingCubit>();
                  var transform = context.read<TransformCubit>().state;
                  if (cubit.isMoving) {
                    cubit.moveTo(transform.localToGlobal(event.localPosition));
                    var movingElement = cubit.getAndResetMove();
                    if (movingElement != null) {
                      context
                          .read<DocumentBloc>()
                          .add(ElementCreated(movingElement));
                      return;
                    }
                  }
                  var currentElement = cubit.getAndReset(event.pointer);
                  var input = context.read<SettingsCubit>().state.inputType;

                  if (input.canCreate(
                          event.pointer, cubit.first(), event.kind) &&
                      currentElement != null) {
                    context
                        .read<DocumentBloc>()
                        .add(ElementCreated(currentElement));
                  } else {
                    if (!openView) {
                      return;
                    }
                    var hits = rayCast(
                        transform.localToGlobal(event.localPosition),
                        state.document.handProperty.includeEraser);
                    if (hits.isNotEmpty) {
                      void showSelection() {
                        var selectionCubit = context.read<SelectionCubit>();
                        var editingCubit = context.read<EditingCubit>();
                        var selection = selectionCubit.state;
                        var bloc = context.read<DocumentBloc>();
                        if (selection == null) return;
                        var index = state.document.content.indexOf(selection);
                        showContextMenu(
                                context: context,
                                position: event.position,
                                builder: (context, close) {
                                  Widget? menu;
                                  if (selection is LabelElement) {
                                    menu = LabelElementDialog(
                                        index: index, close: close);
                                  }
                                  if (selection is ImageElement) {
                                    menu = ImageElementDialog(
                                        index: index, close: close);
                                  }
                                  menu ??= GeneralElementDialog(
                                      index: index, close: close);
                                  return MultiBlocProvider(providers: [
                                    BlocProvider.value(value: bloc),
                                    BlocProvider.value(value: selectionCubit),
                                    BlocProvider.value(value: editingCubit),
                                  ], child: menu);
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
                            builder: (context) => SelectElementDialog(
                                cubit: this.context.read<SelectionCubit>(),
                                elements: hits)).then((value) {
                          if (value != true) {
                            this.context.read<SelectionCubit>().reset();
                          } else {
                            showSelection();
                          }
                        });
                      }
                    } else {
                      context.read<SelectionCubit>().reset();
                      showContextMenu(
                          context: context,
                          position: event.position,
                          builder: (ctx, close) => MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(
                                      value: context.read<DocumentBloc>()),
                                  BlocProvider.value(
                                      value: context.read<TransformCubit>()),
                                ],
                                child: Actions(
                                    actions: context
                                            .findAncestorWidgetOfExactType<
                                                Actions>()
                                            ?.actions ??
                                        {},
                                    child: BackgroundContextMenu(close: close)),
                              ));
                    }
                  }
                },
                behavior: HitTestBehavior.translucent,
                onPointerHover: (event) {
                  var editingCubit = context.read<EditingCubit>();
                  var transform = context.read<TransformCubit>().state;
                  if (editingCubit.isMoving) {
                    var position = event.localPosition;
                    editingCubit.moveTo(transform.localToGlobal(position));
                  }
                },
                onPointerMove: (PointerMoveEvent event) async {
                  var cubit = context.read<EditingCubit>();
                  var currentElement = cubit.get(event.pointer);
                  var transform = context.read<TransformCubit>().state;
                  var input = context.read<SettingsCubit>().state.inputType;
                  if (cubit.isMoving) {
                    var position = event.localPosition;
                    cubit.moveTo(transform.localToGlobal(position));
                    return;
                  }
                  if (!input.canCreate(
                          event.pointer, cubit.first(), event.kind) ||
                      event.buttons == kMiddleMouseButton ||
                      state.currentPainter == null) {
                    if (openView) {
                      openView = (event.delta / transform.size) == Offset.zero;
                    }
                    context
                        .read<TransformCubit>()
                        .move(event.delta / transform.size);
                    return;
                  }
                  if ((event.kind == PointerDeviceKind.stylus ||
                      state.currentPainter != null)) {
                    var painter = state.currentPainter;
                    if (painter is PathEraserPainter) {
                      context.read<DocumentBloc>().add(ElementsRemoved(rayCast(
                          transform.localToGlobal(event.localPosition),
                          painter.includeEraser)));
                    } else if (painter is LayerPainter) {
                      context.read<DocumentBloc>().add(ElementsLayerChanged(
                          painter.layer,
                          rayCast(transform.localToGlobal(event.localPosition),
                              painter.includeEraser)));
                    } else if (currentElement != null &&
                        currentElement is PathElement) {
                      // Add point to custom paint
                      context.read<EditingCubit>().change(
                          event.pointer,
                          currentElement.copyWith(
                              points: List.from(currentElement.points)
                                ..add(PathPoint.fromOffset(
                                    transform
                                        .localToGlobal(event.localPosition),
                                    event.pressure))));
                    }
                  }
                },
                child: Builder(builder: (context) {
                  return FutureBuilder<Map<PadElement, ui.Image>>(
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
                      return BlocBuilder<TransformCubit, CameraTransform>(
                        builder: (context, transform) {
                          return Stack(children: [
                            Container(color: Colors.white),
                            BlocBuilder<EditingCubit, Map<int, PadElement>>(
                              builder: (context, editing) =>
                                  BlocBuilder<SelectionCubit, PadElement?>(
                                      builder: (context, selection) {
                                return CustomPaint(
                                  size: Size.infinite,
                                  foregroundPainter: ForegroundPainter(
                                      editing, transform, selection),
                                  painter: ViewPainter(state.document,
                                      invisibleLayers: state.invisibleLayers,
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
                                    child: const CircularProgressIndicator(
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
      })));
    });
  }
}
