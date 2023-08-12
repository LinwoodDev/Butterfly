import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/area/context.dart';
import 'package:butterfly/dialogs/elements.dart';
import 'package:butterfly/helpers/offset_helper.dart';
import 'package:butterfly/helpers/point_helper.dart';
import 'package:butterfly/helpers/rect_helper.dart';
import 'package:butterfly/models/cursor.dart';
import 'package:butterfly/renderers/foregrounds/area.dart';
import 'package:butterfly/visualizer/painter.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lw_sysinfo/lw_sysinfo.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../actions/paste.dart';
import '../api/open.dart';
import '../cubits/current_index.dart';
import '../dialogs/camera.dart';
import '../dialogs/name.dart';
import '../helpers/num_helper.dart';
import '../models/label.dart';
import '../models/viewport.dart';
import '../renderers/cursors/eraser.dart';
import '../renderers/cursors/label.dart';
import '../renderers/renderer.dart';
import '../services/asset.dart';
import '../services/import.dart';
import '../views/toolbars/color.dart';
import '../views/toolbars/components.dart';
import '../views/toolbars/label.dart';
import '../views/toolbars/presentation/toolbar.dart';
import '../widgets/context_menu.dart';

part 'area.dart';
part 'asset.dart';
part 'eraser.dart';
part 'full_screen.dart';
part 'hand.dart';
part 'import.dart';
part 'label.dart';
part 'laser.dart';
part 'layer.dart';
part 'move.dart';
part 'path_eraser.dart';
part 'pen.dart';
part 'presentation.dart';
part 'redo.dart';
part 'shape.dart';
part 'spacer.dart';
part 'stamp.dart';
part 'undo.dart';

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

  DocumentPresentationState? getPresentationState() {
    final state = getDocumentBloc().state;
    if (state is! DocumentPresentationState) {
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

  NoteData? getData() => getState()?.data;

  DocumentPage? getPage() => getState()?.page;
}

enum PainterStatus { normal, disabled }

abstract class Handler<T> {
  final T data;

  const Handler(this.data);

  bool onSelected(DocumentBloc bloc, CurrentIndexCubit currentIndexCubit,
          bool justAdded) =>
      true;

  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
          NoteData document, DocumentPage page, DocumentInfo info,
          [Area? currentArea]) =>
      [];

  bool onRendererUpdated(DocumentPage page, Renderer old, Renderer updated) =>
      false;

  bool onRenderersCreated(DocumentPage page, List<Renderer> renderers) => false;

  void onPointerDown(PointerDownEvent event, EventContext context) {}

  void onPointerMove(PointerMoveEvent event, EventContext context) {}

  void onPointerGestureMove(PointerMoveEvent event, EventContext context) {}

  void onPointerUp(PointerUpEvent event, EventContext context) {}

  void onPointerHover(PointerHoverEvent event, EventContext context) {}

  void onTapUp(TapUpDetails details, EventContext context) {}

  void onTapDown(TapDownDetails details, EventContext context) {}

  void onSecondaryTapUp(TapUpDetails details, EventContext context) {}

  void onSecondaryTapDown(TapDownDetails details, EventContext context) {}

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

  PhosphorIconData? getIcon(DocumentBloc bloc) => null;

  static Handler fromDocument(DocumentInfo info, int index) {
    final painter = info.painters[index];
    return Handler.fromPainter(painter);
  }

  static Handler fromPainter(Painter painter) {
    return painter.map(
      hand: (value) => HandHandler(value),
      move: (value) => MoveHandler(value),
      import: (value) => ImportHandler(value),
      undo: (value) => UndoHandler(value),
      redo: (value) => RedoHandler(value),
      label: (value) => LabelHandler(value),
      pen: (value) => PenHandler(value),
      eraser: (value) => EraserHandler(value),
      pathEraser: (value) => PathEraserHandler(value),
      layer: (value) => LayerHandler(value),
      area: (value) => AreaHandler(value),
      laser: (value) => LaserHandler(value),
      shape: (value) => ShapeHandler(value),
      stamp: (value) => StampHandler(value),
      presentation: (value) => PresentationHandler(value),
      spacer: (value) => SpacerHandler(value),
      fullSceen: (value) => FullScreenHandler(value),
      asset: (value) => AssetHandler(value),
    );
  }

  PreferredSizeWidget? getToolbar(DocumentBloc bloc) => null;

  void dispose(DocumentBloc bloc) {}

  Map<Type, Action<Intent>> getActions(BuildContext context) => {
        PasteTextIntent: CallbackAction<PasteTextIntent>(
            onInvoke: (intent) =>
                Actions.maybeInvoke(context, PasteIntent(context))),
      };

  MouseCursor? get cursor => null;
}

mixin HandlerWithCursor<T> on Handler<T> {
  Offset? _currentPos;

  Renderer createCursor(Offset position);

  @mustCallSuper
  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
      NoteData document, DocumentPage page, DocumentInfo info,
      [Area? currentArea]) {
    final renderers =
        super.createForegrounds(currentIndexCubit, document, page, info);
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
  DocumentBloc bloc,
  CameraTransform transform,
  double radius,
) async {
  return rayCastRect(
    Rect.fromCircle(center: globalPosition, radius: radius),
    bloc,
    transform,
  );
}

Future<Set<Renderer<PadElement>>> rayCastRect(
  Rect rect,
  DocumentBloc bloc,
  CameraTransform transform,
) async {
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

abstract class PastingHandler<T> extends Handler<T> {
  Offset? _firstPos;
  Offset? _secondPos;
  bool _aspectRatio = false, _center = false;
  String _currentLayer = '';

  PastingHandler(super.data);

  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
          NoteData document, DocumentPage page, DocumentInfo info,
          [Area? currentArea]) =>
      [
        if (_firstPos != null && _secondPos != null)
          ...getTransformed().map((e) => Renderer.fromInstance(e)).toList(),
      ];

  List<PadElement> transformElements(Rect rect, String layer);

  List<PadElement> getTransformed() {
    final first = _firstPos;
    final second = _secondPos;
    if (first == null || second == null) return [];
    var top = min(first.dy, second.dy);
    var left = min(first.dx, second.dx);
    var bottom = max(first.dy, second.dy);
    var right = max(first.dx, second.dx);
    var width = right - left;
    var height = bottom - top;
    if (_aspectRatio) {
      final largest = max(width, height);
      width = largest;
      height = largest;
      right = left + width;
      bottom = top + height;
    }
    if (constraintedHeight != 0) {
      height = constraintedHeight;
      bottom = top + height;
    }
    if (constraintedWidth != 0) {
      width = constraintedWidth;
      right = left + width;
    }
    if (constraintedAspectRatio != 0 &&
        (constraintedHeight == 0 || constraintedWidth == 0)) {
      if (constraintedHeight != 0) {
        height = constraintedHeight;
        width = constraintedAspectRatio * height;
        right = left + width;
      } else if (constraintedWidth != 0) {
        width = constraintedWidth;
        height = width / constraintedAspectRatio;
        bottom = top + height;
      } else {
        final largest = max(width, height);
        width = constraintedAspectRatio * largest;
        height = largest / constraintedAspectRatio;
        right = left + width;
        bottom = top + height;
      }
    }
    if (_center) {
      top -= height;
      left -= width;
    }
    final rect = Rect.fromLTRB(left, top, right, bottom);
    if (rect.isEmpty) return [];
    return transformElements(rect, _currentLayer);
  }

  void _updateElement(PointerEvent event, EventContext context,
      [bool first = false]) {
    final transform = context.getCameraTransform();
    if (first) _firstPos = transform.localToGlobal(event.localPosition);
    _secondPos = transform.localToGlobal(event.localPosition);
    _aspectRatio = context.isCtrlPressed;
    _center = context.isShiftPressed;
    _currentLayer = context.getState()?.currentLayer ?? '';

    context.refresh();
  }

  @override
  void onPointerDown(PointerDownEvent event, EventContext context) =>
      _updateElement(event, context, true);
  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) =>
      _updateElement(event, context);

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    final bloc = context.getDocumentBloc();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final elements = getTransformed();
    if (elements.isEmpty) return;
    final current = List<PadElement>.from(elements);
    bloc.add(ElementsCreated(current));
    bloc.bake();
    _firstPos = null;
    _secondPos = null;
    context.refresh();
  }

  double get constraintedAspectRatio => 0;
  double get constraintedWidth => 0;
  double get constraintedHeight => 0;
}
