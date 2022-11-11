import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/move.dart';
import 'package:butterfly/helpers/xml_helper.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/export.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:xml/xml.dart';

import '../embed/embedding.dart';
import '../handlers/handler.dart';
import '../models/area.dart';
import '../models/background.dart';
import '../models/element.dart';
import '../models/painter.dart';
import '../models/viewport.dart';
import '../selections/selection.dart';
import '../view_painter.dart';

part 'current_index.freezed.dart';

@freezed
class CurrentIndex with _$CurrentIndex {
  const CurrentIndex._();
  const factory CurrentIndex(
    int? index,
    Handler handler,
    SettingsCubit settingsCubit,
    TransformCubit transformCubit, {
    Handler? temporaryHandler,
    @Default([]) List<Renderer> foregrounds,
    Selection? selection,
    List<Renderer>? temporaryForegrounds,
    @Default([]) List<int> pointers,
    int? buttons,
    @Default(CameraViewport.unbaked()) CameraViewport cameraViewport,
    @Default(AssetLocation(path: '')) AssetLocation location,
    Embedding? embedding,
    @Default(false) bool saved,
  }) = _CurrentIndex;

  bool get moveEnabled =>
      settingsCubit.state.inputGestures && pointers.length > 1;
}

class CurrentIndexCubit extends Cubit<CurrentIndex> {
  CurrentIndexCubit(SettingsCubit settingsCubit, TransformCubit transformCubit,
      Embedding? embedding)
      : super(CurrentIndex(null, MoveHandler(), settingsCubit, transformCubit,
            embedding: embedding));

  Handler getHandler({bool disableTemporary = false}) {
    if (disableTemporary) {
      return state.handler;
    } else {
      return state.temporaryHandler ?? state.handler;
    }
  }

  Handler? changePainter(DocumentBloc bloc, int index,
      [Handler? handler, bool justAdded = false]) {
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return null;
    final document = blocState.document;
    if (index < 0 || index >= document.painters.length) {
      return null;
    }
    final painter = document.painters[index];
    final currentHandler = handler ?? Handler.fromPainter(painter);
    if (currentHandler.onSelected(bloc, this, justAdded)) {
      emit(state.copyWith(
        index: index,
        handler: currentHandler,
        foregrounds: currentHandler.createForegrounds(
            this, document, blocState.currentArea),
        temporaryForegrounds: null,
        temporaryHandler: null,
      ));
    }
    return handler;
  }

  void updatePainter(AppDocument document, Area? currentArea, Painter painter) {
    final handler = Handler.fromPainter(painter);
    emit(state.copyWith(
      index: state.index,
      handler: handler,
      foregrounds: handler.createForegrounds(this, document, currentArea),
    ));
  }

  void updateTemporaryPainter(
      AppDocument document, Area? currentArea, Painter painter) {
    final handler = Handler.fromPainter(painter);
    emit(state.copyWith(
      temporaryHandler: handler,
      temporaryForegrounds:
          handler.createForegrounds(this, document, currentArea),
    ));
  }

  T? fetchHandler<T extends Handler>({bool disableTemporary = false}) {
    final handler = getHandler(disableTemporary: disableTemporary);
    if (handler is T) return handler;
    return null;
  }

  void refresh(AppDocument document, [Area? currentArea]) {
    if (!isClosed) {
      emit(state.copyWith(
        temporaryForegrounds: state.temporaryHandler
            ?.createForegrounds(this, document, currentArea),
        foregrounds:
            state.handler.createForegrounds(this, document, currentArea),
      ));
    }
  }

  Painter? getPainter(AppDocument document) {
    var index = state.index;
    if (index == null) {
      return null;
    }
    if (document.painters.isEmpty ||
        index < 0 ||
        index >= document.painters.length) {
      return null;
    }
    return document.painters[index];
  }

  T? fetchPainter<T extends Painter>(AppDocument document) {
    final painter = getPainter(document);
    if (painter is T) return painter;
    return null;
  }

  void reset(AppDocument document) {
    emit(state.copyWith(
      index: null,
      handler: MoveHandler(),
      foregrounds: [],
      temporaryHandler: null,
      temporaryForegrounds: null,
    ));
  }

  void changeIndex(int i) {
    emit(state.copyWith(index: i));
  }

  void addPointer(int pointer) {
    emit(state.copyWith(pointers: state.pointers.toList()..add(pointer)));
  }

  void removePointer(int pointer) {
    emit(state.copyWith(pointers: state.pointers.toList()..remove(pointer)));
  }

  Handler? changeTemporaryHandlerIndex(DocumentBloc bloc, int index) {
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return null;
    if (index < 0 || index >= blocState.document.painters.length) {
      return null;
    }
    final painter = blocState.document.painters[index];
    return changeTemporaryHandler(bloc, painter);
  }

  Handler? changeTemporaryHandler(DocumentBloc bloc, Painter painter) {
    final handler = Handler.fromPainter(painter);
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return null;
    final document = blocState.document;
    final currentArea = blocState.currentArea;
    if (handler.onSelected(bloc, this, false)) {
      emit(state.copyWith(
        temporaryHandler: handler,
        temporaryForegrounds:
            handler.createForegrounds(this, document, currentArea),
      ));
    }
    return handler;
  }

  List<Renderer> get foregrounds =>
      state.temporaryForegrounds ?? state.foregrounds;

  void resetTemporaryHandler() {
    if (state.temporaryHandler == null) {
      return;
    }
    emit(state.copyWith(
      temporaryHandler: null,
      temporaryForegrounds: null,
    ));
  }

  List<Renderer<PadElement>> get renderers =>
      List.from(state.cameraViewport.bakedElements)
        ..addAll(state.cameraViewport.unbakedElements);

  Renderer? getRenderer(PadElement element) =>
      renderers.firstWhereOrNull((renderer) => renderer.element == element);

  Future<void> bake(AppDocument document,
      {Size? viewportSize, double? pixelRatio, bool reset = false}) async {
    final cameraViewport = state.cameraViewport;
    final size = viewportSize ?? cameraViewport.toSize();
    final ratio = pixelRatio ?? cameraViewport.pixelRatio;
    if (size.height <= 0 || size.width <= 0) {
      return;
    }
    final transform = state.transformCubit.state;
    final rect = Rect.fromLTWH(-transform.position.dx, -transform.position.dy,
        size.width / transform.size, size.height / transform.size);
    var renderers = cameraViewport.unbakedElements;
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    final last = state.cameraViewport;
    reset = reset ||
        last.width != size.width.ceil() ||
        last.height != size.height.ceil() ||
        last.x != transform.position.dx ||
        last.y != transform.position.dy ||
        last.scale != transform.size;
    if (renderers.isEmpty && !reset) return;
    List<Renderer<PadElement>> visibleElements;
    if (reset) {
      renderers = this.renderers;
      visibleElements = renderers
          .where((renderer) => renderer.rect?.overlaps(rect) ?? true)
          .toList();
    } else {
      visibleElements = List.from(cameraViewport.visibleElements)
        ..addAll(renderers);
    }
    canvas.scale(ratio);

    // Wait one frame
    await Future.delayed(const Duration(milliseconds: 1));

    ViewPainter(
      document,
      transform: state.transformCubit.state,
      cameraViewport: reset
          ? cameraViewport.unbake(
              unbakedElements: visibleElements,
              visibleElements: visibleElements)
          : last,
      renderBackground: false,
      renderBaked: !reset,
    ).paint(canvas, size);

    var picture = recorder.endRecording();

    var newImage = await picture.toImage(
        (size.width * ratio).ceil(), (size.height * ratio).ceil());

    var currentRenderers = state.cameraViewport.unbakedElements;
    if (reset) {
      currentRenderers = this.renderers;
    } else {
      renderers.addAll(state.cameraViewport.bakedElements);
    }
    currentRenderers = currentRenderers
        .whereNot((element) => renderers.contains(element))
        .toList();
    visibleElements.addAll(currentRenderers);
    emit(state.copyWith(
        cameraViewport: cameraViewport.bake(
            height: size.height.ceil(),
            width: size.width.ceil(),
            pixelRatio: ratio,
            scale: state.transformCubit.state.size,
            x: state.transformCubit.state.position.dx,
            y: state.transformCubit.state.position.dy,
            image: newImage,
            bakedElements: renderers,
            unbakedElements: currentRenderers,
            visibleElements: visibleElements)));
  }

  Future<ByteData?> render(AppDocument document,
      {required int width,
      required int height,
      double x = 0,
      double y = 0,
      double scale = 1,
      bool renderBackground = true}) async {
    var recorder = ui.PictureRecorder();
    var canvas = Canvas(recorder);
    var painter = ViewPainter(document,
        renderBackground: renderBackground,
        cameraViewport: state.cameraViewport.withUnbaked(renderers),
        transform: CameraTransform(-Offset(x.toDouble(), y.toDouble()), scale));
    painter.paint(canvas, Size(width.toDouble(), height.toDouble()));
    var picture = recorder.endRecording();
    var image = await picture.toImage(width, height);
    return await image.toByteData(format: ui.ImageByteFormat.png);
  }

  XmlDocument renderSVG(AppDocument document,
      {required int width,
      required int height,
      double x = 0,
      double y = 0,
      bool renderBackground = true}) {
    final xml = XmlDocument();
    final svg = xml.createElement('svg', attributes: {
      'xmlns': 'http://www.w3.org/2000/svg',
      'xmlns:xlink': 'http://www.w3.org/1999/xlink',
      'version': '1.1',
      'width': '${width}px',
      'height': '${height}px',
      'viewBox': '$x $y $width $height',
    });
    svg
        .createElement('defs')
        .createElement('mask', id: 'eraser-mask')
        .createElement('rect', attributes: {
      'x': '${x}px',
      'y': '${y}px',
      'width': '${width}px',
      'height': '${height}px',
      'fill': 'white',
    });

    final rect = Rect.fromLTWH(x, y, width.toDouble(), height.toDouble());
    if (renderBackground) {
      state.cameraViewport.background?.buildSvg(xml, document, rect);
    }
    for (var e in renderers) {
      e.buildSvg(xml, document, rect);
    }
    return xml;
  }

  void unbake(
      {Renderer<Background>? background,
      List<Renderer<PadElement>>? unbakedElements}) {
    emit(state.copyWith(
        cameraViewport: state.cameraViewport
            .unbake(unbakedElements: unbakedElements, background: background)));
  }

  void withUnbaked(List<Renderer<PadElement>> unbakedElements) {
    emit(state.copyWith(
        cameraViewport: state.cameraViewport.withUnbaked(unbakedElements)));
  }

  void setSaveState({AssetLocation? location, bool? saved}) {
    emit(state.copyWith(
        location: location ?? state.location, saved: saved ?? state.saved));
  }

  Future<pw.Document> renderPDF(
    AppDocument appDocument, {
    required List<AreaPreset> areas,
    bool renderBackground = true,
  }) async {
    final document = pw.Document();
    for (final preset in areas) {
      final areaName = preset.name;
      final quality = preset.quality;
      final area = appDocument.getAreaByName(areaName);
      if (area == null) {
        continue;
      }
      final pageFormat = PdfPageFormat(area.width, area.height);
      final width = area.width * quality;
      final height = area.height * quality;
      final scale = quality;
      final image = await render(appDocument,
          width: width.ceil(),
          height: height.ceil(),
          x: area.position.dx,
          y: area.position.dy,
          scale: scale,
          renderBackground: renderBackground);
      if (image == null) continue;
      document.addPage(pw.Page(
          pageFormat: pageFormat,
          build: (context) {
            return pw.Image(pw.MemoryImage(image.buffer.asUint8List()));
          }));
    }
    return document;
  }

  void updateIndex(AppDocument document) {
    final index = document.painters.indexOf(state.handler.data);
    if (index < 0) {
      reset(document);
      return;
    }
    if (index == state.index) {
      return;
    }
    changeIndex(index);
    final selection = state.selection;
    if (selection?.selected.contains(state.handler.data) ?? false) {
      resetSelection();
    }
  }

  void insertSelection(dynamic selected, [bool toggle = true]) {
    final selection = state.selection;
    if (selection == null) {
      emit(state.copyWith(selection: Selection.from(selected)));
      return;
    }
    Selection next;
    if (selection.selected.contains(selected) && toggle) {
      next = selection.remove(selected);
    } else {
      next = selection.insert(selected);
    }
    emit(state.copyWith(selection: next));
  }

  void changeSelection(dynamic selected, [bool toggle = true]) {
    emit(state.copyWith(
        selection:
            (toggle && (state.selection?.selected.contains(selected) ?? false))
                ? null
                : Selection.from(selected)));
  }

  void resetSelection() {
    emit(state.copyWith(selection: null));
  }

  void setButtons(int buttons) {
    emit(state.copyWith(buttons: buttons));
  }

  void removeButtons() {
    emit(state.copyWith(buttons: null));
  }

  void resetInput(DocumentBloc bloc) {
    state.handler.resetInput(bloc);
    emit(state.copyWith(buttons: null, pointers: []));
  }

  void changeTemporaryHandlerMove() {
    emit(state.copyWith(temporaryHandler: MoveHandler()));
  }
}
