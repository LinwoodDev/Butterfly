import 'package:freezed_annotation/freezed_annotation.dart';

part 'view.freezed.dart';
part 'view.g.dart';

@freezed
@JsonSerializable()
final class ViewOption with _$ViewOption {
  const ViewOption();

  factory ViewOption.fromJson(Map<String, dynamic> json) =>
      _$ViewOptionFromJson(json);

  Map<String, Object?> toJson() => _$ViewOptionToJson(this);
}
