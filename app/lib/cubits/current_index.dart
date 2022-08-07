import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:butterfly/api/xml_helper.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
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
import '../view_painter.dart';

part 'current_index.freezed.dart';

@freezed
class CurrentIndex with _$CurrentIndex {
  const CurrentIndex._();
  const factory CurrentIndex(
    int index,
    Handler handler,
    SettingsCubit settingsCubit,
    TransformCubit transformCubit, {
    int? temporaryIndex,
    Handler? temporaryHandler,
    @Default([]) List<Renderer> foregrounds,
    @Default([]) List<Rect> selections,
    List<Renderer>? temporaryForegrounds,
    List<Rect>? temporarySelections,
    @Default([]) List<int> pointers,
    @Default(CameraViewport.unbaked()) CameraViewport cameraViewport,
    @Default(AssetLocation(path: '')) AssetLocation location,
    Embedding? embedding,
    @Default(false) bool saved,
  }) = _CurrentIndex;

  bool get moveEnabled =>
      settingsCubit.state.inputGestures && pointers.length > 1;
}

class CurrentIndexCubit extends Cubit<CurrentIndex> {
  CurrentIndexCubit(AppDocument document, SettingsCubit settingsCubit,
      TransformCubit transformCubit, Embedding? embedding)
      : super(CurrentIndex(-1, HandHandler(document.handProperty),
            settingsCubit, transformCubit,
            embedding: embedding));

  Handler getHandler({bool disableTemporary = false}) {
    if (disableTemporary) {
      return state.handler;
    } else {
      return state.temporaryHandler ?? state.handler;
    }
  }

  void changeHandler(int index, Handler handler) =>
      emit(state.copyWith(index: index, handler: handler));
  Handler? changePainter(AppDocument document, Area? currentArea, int index) {
    final painter = document.painters[index];
    final handler = Handler.fromPainter(painter);
    emit(state.copyWith(
        index: index,
        handler: handler,
        foregrounds: handler.createForegrounds(document, currentArea),
        selections: handler.createSelections(document, currentArea)));
    return handler;
  }

  void updatePainter(AppDocument document, Area? currentArea, Painter painter) {
    final handler = Handler.fromPainter(painter);
    emit(state.copyWith(
        index: state.index,
        handler: handler,
        foregrounds: handler.createForegrounds(document, currentArea),
        selections: handler.createSelections(document, currentArea)));
  }

  T? fetchHandler<T extends Handler>({bool disableTemporary = false}) {
    final handler = getHandler(disableTemporary: disableTemporary);
    if (handler is T) return handler;
    return null;
  }

  void refresh(AppDocument document, [Area? currentArea]) {
    final handler = state.handler;
    if (!isClosed) {
      emit(state.copyWith(
          foregrounds: handler.createForegrounds(document, currentArea),
          selections: handler.createSelections(document, currentArea)));
    }
  }

  Painter? getPainter(AppDocument document) {
    var index = state.index;
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
      index: -1,
      handler: HandHandler(document.handProperty),
      foregrounds: [],
      selections: [],
      temporaryIndex: null,
      temporaryHandler: null,
      temporaryForegrounds: null,
      temporarySelections: null,
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

  Handler? changeTemporaryHandler(
      AppDocument document, Area? currentArea, int index) {
    final painter = document.painters[index];
    final handler = Handler.fromPainter(painter);
    emit(state.copyWith(
        temporaryIndex: index,
        temporaryHandler: handler,
        foregrounds: handler.createForegrounds(document, currentArea),
        selections: handler.createSelections(document, currentArea)));
    return handler;
  }

  Handler? changeTemporaryHandlerHand(AppDocument document, Area? currentArea) {
    final handler = HandHandler(document.handProperty);
    emit(state.copyWith(
        temporaryIndex: -1,
        temporaryHandler: handler,
        foregrounds: handler.createForegrounds(document, currentArea),
        selections: handler.createSelections(document, currentArea)));
    return handler;
  }

  Handler? changeTemporaryHandlerSecondary(
      AppDocument document, Area? currentArea) {
    int index = 1;
    if (document.painters.length == 1) {
      index = 0;
    } else if (document.painters.isEmpty) {
      return null;
    }
    final painter = document.painters[index];
    final handler = Handler.fromPainter(painter);
    emit(state.copyWith(
        temporaryIndex: index,
        temporaryHandler: handler,
        temporaryForegrounds: handler.createForegrounds(document, currentArea),
        temporarySelections: handler.createSelections(document, currentArea)));
    return handler;
  }

  List<Renderer> get foregrounds =>
      state.temporaryForegrounds ?? state.foregrounds;
  List<Rect> get selections => state.temporarySelections ?? state.selections;

  void resetTemporaryHandler(AppDocument document, Area? currentArea) {
    if (state.temporaryIndex == null && state.temporaryHandler == null) {
      return;
    }
    emit(state.copyWith(
      temporaryIndex: null,
      temporaryHandler: null,
      temporaryForegrounds: null,
      temporarySelections: null,
    ));
  }

  int getIndex({bool disableTemporary = false}) {
    if (disableTemporary) {
      return state.index;
    } else {
      return state.temporaryIndex ?? state.index;
    }
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
}
