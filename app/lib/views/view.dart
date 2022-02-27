import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editing.dart';
import 'package:butterfly/cubits/selection.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/area/context.dart';
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
import 'package:butterfly/models/painters/area.dart';
import 'package:butterfly/models/painters/label.dart';
import 'package:butterfly/models/painters/layer.dart';
import 'package:butterfly/models/painters/painter.dart';
import 'package:butterfly/models/painters/path_eraser.dart';
import 'package:butterfly/models/painters/pen.dart';
import 'package:butterfly/widgets/context_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../models/area.dart';
import '../view_painter.dart';

class MainViewViewport extends StatefulWidget {
  const MainViewViewport({Key? key}) : super(key: key);

  @override
  _MainViewViewportState createState() => _MainViewViewportState();
}

class _RayCastParams {
  final Offset position;
  final double radius;
  final bool includeEraser;
  final List<PadElement> elements;
  final List<String> invisibleLayers;

  _RayCastParams(this.position, this.elements, this.invisibleLayers,
      this.includeEraser, this.radius);
}

List<int> _executeRayCast(_RayCastParams params) {
  var result = <int>[];
  params.elements
      .asMap()
      .entries
      .where((element) =>
          !params.invisibleLayers.contains(element.value.layer) &&
          element.value.hit(params.position, params.radius) &&
          (element.value is! EraserElement || params.includeEraser))
      .forEach((element) => result.add(element.key));
  return result;
}

class _MainViewViewportState extends State<MainViewViewport> {
  double size = 1.0;
  GlobalKey paintKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: ClipRRect(
            child: LayoutBuilder(
                builder: (context, constraints) =>
                    BlocBuilder<DocumentBloc, DocumentState>(
                        builder: (context, state) {
                      if (state is! DocumentLoadSuccess) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      void _bake([CameraTransform? transform]) {
                        context.read<DocumentBloc>().add(ImageBaked(
                            constraints.biggest,
                            MediaQuery.of(context).devicePixelRatio,
                            transform ?? context.read<TransformCubit>().state));
                      }

                      if (state.bakedViewport?.toSize() !=
                          Size(constraints.biggest.width.roundToDouble(),
                              constraints.biggest.height.roundToDouble())) {
                        _bake();
                      }
                      Future<Map<int, PadElement>> rayCast(
                          Offset offset, bool includeEraser,
                          [double radius = 5]) async {
                        var content = state.document.content;
                        var zoom = context.read<TransformCubit>().state.size;
                        var result = await compute(
                            _executeRayCast,
                            _RayCastParams(
                                offset,
                                content.toList(),
                                state.invisibleLayers.toList(),
                                includeEraser,
                                radius / zoom));
                        return result.map((e) => content[e]).toList().asMap();
                      }

                      Future<void> createElement(int pointer,
                          Offset localPosition, double pressure) async {
                        var transform = context.read<TransformCubit>().state;
                        if (state.currentPainter is BuildedPainter) {
                          var painter = state.currentPainter as BuildedPainter;
                          double zoom = 1;
                          if (painter is PenPainter) {
                            zoom = painter.zoomDependent ? transform.size : 1;
                          }
                          context.read<EditingCubit>().put(
                              pointer,
                              painter.buildElement(
                                  transform.localToGlobal(localPosition),
                                  pressure,
                                  zoom,
                                  state.currentLayer));
                        }
                        if (state.currentPainter is LabelPainter) {
                          var painter = state.currentPainter as LabelPainter;
                          var bloc = context.read<DocumentBloc>();

                          var newElement = await showDialog(
                              context: context,
                              builder: (_) => BlocProvider.value(
                                  value: bloc,
                                  child: EditLabelElementDialog(
                                    element: LabelElement(
                                      property: painter.property,
                                      position: transform
                                          .localToGlobal(localPosition),
                                    ),
                                  )));
                          if (newElement != null) {
                            bloc
                              ..add(ElementsCreated([newElement]))
                              ..add(ImageBaked(
                                  constraints.biggest,
                                  MediaQuery.of(context).devicePixelRatio,
                                  transform));
                          }
                        }
                      }

                      Future<dynamic> showAreaContextMenu(
                          Offset position) async {
                        Future<dynamic> _showExactAreaContextMenu(Area area) =>
                            showContextMenu(
                                context: context,
                                position: position,
                                builder: (ctx, close) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(
                                            value:
                                                context.read<DocumentBloc>()),
                                        BlocProvider.value(
                                            value:
                                                context.read<TransformCubit>()),
                                      ],
                                      child: Actions(
                                          actions: context
                                                  .findAncestorWidgetOfExactType<
                                                      Actions>()
                                                  ?.actions ??
                                              {},
                                          child: AreaContextMenu(
                                              position: position,
                                              area: area,
                                              close: close)),
                                    ));
                        var transform = context.read<TransformCubit>().state;
                        var areas = state.document.areas
                            .where((area) => area.hit(
                                transform.localToGlobal(position), 5 / size))
                            .toList()
                            .reversed
                            .toList();
                        if (areas.length == 1) {
                          return _showExactAreaContextMenu(areas.first);
                        } else if (areas.length > 1) {
                          var selected = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              scrollable: true,
                              title: Text(
                                  AppLocalizations.of(context)!.selectArea),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: List.generate(
                                    areas.length,
                                    (index) => IconButton(
                                        icon: const Icon(
                                            PhosphorIcons.squareLight),
                                        onPressed: () {
                                          Navigator.pop(context, areas[index]);
                                        }),
                                  ),
                                ),
                              ),
                            ),
                          );
                          if (selected != null) {
                            return _showExactAreaContextMenu(selected);
                          }
                        }
                      }

                      var openView = false;

                      return GestureDetector(
                          onSecondaryTapUp: (details) {
                            showAreaContextMenu(details.localPosition);
                          },
                          onScaleUpdate: (details) {
                            if (state.currentPainter is! AreaPainter &&
                                (state.currentPainter != null ||
                                    details.scale == 1)) return;
                            if (openView) openView = details.scale == 1;
                            var cubit = context.read<TransformCubit>();
                            var current = details.scale;
                            current = current - size;
                            current += 1;
                            var sensitivity = context
                                .read<SettingsCubit>()
                                .state
                                .touchSensitivity;
                            cubit.zoom((1 - current) / -sensitivity + 1,
                                details.localFocalPoint);
                            if (state.currentPainter != null &&
                                details.pointerCount == 2) {
                              cubit.move(details.focalPointDelta);
                            }
                            size = details.scale;
                          },
                          onLongPressEnd: (details) {
                            if (state.currentPainter is! AreaPainter) return;
                            showAreaContextMenu(details.globalPosition);
                          },
                          onScaleEnd: (details) => _bake(),
                          onScaleStart: (details) {
                            size = 1;
                          },
                          child: Listener(
                              onPointerSignal: (pointerSignal) {
                                if (pointerSignal is PointerScrollEvent) {
                                  var scale = pointerSignal.scrollDelta.dx +
                                      pointerSignal.scrollDelta.dy;
                                  var sensitivity = context
                                      .read<SettingsCubit>()
                                      .state
                                      .mouseSensitivity;
                                  scale /= -sensitivity * 100;
                                  scale += 1;
                                  var cubit = context.read<TransformCubit>();
                                  cubit.zoom(
                                      scale, pointerSignal.localPosition);
                                  _bake(cubit.state);
                                }
                              },
                              onPointerDown: (PointerDownEvent event) {
                                var cubit = context.read<EditingCubit>();
                                var sensitivity = context
                                    .read<SettingsCubit>()
                                    .state
                                    .penSensitivity;
                                var input = context
                                    .read<SettingsCubit>()
                                    .state
                                    .inputType;
                                var selectionCubit =
                                    context.read<SelectionCubit>();
                                if (state.currentPainter != null &&
                                    event.buttons != kMiddleMouseButton &&
                                    input.canCreate(event.pointer,
                                        cubit.first(), event.kind)) {
                                  createElement(
                                      event.pointer,
                                      event.localPosition,
                                      event.pressure * sensitivity);
                                } else {
                                  openView = true;
                                }
                                var painter = state.currentPainter;
                                if (painter is AreaPainter &&
                                    event.buttons != kMiddleMouseButton &&
                                    event.buttons != kSecondaryMouseButton) {
                                  var pos = context
                                      .read<TransformCubit>()
                                      .state
                                      .localToGlobal(event.localPosition);
                                  var area = Area.fromPoints(pos, pos,
                                      height: painter.constrainedHeight,
                                      width: painter.constrainedWidth,
                                      aspectRatio:
                                          painter.constrainedAspectRatio);
                                  if (state.document.getAreaByRect(area.rect) ==
                                      null) {
                                    selectionCubit.change(area);
                                  }
                                }
                              },
                              onPointerUp: (PointerUpEvent event) async {
                                var cubit = context.read<EditingCubit>();
                                var transformCubit =
                                    context.read<TransformCubit>();
                                var selectionCubit =
                                    context.read<SelectionCubit>();
                                var selection = selectionCubit.state;
                                var transform = transformCubit.state;
                                var bloc = context.read<DocumentBloc>();
                                var state = bloc.state;
                                if (state is! DocumentLoadSuccess) return;
                                var painter = state.currentPainter;
                                if (painter is AreaPainter &&
                                    selection is Area &&
                                    (event.localPosition - selection.position)
                                            .distanceSquared >
                                        transform.size) {
                                  var pos = transform
                                      .localToGlobal(event.localPosition);
                                  var area = Area.fromPoints(
                                      selection.position, pos,
                                      height: painter.constrainedHeight,
                                      width: painter.constrainedWidth,
                                      aspectRatio:
                                          painter.constrainedAspectRatio);
                                  if (state.document.getAreaByRect(area.rect) ==
                                      null) {
                                    context
                                        .read<DocumentBloc>()
                                        .add(AreaCreated(area));
                                    selectionCubit.reset();
                                  }
                                  return;
                                }
                                _bake();
                                if (state.currentPainter is AreaPainter &&
                                    selection is Area) {
                                  return;
                                }
                                if (cubit.isMoving) {
                                  cubit.moveTo(transform
                                      .localToGlobal(event.localPosition));
                                  var movingElement = cubit.getAndResetMove();
                                  if (movingElement != null) {
                                    bloc
                                      ..add(ElementsCreated([movingElement]))
                                      ..add(ImageBaked(
                                          constraints.biggest,
                                          MediaQuery.of(context)
                                              .devicePixelRatio,
                                          transform));
                                    return;
                                  }
                                }
                                var currentElement =
                                    cubit.getAndReset(event.pointer);
                                var input = context
                                    .read<SettingsCubit>()
                                    .state
                                    .inputType;

                                if (input.canCreate(event.pointer,
                                        cubit.first(), event.kind) &&
                                    currentElement != null) {
                                  context.read<DocumentBloc>()
                                    ..add(ElementsCreated([currentElement]))
                                    ..add(ImageBaked(
                                        constraints.biggest,
                                        MediaQuery.of(context).devicePixelRatio,
                                        transform));
                                } else {
                                  if (!openView ||
                                      state.currentPainter != null) {
                                    return;
                                  }
                                  var hits = await rayCast(
                                      transform
                                          .localToGlobal(event.localPosition),
                                      state
                                          .document.handProperty.includeEraser);

                                  if (hits.isNotEmpty) {
                                    void showSelection() {
                                      var selectionCubit =
                                          context.read<SelectionCubit>();
                                      var editingCubit =
                                          context.read<EditingCubit>();
                                      var selection = selectionCubit.state;
                                      var bloc = context.read<DocumentBloc>();
                                      if (selection == null) return;
                                      var index = state.document.content
                                          .indexOf(selection);
                                      var actor =
                                          context.findAncestorWidgetOfExactType<
                                              Actions>();
                                      showContextMenu(
                                              context: context,
                                              position: event.position,
                                              builder: (context, close) {
                                                Widget? menu;
                                                if (selection is LabelElement) {
                                                  menu = LabelElementDialog(
                                                      position: event.position,
                                                      index: index,
                                                      close: close);
                                                }
                                                if (selection is ImageElement) {
                                                  menu = ImageElementDialog(
                                                      position: event.position,
                                                      index: index,
                                                      close: close);
                                                }
                                                menu ??= GeneralElementDialog(
                                                    position: event.position,
                                                    index: index,
                                                    close: close);
                                                return MultiBlocProvider(
                                                    providers: [
                                                      BlocProvider.value(
                                                          value: bloc),
                                                      BlocProvider.value(
                                                          value:
                                                              selectionCubit),
                                                      BlocProvider.value(
                                                          value: editingCubit),
                                                      BlocProvider.value(
                                                          value: transformCubit)
                                                    ],
                                                    child: Actions(
                                                        actions:
                                                            actor?.actions ??
                                                                {},
                                                        child: menu));
                                              })
                                          .then((value) => context
                                              .read<SelectionCubit>()
                                              .reset());
                                    }

                                    context
                                        .read<SelectionCubit>()
                                        .change(hits.values.last);
                                    if (hits.length == 1) {
                                      showSelection();
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              SelectElementDialog(
                                                  cubit:
                                                      this.context.read<
                                                          SelectionCubit>(),
                                                  elements: hits.values
                                                      .toList())).then((value) {
                                        if (value != true) {
                                          this
                                              .context
                                              .read<SelectionCubit>()
                                              .reset();
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
                                        builder: (ctx, close) =>
                                            MultiBlocProvider(
                                              providers: [
                                                BlocProvider.value(
                                                    value: context
                                                        .read<DocumentBloc>()),
                                                BlocProvider.value(
                                                    value: context.read<
                                                        TransformCubit>()),
                                              ],
                                              child: Actions(
                                                  actions: context
                                                          .findAncestorWidgetOfExactType<
                                                              Actions>()
                                                          ?.actions ??
                                                      {},
                                                  child: BackgroundContextMenu(
                                                      position: event.position,
                                                      close: close)),
                                            ));
                                  }
                                }
                              },
                              behavior: HitTestBehavior.translucent,
                              onPointerHover: (event) {
                                var editingCubit = context.read<EditingCubit>();
                                var transform =
                                    context.read<TransformCubit>().state;
                                if (editingCubit.isMoving) {
                                  var position = event.localPosition;
                                  editingCubit.moveTo(
                                      transform.localToGlobal(position));
                                }
                              },
                              onPointerMove: (PointerMoveEvent event) async {
                                var cubit = context.read<EditingCubit>();
                                var currentElement = cubit.get(event.pointer);
                                var sensitivity = context
                                    .read<SettingsCubit>()
                                    .state
                                    .penSensitivity;
                                var transform =
                                    context.read<TransformCubit>().state;
                                var input = context
                                    .read<SettingsCubit>()
                                    .state
                                    .inputType;
                                var selectionCubit =
                                    context.read<SelectionCubit>();
                                var selection = selectionCubit.state;
                                var painter = state.currentPainter;
                                if (selection is Area &&
                                    painter is AreaPainter) {
                                  var pos = transform
                                      .localToGlobal(event.localPosition);
                                  var area = Area.fromPoints(
                                      selection.position, pos,
                                      height: painter.constrainedHeight,
                                      width: painter.constrainedWidth,
                                      aspectRatio:
                                          painter.constrainedAspectRatio);

                                  if (state.document.getAreaByRect(area.rect) ==
                                      null) {
                                    selectionCubit.change(area);
                                  }
                                }
                                if (cubit.isMoving) {
                                  var position = event.localPosition;
                                  cubit.moveTo(
                                      transform.localToGlobal(position));
                                  return;
                                }
                                if (!input.canCreate(event.pointer,
                                        cubit.first(), event.kind) ||
                                    event.buttons == kMiddleMouseButton ||
                                    state.currentPainter == null) {
                                  if (openView) {
                                    openView = (event.delta / transform.size) ==
                                        Offset.zero;
                                  }
                                  context
                                      .read<TransformCubit>()
                                      .move(event.delta / transform.size);
                                  return;
                                }
                                if (event.kind == PointerDeviceKind.stylus ||
                                    state.currentPainter != null) {
                                  var painter = state.currentPainter;
                                  if (painter is PathEraserPainter) {
                                    var globalPos = transform
                                        .localToGlobal(event.localPosition);
                                    var elements = await rayCast(
                                        globalPos,
                                        painter.includeEraser,
                                        painter.strokeWidth);
                                    context.read<DocumentBloc>()
                                      ..add(ElementsRemoved(
                                          elements.values.toList()))
                                      ..add(ImageBaked(
                                          constraints.biggest,
                                          MediaQuery.of(context)
                                              .devicePixelRatio,
                                          transform));
                                  } else if (painter is LayerPainter) {
                                    context.read<DocumentBloc>().add(
                                        ElementsLayerChanged(
                                            painter.layer,
                                            await rayCast(
                                                    transform.localToGlobal(
                                                        event.localPosition),
                                                    painter.includeEraser)
                                                .then((value) => value.values
                                                    .toList()
                                                    .reversed
                                                    .toList())));
                                  } else if (currentElement != null &&
                                      currentElement is PathElement) {
                                    // Add point to custom paint
                                    context.read<EditingCubit>().change(
                                        event.pointer,
                                        currentElement.copyWith(
                                            points:
                                                List.from(currentElement.points)
                                                  ..add(PathPoint.fromOffset(
                                                      transform.localToGlobal(
                                                          event.localPosition),
                                                      event.pressure *
                                                          sensitivity))));
                                  }
                                }
                              },
                              child:
                                  BlocBuilder<TransformCubit, CameraTransform>(
                                builder: (context, transform) {
                                  return Stack(children: [
                                    Container(color: Colors.white),
                                    BlocBuilder<EditingCubit,
                                        Map<int, PadElement>>(
                                      builder: (context, editing) =>
                                          BlocBuilder<SelectionCubit, dynamic>(
                                              builder: (context, selection) {
                                        return CustomPaint(
                                          size: Size.infinite,
                                          foregroundPainter: ForegroundPainter(
                                            editing,
                                            transform,
                                            selection is PadElement
                                                ? selection
                                                : null,
                                            state.currentPainter is AreaPainter
                                                ? (List<Area>.from(
                                                    state.document.areas)
                                                  ..addAll(selection is Area
                                                      ? [selection]
                                                      : []))
                                                : [],
                                          ),
                                          painter: ViewPainter(
                                            state.document,
                                            elements: state.elements,
                                            bakedViewport: state.bakedViewport,
                                            transform: transform,
                                          ),
                                          isComplex: true,
                                          willChange: true,
                                        );
                                      }),
                                    ),
                                  ]);
                                },
                              )));
                    }))));
  }
}
