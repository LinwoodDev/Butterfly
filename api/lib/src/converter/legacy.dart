import 'package:archive/archive.dart';

import '../models/palette.dart';
import '../readers/archive.dart';

Archive convertLegacyDataToArchive(Map<String, dynamic> data) {
  final archive = Archive();
  final reader = ArchiveReader(archive);

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
  }
  return data;
}

Map<String, dynamic> _legacyTemplateJsonMigrator(
    Map<String, dynamic> data, int? fileVersion) {
  data['document'] = _legacyDocumentJsonMigrator(
      Map<String, dynamic>.from(data['document']), fileVersion);
  return data;
}

Map<String, dynamic> _legacyPackJsonMigrator(
    Map<String, dynamic> data, int? fileVersion) {
  return data;
}
