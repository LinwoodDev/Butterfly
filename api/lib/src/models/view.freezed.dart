// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ViewOption _$ViewOptionFromJson(Map<String, dynamic> json) {
  return _ViewOption.fromJson(json);
}

/// @nodoc
mixin _$ViewOption {
  int get gridColor => throw _privateConstructorUsedError;
  double get gridXSize => throw _privateConstructorUsedError;
  double get gridYSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ViewOptionCopyWith<ViewOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViewOptionCopyWith<$Res> {
  factory $ViewOptionCopyWith(
          ViewOption value, $Res Function(ViewOption) then) =
      _$ViewOptionCopyWithImpl<$Res, ViewOption>;
  @useResult
  $Res call({int gridColor, double gridXSize, double gridYSize});
}

/// @nodoc
class _$ViewOptionCopyWithImpl<$Res, $Val extends ViewOption>
    implements $ViewOptionCopyWith<$Res> {
  _$ViewOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gridColor = null,
    Object? gridXSize = null,
    Object? gridYSize = null,
  }) {
    return _then(_value.copyWith(
      gridColor: null == gridColor
          ? _value.gridColor
          : gridColor // ignore: cast_nullable_to_non_nullable
              as int,
      gridXSize: null == gridXSize
          ? _value.gridXSize
          : gridXSize // ignore: cast_nullable_to_non_nullable
              as double,
      gridYSize: null == gridYSize
          ? _value.gridYSize
          : gridYSize // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ViewOptionImplCopyWith<$Res>
    implements $ViewOptionCopyWith<$Res> {
  factory _$$ViewOptionImplCopyWith(
          _$ViewOptionImpl value, $Res Function(_$ViewOptionImpl) then) =
      __$$ViewOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int gridColor, double gridXSize, double gridYSize});
}

/// @nodoc
class __$$ViewOptionImplCopyWithImpl<$Res>
    extends _$ViewOptionCopyWithImpl<$Res, _$ViewOptionImpl>
    implements _$$ViewOptionImplCopyWith<$Res> {
  __$$ViewOptionImplCopyWithImpl(
      _$ViewOptionImpl _value, $Res Function(_$ViewOptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gridColor = null,
    Object? gridXSize = null,
    Object? gridYSize = null,
  }) {
    return _then(_$ViewOptionImpl(
      gridColor: null == gridColor
          ? _value.gridColor
          : gridColor // ignore: cast_nullable_to_non_nullable
              as int,
      gridXSize: null == gridXSize
          ? _value.gridXSize
          : gridXSize // ignore: cast_nullable_to_non_nullable
              as double,
      gridYSize: null == gridYSize
          ? _value.gridYSize
          : gridYSize // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ViewOptionImpl implements _ViewOption {
  const _$ViewOptionImpl(
      {this.gridColor = BasicColors.black,
      this.gridXSize = 20,
      this.gridYSize = 20});

  factory _$ViewOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ViewOptionImplFromJson(json);

  @override
  @JsonKey()
  final int gridColor;
  @override
  @JsonKey()
  final double gridXSize;
  @override
  @JsonKey()
  final double gridYSize;

  @override
  String toString() {
    return 'ViewOption(gridColor: $gridColor, gridXSize: $gridXSize, gridYSize: $gridYSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ViewOptionImpl &&
            (identical(other.gridColor, gridColor) ||
                other.gridColor == gridColor) &&
            (identical(other.gridXSize, gridXSize) ||
                other.gridXSize == gridXSize) &&
            (identical(other.gridYSize, gridYSize) ||
                other.gridYSize == gridYSize));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, gridColor, gridXSize, gridYSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ViewOptionImplCopyWith<_$ViewOptionImpl> get copyWith =>
      __$$ViewOptionImplCopyWithImpl<_$ViewOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ViewOptionImplToJson(
      this,
    );
  }
}

abstract class _ViewOption implements ViewOption {
  const factory _ViewOption(
      {final int gridColor,
      final double gridXSize,
      final double gridYSize}) = _$ViewOptionImpl;

  factory _ViewOption.fromJson(Map<String, dynamic> json) =
      _$ViewOptionImpl.fromJson;

  @override
  int get gridColor;
  @override
  double get gridXSize;
  @override
  double get gridYSize;
  @override
  @JsonKey(ignore: true)
  _$$ViewOptionImplCopyWith<_$ViewOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
