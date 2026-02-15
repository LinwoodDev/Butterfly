import 'dart:async';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/src/models/text.dart';
import 'package:mocktail/mocktail.dart';
import 'package:lw_file_system/lw_file_system.dart';

class MockSettingsCubit extends Mock implements SettingsCubit {}

class MockButterflyFileSystem implements ButterflyFileSystem {
  final DocumentFileSystem _documentFileSystem = buildMockDocumentFileSystem();
  final TemplateFileSystem _templateFileSystem = buildMockTemplateFileSystem();
  final PackFileSystem _packFileSystem = buildMockPackFileSystem();
  final SettingsCubit _settingsCubit = MockSettingsCubit();

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
    final system = buildPackSystem(storage);
    await system.initialize();
    final files = await system.getFiles();
    for (final file in files) {
      final pack = file.data!;
      final palette = test(pack);
      if (palette == null) continue;
      final name = file.pathWithoutLeadingSlash;
      return palette.toPack(pack, name);
    }
    return null;
  }

  @override
  void removeCachedDocumentSystem(ExternalStorage? storage) {}

  @override
  void removeCachedFileSystem(ExternalStorage? storage) {}

  @override
  void removeCachedPackSystem(ExternalStorage? storage) {}

  @override
  void removeCachedTemplateSystem(ExternalStorage? storage) {}

  @override
  SettingsCubit get settingsCubit => _settingsCubit;

  @override
  Future<void> updatePack(PackAssetLocation location, NoteData newPack) =>
      buildPackSystem().updateFile(location.key, newPack);
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
