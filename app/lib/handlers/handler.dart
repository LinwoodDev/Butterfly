import 'dart:async';
import 'dart:math';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/area/context.dart';
import 'package:butterfly/dialogs/background/context.dart';
import 'package:butterfly/dialogs/elements.dart';
import 'package:butterfly/models/cursor.dart';
import 'package:butterfly/models/element.dart';
import 'package:butterfly/models/painter.dart';
import 'package:butterfly/renderers/area.dart';
import 'package:butterfly/theme/manager.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubits/current_index.dart';
import '../dialogs/area/label.dart';
import '../helpers/rect_helper.dart';
import '../models/area.dart';
import '../models/document.dart';
import '../models/pack.dart';
import '../models/path_point.dart';
import '../models/property.dart';
import '../models/text.dart' as text;
import '../models/text.dart';
import '../models/viewport.dart';
import '../renderers/cursors/eraser.dart';
import '../renderers/cursors/text.dart';
import '../renderers/renderer.dart';
import '../services/import.dart';
import '../views/toolbars/color.dart';
import '../views/toolbars/label.dart';
import '../widgets/context_menu.dart';

part 'area.dart';
part 'eraser.dart';
part 'hand.dart';
part 'import.dart';
part 'label.dart';
part 'laser.dart';
part 'layer.dart';
part 'path_eraser.dart';
part 'pen.dart';
part 'redo.dart';
part 'shape.dart';
part 'stamp.dart';
part 'undo.dart';
part 'waypoint.dart';

@immutable
class EventContext {
  final BuildContext buildContext;
  final Size viewportSize;
  final bool isShiftPressed, isAltPressed, isCtrlPressed;

  const EventContext(this.buildContext, this.viewportSize, this.isShiftPressed,
      this.isAltPressed, this.isCtrlPressed);

  DocumentBloc getDocumentBloc() => BlocProvider.of<DocumentBloc>(buildContext);
  DocumentLoadSuccess? getState() {
    final state = getDocumentBloc().state;
    if (state is! DocumentLoadSuccess) {
      return null;
    }
    return state;
  }

  void addDocumentEvent(DocumentEvent event) => getDocumentBloc().add(event);
  double get devicePixelRatio => MediaQuery.of(buildContext).devicePixelRatio;

  TransformCubit getTransformCubit() =>
      BlocProvider.of<TransformCubit>(buildContext);

  CameraTransform getCameraTransform() => getTransformCubit().state;

  CurrentIndexCubit getCurrentIndexCubit() =>
      BlocProvider.of<CurrentIndexCubit>(buildContext);

  CurrentIndex getCurrentIndex() => getCurrentIndexCubit().state;

  void refresh() => getDocumentBloc().refresh();

  SettingsCubit getSettingsCubit() =>
      BlocProvider.of<SettingsCubit>(buildContext);
  ButterflySettings getSettings() => getSettingsCubit().state;

  Future<void> bake(
          {Size? viewportSize, double? pixelRatio, bool reset = false}) =>
      getDocumentBloc().bake(
          pixelRatio: pixelRatio, viewportSize: viewportSize, reset: reset);

  List<BlocProvider> getProviders() => [
        BlocProvider<DocumentBloc>.value(value: getDocumentBloc()),
        BlocProvider<TransformCubit>.value(value: getTransformCubit()),
        BlocProvider<CurrentIndexCubit>.value(value: getCurrentIndexCubit()),
        BlocProvider<SettingsCubit>.value(value: getSettingsCubit())
      ];

  Map<Type, Action<Intent>> getActions() =>
      buildContext.findAncestorWidgetOfExactType<Actions>()?.actions ?? {};

  ImportService getImportService() => buildContext.read<ImportService>();

  CameraViewport getCameraViewport() => getCurrentIndex().cameraViewport;

  AppDocument? getDocument() => getState()?.document;
}

enum PainterStatus { normal, disabled }

abstract class Handler<T> {
  final T data;

  const Handler(this.data);

  bool onSelected(DocumentBloc bloc, CurrentIndexCubit currentIndexCubit,
          bool justAdded) =>
      true;

  List<Renderer> createForegrounds(
          CurrentIndexCubit currentIndexCubit, AppDocument document,
          [Area? currentArea]) =>
      [];

  Future<bool> onRendererUpdated(
          AppDocument appDocument, Renderer old, Renderer updated) async =>
      false;

  void onTapUp(TapUpDetails details, EventContext context) {}

  void onTapDown(TapDownDetails details, EventContext context) {}

  void onSecondaryTapUp(TapUpDetails details, EventContext context) {}

  void onSecondaryTapDown(TapDownDetails details, EventContext context) {}

  void onPointerDown(PointerDownEvent event, EventContext context) {}

  void onPointerMove(PointerMoveEvent event, EventContext context) {}

  void onPointerGestureMove(PointerMoveEvent event, EventContext context) {}

  void onPointerUp(PointerUpEvent event, EventContext context) {}

  void onPointerHover(PointerHoverEvent event, EventContext context) {}

  void onLongPressEnd(LongPressEndDetails details, EventContext context) {}

  bool onScaleStart(ScaleStartDetails details, EventContext context) => false;

  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {}

  void onScaleEnd(ScaleEndDetails details, EventContext context) {}

  void onDoubleTapDown(TapDownDetails details, EventContext context) {}

  void onDoubleTap(EventContext context) {}

  void onLongPressDown(LongPressDownDetails details, EventContext context) {}

  bool canChange(PointerDownEvent event, EventContext context) => true;

  void resetInput(DocumentBloc bloc) {}

  PainterStatus getStatus(DocumentBloc bloc) => PainterStatus.normal;

  static Handler fromDocument(AppDocument document, int index) {
    final painter = document.painters[index];
    return Handler.fromPainter(painter);
  }

  static Handler fromPainter(Painter painter) {
    return painter.map(
      hand: (value) => HandHandler(value),
      import: (value) => ImportHandler(value),
      undo: (value) => UndoHandler(value),
      redo: (value) => RedoHandler(value),
      label: (value) => LabelHandler(value),
      pen: (value) => PenHandler(value),
      eraser: (value) => EraserHandler(value),
      pathEraser: (value) => PathEraserHandler(value),
      layer: (value) => LayerHandler(value),
      area: (value) => AreaHandler(value),
      waypoint: (value) => WaypointHandler(value),
      laser: (value) => LaserHandler(value),
      shape: (value) => ShapeHandler(value),
      stamp: (value) => StampHandler(value),
    );
  }

  Widget? getToolbar(BuildContext context) => null;

  void dispose(DocumentBloc bloc) {}

  Map<Type, Action<Intent>> getActions(BuildContext context) => {};
}

mixin HandlerWithCursor<T> on Handler<T> {
  Offset? _currentPos;

  Renderer createCursor(Offset position);

  @mustCallSuper
  @override
  List<Renderer> createForegrounds(
      CurrentIndexCubit currentIndexCubit, AppDocument document,
      [Area? currentArea]) {
    final renderers = super.createForegrounds(currentIndexCubit, document);
    if (_currentPos != null) {
      renderers.add(createCursor(_currentPos!));
    }
    return renderers;
  }

  @mustCallSuper
  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    _currentPos = event.localPosition;
    context.refresh();
  }

  @mustCallSuper
  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    _currentPos = event.localPosition;
    context.refresh();
  }
}

typedef HitRequest = bool Function(Offset position, [double radius]);

class _SmallRenderer {
  final HitCalculator hitCalc;
  final PadElement element;

  _SmallRenderer(this.hitCalc, this.element);
  _SmallRenderer.fromRenderer(Renderer renderer)
      : hitCalc = renderer.getHitCalculator(),
        element = renderer.element;
}

class _RayCastParams {
  final List<String> invisibleLayers;
  final List<_SmallRenderer> renderers;
  final Rect rect;
  final double size;

  const _RayCastParams(
      this.invisibleLayers, this.renderers, this.rect, this.size);
}

Future<Set<Renderer<PadElement>>> rayCast(
  Offset globalPosition,
  BuildContext context,
  double radius,
) async {
  return rayCastRect(
    Rect.fromCircle(center: globalPosition, radius: radius),
    context,
  );
}

Future<Set<Renderer<PadElement>>> rayCastRect(
  Rect rect,
  BuildContext context,
) async {
  final bloc = context.read<DocumentBloc>();
  final transform = context.read<TransformCubit>().state;
  final state = bloc.state;
  if (state is! DocumentLoadSuccess) return {};
  final renderers = state.cameraViewport.visibleElements;
  rect = rect.normalized();
  return compute(
    _executeRayCast,
    _RayCastParams(
      state.invisibleLayers,
      renderers.map((e) => _SmallRenderer.fromRenderer(e)).toList(),
      rect,
      transform.size,
    ),
  ).then((value) => value.map((e) => renderers[e]).toSet());
}

Set<int> _executeRayCast(_RayCastParams params) {
  return params.renderers
      .asMap()
      .entries
      .where((e) => !params.invisibleLayers.contains(e.value.element.layer))
      .where((e) => e.value.hitCalc.hit(params.rect))
      .map((e) => e.key)
      .toSet();
}
