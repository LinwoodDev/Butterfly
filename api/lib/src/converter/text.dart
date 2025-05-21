import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:butterfly_api/src/models/pack.dart';
import 'package:butterfly_api/src/models/page.dart';

import '../models/archive.dart';
import '../models/data.dart';

Archive convertTextDataToArchive(Map<String, dynamic> data) {
  data = {
    'fileVersion': 8,
    ...legacyNoteDataJsonMigrator(data),
  };
  var reader = NoteData(Archive());
  reader = reader.setAsset(kMetaArchiveFile, utf8.encode(jsonEncode(data)));
  for (final palette in data['palettes'] ?? []) {
    reader = reader.setAsset('$kPalettesArchiveDirectory/${palette.name}.json',
        utf8.encode((palette)));
  }
  for (final style in data['styles'] ?? []) {
    reader = reader.setAsset(
        '$kStylesArchiveDirectory/${style.name}.json', utf8.encode((style)));
  }
  for (final component in data['components'] ?? []) {
    reader = reader.setAsset(
        '$kComponentsArchiveDirectory/${component.name}.json',
        utf8.encode((component)));
  }
  for (final page in (data['pages'] as Map<String, dynamic>?)?.entries ??
      <MapEntry<String, dynamic>>[]) {
    reader = reader.setPage(DocumentPage.fromJson(page.value), page.key);
  }
  final packs = (data['packs'] ?? []).map((e) => NoteData.fromData(e)).toList();
  for (final pack in packs) {
    reader = reader.setBundledPack(pack);
  }
  final assets = (data['assets'] as Map<String, dynamic>?)?.entries ??
      <MapEntry<String, dynamic>>[];
  for (final asset in assets) {
    reader = reader.setAsset(asset.key, base64Decode(asset.value));
  }
  final thumbnail = data['thumbnail'] as String?;
  if (thumbnail?.isNotEmpty == true) {
    final data = UriData.parse(thumbnail!).contentAsBytes();
    reader = reader.setThumbnail(data);
  }
  return reader.export();
}

Map<String, dynamic> convertDocumentToText(NoteData data) {
  final output = <String, dynamic>{};
  void addMap(String name, Map list) {
    if (list.isEmpty) return;
    output[name] = list;
  }

  List<T> sorted<T>(Iterable<T> iterable, [String Function(T)? key]) {
    final func = key ?? (T item) => item.toString();
    final list = iterable.toList();
    list.sort((a, b) => func(a).compareTo(func(b)));
    return list;
  }

  List<T> sortedItem<T extends NamedItem>(Iterable<T> iterable) {
    return sorted(iterable, (item) => item.name);
  }

  output.addAll(data.getMetadata()?.toJson() ?? {});
  final assets = <String, String>{};
  for (final asset in sorted(data.getValidAssets())) {
    final bytes = data.getAsset(asset);
    if (bytes == null) continue;
    assets[asset] = base64Encode(bytes);
  }
  addMap('assets', assets);

  final packs = <String, String>{};
  for (final pack in sorted(data.getBundledPacks())) {
    final bytes = data.getBundledPackData(pack);
    if (bytes == null) continue;
    packs[pack] = base64Encode(bytes);
  }
  addMap('packs', packs);

  final palettes = <String, Map<String, dynamic>>{};
  for (final palette in sortedItem(data.getNamedPalettes())) {
    palettes[palette.name] = palette.item.toJson();
  }
  addMap('palettes', palettes);

  final styles = <String, Map<String, dynamic>>{};
  for (final style in sortedItem(data.getNamedStyles())) {
    styles[style.name] = style.item.toJson();
  }
  addMap('styles', styles);

  final components = <String, Map<String, dynamic>>{};
  for (final component in sortedItem(data.getNamedComponents())) {
    components[component.name] = component.item.toJson();
  }
  addMap('components', components);

  final pages = <String, Map<String, dynamic>>{};
  for (final name in sorted(data.getPages(true))) {
    final page = data.getPage(name);
    if (page == null) continue;
    pages[name] = page.toJson();
  }
  addMap('pages', pages);

  final thumbnail = data.getThumbnail();
  if (thumbnail != null) {
    output['thumbnail'] =
        UriData.fromBytes(thumbnail, mimeType: 'image/png').toString();
  }

  return output;
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
  if (fileVersion != null && fileVersion >= 0) {
    if (fileVersion < 4) {
      data['palettes'] = List.from(
          Map<String, dynamic>.from(data['palettes'] ?? [])
              .entries
              .map((e) =>
                  {'colors': List<int>.from(e.value).toList(), 'name': e.key})
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
      data['painters'] = List.from(data['painters'] as List).map((e) {
        if (e['type'] == 'stamp') {
          return {
            ...e,
            'component': null,
          };
        }
        return e;
      }).toList();
      data['pages'] = {
        'default': data['type'] == 'document' ? data : data['document']
      };
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
