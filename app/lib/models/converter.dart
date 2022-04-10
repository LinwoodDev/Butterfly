import 'dart:convert';
import 'dart:typed_data';

import 'package:butterfly/models/document.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../main.dart';
import 'palette.dart';

class DocumentJsonConverter
    extends JsonConverter<AppDocument, Map<String, dynamic>> {
  const DocumentJsonConverter();

  @override
  AppDocument fromJson(Map<String, dynamic> json) {
    final fileVersion = json['fileVersion'] as int?;
    if (fileVersion != null && fileVersion >= 0) {
      if (fileVersion < 4) {
        json['palettes'] = List.from(
            Map<String, dynamic>.from(json['palettes'] ?? [])
                .entries
                .map<ColorPalette>((e) => ColorPalette(
                    colors: List<int>.from(e.value).toList(), name: e.key))
                .map((e) => e.toJson())
                .toList());
      }
      if (fileVersion < 5) {
        json['painters'] = List.from(json['painters']).map((e) {
          var map = Map<String, dynamic>.from(e);
          if (map['type'] == 'path-eraser') {
            map['type'] = 'pathEraser';
          }
          return map;
        });
      }
    }
    return const DocumentJsonConverter().fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(AppDocument object) {
    return {'version': kFileVersion}..addAll(object.toJson());
  }
}

class OffsetJsonConverter extends JsonConverter<Offset, Map<String, dynamic>> {
  const OffsetJsonConverter();

  @override
  Offset fromJson(Map<String, dynamic> json) =>
      Offset(json['x'] ?? 0, json['y'] ?? 0);

  @override
  Map<String, dynamic> toJson(Offset object) =>
      {'x': object.dx, 'y': object.dy};
}

class Uint8ListJsonConverter extends JsonConverter<Uint8List, String> {
  const Uint8ListJsonConverter();

  @override
  Uint8List fromJson(String json) => Uint8List.fromList(base64.decode(json));
  @override
  String toJson(Uint8List object) => base64.encode(object.toList());
}
