// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'export.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExportPreset _$ExportPresetFromJson(Map<String, dynamic> json) {
  return _ExportPreset.fromJson(json);
}

/// @nodoc
mixin _$ExportPreset {
  String get name => throw _privateConstructorUsedError;
  List<String> get areas => throw _privateConstructorUsedError;
  double get quality => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExportPresetCopyWith<ExportPreset> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExportPresetCopyWith<$Res> {
  factory $ExportPresetCopyWith(
          ExportPreset value, $Res Function(ExportPreset) then) =
      _$ExportPresetCopyWithImpl<$Res>;
  $Res call({String name, List<String> areas, double quality});
}

/// @nodoc
class _$ExportPresetCopyWithImpl<$Res> implements $ExportPresetCopyWith<$Res> {
  _$ExportPresetCopyWithImpl(this._value, this._then);

  final ExportPreset _value;
  // ignore: unused_field
  final $Res Function(ExportPreset) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? areas = freezed,
    Object? quality = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      areas: areas == freezed
          ? _value.areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<String>,
      quality: quality == freezed
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$$_ExportPresetCopyWith<$Res>
    implements $ExportPresetCopyWith<$Res> {
  factory _$$_ExportPresetCopyWith(
          _$_ExportPreset value, $Res Function(_$_ExportPreset) then) =
      __$$_ExportPresetCopyWithImpl<$Res>;
  @override
  $Res call({String name, List<String> areas, double quality});
}

/// @nodoc
class __$$_ExportPresetCopyWithImpl<$Res>
    extends _$ExportPresetCopyWithImpl<$Res>
    implements _$$_ExportPresetCopyWith<$Res> {
  __$$_ExportPresetCopyWithImpl(
      _$_ExportPreset _value, $Res Function(_$_ExportPreset) _then)
      : super(_value, (v) => _then(v as _$_ExportPreset));

  @override
  _$_ExportPreset get _value => super._value as _$_ExportPreset;

  @override
  $Res call({
    Object? name = freezed,
    Object? areas = freezed,
    Object? quality = freezed,
  }) {
    return _then(_$_ExportPreset(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      areas: areas == freezed
          ? _value._areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<String>,
      quality: quality == freezed
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExportPreset implements _ExportPreset {
  const _$_ExportPreset(
      {this.name = '', final List<String> areas = const [], this.quality = 1})
      : _areas = areas;

  factory _$_ExportPreset.fromJson(Map<String, dynamic> json) =>
      _$$_ExportPresetFromJson(json);

  @override
  @JsonKey()
  final String name;
  final List<String> _areas;
  @override
  @JsonKey()
  List<String> get areas {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  @override
  @JsonKey()
  final double quality;

  @override
  String toString() {
    return 'ExportPreset(name: $name, areas: $areas, quality: $quality)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExportPreset &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other._areas, _areas) &&
            const DeepCollectionEquality().equals(other.quality, quality));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(_areas),
      const DeepCollectionEquality().hash(quality));

  @JsonKey(ignore: true)
  @override
  _$$_ExportPresetCopyWith<_$_ExportPreset> get copyWith =>
      __$$_ExportPresetCopyWithImpl<_$_ExportPreset>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExportPresetToJson(
      this,
    );
  }
}

abstract class _ExportPreset implements ExportPreset {
  const factory _ExportPreset(
      {final String name,
      final List<String> areas,
      final double quality}) = _$_ExportPreset;

  factory _ExportPreset.fromJson(Map<String, dynamic> json) =
      _$_ExportPreset.fromJson;

  @override
  String get name;
  @override
  List<String> get areas;
  @override
  double get quality;
  @override
  @JsonKey(ignore: true)
  _$$_ExportPresetCopyWith<_$_ExportPreset> get copyWith =>
      throw _privateConstructorUsedError;
}
