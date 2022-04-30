import 'dart:convert';

import 'package:butterfly/bloc/document_bloc.dart';

import '../models/document.dart';
import 'action.dart';

class EmbedHandler {
  EmbedHandler();
  EventListener? getDataListener,
      setDataListener,
      renderListener,
      renderSVGListener;

  void register(DocumentBloc bloc) {
    getDataListener ??= onEmbedMessage('getData', (message) async {
      final state = bloc.state;
      if (state is DocumentLoadSuccess) {
        sendEmbedMessage('getData', state.document.toJson());
      }
    });
    setDataListener ??= onEmbedMessage('setData', (message) async {
      final state = bloc.state;
      if (state is DocumentLoadSuccess) {
        Map<String, dynamic> map;
        if (message is Map) {
          map = Map<String, dynamic>.from(message);
        } else if (message is String) {
          map = json.decode(message);
        } else {
          throw Exception('Invalid message type');
        }
        final document = AppDocument.fromJson(map);
        bloc.add(DocumentUpdated(document));
      }
    });
    renderListener ??= onEmbedMessage('render', (message) async {
      final state = bloc.state;
      if (state is DocumentLoadSuccess) {
        double x = 0, y = 0, scale = 1;
        int width = 100, height = 100;
        if (message is Map) {
          x = message['x'] ?? 0;
          y = message['y'] ?? 0;
          width = message['width'] ?? 100;
          height = message['height'] ?? 100;
          scale = message['scale'] ?? 1;
        } else if (message is String) {
          final map = json.decode(message);
          x = map['x'] ?? 0;
          y = map['y'] ?? 0;
          width = map['width'] ?? 100;
          height = map['height'] ?? 100;
          scale = map['scale'] ?? 1;
        }
        sendEmbedMessage('render', state.render(width, height, x, y, scale));
      }
    });
    renderSVGListener ??= onEmbedMessage('renderSVG', (message) async {
      final state = bloc.state;
      if (state is DocumentLoadSuccess) {
        double x = 0, y = 0;
        int width = 100, height = 100;
        if (message is Map) {
          x = message['x'] ?? 0;
          y = message['y'] ?? 0;
          width = message['width'] ?? 100;
          height = message['height'] ?? 100;
        } else if (message is String) {
          final map = json.decode(message);
          x = map['x'] ?? 0;
          y = map['y'] ?? 0;
          width = map['width'] ?? 100;
          height = map['height'] ?? 100;
        }
        sendEmbedMessage('renderSVG', state.renderSVG(width, height, x, y));
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
  }
}
