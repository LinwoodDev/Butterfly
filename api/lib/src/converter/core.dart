import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

class const DoublePointJsonConverter()
    extends JsonConverter<Point<double>, Map> {
  @override
  Point<double> fromJson(Map json) {
    final xJson = json['x'];
    final yJson = json['y'];
    if (xJson is double) {
      if (yJson is double) {
        return .new(xJson, yJson);
      }
    }
    return .new(0, 0);
  }

  @override
  Map toJson(Point<double> object) => {'x': object.x, 'y': object.y};
}

class const Uint8ListJsonConverter() extends JsonConverter<Uint8List, String> {
  @override
  Uint8List fromJson(String json) => .fromList(base64.decode(json));
  @override
  String toJson(Uint8List object) => base64.encode(object.toList());
}

class const DateTimeJsonConverter() extends JsonConverter<DateTime, int> {
  @override
  DateTime fromJson(int json) => .fromMillisecondsSinceEpoch(json);
  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}
