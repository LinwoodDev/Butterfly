import 'package:butterfly/models/packs/element.dart';
import 'package:flutter/painting.dart';

class ColorPack extends ElementPack {
  final Map<String, Color> colors;
  ColorPack({
    this.colors = const {},
  });

  ColorPack.fromJson(Map<String, dynamic> json)
      : colors =
            (json['colors'] as Map<String, int>).map((key, value) => MapEntry(key, Color(value))) {
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() =>
      {"colors": colors.map((key, value) => MapEntry(key, value.value))};
}
