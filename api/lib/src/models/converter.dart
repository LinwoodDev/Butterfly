import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'document.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'palette.dart';

Map<String, dynamic> noteDataJsonMigrator(Map<String, dynamic> data) {
  final fileVersion = data['fileVersion'] as int?;
  final type = data['type'] as String?;
  data = Map<String, dynamic>.from(data);
  switch (type) {
    case 'template':
      data = _templateJsonMigrator(data, fileVersion);
      break;
    case 'pack':
      data = _packJsonMigrator(data, fileVersion);
      break;
    default:
      data = _documentJsonMigrator(data, fileVersion);
      break;
  }
  return data;
}

Map<String, dynamic> _documentJsonMigrator(
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

Map<String, dynamic> _templateJsonMigrator(
    Map<String, dynamic> data, int? fileVersion) {
  data['document'] = _documentJsonMigrator(
      Map<String, dynamic>.from(data['document']), fileVersion);
  return data;
}

Map<String, dynamic> _packJsonMigrator(
    Map<String, dynamic> data, int? fileVersion) {
  return data;
}

class DocumentJsonConverter extends JsonConverter<AppDocument, Map> {
  const DocumentJsonConverter();

  @override
  AppDocument fromJson(Map json) {
    return AppDocument.fromJson(
        _documentJsonMigrator(Map.from(json), json['fileVersion'] as int?));
  }

  @override
  Map<String, dynamic> toJson(AppDocument object) => object.toJson();
}

class TemplateJsonConverter extends JsonConverter<DocumentTemplate, Map> {
  const TemplateJsonConverter();

  @override
  DocumentTemplate fromJson(Map json) {
    return DocumentTemplate.fromJson(
        _templateJsonMigrator(Map.from(json), json['fileVersion'] as int?));
  }

  @override
  Map<String, dynamic> toJson(DocumentTemplate object) => object.toJson();
}

class PackJsonConverter extends JsonConverter<ButterflyPack, Map> {
  const PackJsonConverter();
  @override
  ButterflyPack fromJson(Map json) {
    return ButterflyPack.fromJson(
        _packJsonMigrator(Map.from(json), json['fileVersion'] as int?));
  }

  @override
  Map<String, dynamic> toJson(ButterflyPack object) => object.toJson();
}

class DoublePointJsonConverter extends JsonConverter<Point<double>, Map> {
  const DoublePointJsonConverter();

  @override
  Point<double> fromJson(Map json) {
    final xJson = json['x'];
    final yJson = json['y'];
    if (xJson is double) {
      if (yJson is double) {
        return Point(xJson, yJson);
      }
    }
    return Point(0, 0);
  }

  @override
  Map toJson(Point<double> object) => {'x': object.x, 'y': object.y};
}

class Uint8ListJsonConverter extends JsonConverter<Uint8List, String> {
  const Uint8ListJsonConverter();

  @override
  Uint8List fromJson(String json) => Uint8List.fromList(base64.decode(json));
  @override
  String toJson(Uint8List object) => base64.encode(object.toList());
}

class DateTimeJsonConverter extends JsonConverter<DateTime, int> {
  const DateTimeJsonConverter();
  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json);
  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}
