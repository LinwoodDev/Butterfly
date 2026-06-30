import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/models/persisted_document_state.dart';

class DocumentStateRepository {
  DocumentStateRepository(this.fileSystem);

  final DocumentStateFileSystem fileSystem;

  Future<PersistedDocumentState?> load({
    String? contentHash,
    String? pathKey,
    bool allowContentHash = true,
  }) async {
    await fileSystem.initialize();
    if (allowContentHash && contentHash != null) {
      final byContent = await fileSystem.getFile(
        documentStateContentKey(contentHash),
      );
      if (byContent != null) return byContent;
    }
    if (pathKey != null) {
      return fileSystem.getFile(pathKey);
    }
    return null;
  }

  Future<void> save(
    PersistedDocumentState state, {
    String? contentHash,
    String? pathKey,
  }) async {
    await fileSystem.initialize();
    if (contentHash != null) {
      await _put(documentStateContentKey(contentHash), state);
    }
    if (pathKey != null) {
      await _put(pathKey, state);
    }
  }

  Future<void> _put(String key, PersistedDocumentState state) async {
    if (await fileSystem.hasKey(key)) {
      await fileSystem.updateFile(key, state);
    } else {
      await fileSystem.createFile(key, state);
    }
  }
}
