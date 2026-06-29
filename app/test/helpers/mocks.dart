import 'dart:async';
import 'package:archive/archive.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/models/persisted_document_state.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/src/models/text.dart';
import 'package:mocktail/mocktail.dart';
import 'package:lw_file_system/lw_file_system.dart';

class MockSettingsCubit extends Mock implements SettingsCubit {}

class MockButterflyFileSystem implements ButterflyFileSystem {
  final DocumentFileSystem _documentFileSystem = buildMockDocumentFileSystem();
  final TemplateFileSystem _templateFileSystem = buildMockTemplateFileSystem();
  final PackFileSystem _packFileSystem = buildMockPackFileSystem();
  final DocumentStateFileSystem _documentStateFileSystem =
      buildMockDocumentStateFileSystem();
  final SettingsCubit _settingsCubit;

  MockButterflyFileSystem({SettingsCubit? settingsCubit})
    : _settingsCubit = settingsCubit ?? MockSettingsCubit();

  @override
  Map<String, DocumentFileSystem> buildAllDocumentSystems({
    bool includeLocal = true,
    bool forceRecreate = false,
  }) => {'': _documentFileSystem};

  @override
  DocumentFileSystem buildDefaultDocumentSystem({bool forceRecreate = false}) =>
      _documentFileSystem;

  @override
  PackFileSystem buildDefaultPackSystem({bool forceRecreate = false}) =>
      _packFileSystem;

  @override
  TemplateFileSystem buildDefaultTemplateSystem({bool forceRecreate = false}) =>
      _templateFileSystem;

  @override
  TypedDirectoryFileSystem<NoteFile> buildDocumentSystem([
    ExternalStorage? storage,
    bool forceRecreate = false,
  ]) => _documentFileSystem;

  @override
  DocumentStateFileSystem buildDocumentStateSystem([
    ExternalStorage? storage,
    bool forceRecreate = false,
  ]) => _documentStateFileSystem;

  @override
  TypedKeyFileSystem<NoteData> buildPackSystem([
    ExternalStorage? storage,
    bool forceRecreate = false,
  ]) => _packFileSystem;

  @override
  TypedKeyFileSystem<NoteData> buildTemplateSystem([
    ExternalStorage? storage,
    bool forceRecreate = false,
  ]) => _templateFileSystem;

  @override
  Future<PackItem<ColorPalette>?> findDefaultPalette([
    ExternalStorage? storage,
  ]) => findPack((pack) => pack.getNamedPalettes().firstOrNull, storage);

  @override
  Future<PackItem<TextStyleSheet>?> findDefaultStyleSheet([
    ExternalStorage? storage,
  ]) => findPack((pack) => pack.getNamedStyles().firstOrNull, storage);

  @override
  Future<PackItem<T>?> findPack<T extends PackAsset>(
    NamedItem<T>? Function(NoteData) test, [
    ExternalStorage? storage,
  ]) async {
    for (final (name, pack) in await getCoreAndUserPacks(storage)) {
      final palette = test(pack);
      if (palette == null) continue;
      return palette.toPack(pack, name);
    }
    return null;
  }

  @override
  Future<List<(String, NoteData)>> getCoreAndUserPacks([
    ExternalStorage? storage,
  ]) async {
    final corePack = await DocumentDefaults.getCorePack();
    NoteData createUserCorePack() {
      var pack = NoteData(Archive(), parent: corePack);
      final metadata = corePack.getMetadata();
      if (metadata != null) {
        pack = pack.setMetadata(metadata);
      }
      return pack;
    }

    final system = buildPackSystem(storage);
    await system.initialize();
    final files = await system.getFiles();
    final packs = <(String, NoteData)>[];
    (String, NoteData)? userCorePack;
    for (final file in files) {
      final pack = file.data!;
      final item = (file.pathWithoutLeadingSlash, pack);
      if (item.$1 == kCorePackFileName) {
        userCorePack = (item.$1, NoteData(pack.archive, parent: corePack));
      } else {
        packs.add(item);
      }
    }
    return [
      userCorePack ?? (kCorePackFileName, createUserCorePack()),
      ...packs,
    ];
  }

  @override
  void removeCachedDocumentSystem(ExternalStorage? storage) {}

  @override
  void removeCachedDocumentStateSystem(ExternalStorage? storage) {}

  @override
  void removeCachedFileSystem(ExternalStorage? storage) {}

  @override
  void removeCachedPackSystem(ExternalStorage? storage) {}

  @override
  void removeCachedTemplateSystem(ExternalStorage? storage) {}

  @override
  SettingsCubit get settingsCubit => _settingsCubit;

  @override
  void dispose() {}

  @override
  Future<void> updatePack(PackAssetLocation location, NoteData newPack) async {
    final system = buildPackSystem();
    await system.initialize();
    final existing = await system.getFile(location.namespace);
    if (existing == null) {
      await system.createFile(location.namespace, newPack);
      return;
    }
    await system.updateFile(location.namespace, newPack);
  }
}

TemplateFileSystem buildMockTemplateFileSystem() {
  return MockTypedKeyFileSystem(
    onEncode: encodeNoteData,
    onDecode: decodeNoteData,
  );
}

DocumentFileSystem buildMockDocumentFileSystem() {
  return MockTypedDirectoryFileSystem(
    onEncode: encodeNoteFile,
    onDecode: decodeNoteFile,
  );
}

PackFileSystem buildMockPackFileSystem() {
  return MockTypedKeyFileSystem(
    onEncode: encodeNoteData,
    onDecode: decodeNoteData,
  );
}

DocumentStateFileSystem buildMockDocumentStateFileSystem() {
  return MockTypedKeyFileSystem(
    onEncode: encodePersistedDocumentState,
    onDecode: decodePersistedDocumentState,
  );
}
