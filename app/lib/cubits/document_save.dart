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
  bool _canvasInputActive = false;
  Timer? _autosaveTimer;
  ({Completer<AssetLocation> result, Future<AssetLocation> Function() write})?
  _pendingAutosave;

  void setCanvasInputActive(bool active) {
    if (isClosed || _canvasInputActive == active) return;
    _canvasInputActive = active;
    _armAutosave();
  }

  void _armAutosave() {
    _autosaveTimer?.cancel();
    _autosaveTimer = null;
    if (_pendingAutosave == null) return;
    final settings = settingsCubit.state;
    _setDelayed(_canvasInputActive || settings.delayedAutosave);
    if (_canvasInputActive) return;
    final delay = settings.delayedAutosave ? settings.autosaveDelaySeconds : 0;
    late final Timer timer;
    timer = _autosaveTimer = Timer(
      Duration(seconds: max(0, delay)),
      () => unawaited(_runAutosave(timer)),
    );
  }

  Future<void> _runAutosave(Timer timer) => savingLock.synchronized(() async {
    // Input or a manual save can invalidate a timer queued on the lock.
    final pending = _pendingAutosave;
    if (_autosaveTimer != timer || pending == null) return;
    _clearAutosave();
    try {
      pending.result.complete(await pending.write());
    } catch (error, stackTrace) {
      pending.result.completeError(error, stackTrace);
    }
  });

  void _clearAutosave() {
    _autosaveTimer?.cancel();
    _autosaveTimer = null;
    _pendingAutosave = null;
    if (!isClosed) _setDelayed(false);
  }

  Future<AssetLocation> _scheduleAutosave(
    Future<AssetLocation> Function() write,
  ) {
    if (_pendingAutosave != null) return Future.value(state.location);
    final result = Completer<AssetLocation>();
    _pendingAutosave = (result: result, write: write);
    _armAutosave();
    return result.future;
  }

  void _cancelAutosave() {
    _pendingAutosave?.result.complete(state.location);
    _clearAutosave();
  }

  @override
  Future<void> close() {
    _cancelAutosave();
    return super.close();
  }

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

  void _setDelayed(bool delayed) =>
      emit(state.copyWith(isSaveDelayed: delayed));

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
    bool needsDocumentWrite() =>
        location != null ||
        name != null ||
        force ||
        (state.saved != .saved && state.saved != .absoluteRead);

    if (isClosed) return location ?? state.location;
    if (!needsDocumentWrite()) {
      await editorSessionCubit?.saveNow();
      return state.location;
    }
    if (networkingService.isClient) {
      return AssetLocation.empty;
    }
    Future<AssetLocation> write() async {
      if (isClosed) return location ?? state.location;
      if (isAutosave && !hasAutosave(networkingService)) return state.location;
      if (!needsDocumentWrite()) {
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
      if (!isAutosave) _cancelAutosave();
      setSaveState(saved: SaveState.saving);
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
        late Digest digest;
        final bytes = _exportNoteStream(
          currentData,
          text: destination.fileType == .textNote,
          onDigest: (value) => digest = value,
        );
        final saved = await fileSystem.saveFileStream(
          destination.copyWith(absolute: writeAbsolute),
          bytes,
          create: create,
        );
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
    }

    if (isAutosave) return _scheduleAutosave(write);
    return savingLock.synchronized(write);
  }
}

(Uint8List, Digest) _encodeTextNote(NoteData note) {
  final bytes = note.exportAsTextBytes();
  return (bytes, sha512256.convert(bytes));
}

Stream<Uint8List> _zipChunks(
  NoteData note,
  void Function(Digest) onDigest,
) async* {
  final hash = sha512256.startChunkedConversion(
    ChunkedConversionSink<Digest>.withCallback(
      (digests) => onDigest(digests.single),
    ),
  );
  await for (final chunk in note.exportAsStream()) {
    hash.add(chunk);
    yield chunk;
  }
  hash.close();
}

Stream<Uint8List> _exportNoteStream(
  NoteData note, {
  required bool text,
  required void Function(Digest) onDigest,
}) async* {
  if (text) {
    final (bytes, digest) = await compute(_encodeTextNote, note);
    onDigest(digest);
    yield bytes;
    return;
  }
  if (kIsWeb) {
    yield* _zipChunks(note, onDigest);
    return;
  }

  final messages = ReceivePort();
  Isolate? worker;
  try {
    worker = await Isolate.spawn(
      _encodeZipNote,
      (note, messages.sendPort),
      onError: messages.sendPort,
      onExit: messages.sendPort,
    );
    await for (final message in messages) {
      switch (message) {
        case (final TransferableTypedData data, final SendPort ack):
          yield data.materialize().asUint8List();
          ack.send(null);
        case final Digest digest:
          onDigest(digest);
          return;
        case [final String error, final String stack]:
          throw RemoteError(error, stack);
        default:
          throw StateError('The note encoder exited before finishing');
      }
    }
  } finally {
    worker?.kill(priority: Isolate.immediate);
    messages.close();
  }
}

Future<void> _encodeZipNote((NoteData, SendPort) request) async {
  final (note, output) = request;
  final acknowledgments = ReceivePort();
  final ack = acknowledgments.sendPort;
  final ready = StreamIterator(acknowledgments);
  late Digest digest;
  await for (final chunk in _zipChunks(note, (value) => digest = value)) {
    // Wait for the consumer before producing another chunk.
    output.send((TransferableTypedData.fromList([chunk]), ack));
    await ready.moveNext();
  }
  Isolate.exit(output, digest);
}
