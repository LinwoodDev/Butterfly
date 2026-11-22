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
  bool get absolute => location.absolute || saved == .absoluteRead;
}

class DocumentSaveCubit(
  final SettingsCubit settingsCubit, {
  final String? initialDirectory,
  DocumentSaveState initial = const DocumentSaveState(),
}) extends Cubit<DocumentSaveState> {
  this : super(initial);

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
      saved: (absolute || (keepRead && state.saved == SaveState.absoluteRead))
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
              (!state.absolute ||
                  (state.location.absolute &&
                      (state.location.fileType?.isNote() ?? false))) &&
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
    String? name,
    bool force = false,
    bool isAutosave = false,
    EditorSessionCubit? editorSessionCubit,
  }) async {
    if (location == null &&
        name == null &&
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
          name == null &&
          !force &&
          (state.saved == .saved || state.saved == .absoluteRead)) {
        await editorSessionCubit?.saveNow();
        return state.location;
      }
      var current = location ?? state.location;
      final previousLocation = state.location;
      final absolute = state.absolute;
      final wasReadOnly = state.saved == SaveState.absoluteRead;
      final storage = settingsCubit.getRemote(current.remote);
      if (current.isRemote && storage == null) {
        throw StateError(
          'Storage connection "${current.remote}" is unavailable',
        );
      }
      final fileSystem = bloc.state.fileSystem.buildDocumentSystem(storage);
      if (isClosed) {
        return current;
      }
      setSaveState(saved: SaveState.saving);
      setDelayed(false);
      var documentWritten = false;
      try {
        final blocState = bloc.state;
        final currentData = (await blocState.saveData())?.setName(name);
        if (isClosed) {
          return current;
        }
        if (currentData == null || state.embedding != null) {
          setSaveState(saved: SaveState.saved);
          return AssetLocation.empty;
        }
        final writeAbsolute =
            current.absolute &&
            current.isLocal &&
            (current.fileType?.isNote() ?? false);
        final needsNewNote =
            (absolute && !writeAbsolute && location == null) ||
            !(current.fileType?.isNote() ?? false);
        final create =
            !writeAbsolute &&
            (needsNewNote || (location != null && current != previousLocation));
        final destination = needsNewNote
            ? AssetLocation(
                remote: current.remote,
                path: fileSystem.convertNameToFileSystem(
                  name: currentData.name,
                  suffix: '.bfly',
                  directory: absolute
                      ? null
                      : current.isEmpty
                      ? initialDirectory
                      : current.parent,
                ),
              )
            : current;
        final bytes = destination.fileType == .textNote
            ? Stream.fromFuture(compute(_exportTextNote, currentData))
            : currentData.exportAsStream();
        late Digest digest;
        final hash = sha512256.startChunkedConversion(
          ChunkedConversionSink<Digest>.withCallback(
            (values) => digest = values.single,
          ),
        );
        final saved = await fileSystem.saveFileStream(
          destination.copyWith(absolute: writeAbsolute),
          bytes.map((chunk) {
            hash.add(chunk);
            return chunk;
          }),
          create: create,
        );
        hash.close();
        current = saved.copyWith(absolute: destination.absolute);
        documentWritten = true;
        if (isClosed) return current;
        setSaveState(location: current);
        settingsCubit.addRecentHistory(current);
        await editorSessionCubit?.saveNow(
          pathKey: documentStatePathKeyOrNull(
            current,
            remoteStorage: storage is RemoteStorage,
          ),
          contentHash: digest.toString(),
        );
        if (isClosed) {
          return current;
        }
        setSaveState(
          saved: state.saved == .saving ? .saved : state.saved,
          location: current,
        );
        return current;
      } catch (_) {
        if (!isClosed) {
          setSaveState(
            saved: wasReadOnly && !documentWritten
                ? SaveState.absoluteRead
                : SaveState.unsaved,
          );
        }
        rethrow;
      }
    });
  }
}
