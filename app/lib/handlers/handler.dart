import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/area/context.dart';
import 'package:butterfly/dialogs/elements.dart';
import 'package:butterfly/dialogs/export/general.dart';
import 'package:butterfly/helpers/element.dart';
import 'package:butterfly/helpers/page.dart';
import 'package:butterfly/helpers/point.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly/models/cursor.dart';
import 'package:butterfly/renderers/foregrounds/area.dart';
import 'package:butterfly/renderers/foregrounds/select.dart';
import 'package:butterfly/services/export.dart';
import 'package:butterfly/views/toolbar/eraser.dart';
import 'package:butterfly/visualizer/tool.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image/image.dart' as img;
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_leap/material_leap.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../actions/paste.dart';
import '../actions/select.dart';
import '../api/save.dart';
import '../cubits/current_index.dart';
import '../dialogs/import/camera.dart';
import '../dialogs/name.dart';
import '../models/label.dart';
import '../models/viewport.dart';
import '../renderers/cursors/eraser.dart';
import '../renderers/cursors/label.dart';
import '../renderers/renderer.dart';
import '../services/asset.dart';
import '../services/import.dart';
import '../views/toolbar/color.dart';
import '../views/toolbar/components.dart';
import '../views/toolbar/label.dart';
import '../views/toolbar/presentation/toolbar.dart';
import '../widgets/context_menu.dart';
import 'package:one_dollar_unistroke_recognizer/one_dollar_unistroke_recognizer.dart';
part 'area.dart';
part 'asset.dart';
part 'eraser.dart';
part 'export.dart';
part 'full_screen.dart';
part 'hand.dart';
part 'import.dart';
part 'label.dart';
part 'laser.dart';
part 'layer.dart';
part 'path_eraser.dart';
part 'pen.dart';
part 'eye_dropper.dart';
part 'presentation.dart';
part 'redo.dart';
part 'select.dart';
part 'shape.dart';
part 'spacer.dart';
part 'stamp.dart';
part 'texture.dart';
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

  Future<void> refresh() => getDocumentBloc().refresh();

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
  ExportService getExportService() => buildContext.read<ExportService>();

  ClipboardManager getClipboardManager() =>
      buildContext.read<ClipboardManager>();

  CameraViewport getCameraViewport() => getCurrentIndex().cameraViewport;

  NoteData? getData() => getState()?.data;

  DocumentPage? getPage() => getState()?.page;
  DocumentInfo? getInfo() => getState()?.info;
}

enum ToolStatus { normal, disabled }

abstract class Handler<T> {
  final T data;

  const Handler(this.data);

  bool onSelected(BuildContext context) => true;

  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
          NoteData document, DocumentPage page, DocumentInfo info,
          [Area? currentArea]) =>
      [];

  bool get setupForegrounds => true;

  bool onRendererUpdated(
          DocumentPage page, Renderer old, List<Renderer> updated) =>
      false;

  bool onRenderersCreated(DocumentPage page, List<Renderer> renderers) => false;

  void onPointerDown(PointerDownEvent event, EventContext context) {}

  void onPointerMove(PointerMoveEvent event, EventContext context) {}

  void onPointerUp(PointerUpEvent event, EventContext context) {}

  void onPointerHover(PointerHoverEvent event, EventContext context) {}

  void onTapUp(TapUpDetails details, EventContext context) {}

  void onTapDown(TapDownDetails details, EventContext context) {}

  void onSecondaryTapUp(TapUpDetails details, EventContext context) {}

  void onSecondaryTapDown(TapDownDetails details, EventContext context) {}

  void onLongPressEnd(LongPressEndDetails details, EventContext context) {}

  bool onScaleStart(ScaleStartDetails details, EventContext context) => true;

  void onScaleStartAbort(ScaleStartDetails details, EventContext context) {}

  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {}

  void onScaleEnd(ScaleEndDetails details, EventContext context) {}

  void onDoubleTapDown(TapDownDetails details, EventContext context) {}

  void onDoubleTap(EventContext context) {}

  void onLongPressStart(
      LongPressStartDetails details, EventContext eventContext) {}

  void onLongPressDown(LongPressDownDetails details, EventContext context) {}

  bool canChange(PointerDownEvent event, EventContext context) => true;

  void resetInput(DocumentBloc bloc) {}

  ToolStatus getStatus(DocumentBloc bloc) => ToolStatus.normal;

  PhosphorIconData? getIcon(DocumentBloc bloc) => null;

  static Handler fromDocument(DocumentInfo info, int index) {
    final tool = info.tools[index];
    return Handler.fromTool(tool);
  }

  static Handler fromTool(Tool tool) {
    return switch (tool) {
      HandTool e => HandHandler(e) as Handler,
      SelectTool e => SelectHandler(e),
      ImportTool e => ImportHandler(e),
      UndoTool e => UndoHandler(e),
      RedoTool e => RedoHandler(e),
      LabelTool e => LabelHandler(e),
      PenTool e => PenHandler(e),
      EraserTool e => EraserHandler(e),
      PathEraserTool e => PathEraserHandler(e),
      LayerTool e => LayerHandler(e),
      AreaTool e => AreaHandler(e),
      LaserTool e => LaserHandler(e),
      ShapeTool e => ShapeHandler(e),
      StampTool e => StampHandler(e),
      PresentationTool e => PresentationHandler(e),
      SpacerTool e => SpacerHandler(e),
      FullScreenTool e => FullScreenHandler(e),
      TextureTool e => TextureHandler(e),
      AssetTool e => AssetHandler(e),
      EyeDropperTool e => EyeDropperHandler(e),
      ExportTool e => ExportHandler(e),
    };
  }

  PreferredSizeWidget? getToolbar(DocumentBloc bloc) => null;

  Map<String, RendererState> get rendererStates => const {};

  void dispose(DocumentBloc bloc) {}

  @mustCallSuper
  Map<Type, Action<Intent>> getActions(BuildContext context) => {
        PasteTextIntent: CallbackAction<PasteTextIntent>(
            onInvoke: (intent) =>
                Actions.maybeInvoke(context, PasteIntent(context))),
        SelectAllTextIntent: CallbackAction<SelectAllTextIntent>(
            onInvoke: (intent) =>
                Actions.maybeInvoke(context, SelectAllIntent(context))),
      };

  MouseCursor? get cursor => null;
}

extension ToolHandler<T extends Tool> on Handler<T> {
  void changeTool(DocumentBloc bloc, T newTool) {
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final index = state.info.tools.indexOf(data);
    bloc.add(ToolsChanged({index: newTool}));
  }
}

mixin ColoredHandler<T extends Tool> on Handler<T> {
  int getColor();
  T setColor(int color);

  @override
  PreferredSizeWidget getToolbar(DocumentBloc bloc) => ColorToolbarView(
        color: getColor(),
        onChanged: (value) => changeToolColor(bloc, value),
        onEyeDropper: (context) {
          final state = bloc.state;
          state.currentIndexCubit?.changeTemporaryHandler(
            context,
            EyeDropperTool(),
            bloc: bloc,
            temporaryClicked: true,
          );
        },
      );

  void changeToolColor(DocumentBloc bloc, int value) =>
      changeTool(bloc, setColor(value));
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

abstract class PastingHandler<T> extends Handler<T> {
  Offset? _firstPos;
  Offset? _secondPos;
  bool _aspectRatio = false, _center = false;
  String _currentCollection = '';

  PastingHandler(super.data);

  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
          NoteData document, DocumentPage page, DocumentInfo info,
          [Area? currentArea]) =>
      [
        if (_firstPos != null && _secondPos != null)
          ...getTransformed().map((e) => Renderer.fromInstance(e)),
      ];

  List<PadElement> transformElements(Rect rect, String collection);

  bool get shouldNormalize => true;

  List<PadElement> getTransformed() {
    final first = _firstPos;
    final second = _secondPos;
    if (first == null || second == null) return [];
    double top, left, bottom, right;
    if (shouldNormalize) {
      top = min(first.dy, second.dy);
      left = min(first.dx, second.dx);
      bottom = max(first.dy, second.dy);
      right = max(first.dx, second.dx);
    } else {
      top = first.dy;
      left = first.dx;
      bottom = second.dy;
      right = second.dx;
    }
    var width = (right - left).abs();
    var height = (bottom - top).abs();
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
    return transformElements(rect, _currentCollection);
  }

  void _updateElement(PointerEvent event, EventContext context,
      [bool first = false]) {
    final transform = context.getCameraTransform();
    final globalPos = transform.localToGlobal(event.localPosition);
    if (!context.getDocumentBloc().isInBounds(globalPos)) return;
    if (first) _firstPos = transform.localToGlobal(event.localPosition);
    if (!first && _firstPos == null) return;
    _secondPos = globalPos;
    _aspectRatio = context.isCtrlPressed;
    _center = context.isShiftPressed;
    _currentCollection = context.getState()?.currentCollection ?? '';

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

  @override
  void onScaleStartAbort(ScaleStartDetails details, EventContext context) {
    _firstPos = null;
    _secondPos = null;
    context.refresh();
  }

  double get constraintedAspectRatio => 0;
  double get constraintedWidth => 0;
  double get constraintedHeight => 0;

  bool get currentlyPasting => _firstPos != null && _secondPos != null;
}
