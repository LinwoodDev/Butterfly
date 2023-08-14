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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_ViewOptionCopyWith<$Res>
    implements $ViewOptionCopyWith<$Res> {
  factory _$$_ViewOptionCopyWith(
          _$_ViewOption value, $Res Function(_$_ViewOption) then) =
      __$$_ViewOptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int gridColor, double gridXSize, double gridYSize});
}

/// @nodoc
class __$$_ViewOptionCopyWithImpl<$Res>
    extends _$ViewOptionCopyWithImpl<$Res, _$_ViewOption>
    implements _$$_ViewOptionCopyWith<$Res> {
  __$$_ViewOptionCopyWithImpl(
      _$_ViewOption _value, $Res Function(_$_ViewOption) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gridColor = null,
    Object? gridXSize = null,
    Object? gridYSize = null,
  }) {
    return _then(_$_ViewOption(
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
class _$_ViewOption implements _ViewOption {
  const _$_ViewOption(
      {this.gridColor = 0, this.gridXSize = 20, this.gridYSize = 20});

  factory _$_ViewOption.fromJson(Map<String, dynamic> json) =>
      _$$_ViewOptionFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ViewOption &&
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
  _$$_ViewOptionCopyWith<_$_ViewOption> get copyWith =>
      __$$_ViewOptionCopyWithImpl<_$_ViewOption>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ViewOptionToJson(
      this,
    );
  }
}

abstract class _ViewOption implements ViewOption {
  const factory _ViewOption(
      {final int gridColor,
      final double gridXSize,
      final double gridYSize}) = _$_ViewOption;

  factory _ViewOption.fromJson(Map<String, dynamic> json) =
      _$_ViewOption.fromJson;

  @override
  int get gridColor;
  @override
  double get gridXSize;
  @override
  double get gridYSize;
  @override
  @JsonKey(ignore: true)
  _$$_ViewOptionCopyWith<_$_ViewOption> get copyWith =>
      throw _privateConstructorUsedError;
}
