import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly_api/src/models/text.dart';

import '../models/archive.dart';
import '../models/data.dart';
import '../models/meta.dart';
import '../models/pack.dart';
import '../models/palette.dart';

Archive convertLegacyDataToArchive(Map<String, dynamic> data) {
  data = {
    'fileVersion': data['fileVersion'],
    ...legacyNoteDataJsonMigrator(data),
  };
  final archive = Archive();
  final reader = NoteData(archive);
  final meta = FileMetadata.fromJson(data);
  reader.setMetadata(meta);
  switch (meta.type) {
    case NoteFileType.pack:
      final palettes = (data['palettes'] ?? [])
          .map((e) => ColorPalette.fromJson(e))
          .toList();
      for (final palette in palettes) {
        reader.setPalette(palette);
      }
      final styles = (data['styles'] ?? [])
          .map((e) => TextStyleSheet.fromJson(e))
          .toList();
      for (final style in styles) {
        reader.setStyle(style);
      }
      final components = (data['components'] ?? [])
          .map((e) => ButterflyComponent.fromJson(e))
          .toList();
      for (final component in components) {
        reader.setComponent(component);
      }
      break;
    case NoteFileType.template:
    case NoteFileType.document:
      reader.setAsset(
          '$kPagesArchiveDirectory/default.json',
          utf8.encode(jsonEncode(
              meta.type == NoteFileType.document ? data : data['document'])));
      final packs = (data['packs'] ?? [])
          .map((e) => NoteData.fromData(Uint8List.fromList(
              utf8.encode(jsonEncode({'type': 'pack', ...e})))))
          .toList();
      for (final pack in packs) {
        reader.setPack(pack);
      }
      final thumbnail = data['thumbnail'] as String?;
      if (thumbnail?.isNotEmpty == true) {
        final data = UriData.parse(thumbnail!).contentAsBytes();
        reader.setThumbnail(data);
      }
  }
  return archive;
}

Map<String, dynamic> legacyNoteDataJsonMigrator(Map<String, dynamic> data) {
  final fileVersion = data['fileVersion'] as int?;
  final type = data['type'] as String?;
  data = Map<String, dynamic>.from(data);
  switch (type) {
    case 'template':
      data = _legacyTemplateJsonMigrator(data, fileVersion);
      break;
    case 'pack':
      data = _legacyPackJsonMigrator(data, fileVersion);
      break;
    default:
      data = _legacyDocumentJsonMigrator(data, fileVersion);
      break;
  }
  return data;
}

Map<String, dynamic> _legacyDocumentJsonMigrator(
    Map<String, dynamic> data, int? fileVersion) {
  final fileVersion = data['fileVersion'] as int?;
  if (fileVersion != null && fileVersion >= 0) {
    if (fileVersion < 4) {
      data['palettes'] = List.from(
          Map<String, dynamic>.from(data['palettes'] ?? [])
              .entries
              .map<ColorPalette>((e) => ColorPalette(
                  colors: List<int>.from(e.value).toList(), name: e.key))
              .map((e) => e.toJson())
              .toList());
    }
    if (fileVersion < 5) {
      data['painters'] = List.from((data['painters'] as List).map((e) {
        var map = Map<String, dynamic>.from(e);
        if (map['type'] == 'path-eraser') {
          map['type'] = 'pathEraser';
        }
        return map;
      })).where((map) => map['type'] != 'image').toList();
      data['content'] = List.from((data['content'] as List).map((e) {
        var map = Map<String, dynamic>.from(e);
        if (map['type'] == 'paint') {
          map['type'] = 'pen';
        }
        return map;
      })).toList();
      data['background'] = Map<String, dynamic>.from(data['background'] ?? {})
        ..['type'] = 'box';
    }
    if (fileVersion < 6) {
      data['painters'] = [
        {'type': 'hand', ...data['handProperty']},
        {'type': 'undo'},
        {'type': 'redo'},
        ...(data['painters'] as List).map((e) {
          var map = Map<String, dynamic>.from(e);
          if (['svg', 'image'].contains(map['type'])) {
            final constraints = map['constraints'];
            if (constraints is Map) {
              final current = Map<String, dynamic>.from(constraints);
              if (current['type'] == 'scaled') {
                current['scaleX'] = map['scale'];
                current['scaleY'] = map['scale'];
              }
              map['constraints'] = current;
            }
          }
          return map;
        }),
      ];
      if (data['background']?['type'] == null) {
        data['background'] = {'type': 'empty'};
      }
    }
    if (fileVersion < 7) {
      data['content'] = List.from(data['content'] as List).where((e) {
        return e['type'] != 'eraser';
      }).map((e) {
        if (e['type'] == 'label') {
          return {
            'type': 'text',
            'property': {
              'type': 'defined',
              'paragraph': {
                'type': 'defined',
                'alignment': e['horizontalAlignment'],
                'span': e,
              },
              'alignment': e['verticalAlignment'],
            },
          };
        }
        if (e['type'] == 'image') {
          return {
            ...e as Map,
            'source': UriData.fromBytes(e['pixels'], mimeType: 'image/png'),
          };
        }
        return e;
      }).toList();
      if (data['createdAt'] is String) {
        data['createdAt'] =
            DateTime.parse(data['createdAt'] as String).millisecondsSinceEpoch;
      }
      if (data['updatedAt'] is String) {
        data['updatedAt'] =
            DateTime.parse(data['updatedAt'] as String).millisecondsSinceEpoch;
      }
    }
    if (fileVersion < 8) {
      data['content'] = List.from(data['content'] as List).map((e) {
        if (e['type'] == 'svg') {
          return {
            ...e,
            'source': UriData.fromString(e['source'] as String,
                encoding: utf8, mimeType: 'image/svg+xml'),
          };
        }
        return e;
      }).toList();
    }
  }
  return data;
}

Map<String, dynamic> _legacyTemplateJsonMigrator(
    Map<String, dynamic> data, int? fileVersion) {
  data['document'] = _legacyDocumentJsonMigrator(
      Map<String, dynamic>.from(data['document']), fileVersion);
  return {...data['document'], ...data};
}

Map<String, dynamic> _legacyPackJsonMigrator(
    Map<String, dynamic> data, int? fileVersion) {
  return data;
}
