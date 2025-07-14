// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'palette.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ColorPalette {
  String get name;
  @ColorJsonConverter()
  List<SRGBColor> get colors;

  /// Create a copy of ColorPalette
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ColorPaletteCopyWith<ColorPalette> get copyWith =>
      _$ColorPaletteCopyWithImpl<ColorPalette>(
          this as ColorPalette, _$identity);

  /// Serializes this ColorPalette to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ColorPalette &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.colors, colors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(colors));

  @override
  String toString() {
    return 'ColorPalette(name: $name, colors: $colors)';
  }
}

/// @nodoc
abstract mixin class $ColorPaletteCopyWith<$Res> {
  factory $ColorPaletteCopyWith(
          ColorPalette value, $Res Function(ColorPalette) _then) =
      _$ColorPaletteCopyWithImpl;
  @useResult
  $Res call({String name, @ColorJsonConverter() List<SRGBColor> colors});
}

/// @nodoc
class _$ColorPaletteCopyWithImpl<$Res> implements $ColorPaletteCopyWith<$Res> {
  _$ColorPaletteCopyWithImpl(this._self, this._then);

  final ColorPalette _self;
  final $Res Function(ColorPalette) _then;

  /// Create a copy of ColorPalette
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? colors = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      colors: null == colors
          ? _self.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as List<SRGBColor>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ColorPalette implements ColorPalette {
  const _ColorPalette(
      {required this.name,
      @ColorJsonConverter() final List<SRGBColor> colors = const []})
      : _colors = colors;
  factory _ColorPalette.fromJson(Map<String, dynamic> json) =>
      _$ColorPaletteFromJson(json);

  @override
  final String name;
  final List<SRGBColor> _colors;
  @override
  @JsonKey()
  @ColorJsonConverter()
  List<SRGBColor> get colors {
    if (_colors is EqualUnmodifiableListView) return _colors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_colors);
  }

  /// Create a copy of ColorPalette
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ColorPaletteCopyWith<_ColorPalette> get copyWith =>
      __$ColorPaletteCopyWithImpl<_ColorPalette>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ColorPaletteToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ColorPalette &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._colors, _colors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_colors));

  @override
  String toString() {
    return 'ColorPalette(name: $name, colors: $colors)';
  }
}

/// @nodoc
abstract mixin class _$ColorPaletteCopyWith<$Res>
    implements $ColorPaletteCopyWith<$Res> {
  factory _$ColorPaletteCopyWith(
          _ColorPalette value, $Res Function(_ColorPalette) _then) =
      __$ColorPaletteCopyWithImpl;
  @override
  @useResult
  $Res call({String name, @ColorJsonConverter() List<SRGBColor> colors});
}

/// @nodoc
class __$ColorPaletteCopyWithImpl<$Res>
    implements _$ColorPaletteCopyWith<$Res> {
  __$ColorPaletteCopyWithImpl(this._self, this._then);

  final _ColorPalette _self;
  final $Res Function(_ColorPalette) _then;

  /// Create a copy of ColorPalette
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? colors = null,
  }) {
    return _then(_ColorPalette(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      colors: null == colors
          ? _self._colors
          : colors // ignore: cast_nullable_to_non_nullable
              as List<SRGBColor>,
    ));
  }
}

// dart format on
