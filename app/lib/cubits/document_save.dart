part of 'editor_runtime.dart';

const _defaultDocumentLocation = AssetLocation(path: '');

@freezed
class const DocumentSaveState({
  final bool isSaveDelayed = false,
  final AssetLocation location = _defaultDocumentLocation,
  final Embedding? embedding,
  final bool fullScreen = false,
  final SaveState saved = .saved,
  final bool isCreating = false,
}) with _$DocumentSaveState {}

extension DocumentSaveStateProperties on DocumentSaveState {
  bool get absolute => saved == .absoluteRead;
}

class DocumentSaveCubit(
  final SettingsCubit settingsCubit, [
  super.initial = const DocumentSaveState(),
]) extends Cubit<DocumentSaveState> {
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

  void changeFullScreen(bool value) => emit(state.copyWith(fullScreen: value));

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
        (state.saved == .saved || state.saved == .absoluteRead)) {
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
          (state.saved == .saved || state.saved == .absoluteRead)) {
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
      String contentHash;
      if (absolute || !(current.fileType?.isNote() ?? false)) {
        final (file, hash) = await compute(_toFileWithContentHash, (
          currentData,
          false,
        ));
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
        contentHash = hash;
      } else {
        final (file, hash) = await compute(_toFileWithContentHash, (
          currentData,
          current.fileType == .textNote,
        ));
        await fileSystem.updateFile(current.path, file);
        contentHash = hash;
      }
      settingsCubit.addRecentHistory(current);
      await editorSessionCubit?.saveNow(
        pathKey: documentStatePathKeyOrNull(current),
        contentHash: contentHash,
      );
      if (isClosed) {
        return current;
      }
      setSaveState(
        saved: state.saved == .saving ? .saved : state.saved,
        location: current,
      );
      return current;
    });
  }
}
