import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly/settings/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';

void main() {
  test('streams nested document directories into the zip', () async {
    final fileSystem = _TrackingFileSystem()
      ..addFile('root.bfly', Uint8List.fromList([1]))
      ..addFile('folder/nested.bfly', Uint8List.fromList([2, 3]))
      ..addFile('folder/deep/end.bfly', Uint8List.fromList([4, 5, 6]));
    final directRoot = await fileSystem.readAsset('', readData: false);
    expect(directRoot, isA<RawFileSystemDirectory>());
    expect(
      (directRoot! as RawFileSystemDirectory).assets.map(
        (asset) => asset.fileName,
      ),
      ['root.bfly', 'folder'],
    );
    final root =
        await fileSystem.readAsset('', readData: false)
            as RawFileSystemDirectory;
    expect(root.assets.map((asset) => asset.fileName), ['root.bfly', 'folder']);
    final output = OutputMemoryStream();
    final encoder = ZipEncoder()..startEncode(output);

    await addDirectoryToZip(fileSystem, encoder, root, 'Documents');
    encoder.endEncode();

    final archive = ZipDecoder().decodeBytes(output.getBytes());
    expect(archive.files.map((file) => file.name), [
      'Documents/',
      'Documents/root.bfly',
      'Documents/folder/',
      'Documents/folder/nested.bfly',
      'Documents/folder/deep/',
      'Documents/folder/deep/end.bfly',
    ]);
    expect(archive.findFile('Documents/folder/deep/end.bfly')?.content, [
      4,
      5,
      6,
    ]);
    expect(fileSystem.dataReads, {
      'root.bfly',
      'folder/nested.bfly',
      'folder/deep/end.bfly',
    });
  });

  test('does not add a documents prefix for document-only exports', () async {
    final fileSystem = _TrackingFileSystem()
      ..addFile('folder/nested.bfly', Uint8List.fromList([1, 2, 3]));
    final root =
        await fileSystem.readAsset('', readData: false)
            as RawFileSystemDirectory;
    expect(root.assets.map((asset) => asset.fileName), ['folder']);
    final output = OutputMemoryStream();
    final encoder = ZipEncoder()..startEncode(output);

    await addDirectoryToZip(fileSystem, encoder, root, '');
    encoder.endEncode();

    final archive = ZipDecoder().decodeBytes(output.getBytes());
    expect(archive.findFile('folder/nested.bfly')?.content, [1, 2, 3]);
    expect(archive.findFile('Documents/folder/nested.bfly'), isNull);
  });

  test('exports a large flat library one file at a time', () async {
    final fileSystem = _TrackingFileSystem();
    for (var i = 0; i < 500; i++) {
      fileSystem.addFile('document-$i.bfly', Uint8List.fromList([i % 256]));
    }
    final root =
        await fileSystem.readAsset('', readData: false)
            as RawFileSystemDirectory;
    final output = OutputMemoryStream();
    final encoder = ZipEncoder()..startEncode(output);

    await addDirectoryToZip(fileSystem, encoder, root, 'Documents');
    encoder.endEncode();

    final archive = ZipDecoder().decodeBytes(output.getBytes());
    expect(archive.files.length, 501);
    expect(fileSystem.dataReads.length, 500);
    expect(archive.findFile('Documents/document-499.bfly')?.content, [243]);
  });

  test('exports packs and templates into separate directories', () async {
    final packs = _NormalizedMockKeyFileSystem();
    final templates = _NormalizedMockKeyFileSystem();
    await packs.updateFile('colors.bfly', Uint8List.fromList([1, 2]));
    await templates.updateFile('page.bfly', Uint8List.fromList([3, 4]));
    final output = OutputMemoryStream();
    final encoder = ZipEncoder()..startEncode(output);
    var completedFiles = 0;

    await addKeyFilesToZip(
      packs,
      encoder,
      await packs.getKeys(),
      'Packs',
      onFileAdded: () => completedFiles++,
    );
    await addKeyFilesToZip(
      templates,
      encoder,
      await templates.getKeys(),
      'Templates',
      onFileAdded: () => completedFiles++,
    );
    encoder.endEncode();

    final archive = ZipDecoder().decodeBytes(output.getBytes());
    expect(archive.findFile('Packs/colors.bfly')?.content, [1, 2]);
    expect(archive.findFile('Templates/page.bfly')?.content, [3, 4]);
    expect(completedFiles, 2);
  });
}

class _TrackingFileSystem extends MockFileSystem {
  final dataReads = <String>{};

  @override
  String normalizePath(String path) {
    final normalized = super.normalizePath(path);
    if (normalized == '/' || normalized == '.') return '';
    return normalized.startsWith('/') ? normalized.substring(1) : normalized;
  }

  @override
  Future<FileSystemEntity<Uint8List>?> readAsset(
    String path, {
    bool readData = true,
    bool forceRemote = false,
  }) {
    if (readData) dataReads.add(normalizePath(path));
    return super.readAsset(path, readData: readData, forceRemote: forceRemote);
  }
}

class _NormalizedMockKeyFileSystem extends MockKeyFileSystem {
  @override
  String normalizePath(String path) {
    final normalized = super.normalizePath(path);
    if (normalized == '/' || normalized == '.') return '';
    return normalized.startsWith('/') ? normalized.substring(1) : normalized;
  }
}
