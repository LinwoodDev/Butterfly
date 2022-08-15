import 'package:butterfly/models/element.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pack.g.dart';
part 'pack.freezed.dart';

@freezed
class ButterflyPack with _$ButterflyPack {
  const factory ButterflyPack({
    @Default('') String name,
    @Default(<ButterflyComponent>[]) List<ButterflyComponent> components,
  }) = _ButterflyPack;

  factory ButterflyPack.fromJson(Map<String, dynamic> json) =>
      _$ButterflyPackFromJson(json);
}

@freezed
class ButterflyComponent with _$ButterflyComponent {
  const factory ButterflyComponent({
    required String name,
    @Default(<PadElement>[]) List<PadElement> element,
  }) = _ButterflyComponent;

  factory ButterflyComponent.fromJson(Map<String, dynamic> json) =>
      _$ButterflyComponentFromJson(json);
}

@freezed
class ButterflyParameter with _$ButterflyParameter {
  const factory ButterflyParameter.text({
    required int child,
    required String name,
    required String value,
  }) = TextParameter;

  const factory ButterflyParameter.color({
    required int child,
    required String name,
    required int value,
  }) = ColorParameter;

  const factory ButterflyParameter.bool({
    required int child,
    required String name,
    required bool value,
  }) = BoolParameter;

  const factory ButterflyParameter.int({
    required int child,
    required String name,
    required int value,
  }) = IntParameter;

  const factory ButterflyParameter.double({
    required int child,
    required String name,
    required double value,
  }) = DoubleParameter;

  factory ButterflyParameter.fromJson(Map<String, dynamic> json) =>
      _$ButterflyParameterFromJson(json);
}
