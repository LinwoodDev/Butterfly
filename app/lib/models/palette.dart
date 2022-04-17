import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'palette.freezed.dart';
part 'palette.g.dart';

@freezed
class ColorPalette with _$ColorPalette {
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
            colors: materialColors.map((e) => e.value).toList()),
        ColorPalette(
            name: AppLocalizations.of(context)!.highlighter,
            colors:
                materialColors.map((e) => e.withOpacity(0.25).value).toList())
      ];
  const factory ColorPalette(
      {required String name, @Default([]) List<int> colors}) = _ColorPalette;
  factory ColorPalette.fromJson(Map<String, dynamic> json) =>
      _$ColorPaletteFromJson(json);
}
