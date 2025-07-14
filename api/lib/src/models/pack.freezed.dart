// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pack.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ButterflyComponent {
  String get name;
  String? get thumbnail;
  List<PadElement> get elements;

  /// Create a copy of ButterflyComponent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ButterflyComponentCopyWith<ButterflyComponent> get copyWith =>
      _$ButterflyComponentCopyWithImpl<ButterflyComponent>(
          this as ButterflyComponent, _$identity);

  /// Serializes this ButterflyComponent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'ButterflyComponent(name: $name, thumbnail: $thumbnail, elements: $elements)';
  }
}

/// @nodoc
abstract mixin class $ButterflyComponentCopyWith<$Res> {
  factory $ButterflyComponentCopyWith(
          ButterflyComponent value, $Res Function(ButterflyComponent) _then) =
      _$ButterflyComponentCopyWithImpl;
  @useResult
  $Res call({String name, String? thumbnail, List<PadElement> elements});
}

/// @nodoc
class _$ButterflyComponentCopyWithImpl<$Res>
    implements $ButterflyComponentCopyWith<$Res> {
  _$ButterflyComponentCopyWithImpl(this._self, this._then);

  final ButterflyComponent _self;
  final $Res Function(ButterflyComponent) _then;

  /// Create a copy of ButterflyComponent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? thumbnail = freezed,
    Object? elements = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: freezed == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      elements: null == elements
          ? _self.elements
          : elements // ignore: cast_nullable_to_non_nullable
              as List<PadElement>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ButterflyComponent implements ButterflyComponent {
  const _ButterflyComponent(
      {required this.name,
      this.thumbnail,
      final List<PadElement> elements = const <PadElement>[]})
      : _elements = elements;
  factory _ButterflyComponent.fromJson(Map<String, dynamic> json) =>
      _$ButterflyComponentFromJson(json);

  @override
  final String name;
  @override
  final String? thumbnail;
  final List<PadElement> _elements;
  @override
  @JsonKey()
  List<PadElement> get elements {
    if (_elements is EqualUnmodifiableListView) return _elements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_elements);
  }

  /// Create a copy of ButterflyComponent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ButterflyComponentCopyWith<_ButterflyComponent> get copyWith =>
      __$ButterflyComponentCopyWithImpl<_ButterflyComponent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ButterflyComponentToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'ButterflyComponent(name: $name, thumbnail: $thumbnail, elements: $elements)';
  }
}

/// @nodoc
abstract mixin class _$ButterflyComponentCopyWith<$Res>
    implements $ButterflyComponentCopyWith<$Res> {
  factory _$ButterflyComponentCopyWith(
          _ButterflyComponent value, $Res Function(_ButterflyComponent) _then) =
      __$ButterflyComponentCopyWithImpl;
  @override
  @useResult
  $Res call({String name, String? thumbnail, List<PadElement> elements});
}

/// @nodoc
class __$ButterflyComponentCopyWithImpl<$Res>
    implements _$ButterflyComponentCopyWith<$Res> {
  __$ButterflyComponentCopyWithImpl(this._self, this._then);

  final _ButterflyComponent _self;
  final $Res Function(_ButterflyComponent) _then;

  /// Create a copy of ButterflyComponent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? thumbnail = freezed,
    Object? elements = null,
  }) {
    return _then(_ButterflyComponent(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: freezed == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      elements: null == elements
          ? _self._elements
          : elements // ignore: cast_nullable_to_non_nullable
              as List<PadElement>,
    ));
  }
}

ButterflyParameter _$ButterflyParameterFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'text':
      return TextParameter.fromJson(json);
    case 'color':
      return ColorParameter.fromJson(json);
    case 'bool':
      return BoolParameter.fromJson(json);
    case 'int':
      return IntParameter.fromJson(json);
    case 'double':
      return DoubleParameter.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'ButterflyParameter',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$ButterflyParameter {
  int get child;
  String get name;
  Object get value;

  /// Create a copy of ButterflyParameter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ButterflyParameterCopyWith<ButterflyParameter> get copyWith =>
      _$ButterflyParameterCopyWithImpl<ButterflyParameter>(
          this as ButterflyParameter, _$identity);

  /// Serializes this ButterflyParameter to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'ButterflyParameter(child: $child, name: $name, value: $value)';
  }
}

/// @nodoc
abstract mixin class $ButterflyParameterCopyWith<$Res> {
  factory $ButterflyParameterCopyWith(
          ButterflyParameter value, $Res Function(ButterflyParameter) _then) =
      _$ButterflyParameterCopyWithImpl;
  @useResult
  $Res call({int child, String name});
}

/// @nodoc
class _$ButterflyParameterCopyWithImpl<$Res>
    implements $ButterflyParameterCopyWith<$Res> {
  _$ButterflyParameterCopyWithImpl(this._self, this._then);

  final ButterflyParameter _self;
  final $Res Function(ButterflyParameter) _then;

  /// Create a copy of ButterflyParameter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? child = null,
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class TextParameter implements ButterflyParameter {
  const TextParameter(
      {required this.child,
      required this.name,
      required this.value,
      final String? $type})
      : $type = $type ?? 'text';
  factory TextParameter.fromJson(Map<String, dynamic> json) =>
      _$TextParameterFromJson(json);

  @override
  final int child;
  @override
  final String name;
  @override
  final String value;

  @JsonKey(name: 'type')
  final String $type;

  /// Create a copy of ButterflyParameter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TextParameterCopyWith<TextParameter> get copyWith =>
      _$TextParameterCopyWithImpl<TextParameter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TextParameterToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'ButterflyParameter.text(child: $child, name: $name, value: $value)';
  }
}

/// @nodoc
abstract mixin class $TextParameterCopyWith<$Res>
    implements $ButterflyParameterCopyWith<$Res> {
  factory $TextParameterCopyWith(
          TextParameter value, $Res Function(TextParameter) _then) =
      _$TextParameterCopyWithImpl;
  @override
  @useResult
  $Res call({int child, String name, String value});
}

/// @nodoc
class _$TextParameterCopyWithImpl<$Res>
    implements $TextParameterCopyWith<$Res> {
  _$TextParameterCopyWithImpl(this._self, this._then);

  final TextParameter _self;
  final $Res Function(TextParameter) _then;

  /// Create a copy of ButterflyParameter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? child = null,
    Object? name = null,
    Object? value = null,
  }) {
    return _then(TextParameter(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class ColorParameter implements ButterflyParameter {
  const ColorParameter(
      {required this.child,
      required this.name,
      required this.value,
      final String? $type})
      : $type = $type ?? 'color';
  factory ColorParameter.fromJson(Map<String, dynamic> json) =>
      _$ColorParameterFromJson(json);

  @override
  final int child;
  @override
  final String name;
  @override
  final int value;

  @JsonKey(name: 'type')
  final String $type;

  /// Create a copy of ButterflyParameter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ColorParameterCopyWith<ColorParameter> get copyWith =>
      _$ColorParameterCopyWithImpl<ColorParameter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ColorParameterToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'ButterflyParameter.color(child: $child, name: $name, value: $value)';
  }
}

/// @nodoc
abstract mixin class $ColorParameterCopyWith<$Res>
    implements $ButterflyParameterCopyWith<$Res> {
  factory $ColorParameterCopyWith(
          ColorParameter value, $Res Function(ColorParameter) _then) =
      _$ColorParameterCopyWithImpl;
  @override
  @useResult
  $Res call({int child, String name, int value});
}

/// @nodoc
class _$ColorParameterCopyWithImpl<$Res>
    implements $ColorParameterCopyWith<$Res> {
  _$ColorParameterCopyWithImpl(this._self, this._then);

  final ColorParameter _self;
  final $Res Function(ColorParameter) _then;

  /// Create a copy of ButterflyParameter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? child = null,
    Object? name = null,
    Object? value = null,
  }) {
    return _then(ColorParameter(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class BoolParameter implements ButterflyParameter {
  const BoolParameter(
      {required this.child,
      required this.name,
      required this.value,
      final String? $type})
      : $type = $type ?? 'bool';
  factory BoolParameter.fromJson(Map<String, dynamic> json) =>
      _$BoolParameterFromJson(json);

  @override
  final int child;
  @override
  final String name;
  @override
  final bool value;

  @JsonKey(name: 'type')
  final String $type;

  /// Create a copy of ButterflyParameter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BoolParameterCopyWith<BoolParameter> get copyWith =>
      _$BoolParameterCopyWithImpl<BoolParameter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BoolParameterToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'ButterflyParameter.bool(child: $child, name: $name, value: $value)';
  }
}

/// @nodoc
abstract mixin class $BoolParameterCopyWith<$Res>
    implements $ButterflyParameterCopyWith<$Res> {
  factory $BoolParameterCopyWith(
          BoolParameter value, $Res Function(BoolParameter) _then) =
      _$BoolParameterCopyWithImpl;
  @override
  @useResult
  $Res call({int child, String name, bool value});
}

/// @nodoc
class _$BoolParameterCopyWithImpl<$Res>
    implements $BoolParameterCopyWith<$Res> {
  _$BoolParameterCopyWithImpl(this._self, this._then);

  final BoolParameter _self;
  final $Res Function(BoolParameter) _then;

  /// Create a copy of ButterflyParameter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? child = null,
    Object? name = null,
    Object? value = null,
  }) {
    return _then(BoolParameter(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class IntParameter implements ButterflyParameter {
  const IntParameter(
      {required this.child,
      required this.name,
      required this.value,
      final String? $type})
      : $type = $type ?? 'int';
  factory IntParameter.fromJson(Map<String, dynamic> json) =>
      _$IntParameterFromJson(json);

  @override
  final int child;
  @override
  final String name;
  @override
  final int value;

  @JsonKey(name: 'type')
  final String $type;

  /// Create a copy of ButterflyParameter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IntParameterCopyWith<IntParameter> get copyWith =>
      _$IntParameterCopyWithImpl<IntParameter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$IntParameterToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'ButterflyParameter.int(child: $child, name: $name, value: $value)';
  }
}

/// @nodoc
abstract mixin class $IntParameterCopyWith<$Res>
    implements $ButterflyParameterCopyWith<$Res> {
  factory $IntParameterCopyWith(
          IntParameter value, $Res Function(IntParameter) _then) =
      _$IntParameterCopyWithImpl;
  @override
  @useResult
  $Res call({int child, String name, int value});
}

/// @nodoc
class _$IntParameterCopyWithImpl<$Res> implements $IntParameterCopyWith<$Res> {
  _$IntParameterCopyWithImpl(this._self, this._then);

  final IntParameter _self;
  final $Res Function(IntParameter) _then;

  /// Create a copy of ButterflyParameter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? child = null,
    Object? name = null,
    Object? value = null,
  }) {
    return _then(IntParameter(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class DoubleParameter implements ButterflyParameter {
  const DoubleParameter(
      {required this.child,
      required this.name,
      required this.value,
      final String? $type})
      : $type = $type ?? 'double';
  factory DoubleParameter.fromJson(Map<String, dynamic> json) =>
      _$DoubleParameterFromJson(json);

  @override
  final int child;
  @override
  final String name;
  @override
  final double value;

  @JsonKey(name: 'type')
  final String $type;

  /// Create a copy of ButterflyParameter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DoubleParameterCopyWith<DoubleParameter> get copyWith =>
      _$DoubleParameterCopyWithImpl<DoubleParameter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DoubleParameterToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'ButterflyParameter.double(child: $child, name: $name, value: $value)';
  }
}

/// @nodoc
abstract mixin class $DoubleParameterCopyWith<$Res>
    implements $ButterflyParameterCopyWith<$Res> {
  factory $DoubleParameterCopyWith(
          DoubleParameter value, $Res Function(DoubleParameter) _then) =
      _$DoubleParameterCopyWithImpl;
  @override
  @useResult
  $Res call({int child, String name, double value});
}

/// @nodoc
class _$DoubleParameterCopyWithImpl<$Res>
    implements $DoubleParameterCopyWith<$Res> {
  _$DoubleParameterCopyWithImpl(this._self, this._then);

  final DoubleParameter _self;
  final $Res Function(DoubleParameter) _then;

  /// Create a copy of ButterflyParameter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? child = null,
    Object? name = null,
    Object? value = null,
  }) {
    return _then(DoubleParameter(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$PackAssetLocation {
  String get pack;
  String get name;

  /// Create a copy of PackAssetLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PackAssetLocationCopyWith<PackAssetLocation> get copyWith =>
      _$PackAssetLocationCopyWithImpl<PackAssetLocation>(
          this as PackAssetLocation, _$identity);

  /// Serializes this PackAssetLocation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PackAssetLocation &&
            (identical(other.pack, pack) || other.pack == pack) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, pack, name);

  @override
  String toString() {
    return 'PackAssetLocation(pack: $pack, name: $name)';
  }
}

/// @nodoc
abstract mixin class $PackAssetLocationCopyWith<$Res> {
  factory $PackAssetLocationCopyWith(
          PackAssetLocation value, $Res Function(PackAssetLocation) _then) =
      _$PackAssetLocationCopyWithImpl;
  @useResult
  $Res call({String pack, String name});
}

/// @nodoc
class _$PackAssetLocationCopyWithImpl<$Res>
    implements $PackAssetLocationCopyWith<$Res> {
  _$PackAssetLocationCopyWithImpl(this._self, this._then);

  final PackAssetLocation _self;
  final $Res Function(PackAssetLocation) _then;

  /// Create a copy of PackAssetLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pack = null,
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      pack: null == pack
          ? _self.pack
          : pack // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PackAssetLocation extends PackAssetLocation {
  const _PackAssetLocation([this.pack = '', this.name = '']) : super._();
  factory _PackAssetLocation.fromJson(Map<String, dynamic> json) =>
      _$PackAssetLocationFromJson(json);

  @override
  @JsonKey()
  final String pack;
  @override
  @JsonKey()
  final String name;

  /// Create a copy of PackAssetLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PackAssetLocationCopyWith<_PackAssetLocation> get copyWith =>
      __$PackAssetLocationCopyWithImpl<_PackAssetLocation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PackAssetLocationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PackAssetLocation &&
            (identical(other.pack, pack) || other.pack == pack) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, pack, name);

  @override
  String toString() {
    return 'PackAssetLocation(pack: $pack, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$PackAssetLocationCopyWith<$Res>
    implements $PackAssetLocationCopyWith<$Res> {
  factory _$PackAssetLocationCopyWith(
          _PackAssetLocation value, $Res Function(_PackAssetLocation) _then) =
      __$PackAssetLocationCopyWithImpl;
  @override
  @useResult
  $Res call({String pack, String name});
}

/// @nodoc
class __$PackAssetLocationCopyWithImpl<$Res>
    implements _$PackAssetLocationCopyWith<$Res> {
  __$PackAssetLocationCopyWithImpl(this._self, this._then);

  final _PackAssetLocation _self;
  final $Res Function(_PackAssetLocation) _then;

  /// Create a copy of PackAssetLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? pack = null,
    Object? name = null,
  }) {
    return _then(_PackAssetLocation(
      null == pack
          ? _self.pack
          : pack // ignore: cast_nullable_to_non_nullable
              as String,
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
