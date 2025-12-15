import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/area/context.dart';
import 'package:butterfly/dialogs/collections.dart';
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
import 'package:butterfly/views/toolbar/polygon.dart';
import 'package:butterfly/visualizer/tool.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:image/image.dart' as img;
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_leap/material_leap.dart';
import 'package:barcode/barcode.dart' hide BarcodeType;

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../actions/paste.dart';
import '../actions/select.dart';
import '../api/save.dart';
import '../cubits/current_index.dart';
import '../dialogs/import/camera.dart';
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

part 'mixins.dart';

part 'area.dart';
part 'asset.dart';
part 'barcode.dart';
part 'eraser.dart';
part 'export.dart';
part 'full_screen.dart';
part 'hand.dart';
part 'import.dart';
part 'label.dart';
part 'laser.dart';
part 'collection.dart';
part 'path_eraser.dart';
part 'pen.dart';
part 'eye_dropper.dart';
part 'presentation.dart';
part 'redo.dart';
part 'ruler.dart';
part 'grid.dart';
part 'polygon.dart';
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

  const EventContext(
    this.buildContext,
    this.viewportSize,
    this.isShiftPressed,
    this.isAltPressed,
    this.isCtrlPressed,
  );

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
  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(buildContext);

  TransformCubit getTransformCubit() =>
      BlocProvider.of<TransformCubit>(buildContext);

  CameraTransform getCameraTransform() => getTransformCubit().state;

  CurrentIndexCubit getCurrentIndexCubit() =>
      BlocProvider.of<CurrentIndexCubit>(buildContext);

  CurrentIndex getCurrentIndex() => getCurrentIndexCubit().state;

  Future<void> refresh({bool allowBake = true}) =>
      getDocumentBloc().refresh(allowBake: allowBake);

  SettingsCubit getSettingsCubit() =>
      BlocProvider.of<SettingsCubit>(buildContext);
  ButterflySettings getSettings() => getSettingsCubit().state;

  Future<void> bake({
    Size? viewportSize,
    double? pixelRatio,
    bool reset = false,
  }) => getDocumentBloc().bake(
    pixelRatio: pixelRatio,
    viewportSize: viewportSize,
    reset: reset,
  );

  Future<void> delayedBake({
    Size? viewportSize,
    double? pixelRatio,
    bool reset = false,
    bool testTransform = false,
  }) => getDocumentBloc().delayedBake(
    pixelRatio: pixelRatio,
    viewportSize: viewportSize,
    reset: reset,
    testTransform: testTransform,
  );

  List<BlocProvider> getProviders() => [
    BlocProvider<DocumentBloc>.value(value: getDocumentBloc()),
    BlocProvider<TransformCubit>.value(value: getTransformCubit()),
    BlocProvider<CurrentIndexCubit>.value(value: getCurrentIndexCubit()),
    BlocProvider<SettingsCubit>.value(value: getSettingsCubit()),
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

  ButterflyFileSystem getFileSystem() =>
      buildContext.read<ButterflyFileSystem>();
}

enum ToolStatus { normal, disabled, selected }

enum SelectState { normal, none, toggle }

abstract class Handler<T> {
  final T data;

  const Handler(this.data);

  FutureOr<SelectState> onSelected(
    BuildContext context, [
    bool wasAdded = true,
  ]) => SelectState.normal;

  List<Renderer> createForegrounds(
    CurrentIndexCubit currentIndexCubit,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) => [];

  bool get setupForegrounds => true;

  bool onRendererUpdated(
    DocumentPage page,
    Renderer old,
    List<Renderer> updated,
  ) => false;

  bool onRenderersCreated(DocumentPage page, List<Renderer> renderers) => false;

  void onPointerDown(PointerDownEvent event, EventContext context) {}

  void onPointerMove(PointerMoveEvent event, EventContext context) {}

  FutureOr<void> onPointerUp(PointerUpEvent event, EventContext context) {}

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
    LongPressStartDetails details,
    EventContext eventContext,
  ) {}

  void onViewportUpdated(
    CameraViewport currentViewport,
    CameraViewport newViewport,
  ) {}

  void onLongPressDown(LongPressDownDetails details, EventContext context) {}

  bool canChange(PointerDownEvent event, EventContext context) => true;

  FutureOr<void> resetInput(DocumentBloc bloc) {}

  ToolStatus getStatus(DocumentBloc bloc) => ToolStatus.normal;

  PhosphorIconData? getIcon(DocumentBloc bloc) => null;

  static Handler fromDocument(DocumentInfo info, int index) {
    final tool = info.tools[index];
    return Handler.fromTool(tool);
  }

  static Handler<T> fromTool<T extends Tool>(T tool) {
    return switch (tool) {
          HandTool() => HandHandler(tool),
          SelectTool() => SelectHandler(tool),
          ImportTool() => ImportHandler(tool),
          UndoTool() => UndoHandler(tool),
          RedoTool() => RedoHandler(tool),
          LabelTool() => LabelHandler(tool),
          PenTool() => PenHandler(tool),
          EraserTool() => EraserHandler(tool),
          PathEraserTool() => PathEraserHandler(tool),
          CollectionTool() => CollectionHandler(tool),
          AreaTool() => AreaHandler(tool),
          LaserTool() => LaserHandler(tool),
          ShapeTool() => ShapeHandler(tool),
          StampTool() => StampHandler(tool),
          PresentationTool() => PresentationHandler(tool),
          SpacerTool() => SpacerHandler(tool),
          FullScreenTool() => FullScreenHandler(tool),
          TextureTool() => TextureHandler(tool),
          AssetTool() => AssetHandler(tool),
          EyeDropperTool() => EyeDropperHandler(tool),
          ExportTool() => ExportHandler(tool),
          GridTool() => GridHandler(tool),
          RulerTool() => RulerHandler(tool),
          BarcodeTool() => BarcodeHandler(tool),
          PolygonTool() => PolygonHandler(tool),
        }
        as Handler<T>;
  }

  FutureOr<PreferredSizeWidget?> getToolbar(DocumentBloc bloc) => null;

  Map<String, RendererState> get rendererStates => const {};

  void dispose(DocumentBloc bloc) {}

  @mustCallSuper
  Map<Type, Action<Intent>> getActions(BuildContext context) => {
    PasteTextIntent: CallbackAction<PasteTextIntent>(
      onInvoke: (intent) => Actions.maybeInvoke(context, PasteIntent(context)),
    ),
    SelectAllTextIntent: CallbackAction<SelectAllTextIntent>(
      onInvoke: (intent) =>
          Actions.maybeInvoke(context, SelectAllIntent(context)),
    ),
  };

  MouseCursor? get cursor => null;
}

double getPressureOfEvent(PointerEvent event) {
  var range = event.pressureMax - event.pressureMin;
  if (range <= 0) range = 1;
  final pressure = event.kind == PointerDeviceKind.stylus
      ? (event.pressure - event.pressureMin) / range
      : 0.5;
  if (pressure.isNaN || pressure <= 0) return 0.5;
  return pressure;
}

extension ToolHandler<T extends Tool> on Handler<T> {
  void changeTool(DocumentBloc bloc, T newTool) {
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final index = state.info.tools.indexOf(data);
    bloc.add(ToolsChanged({index: newTool}));
  }
}
