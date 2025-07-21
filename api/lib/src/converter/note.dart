import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';

import '../../butterfly_api.dart';

const kArchiveSignature = 0x50;

NoteData noteDataMigrator(Uint8List data, {String? password}) {
  Archive archive;
  if (data.isNotEmpty && data[0] != kArchiveSignature) {
    final map = json.decode(utf8.decode(data)) as Map<String, dynamic>;
    archive = convertLegacyDataToArchive(map);
  } else {
    archive = ZipDecoder().decodeBytes(data, password: password);
  }
  return archiveNoteDataMigrator(archive, password: password);
}

NoteData archiveNoteDataMigrator(Archive archive, {String? password}) {
  var noteData = NoteData.build(archive, password: password);
  var metadata = noteData.getMetadata();
  if (metadata != null &&
      (metadata.fileVersion ?? kFileVersion) < kFileVersion) {
    noteData = _migrate(noteData, metadata);
    metadata = noteData.getMetadata();
    if (metadata != null) {
      noteData = noteData.setMetadata(
        metadata.copyWith(fileVersion: kFileVersion, updatedAt: DateTime.now()),
      );
    }
  }
  return noteData;
}

NoteData _migrate(NoteData noteData, FileMetadata metadata) {
  final version = metadata.fileVersion ?? kFileVersion;
  if (version < 9) {
    final pagePath = '$kPagesArchiveDirectory/default.json';
    final page = noteData.getAsset(pagePath);
    if (page != null) {
      final pageData = json.decode(utf8.decode(page)) as Map<String, dynamic>;
      noteData = noteData.setAsset(
        kInfoArchiveFile,
        utf8.encode(
          json.encode({
            'painters': (pageData['painters'] as List?)?.where(
              (element) => element['type'] != 'waypoint',
            ),
            ...pageData,
          }),
        ),
      );
    }
  }
  if (version < 10) {
    for (final page in noteData.getAssets('$kPagesArchiveDirectory/')) {
      final data = noteData.getAsset('$kPagesArchiveDirectory/$page');
      if (data == null) continue;
      final pageData = json.decode(utf8.decode(data)) as Map<String, dynamic>;
      final backgroundType = pageData['background']?['type'];
      if (backgroundType == 'box') {
        pageData['background'] = {
          'type': 'texture',
          'texture': {...pageData['background'], 'type': 'pattern'},
        };
      }
      pageData['backgrounds'] = [
        if (backgroundType != 'empty') pageData['background'],
      ];
      noteData = noteData.setAsset(
        '$kPagesArchiveDirectory/$page',
        utf8.encode(json.encode(pageData)),
      );
    }
    final info = noteData.getAsset(kInfoArchiveFile);
    if (info != null) {
      final infoData = json.decode(utf8.decode(info)) as Map<String, dynamic>;
      infoData['view'] = infoData['tool'];
      infoData['tools'] = (infoData['painters'] as List).map((e) {
        if (e['type'] == 'hand') {
          e['type'] = 'select';
        } else if (e['type'] == 'move') {
          e['type'] = 'hand';
        }
        return e;
      }).toList();
      noteData = noteData.setAsset(
        kInfoArchiveFile,
        utf8.encode(json.encode(infoData)),
      );
    }
  }
  if (version < 11) {
    for (final page in noteData.getAssets('$kPagesArchiveDirectory/')) {
      final data = noteData.getAsset('$kPagesArchiveDirectory/$page');
      if (data == null) continue;
      final pageData = json.decode(utf8.decode(data)) as Map<String, dynamic>;
      final content = pageData['content'] as List?;
      final newLayer = {
        'id': createUniqueId(),
        'content':
            content?.map((e) => {...e, 'collection': e['layer']}).toList() ??
            [],
      };
      pageData['layers'] = [newLayer];
      noteData = noteData.setAsset(
        '$kPagesArchiveDirectory/$page',
        utf8.encode(json.encode(pageData)),
      );
    }
    final info = noteData.getAsset(kInfoArchiveFile);
    if (info != null) {
      final infoData = json.decode(utf8.decode(info)) as Map<String, dynamic>;
      infoData['tools'] = (infoData['tools'] as List).map((e) {
        if (e['type'] == 'layer') {
          e['type'] = 'collection';
        }
        return e;
      }).toList();
      noteData = noteData.setAsset(
        kInfoArchiveFile,
        utf8.encode(json.encode(infoData)),
      );
    }
  }
  return noteData;
}
