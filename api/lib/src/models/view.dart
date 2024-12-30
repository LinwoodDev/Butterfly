import 'package:freezed_annotation/freezed_annotation.dart';

part 'view.freezed.dart';
part 'view.g.dart';

@freezed
sealed class ViewOption with _$ViewOption {
  const factory ViewOption() = _ViewOption;

  factory ViewOption.fromJson(Map<String, dynamic> json) =>
      _$ViewOptionFromJson(json);
}
