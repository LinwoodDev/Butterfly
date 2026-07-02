part of 'editor_runtime.dart';

@freezed
sealed class DocumentSaveState with _$DocumentSaveState {
  const DocumentSaveState._();

  const factory DocumentSaveState({
    @Default(false) bool isSaveDelayed,
    @Default(AssetLocation(path: '')) AssetLocation location,
    Embedding? embedding,
    @Default(SaveState.saved) SaveState saved,
    @Default(false) bool isCreating,
  }) = _DocumentSaveState;

  bool get absolute => saved == SaveState.absoluteRead;
}

class DocumentSaveCubit extends Cubit<DocumentSaveState> {
  DocumentSaveCubit(
    this.settingsCubit, [
    super.initial = const DocumentSaveState(),
  ]);

  final SettingsCubit settingsCubit;

  final savingLock = Lock();

  void replace(DocumentSaveState state) => emit(state);

  void setSaveState({
    AssetLocation? location,
    SaveState? saved,
    bool absolute = false,
    bool? isCreating,
    bool keepRead = false,
  }) => emit(
    state.copyWith(
      location: location ?? state.location,
      isCreating: isCreating ?? state.isCreating,
      saved: (absolute || (keepRead && state.absolute))
          ? SaveState.absoluteRead
          : saved ?? state.saved,
    ),
  );

  void setDelayed(bool delayed) => emit(state.copyWith(isSaveDelayed: delayed));

  ExternalStorage? getRemoteStorage() =>
      settingsCubit.getRemote(state.location.remote);

  bool hasAutosave(NetworkingService networkingService) =>
      settingsCubit.state.autosave &&
      (networkingService.isActive ||
          !(state.embedding?.save ?? true) ||
          (!kIsWeb &&
              !state.absolute &&
              (state.location.isEmpty ||
                  (state.location.fileType?.isNote() ?? false)) &&
              (state.location.remote.isEmpty ||
                  (settingsCubit
                          .getRemote(state.location.remote)
                          ?.hasDocumentCached(state.location.path) ??
                      false))));

  Future<AssetLocation> save(
    DocumentBloc bloc,
    NetworkingService networkingService, {
    AssetLocation? location,
    bool force = false,
    bool isAutosave = false,
    EditorSessionCubit? editorSessionCubit,
  }) async {
    final absolute = state.absolute;
    if (location == null &&
        !force &&
        (state.saved == SaveState.saved ||
            state.saved == SaveState.absoluteRead)) {
      await editorSessionCubit?.saveNow();
      return state.location;
    }
    if (networkingService.isClient) {
      return AssetLocation.empty;
    }
    if (state.isSaveDelayed && isAutosave) {
      return state.location;
    }
    final storage = getRemoteStorage();
    final fileSystem = bloc.state.fileSystem.buildDocumentSystem(storage);
    final isDelayed = settingsCubit.state.delayedAutosave;
    if (isDelayed && isAutosave) {
      final seconds = max(0, settingsCubit.state.autosaveDelaySeconds);
      setDelayed(true);
      await Future.delayed(Duration(seconds: seconds));
      if (!state.isSaveDelayed) {
        return state.location;
      }
    }
    return savingLock.synchronized(() async {
      if (location == null &&
          !force &&
          (state.saved == SaveState.saved ||
              state.saved == SaveState.absoluteRead)) {
        await editorSessionCubit?.saveNow();
        return state.location;
      }
      var current = location ?? state.location;
      if (isClosed) {
        return current;
      }
      setSaveState(saved: SaveState.saving, location: current);
      setDelayed(false);
      final blocState = bloc.state;
      final currentData = await blocState.saveData();
      if (isClosed) {
        return current;
      }
      if (currentData == null || state.embedding != null) {
        setSaveState(saved: SaveState.saved);
        return AssetLocation.empty;
      }
      if (absolute || !(current.fileType?.isNote() ?? false)) {
        final file = await compute(_toFile, (currentData, false));
        final document = await fileSystem.createFileWithName(
          name: currentData.name,
          suffix: '.bfly',
          directory: absolute
              ? null
              : current.fileExtension.isEmpty
              ? state.location.path
              : state.location.parent,
          file,
        );
        current = document.location;
      } else {
        final file = await compute(_toFile, (
          currentData,
          current.fileType == AssetFileType.textNote,
        ));
        await fileSystem.updateFile(current.path, file);
      }
      settingsCubit.addRecentHistory(current);
      await editorSessionCubit?.saveNow();
      if (isClosed) {
        return current;
      }
      setSaveState(
        saved: state.saved == SaveState.saving ? SaveState.saved : state.saved,
        location: current,
      );
      return current;
    });
  }
}
