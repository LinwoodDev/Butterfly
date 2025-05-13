import 'dart:typed_data';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/src/converter/color.dart';
import 'package:dart_leap/dart_leap.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pack.g.dart';
part 'pack.freezed.dart';

@freezed
abstract class PackAsset with _$PackAsset {
  const PackAsset();
}

@freezed
sealed class ColorPalette extends PackAsset with _$ColorPalette {
  const ColorPalette._();

  const factory ColorPalette(
          {@Default([]) @ColorJsonConverter() List<SRGBColor> colors}) =
      _ColorPalette;
  factory ColorPalette.fromJson(Map<String, dynamic> json) =>
      _$ColorPaletteFromJson(json);
}

@freezed
sealed class ButterflyComponent extends PackAsset with _$ButterflyComponent {
  const ButterflyComponent._();

  const factory ButterflyComponent({
    @Uint8ListJsonConverter() Uint8List? thumbnail,
    @Default(<PadElement>[]) List<PadElement> elements,
  }) = _ButterflyComponent;

  factory ButterflyComponent.fromJson(Map<String, dynamic> json) =>
      _$ButterflyComponentFromJson(json);
}

@Freezed(equal: false)
sealed class ButterflyParameter with _$ButterflyParameter {
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

final class PackAssetLocation {
  final String namespace;
  final String key;

  const PackAssetLocation(this.namespace, this.key);
}

@Freezed(genericArgumentFactories: true)
sealed class NamedItem<T extends PackAsset> with _$NamedItem<T> {
  const NamedItem._();

  const factory NamedItem({
    required String name,
    required T item,
  }) = _NamedItem<T>;

  factory NamedItem.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$NamedItemFromJson(json, fromJsonT);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw UnimplementedError(
          'toJson is not implemented for NamedItem<T>. Use NamedItem.fromJson instead.');
}

final class PackItem<T extends PackAsset> implements PackAssetLocation {
  final PackAssetLocation location;
  final NoteData pack;
  final T item;

  const PackItem(this.location, this.pack, this.item);
  PackItem.build(String namespace, String key, this.pack, this.item)
      : location = PackAssetLocation(namespace, key);

  @override
  String get namespace => location.namespace;
  @override
  String get key => location.key;
}
