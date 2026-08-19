import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'action.dart';
import 'embedding.dart';

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

  ExportPadding _mapPadding(Map<String, dynamic> map) {
    final value = map['padding'];
    if (value is! Map) return const ExportPadding();
    final padding = value.cast<String, dynamic>();
    return ExportPadding(
      top: _mapDouble(padding, 'top', 0),
      right: _mapDouble(padding, 'right', 0),
      bottom: _mapDouble(padding, 'bottom', 0),
      left: _mapDouble(padding, 'left', 0),
    );
  }

  Size _renderViewportSize(BuildContext context, EditorController controller) {
    final measured = controller.rendererCubit.state.cameraViewport.viewportSize;
    if (measured != null && measured.width > 0 && measured.height > 0) {
      return measured;
    }
    return MediaQuery.sizeOf(context);
  }

  Uint8List? _messageToBytes(Object? message) {
    if (message is Uint8List) return message;
    if (message is ByteBuffer) return message.asUint8List();
    if (message is ByteData) {
      return message.buffer.asUint8List(
        message.offsetInBytes,
        message.lengthInBytes,
      );
    }
    if (message is List) {
      try {
        return Uint8List.fromList(
          message.cast<num>().map((e) => e.toInt()).toList(),
        );
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  bool _isValidDocumentData(Uint8List bytes) {
    try {
      return NoteData.fromData(bytes).isValid;
    } catch (_) {
      return false;
    }
  }

  Uri _buildEmbedUri(Embedding embedding) => Uri(
    path: '/embed',
    queryParameters: {
      if (!embedding.save) 'save': 'false',
      if (!embedding.editable) 'editable': 'false',
      if (embedding.language.isNotEmpty) 'language': embedding.language,
      if (embedding.theme.isNotEmpty) 'theme': embedding.theme,
      if (embedding.fileName.isNotEmpty) 'fileName': embedding.fileName,
    },
  );

  void register(BuildContext context, DocumentBloc bloc) {
    _blocSubscription ??= bloc.stream.listen((state) {
      if (state is DocumentLoadSuccess &&
          bloc.editorController.saveCubit.state.saved == SaveState.unsaved) {
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
      final bytes = _messageToBytes(message);
      if (bytes == null) return;
      if (!_isValidDocumentData(bytes)) {
        sendEmbedMessage('error', {
          'method': 'setData',
          'message': 'Invalid Butterfly document data',
        });
        return;
      }
      final embedding = bloc.editorController.saveCubit.state.embedding;
      if (embedding == null) return;
      GoRouter.of(context)
          .go(_buildEmbedUri(embedding).toString(), extra: bytes);
    });
    renderListener ??= onEmbedMessage('render', (message) async {
      final state = bloc.state;
      if (state is DocumentLoadSuccess) {
        final controller = bloc.editorController;
        final transform = controller.transformCubit.state;
        final viewportSize = _renderViewportSize(context, controller);
        double x = transform.position.dx, y = transform.position.dy;
        double scale = transform.size, rotation = transform.rotation;
        ExportPadding padding = const ExportPadding();
        double width = viewportSize.width, height = viewportSize.height;
        bool renderBackground = true;
        final map = _messageToMap(message);
        if (map != null) {
          x = _mapDouble(map, 'x', x);
          y = _mapDouble(map, 'y', y);
          width = _mapDouble(map, 'width', width);
          height = _mapDouble(map, 'height', height);
          scale = _mapDouble(map, 'scale', scale);
          rotation = _mapDouble(map, 'rotation', rotation);
          padding = _mapPadding(map);
          renderBackground = _mapBool(map, 'renderBackground', true);
        }
        try {
          final data = await controller.rendererCubit.render(
            controller,
            state.data,
            state.page,
            state.info,
            ImageExportOptions(
              width: width,
              height: height,
              x: x,
              y: y,
              scale: scale,
              rotation: rotation,
              padding: padding,
              renderBackground: renderBackground,
            ),
            invisibleLayers: state.invisibleLayers,
            docState: state,
          );
          if (data == null) {
            sendEmbedMessage('error', {
              'method': 'render',
              'message': 'Could not render the PNG image.',
            });
            return;
          }
          final bytes = data.buffer.asUint8List(
            data.offsetInBytes,
            data.lengthInBytes,
          );
          sendEmbedMessage('render', base64.encode(bytes));
        } catch (error) {
          sendEmbedMessage('error', {
            'method': 'render',
            'message': error.toString(),
          });
        }
      }
    });
    renderSVGListener ??= onEmbedMessage('renderSVG', (message) async {
      final state = bloc.state;
      if (state is DocumentLoadSuccess) {
        final controller = bloc.editorController;
        final transform = controller.transformCubit.state;
        final viewportSize = _renderViewportSize(context, controller);
        double x = transform.position.dx, y = transform.position.dy;
        double scale = transform.size, rotation = transform.rotation;
        ExportPadding padding = const ExportPadding();
        double width = viewportSize.width, height = viewportSize.height;
        bool renderBackground = true;
        final map = _messageToMap(message);
        if (map != null) {
          x = _mapDouble(map, 'x', x);
          y = _mapDouble(map, 'y', y);
          width = _mapDouble(map, 'width', width);
          height = _mapDouble(map, 'height', height);
          scale = _mapDouble(map, 'scale', scale);
          rotation = _mapDouble(map, 'rotation', rotation);
          padding = _mapPadding(map);
          renderBackground = _mapBool(map, 'renderBackground', true);
        }
        sendEmbedMessage(
          'renderSVG',
          controller.rendererCubit
              .renderSVG(
                state.data,
                state.page,
                SvgExportOptions(
                  width: width,
                  height: height,
                  x: x,
                  y: y,
                  scale: scale,
                  rotation: rotation,
                  padding: padding,
                  renderBackground: renderBackground,
                ),
                invisibleLayers: state.invisibleLayers,
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
