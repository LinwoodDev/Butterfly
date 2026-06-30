import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:butterfly/api/image.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/embed/embedding.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/helpers/async.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/selections/selection.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/editor_session.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/services/network.dart';
import 'package:butterfly/services/logger.dart';
import 'package:butterfly/helpers/xml.dart';
import 'package:butterfly/view_painter.dart';
import 'package:butterfly/views/navigator/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image/image.dart' as img;
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/helpers.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:synchronized/synchronized.dart';
import 'package:xml/xml.dart';

part 'editor_runtime.freezed.dart';
part 'editor_renderer.dart';
part 'editor_tool.dart';
part 'editor_input.dart';
part 'document_save.dart';
part 'editor_view.dart';

Future<NoteFile> _toFile((NoteData, bool) args) async {
  return args.$1.toFile(isTextBased: args.$2);
}

void _sendNetworkingState(
  EditorController controller, {
  List<Renderer<dynamic>>? foregrounds,
  Offset? cursor,
}) {
  cursor ??= controller.inputCubit.state.lastPosition ?? Offset.zero;
  controller.networkingService.sendUser(
    NetworkingUser(
      cursor: controller.transformCubit.state.localToGlobal(cursor).toPoint(),
      foreground:
          (foregrounds ?? controller.toolCubit.state.getAllForegrounds(false))
              .map((e) => e.element)
              .whereType<PadElement>()
              .toList(),
      name: controller.networkingService.userName,
    ),
  );
}

enum SaveState { saved, saving, unsaved, absoluteRead }

enum HideState { visible, keyboard, touch }

enum RendererState { visible, temporary, hidden }

enum TemporaryState { allowClick, removeAfterClick, removeAfterRelease }

abstract interface class EditorRuntimeContext {
  SettingsCubit get settingsCubit;
  RendererCubit get rendererCubit;
  EditorInputCubit get inputCubit;
  EditorViewCubit get viewCubit;
}
