import 'package:freezed_annotation/freezed_annotation.dart';

import 'colors.dart';

part 'view.freezed.dart';
part 'view.g.dart';

@freezed
sealed class ViewOption with _$ViewOption {
  const factory ViewOption({
    @Default(BasicColors.black) int gridColor,
    @Default(20) double gridXSize,
    @Default(20) double gridYSize,
  }) = _ViewOption;

  factory ViewOption.fromJson(Map<String, dynamic> json) =>
      _$ViewOptionFromJson(json);
}
