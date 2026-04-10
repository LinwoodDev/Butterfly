import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
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
  StreamSubscription? _blocSubscription;
  Timer? _changeDebounceTimer;

  Map<String, dynamic>? _messageToMap(Object? message) {
    if (message is Map<String, dynamic>) return message;
    if (message is Map) return message.cast<String, dynamic>();
    if (message is String) {
      try {
        final decoded = json.decode(message);
        if (decoded is Map<String, dynamic>) return decoded;
        if (decoded is Map) return decoded.cast<String, dynamic>();
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  double _mapDouble(Map<String, dynamic> map, String key, double fallback) =>
      (map[key] as num?)?.toDouble() ?? fallback;

  bool _mapBool(Map<String, dynamic> map, String key, bool fallback) =>
      map[key] is bool ? map[key] as bool : fallback;

  void register(BuildContext context, DocumentBloc bloc) {
    _blocSubscription ??= bloc.stream.listen((state) {
      if (state is DocumentLoadSuccess && state.saved == SaveState.unsaved) {
        _changeDebounceTimer?.cancel();
        _changeDebounceTimer = Timer(
          const Duration(milliseconds: 500),
          () async {
            final currentState = bloc.state;
            if (currentState is DocumentLoadSuccess) {
              sendEmbedMessage(
                'change',
                (await currentState.saveData()).exportAsBytes(),
              );
            }
          },
        );
      }
    });

    getDataListener ??= onEmbedMessage('getData', (message) async {
      final state = bloc.state;
      if (state is DocumentLoadSuccess) {
        sendEmbedMessage('getData', (await state.saveData()).exportAsBytes());
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
        final map = _messageToMap(message);
        if (map != null) {
          x = _mapDouble(map, 'x', 0);
          y = _mapDouble(map, 'y', 0);
          width = _mapDouble(map, 'width', 100);
          height = _mapDouble(map, 'height', 100);
          scale = _mapDouble(map, 'scale', 1);
          renderBackground = _mapBool(map, 'renderBackground', true);
        }
        final data = await state.currentIndexCubit.render(
          state.data,
          state.page,
          state.info,
          ImageExportOptions(
            width: width,
            height: height,
            x: x,
            y: y,
            scale: scale,
            renderBackground: renderBackground,
          ),
          docState: state,
        );
        sendEmbedMessage(
          'render',
          base64.encode(data?.buffer.asUint8List() ?? []),
        );
      }
    });
    renderSVGListener ??= onEmbedMessage('renderSVG', (message) async {
      final state = bloc.state;
      if (state is DocumentLoadSuccess) {
        double x = 0, y = 0;
        double width = 100, height = 100;
        bool renderBackground = true;
        final map = _messageToMap(message);
        if (map != null) {
          x = _mapDouble(map, 'x', 0);
          y = _mapDouble(map, 'y', 0);
          width = _mapDouble(map, 'width', 100);
          height = _mapDouble(map, 'height', 100);
          renderBackground = _mapBool(map, 'renderBackground', true);
        }
        sendEmbedMessage(
          'renderSVG',
          state.currentIndexCubit
              .renderSVG(
                state.data,
                state.page,
                SvgExportOptions(
                  width: width,
                  height: height,
                  x: x,
                  y: y,
                  renderBackground: renderBackground,
                ),
              )
              .toXmlString(),
        );
      }
    });
  }

  void unregister() {
    _blocSubscription?.cancel();
    _blocSubscription = null;
    _changeDebounceTimer?.cancel();
    _changeDebounceTimer = null;
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
