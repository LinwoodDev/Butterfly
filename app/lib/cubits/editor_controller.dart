import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_session.dart';
import 'package:butterfly/cubits/editor_runtime.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/persisted_document_state.dart';
import 'package:butterfly/renderers/cursors/user.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/network.dart';
import 'package:butterfly/services/logger.dart';
import 'package:butterfly/views/navigator/view.dart';
import 'package:butterfly/visualizer/tool.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:networker/networker.dart';

import '../embed/embedding.dart';
import '../handlers/handler.dart';
import '../models/viewport.dart';

export 'editor_runtime.dart'
    show
        DocumentSaveCubit,
        DocumentSaveState,
        EditorInputCubit,
        EditorInputState,
        EditorRuntimeContext,
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

class EditorController implements EditorRuntimeContext {
  @override
  final SettingsCubit settingsCubit;
  final TransformCubit transformCubit;
  final NetworkingService networkingService;
  final EditorSessionCubit? editorSessionCubit;
  @override
  final RendererCubit rendererCubit;
  final ToolCubit toolCubit;
  @override
  final EditorInputCubit inputCubit;
  final DocumentSaveCubit saveCubit;
  @override
  final EditorViewCubit viewCubit;

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
           locks:
               editorSessionCubit?.state.locks ?? const PersistentLockState(),
           navigatorEnabled:
               editorSessionCubit?.state.navigator.enabled ?? false,
           navigatorPage:
               editorSessionCubit?.navigatorPage ?? NavigatorPage.waypoints,
           areaNavigatorCreate:
               editorSessionCubit?.state.areaNavigator.create ?? true,
           areaNavigatorExact:
               editorSessionCubit?.state.areaNavigator.exact ?? true,
           areaNavigatorAsk:
               editorSessionCubit?.state.areaNavigator.ask ?? false,
         ),
       ) {
    rendererCubit.bindController(this);
    toolCubit.bindController(this);
    inputCubit.bindToolCubit(toolCubit);
    viewCubit.bindToolCubit(toolCubit);
  }

  WeakReference<DocumentBloc>? _documentBloc;
  var _closed = false;

  bool get isClosed => _closed;

  DocumentBloc? get activeDocumentBloc {
    final bloc = _documentBloc?.target;
    if (bloc == null || bloc.isClosed) return null;
    return bloc;
  }

  DocumentLoaded? get activeDocumentState {
    final state = activeDocumentBloc?.state;
    return state is DocumentLoaded ? state : null;
  }

  Future<void> reload(DocumentBloc bloc, [DocumentLoaded? blocState]) =>
      reloadRuntime(bloc, blocState);

  void init(DocumentBloc bloc) {
    _documentBloc = WeakReference(bloc);
    final blocState = bloc.state;
    final index = blocState is DocumentLoadSuccess
        ? editorSessionCubit?.resolveToolIndex(blocState.info)
        : toolCubit.state.index;
    toolCubit.changeTool(this, bloc, index: index ?? 0);
    networkingService.setup(bloc);
  }

  Future<void> updateNetworkingState(
    DocumentBloc bloc, [
    Map<Channel?, NetworkingUser>? current,
  ]) async {
    talker.verbose('Updating networking state');
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    final users = (current ?? networkingService.users).entries.toList();
    final usersByChannel = {for (final entry in users) entry.key: entry.value};
    final activeForegroundElements = users
        .expand((entry) => entry.value.foreground ?? const <PadElement>[])
        .toSet();

    final foregrounds = toolCubit.state.networkingForegrounds.toList();
    foregrounds.removeWhere((renderer) {
      bool shouldRemove;
      if (renderer is UserCursor) {
        final activeUser = usersByChannel[renderer.userId];
        shouldRemove = activeUser == null || activeUser != renderer.element;
      } else {
        shouldRemove = !activeForegroundElements.contains(renderer.element);
      }
      if (shouldRemove) {
        renderer.dispose();
      }
      return shouldRemove;
    });

    final existingElements = foregrounds.map((e) => e.element).toSet();
    final added = <Renderer>[];
    added.addAll(
      users
          .expand((entry) => entry.value.foreground ?? const <PadElement>[])
          .where((element) => !existingElements.contains(element))
          .map((element) => Renderer.fromInstance(element)),
    );
    added.addAll(
      users
          .where(
            (entry) =>
                foregrounds.whereType<UserCursor>().firstWhereOrNull(
                  (cursor) =>
                      cursor.userId == entry.key &&
                      cursor.element == entry.value,
                ) ==
                null,
          )
          .map((entry) => UserCursor(entry.value, entry.key)),
    );
    await Future.wait(
      added.map(
        (e) async => await e.setup(
          transformCubit,
          blocState.data,
          blocState.assetService,
          blocState.page,
        ),
      ),
    );
    foregrounds.addAll(added);
    toolCubit.setForegrounds(networkingForegrounds: foregrounds);
  }

  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    final bloc = activeDocumentBloc;
    if (bloc != null) {
      await toolCubit.disposeRuntime(bloc);
    }
    _documentBloc = null;
    await rendererCubit.disposeRuntime();
    await rendererCubit.close();
    await toolCubit.close();
    await inputCubit.close();
    await saveCubit.close();
    await viewCubit.close();
    if (!networkingService.isClosed) {
      await networkingService.close();
    }
  }

  /// If addedElements is null, the viewport gets unbaked
  Future<void> stateChanged(
    DocumentLoadSuccess current,
    DocumentBloc bloc, {
    DocumentLoadSuccess? oldState,
    List<Renderer<PadElement>> addedElements = const [],
    List<Renderer<PadElement>>? replacedElements,
    List<Renderer<Background>>? backgrounds,
    bool reset = false,
    bool unbake = false,
    bool Function()? shouldRefresh,
    bool updateIndex = false,
  }) async {
    rendererCubit.cancelDelayedBake();
    for (var renderer in {
      ...?backgrounds,
      ...?replacedElements,
      ...addedElements,
    }) {
      await renderer.setup(
        transformCubit,
        current.data,
        current.assetService,
        current.page,
      );
    }
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    toolCubit.state.handler.onDocumentUpdated(blocState, oldState);

    final addsCombinedHighlight = addedElements.any(
      (renderer) =>
          renderer is PenRenderer && renderer.element.combineId != null,
    );
    if (replacedElements != null) {
      await rendererCubit.replaceUnbaked(this, blocState, [
        ...replacedElements,
        ...addedElements,
      ], backgrounds: backgrounds);
    } else if (addsCombinedHighlight) {
      await rendererCubit.unbake(
        this,
        blocState,
        unbakedElements: [...rendererCubit.renderers, ...addedElements],
      );
    } else if (unbake) {
      await rendererCubit.unbake(this, blocState, backgrounds: backgrounds);
    } else if (backgrounds != null) {
      await rendererCubit.unbake(this, blocState, backgrounds: backgrounds);
    } else {
      await rendererCubit.addUnbaked(this, blocState, addedElements);
    }

    saveCubit.setSaveState(saved: SaveState.unsaved);
    if (saveCubit.state.embedding != null) {
      return;
    }
    if (reset) {
      await reload(bloc, current);
    } else {
      final refreshRequested = shouldRefresh?.call() == true;
      if (refreshRequested) {
        // For replacement updates we force a reset bake below, so avoid
        // scheduling an extra delayed bake from refresh().
        await toolCubit.refresh(
          this,
          current,
          allowBake: replacedElements == null,
        );
      }
      if (replacedElements != null) {
        await rendererCubit.bake(this, blocState, reset: true);
      }
    }
    if (updateIndex) {
      toolCubit.updateIndex(this, bloc);
    }
    if (saveCubit.hasAutosave(networkingService)) {
      saveCubit.save(
        bloc,
        networkingService,
        isAutosave: true,
        editorSessionCubit: editorSessionCubit,
      );
    }
  }

  Future<void> reloadTool(
    DocumentBloc bloc, [
    DocumentLoaded? blocState,
  ]) async {
    final current = blocState ?? bloc.state;
    if (current is! DocumentLoaded) return;
    final tools = current.info.tools;
    final toolIndex = toolCubit.state.index ?? 0;
    final newTool = tools.elementAtOrNull(toolIndex);
    if (newTool?.isAction() ?? true) {
      await toolCubit.changeTool(this, bloc, index: 0, allowBake: false);
    } else if (newTool != toolCubit.state.handler.data) {
      await toolCubit.changeTool(
        this,
        bloc,
        index: toolIndex,
        allowBake: false,
      );
    }
  }

  Future<void> reloadRuntime(
    DocumentBloc bloc, [
    DocumentLoaded? blocState,
  ]) async {
    final current = blocState ?? bloc.state;
    if (current is! DocumentLoaded) return;
    await reloadTool(bloc, current);
    await rendererCubit.loadElements(this, current);
    await toolCubit.refresh(this, current, allowBake: false);
    await rendererCubit.delayedBake(this, current);
  }
}
