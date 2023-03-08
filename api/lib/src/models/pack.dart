import 'package:collection/collection.dart';
 
import 'converter.dart';
import 'element.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'palette.dart';
import 'text.dart';

import 'document.dart';

part 'pack.g.dart';
part 'pack.freezed.dart';

@Freezed(equal: false)
class ButterflyPack with _$ButterflyPack {
  const ButterflyPack._();

  const factory ButterflyPack({
    @Default('') String name,
    @Default('') String description,
    @Default('') String author,
    @Default(<ButterflyComponent>[]) List<ButterflyComponent> components,
    @Default(<TextStyleSheet>[]) List<TextStyleSheet> styles,
    @Default(<ColorPalette>[]) List<ColorPalette> palettes,
    @DateTimeJsonConverter() required DateTime createdAt,
    @DateTimeJsonConverter() required DateTime updatedAt,
  }) = _ButterflyPack;

  factory ButterflyPack.fromJson(Map<String, dynamic> json) =>
      _$ButterflyPackFromJson(json);

  ButterflyComponent? getComponent(String name) {
    return components.firstWhereOrNull((e) => e.name == name);
  }

  TextStyleSheet? getStyle(String name) {
    return styles.firstWhereOrNull((e) => e.name == name);
  }
   ColorPalette? getPalette(String name) {
    return palettes.firstWhereOrNull((e) => e.name == name);
  }
}

@Freezed(equal: false)
class ButterflyComponent with _$ButterflyComponent {
  const factory ButterflyComponent({
    required String name,
    @Default(<PadElement>[]) List<PadElement> elements,
  }) = _ButterflyComponent;

  factory ButterflyComponent.fromJson(Map<String, dynamic> json) =>
      _$ButterflyComponentFromJson(json);
}

@Freezed(equal: false)
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

@freezed
class PackAssetLocation with _$PackAssetLocation {
  const factory PackAssetLocation({
    @Default('') String pack,
    @Default('') String name,
  }) = _PackAssetLocation;

  factory PackAssetLocation.fromJson(Map<String, dynamic> json) =>
      _$PackAssetLocationFromJson(json);
}

extension PackDocumentException on AppDocument {
  ButterflyComponent? getComponent(PackAssetLocation location) {
    return getPack(location.pack)?.getComponent(location.name);
  }

  TextStyleSheet? getStyle(PackAssetLocation location) {
    return getPack(location.pack)?.getStyle(location.name);
  }

  ColorPalette? getPalette(PackAssetLocation location) {
    return getPack(location.pack)?.getPalette(location.name);
  
  }
}
