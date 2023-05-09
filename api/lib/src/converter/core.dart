import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

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
