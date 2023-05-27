import 'dart:convert';
import 'dart:typed_data';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'action.dart';

class EmbedHandler {
  EmbedHandler();
  EventListener? getDataListener,
      setDataListener,
      renderListener,
      renderSVGListener;

  void register(BuildContext context, DocumentBloc bloc) {
    getDataListener ??= onEmbedMessage('getData', (message) async {
      final state = bloc.state;
      if (state is DocumentLoadSuccess) {
        sendEmbedMessage('getData', state.saveData().save());
      }
    });
    setDataListener ??= onEmbedMessage('setData', (message) async {
      if (message is! List<int>) return;
      final data = NoteData.fromData(Uint8List.fromList(message));
      GoRouter.of(context).go('/new', extra: data);
    });
    renderListener ??= onEmbedMessage('render', (message) async {
      final state = bloc.state;
      if (state is DocumentLoadSuccess) {
        double x = 0, y = 0, scale = 1;
        double width = 100, height = 100;
        bool renderBackground = true;
        if (message is Map) {
          x = message['x'] ?? 0;
          y = message['y'] ?? 0;
          width = message['width'] ?? 100;
          height = message['height'] ?? 100;
          scale = message['scale'] ?? 1;
          renderBackground = message['renderBackground'] ?? true;
        } else if (message is String) {
          final map = json.decode(message);
          x = map['x'] ?? 0;
          y = map['y'] ?? 0;
          width = map['width'] ?? 100;
          height = map['height'] ?? 100;
          scale = map['scale'] ?? 1;
          renderBackground = map['renderBackground'] ?? true;
        }
        final data = await state.currentIndexCubit.render(
          state.data,
          state.page,
          state.info,
          width: width,
          height: height,
          x: x,
          y: y,
          scale: scale,
          renderBackground: renderBackground,
        );
        sendEmbedMessage(
            'render', base64.encode(data?.buffer.asUint8List() ?? []));
      }
    });
    renderSVGListener ??= onEmbedMessage('renderSVG', (message) async {
      final state = bloc.state;
      if (state is DocumentLoadSuccess) {
        double x = 0, y = 0;
        int width = 100, height = 100;
        bool renderBackground = true;
        if (message is Map) {
          x = message['x'] ?? 0;
          y = message['y'] ?? 0;
          width = message['width'] ?? 100;
          height = message['height'] ?? 100;
          renderBackground = message['renderBackground'] ?? true;
        } else if (message is String) {
          final map = json.decode(message);
          x = map['x'] ?? 0;
          y = map['y'] ?? 0;
          width = map['width'] ?? 100;
          height = map['height'] ?? 100;
          renderBackground = map['renderBackground'] ?? true;
        }
        sendEmbedMessage(
          'renderSVG',
          state.currentIndexCubit
              .renderSVG(
                state.page,
                width: width,
                height: height,
                x: x,
                y: y,
                renderBackground: renderBackground,
              )
              .toXmlString(),
        );
      }
    });
  }

  void unregister() {
    if (getDataListener != null) {
      removeEmbedMessageListener(getDataListener!);
      getDataListener = null;
    }
    if (setDataListener != null) {
      removeEmbedMessageListener(setDataListener!);
      setDataListener = null;
    }
    if (renderListener != null) {
      removeEmbedMessageListener(renderListener!);
      renderListener = null;
    }
    if (renderSVGListener != null) {
      removeEmbedMessageListener(renderSVGListener!);
      renderSVGListener = null;
    }
  }
}
