// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
  List<AreaPreset> get areas => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExportPresetCopyWith<ExportPreset> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExportPresetCopyWith<$Res> {
  factory $ExportPresetCopyWith(
          ExportPreset value, $Res Function(ExportPreset) then) =
      _$ExportPresetCopyWithImpl<$Res, ExportPreset>;
  @useResult
  $Res call({String name, List<AreaPreset> areas});
}

/// @nodoc
class _$ExportPresetCopyWithImpl<$Res, $Val extends ExportPreset>
    implements $ExportPresetCopyWith<$Res> {
  _$ExportPresetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? areas = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      areas: null == areas
          ? _value.areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<AreaPreset>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExportPresetCopyWith<$Res>
    implements $ExportPresetCopyWith<$Res> {
  factory _$$_ExportPresetCopyWith(
          _$_ExportPreset value, $Res Function(_$_ExportPreset) then) =
      __$$_ExportPresetCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<AreaPreset> areas});
}

/// @nodoc
class __$$_ExportPresetCopyWithImpl<$Res>
    extends _$ExportPresetCopyWithImpl<$Res, _$_ExportPreset>
    implements _$$_ExportPresetCopyWith<$Res> {
  __$$_ExportPresetCopyWithImpl(
      _$_ExportPreset _value, $Res Function(_$_ExportPreset) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? areas = null,
  }) {
    return _then(_$_ExportPreset(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      areas: null == areas
          ? _value._areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<AreaPreset>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExportPreset implements _ExportPreset {
  const _$_ExportPreset(
      {this.name = '', final List<AreaPreset> areas = const []})
      : _areas = areas;

  factory _$_ExportPreset.fromJson(Map<String, dynamic> json) =>
      _$$_ExportPresetFromJson(json);

  @override
  @JsonKey()
  final String name;
  final List<AreaPreset> _areas;
  @override
  @JsonKey()
  List<AreaPreset> get areas {
    if (_areas is EqualUnmodifiableListView) return _areas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  @override
  String toString() {
    return 'ExportPreset(name: $name, areas: $areas)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExportPreset &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._areas, _areas));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_areas));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
      {final String name, final List<AreaPreset> areas}) = _$_ExportPreset;

  factory _ExportPreset.fromJson(Map<String, dynamic> json) =
      _$_ExportPreset.fromJson;

  @override
  String get name;
  @override
  List<AreaPreset> get areas;
  @override
  @JsonKey(ignore: true)
  _$$_ExportPresetCopyWith<_$_ExportPreset> get copyWith =>
      throw _privateConstructorUsedError;
}

AreaPreset _$AreaPresetFromJson(Map<String, dynamic> json) {
  return _AreaPreset.fromJson(json);
}

/// @nodoc
mixin _$AreaPreset {
  String get name => throw _privateConstructorUsedError;
  double get quality => throw _privateConstructorUsedError;
  Area? get area => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AreaPresetCopyWith<AreaPreset> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AreaPresetCopyWith<$Res> {
  factory $AreaPresetCopyWith(
          AreaPreset value, $Res Function(AreaPreset) then) =
      _$AreaPresetCopyWithImpl<$Res, AreaPreset>;
  @useResult
  $Res call({String name, double quality, Area? area});

  $AreaCopyWith<$Res>? get area;
}

/// @nodoc
class _$AreaPresetCopyWithImpl<$Res, $Val extends AreaPreset>
    implements $AreaPresetCopyWith<$Res> {
  _$AreaPresetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? quality = null,
    Object? area = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as double,
      area: freezed == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as Area?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AreaCopyWith<$Res>? get area {
    if (_value.area == null) {
      return null;
    }

    return $AreaCopyWith<$Res>(_value.area!, (value) {
      return _then(_value.copyWith(area: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AreaPresetCopyWith<$Res>
    implements $AreaPresetCopyWith<$Res> {
  factory _$$_AreaPresetCopyWith(
          _$_AreaPreset value, $Res Function(_$_AreaPreset) then) =
      __$$_AreaPresetCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, double quality, Area? area});

  @override
  $AreaCopyWith<$Res>? get area;
}

/// @nodoc
class __$$_AreaPresetCopyWithImpl<$Res>
    extends _$AreaPresetCopyWithImpl<$Res, _$_AreaPreset>
    implements _$$_AreaPresetCopyWith<$Res> {
  __$$_AreaPresetCopyWithImpl(
      _$_AreaPreset _value, $Res Function(_$_AreaPreset) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? quality = null,
    Object? area = freezed,
  }) {
    return _then(_$_AreaPreset(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as double,
      area: freezed == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as Area?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AreaPreset implements _AreaPreset {
  const _$_AreaPreset({this.name = '', this.quality = 1, this.area});

  factory _$_AreaPreset.fromJson(Map<String, dynamic> json) =>
      _$$_AreaPresetFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final double quality;
  @override
  final Area? area;

  @override
  String toString() {
    return 'AreaPreset(name: $name, quality: $quality, area: $area)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AreaPreset &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.area, area) || other.area == area));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, quality, area);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AreaPresetCopyWith<_$_AreaPreset> get copyWith =>
      __$$_AreaPresetCopyWithImpl<_$_AreaPreset>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AreaPresetToJson(
      this,
    );
  }
}

abstract class _AreaPreset implements AreaPreset {
  const factory _AreaPreset(
      {final String name,
      final double quality,
      final Area? area}) = _$_AreaPreset;

  factory _AreaPreset.fromJson(Map<String, dynamic> json) =
      _$_AreaPreset.fromJson;

  @override
  String get name;
  @override
  double get quality;
  @override
  Area? get area;
  @override
  @JsonKey(ignore: true)
  _$$_AreaPresetCopyWith<_$_AreaPreset> get copyWith =>
      throw _privateConstructorUsedError;
}
