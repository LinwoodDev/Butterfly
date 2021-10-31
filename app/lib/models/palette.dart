import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

@immutable
class ColorPalette {
  final String name;
  final List<Color> colors;

  static const materialColors = [
    Colors.white,
    Colors.pink,
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lime,
    Colors.green,
    Colors.teal,
    Colors.cyan,
    Colors.lightBlue,
    Colors.blue,
    Colors.indigo,
    Colors.blueGrey,
    Colors.purple,
    Colors.brown,
    Colors.grey,
    Colors.black
  ];
  static List<ColorPalette> getMaterialPalette(BuildContext context) => [
        ColorPalette(
            name: AppLocalizations.of(context)!.defaultPalette,
            colors: materialColors),
        ColorPalette(
            name: AppLocalizations.of(context)!.highlighter,
            colors: materialColors.map((e) => e.withOpacity(0.5)).toList())
      ];

  const ColorPalette({this.name = '', this.colors = const []});
  ColorPalette.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        colors = List<int>.from(json['colors']).map((e) => Color(e)).toList();
  Map<String, dynamic> toJson() =>
      {'name': name, 'colors': colors.map((e) => e.value).toList()};

  ColorPalette copyWith({String? name, List<Color>? colors}) =>
      ColorPalette(name: name ?? this.name, colors: colors ?? this.colors);
}
