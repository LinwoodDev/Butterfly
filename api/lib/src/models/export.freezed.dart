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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$ExportPresetImplCopyWith<$Res>
    implements $ExportPresetCopyWith<$Res> {
  factory _$$ExportPresetImplCopyWith(
          _$ExportPresetImpl value, $Res Function(_$ExportPresetImpl) then) =
      __$$ExportPresetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<AreaPreset> areas});
}

/// @nodoc
class __$$ExportPresetImplCopyWithImpl<$Res>
    extends _$ExportPresetCopyWithImpl<$Res, _$ExportPresetImpl>
    implements _$$ExportPresetImplCopyWith<$Res> {
  __$$ExportPresetImplCopyWithImpl(
      _$ExportPresetImpl _value, $Res Function(_$ExportPresetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? areas = null,
  }) {
    return _then(_$ExportPresetImpl(
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
class _$ExportPresetImpl implements _ExportPreset {
  const _$ExportPresetImpl(
      {this.name = '', final List<AreaPreset> areas = const []})
      : _areas = areas;

  factory _$ExportPresetImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExportPresetImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExportPresetImpl &&
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
  _$$ExportPresetImplCopyWith<_$ExportPresetImpl> get copyWith =>
      __$$ExportPresetImplCopyWithImpl<_$ExportPresetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExportPresetImplToJson(
      this,
    );
  }
}

abstract class _ExportPreset implements ExportPreset {
  const factory _ExportPreset(
      {final String name, final List<AreaPreset> areas}) = _$ExportPresetImpl;

  factory _ExportPreset.fromJson(Map<String, dynamic> json) =
      _$ExportPresetImpl.fromJson;

  @override
  String get name;
  @override
  List<AreaPreset> get areas;
  @override
  @JsonKey(ignore: true)
  _$$ExportPresetImplCopyWith<_$ExportPresetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AreaPreset _$AreaPresetFromJson(Map<String, dynamic> json) {
  return _AreaPreset.fromJson(json);
}

/// @nodoc
mixin _$AreaPreset {
  String get page => throw _privateConstructorUsedError;
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
  $Res call({String page, String name, double quality, Area? area});

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
    Object? page = null,
    Object? name = null,
    Object? quality = null,
    Object? area = freezed,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$AreaPresetImplCopyWith<$Res>
    implements $AreaPresetCopyWith<$Res> {
  factory _$$AreaPresetImplCopyWith(
          _$AreaPresetImpl value, $Res Function(_$AreaPresetImpl) then) =
      __$$AreaPresetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String page, String name, double quality, Area? area});

  @override
  $AreaCopyWith<$Res>? get area;
}

/// @nodoc
class __$$AreaPresetImplCopyWithImpl<$Res>
    extends _$AreaPresetCopyWithImpl<$Res, _$AreaPresetImpl>
    implements _$$AreaPresetImplCopyWith<$Res> {
  __$$AreaPresetImplCopyWithImpl(
      _$AreaPresetImpl _value, $Res Function(_$AreaPresetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? name = null,
    Object? quality = null,
    Object? area = freezed,
  }) {
    return _then(_$AreaPresetImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$AreaPresetImpl implements _AreaPreset {
  const _$AreaPresetImpl(
      {this.page = 'default', this.name = '', this.quality = 1, this.area});

  factory _$AreaPresetImpl.fromJson(Map<String, dynamic> json) =>
      _$$AreaPresetImplFromJson(json);

  @override
  @JsonKey()
  final String page;
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
    return 'AreaPreset(page: $page, name: $name, quality: $quality, area: $area)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreaPresetImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.area, area) || other.area == area));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, page, name, quality, area);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AreaPresetImplCopyWith<_$AreaPresetImpl> get copyWith =>
      __$$AreaPresetImplCopyWithImpl<_$AreaPresetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AreaPresetImplToJson(
      this,
    );
  }
}

abstract class _AreaPreset implements AreaPreset {
  const factory _AreaPreset(
      {final String page,
      final String name,
      final double quality,
      final Area? area}) = _$AreaPresetImpl;

  factory _AreaPreset.fromJson(Map<String, dynamic> json) =
      _$AreaPresetImpl.fromJson;

  @override
  String get page;
  @override
  String get name;
  @override
  double get quality;
  @override
  Area? get area;
  @override
  @JsonKey(ignore: true)
  _$$AreaPresetImplCopyWith<_$AreaPresetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
