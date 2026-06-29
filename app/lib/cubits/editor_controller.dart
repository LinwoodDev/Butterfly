import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:butterfly/api/image.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_session.dart';
import 'package:butterfly/cubits/editor_runtime.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly/helpers/xml.dart';
import 'package:butterfly/renderers/cursors/user.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/network.dart';
import 'package:butterfly/services/logger.dart';
import 'package:butterfly/views/navigator/constants.dart';
import 'package:butterfly/views/navigator/view.dart';
import 'package:butterfly/visualizer/tool.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:networker/networker.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:xml/xml.dart';

import '../embed/embedding.dart';
import '../handlers/handler.dart';
import '../models/viewport.dart';
import '../view_painter.dart';

export 'editor_runtime.dart'
    show
        DocumentSaveCubit,
        DocumentSaveState,
        EditorInputCubit,
        EditorInputState,
        EditorViewCubit,
        EditorViewState,
        HideState,
        RendererCubit,
        RendererRuntimeState,
        RendererState,
        SaveState,
        TemporaryState,
        ToolCubit,
        ToolRuntimeState;

part 'editor_controller_methods.dart';

class EditorController {
  final SettingsCubit settingsCubit;
  final TransformCubit transformCubit;
  final NetworkingService networkingService;
  final EditorSessionCubit? editorSessionCubit;
  late final RendererCubit rendererCubit;
  late final ToolCubit toolCubit;
  late final EditorInputCubit inputCubit;
  late final DocumentSaveCubit saveCubit;
  late final EditorViewCubit viewCubit;
  StreamSubscription<RendererRuntimeState>? _rendererSubscription;
  StreamSubscription<ToolRuntimeState>? _toolSubscription;
  StreamSubscription<EditorInputState>? _inputSubscription;
  StreamSubscription<EditorViewState>? _viewSubscription;

  EditorController(
    this.settingsCubit,
    this.transformCubit,
    CameraViewport viewport, {
    Embedding? embedding,
    NetworkingService? networkingService,
    this.editorSessionCubit,
    bool absolute = false,
  }) : networkingService = networkingService ?? NetworkingService(),
       rendererCubit = RendererCubit(
         settingsCubit,
         RendererRuntimeState(cameraViewport: viewport),
       ),
       toolCubit = ToolCubit(
         ToolRuntimeState(
           index: editorSessionCubit?.state.selectedTool.toolIndex,
           handler: HandHandler(),
         ),
       ),
       inputCubit = EditorInputCubit(settingsCubit),
       saveCubit = DocumentSaveCubit(
         settingsCubit,
         DocumentSaveState(
           embedding: embedding,
           saved: absolute ? SaveState.absoluteRead : SaveState.saved,
         ),
       ),
       viewCubit = EditorViewCubit(
         editorSessionCubit: editorSessionCubit,
         initial: EditorViewState(
           utilities:
               editorSessionCubit?.state.utilities ?? const UtilitiesState(),
           navigatorEnabled:
               editorSessionCubit?.state.navigatorEnabled ?? false,
           navigatorPage:
               editorSessionCubit?.navigatorPage ?? NavigatorPage.waypoints,
           areaNavigatorCreate:
               editorSessionCubit?.state.areaNavigatorCreate ?? true,
           areaNavigatorExact:
               editorSessionCubit?.state.areaNavigatorExact ?? true,
           areaNavigatorAsk:
               editorSessionCubit?.state.areaNavigatorAsk ?? false,
         ),
       ) {
    _previousRendererState = rendererCubit.state;
    _previousToolState = toolCubit.state;
    _previousInputState = inputCubit.state;
    _previousViewState = viewCubit.state;
    _transformSubscription = transformCubit.stream.listen(_onTransformChanged);
    _rendererSubscription = rendererCubit.stream.listen(_onRendererChanged);
    _toolSubscription = toolCubit.stream.listen(_onToolChanged);
    _inputSubscription = inputCubit.stream.listen(_onInputChanged);
    _viewSubscription = viewCubit.stream.listen(_onViewChanged);
  }

  StreamSubscription? _transformSubscription;
  Timer? _transformDebounceTimer;
  Timer? _networkingDebounceTimer;
  RendererRuntimeState _previousRendererState = const RendererRuntimeState();
  ToolRuntimeState? _previousToolState;
  EditorInputState _previousInputState = const EditorInputState();
  EditorViewState? _previousViewState;
  WeakReference<DocumentBloc>? _documentBloc;
  var _closed = false;
  var _isClosing = false;

  bool get isClosed => _closed;

  Future<void> reload(DocumentBloc bloc, [DocumentLoaded? blocState]) =>
      reloadRuntime(bloc, blocState);
}

Future<NoteFile> _toFile((NoteData, bool) args) async {
  return args.$1.toFile(isTextBased: args.$2);
}
