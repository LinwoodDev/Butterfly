import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:butterfly/api/xml_helper.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';

import '../handlers/handler.dart';
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
    Handler? handler,
    DocumentBloc bloc,
    SettingsCubit settingsCubit,
    TransformCubit transformCubit, {
    @Default([]) List<Renderer> foregrounds,
    @Default([]) List<Rect> selections,
    @Default([]) List<int> pointers,
    @Default([]) CameraViewport cameraViewport,
  }) = _CurrentIndex;

  bool get moveEnabled =>
      settingsCubit.state.inputGestures && pointers.length > 1;
}

class CurrentIndexCubit extends Cubit<CurrentIndex> {
  CurrentIndexCubit(DocumentBloc bloc, SettingsCubit settingsCubit,
      TransformCubit transformCubit)
      : super(CurrentIndex(-1, null, bloc, settingsCubit, transformCubit)) {
    reset();
  }

  Handler getHandler() {
    var current = state.handler;
    if (current == null) {
      current = HandHandler(this);
      emit(state.copyWith(index: -1, handler: current));
      return current;
    }
    return current;
  }

  void changeHandler(int index, Handler handler) =>
      emit(state.copyWith(index: index, handler: handler));
  Handler? changePainter(int index) {
    final blocState = state.bloc.state;
    if (blocState is! DocumentLoadSuccess) return null;
    final document = blocState.document;
    final currentArea = blocState.currentArea;
    final handler = Handler.fromBloc(this, state.bloc, index);
    emit(state.copyWith(
        index: index,
        handler: handler,
        foregrounds: handler.createForegrounds(document, currentArea),
        selections: handler.createSelections(document, currentArea)));
    return handler;
  }

  T? fetchHandler<T extends Handler>() {
    final handler = getHandler();
    if (handler is T) return handler;
    return null;
  }

  void refresh() {
    final blocState = state.bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    final document = blocState.document;
    final handler = state.handler;
    final currentArea = blocState.currentArea;
    if (!isClosed) {
      emit(state.copyWith(
          foregrounds: handler?.createForegrounds(document, currentArea) ?? [],
          selections: handler?.createSelections(document, currentArea) ?? []));
    }
  }

  Painter? getPainter() {
    final blocState = state.bloc.state;
    if (blocState is! DocumentLoadSuccess) return null;
    final document = blocState.document;
    var index = state.index;
    if (document.painters.isEmpty ||
        index < 0 ||
        index >= document.painters.length) {
      return null;
    }
    return document.painters[index];
  }

  T? fetchPainter<T extends Painter>() {
    final painter = getPainter();
    if (painter is T) return painter;
    return null;
  }

  void reset() {
    emit(state.copyWith(index: -1, handler: HandHandler(this)));
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

  List<Renderer<PadElement>> get renderers =>
      List.from(state.cameraViewport.bakedElements)
        ..addAll(state.cameraViewport.unbakedElements);

  Renderer? getRenderer(PadElement element) =>
      renderers.firstWhereOrNull((renderer) => renderer.element == element);

  Future<void> bake(AppDocument document,
      {Size? viewportSize, double? pixelRatio}) async {
    var current = state;
    if (current is! DocumentLoadSuccess) return;
    final size = viewportSize ?? current.cameraViewport.toSize();
    final ratio = pixelRatio ?? current.cameraViewport.pixelRatio;
    if (size.height <= 0 || size.width <= 0) {
      return;
    }

    var renderers = current.cameraViewport.unbakedElements;
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    var last = current.cameraViewport;
    final reset = last.width != size.width.ceil() ||
        last.height != size.height.ceil() ||
        last.x != state.transformCubit.state.position.dx ||
        last.y != state.transformCubit.state.position.dy ||
        last.scale != state.transformCubit.state.size;
    if (renderers.isEmpty && !reset) return;
    if (reset) {
      renderers = renderers;
    }
    canvas.scale(ratio);

    // Wait one frame
    await Future.delayed(const Duration(milliseconds: 1));

    ViewPainter(
      document,
      transform: state.transformCubit.state,
      cameraViewport: reset ? current.cameraViewport.unbake(renderers) : last,
      renderBackground: false,
      renderBaked: !reset,
    ).paint(canvas, size);

    var picture = recorder.endRecording();

    var newImage = await picture.toImage(
        (size.width * ratio).ceil(), (size.height * ratio).ceil());

    var currentRenderers = current.cameraViewport.unbakedElements;
    if (reset) {
      currentRenderers = renderers;
    } else {
      renderers.addAll(current.cameraViewport.bakedElements);
    }
    currentRenderers = currentRenderers
        .whereNot((element) => renderers.contains(element))
        .toList();
    emit(current.copyWith(
        cameraViewport: current.cameraViewport.bake(
            height: size.height.ceil(),
            width: size.width.ceil(),
            pixelRatio: ratio,
            scale: state.transformCubit.state.size,
            x: state.transformCubit.state.position.dx,
            y: state.transformCubit.state.position.dy,
            image: newImage,
            bakedElements: renderers,
            unbakedElements: currentRenderers)));
  }

  Future<ByteData?> render(
      {required int width,
      required int height,
      double x = 0,
      double y = 0,
      double scale = 1,
      bool renderBackground = true}) async {
    var recorder = ui.PictureRecorder();
    var canvas = Canvas(recorder);
    final blocState = state.bloc.state;
    if (blocState is! DocumentLoadSuccess) return null;
    var painter = ViewPainter(blocState.document,
        renderBackground: renderBackground,
        cameraViewport: state.cameraViewport.withUnbaked(renderers),
        transform: CameraTransform(-Offset(x.toDouble(), y.toDouble()), scale));
    painter.paint(canvas, Size(width.toDouble(), height.toDouble()));
    var picture = recorder.endRecording();
    var image = await picture.toImage(width, height);
    return await image.toByteData(format: ui.ImageByteFormat.png);
  }

  XmlDocument renderSVG(
      {required int width,
      required int height,
      double x = 0,
      double y = 0,
      bool renderBackground = true}) {
    final document = XmlDocument();
    final blocState = state.bloc.state;
    if (blocState is! DocumentLoadSuccess) return document;
    final svg = document.createElement('svg', attributes: {
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
      state.cameraViewport.background
          ?.buildSvg(document, blocState.document, rect);
    }
    for (var e in renderers) {
      e.buildSvg(document, blocState.document, rect);
    }
    return document;
  }
}
