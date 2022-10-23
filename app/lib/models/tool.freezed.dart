// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tool.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ToolOption _$ToolOptionFromJson(Map<String, dynamic> json) {
  return _ToolOption.fromJson(json);
}

/// @nodoc
mixin _$ToolOption {
  int get gridColor => throw _privateConstructorUsedError;
  double get gridXSize => throw _privateConstructorUsedError;
  double get gridYSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ToolOptionCopyWith<ToolOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToolOptionCopyWith<$Res> {
  factory $ToolOptionCopyWith(
          ToolOption value, $Res Function(ToolOption) then) =
      _$ToolOptionCopyWithImpl<$Res, ToolOption>;
  @useResult
  $Res call({int gridColor, double gridXSize, double gridYSize});
}

/// @nodoc
class _$ToolOptionCopyWithImpl<$Res, $Val extends ToolOption>
    implements $ToolOptionCopyWith<$Res> {
  _$ToolOptionCopyWithImpl(this._value, this._then);

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
abstract class _$$_ToolOptionCopyWith<$Res>
    implements $ToolOptionCopyWith<$Res> {
  factory _$$_ToolOptionCopyWith(
          _$_ToolOption value, $Res Function(_$_ToolOption) then) =
      __$$_ToolOptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int gridColor, double gridXSize, double gridYSize});
}

/// @nodoc
class __$$_ToolOptionCopyWithImpl<$Res>
    extends _$ToolOptionCopyWithImpl<$Res, _$_ToolOption>
    implements _$$_ToolOptionCopyWith<$Res> {
  __$$_ToolOptionCopyWithImpl(
      _$_ToolOption _value, $Res Function(_$_ToolOption) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gridColor = null,
    Object? gridXSize = null,
    Object? gridYSize = null,
  }) {
    return _then(_$_ToolOption(
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
class _$_ToolOption implements _ToolOption {
  const _$_ToolOption(
      {this.gridColor = 0, this.gridXSize = 20, this.gridYSize = 20});

  factory _$_ToolOption.fromJson(Map<String, dynamic> json) =>
      _$$_ToolOptionFromJson(json);

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
    return 'ToolOption(gridColor: $gridColor, gridXSize: $gridXSize, gridYSize: $gridYSize)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ToolOption &&
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
  _$$_ToolOptionCopyWith<_$_ToolOption> get copyWith =>
      __$$_ToolOptionCopyWithImpl<_$_ToolOption>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ToolOptionToJson(
      this,
    );
  }
}

abstract class _ToolOption implements ToolOption {
  const factory _ToolOption(
      {final int gridColor,
      final double gridXSize,
      final double gridYSize}) = _$_ToolOption;

  factory _ToolOption.fromJson(Map<String, dynamic> json) =
      _$_ToolOption.fromJson;

  @override
  int get gridColor;
  @override
  double get gridXSize;
  @override
  double get gridYSize;
  @override
  @JsonKey(ignore: true)
  _$$_ToolOptionCopyWith<_$_ToolOption> get copyWith =>
      throw _privateConstructorUsedError;
}

ToolState _$ToolStateFromJson(Map<String, dynamic> json) {
  return _ToolState.fromJson(json);
}

/// @nodoc
mixin _$ToolState {
  bool get rulerEnabled => throw _privateConstructorUsedError;
  bool get gridEnabled => throw _privateConstructorUsedError;
  @OffsetJsonConverter()
  Offset get rulerPosition => throw _privateConstructorUsedError;
  double get rulerAngle => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ToolStateCopyWith<ToolState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToolStateCopyWith<$Res> {
  factory $ToolStateCopyWith(ToolState value, $Res Function(ToolState) then) =
      _$ToolStateCopyWithImpl<$Res, ToolState>;
  @useResult
  $Res call(
      {bool rulerEnabled,
      bool gridEnabled,
      @OffsetJsonConverter() Offset rulerPosition,
      double rulerAngle});
}

/// @nodoc
class _$ToolStateCopyWithImpl<$Res, $Val extends ToolState>
    implements $ToolStateCopyWith<$Res> {
  _$ToolStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rulerEnabled = null,
    Object? gridEnabled = null,
    Object? rulerPosition = null,
    Object? rulerAngle = null,
  }) {
    return _then(_value.copyWith(
      rulerEnabled: null == rulerEnabled
          ? _value.rulerEnabled
          : rulerEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      gridEnabled: null == gridEnabled
          ? _value.gridEnabled
          : gridEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      rulerPosition: null == rulerPosition
          ? _value.rulerPosition
          : rulerPosition // ignore: cast_nullable_to_non_nullable
              as Offset,
      rulerAngle: null == rulerAngle
          ? _value.rulerAngle
          : rulerAngle // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ToolStateCopyWith<$Res> implements $ToolStateCopyWith<$Res> {
  factory _$$_ToolStateCopyWith(
          _$_ToolState value, $Res Function(_$_ToolState) then) =
      __$$_ToolStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool rulerEnabled,
      bool gridEnabled,
      @OffsetJsonConverter() Offset rulerPosition,
      double rulerAngle});
}

/// @nodoc
class __$$_ToolStateCopyWithImpl<$Res>
    extends _$ToolStateCopyWithImpl<$Res, _$_ToolState>
    implements _$$_ToolStateCopyWith<$Res> {
  __$$_ToolStateCopyWithImpl(
      _$_ToolState _value, $Res Function(_$_ToolState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rulerEnabled = null,
    Object? gridEnabled = null,
    Object? rulerPosition = null,
    Object? rulerAngle = null,
  }) {
    return _then(_$_ToolState(
      rulerEnabled: null == rulerEnabled
          ? _value.rulerEnabled
          : rulerEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      gridEnabled: null == gridEnabled
          ? _value.gridEnabled
          : gridEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      rulerPosition: null == rulerPosition
          ? _value.rulerPosition
          : rulerPosition // ignore: cast_nullable_to_non_nullable
              as Offset,
      rulerAngle: null == rulerAngle
          ? _value.rulerAngle
          : rulerAngle // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ToolState implements _ToolState {
  const _$_ToolState(
      {this.rulerEnabled = false,
      this.gridEnabled = false,
      @OffsetJsonConverter() this.rulerPosition = Offset.zero,
      this.rulerAngle = 0});

  factory _$_ToolState.fromJson(Map<String, dynamic> json) =>
      _$$_ToolStateFromJson(json);

  @override
  @JsonKey()
  final bool rulerEnabled;
  @override
  @JsonKey()
  final bool gridEnabled;
  @override
  @JsonKey()
  @OffsetJsonConverter()
  final Offset rulerPosition;
  @override
  @JsonKey()
  final double rulerAngle;

  @override
  String toString() {
    return 'ToolState(rulerEnabled: $rulerEnabled, gridEnabled: $gridEnabled, rulerPosition: $rulerPosition, rulerAngle: $rulerAngle)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ToolState &&
            (identical(other.rulerEnabled, rulerEnabled) ||
                other.rulerEnabled == rulerEnabled) &&
            (identical(other.gridEnabled, gridEnabled) ||
                other.gridEnabled == gridEnabled) &&
            (identical(other.rulerPosition, rulerPosition) ||
                other.rulerPosition == rulerPosition) &&
            (identical(other.rulerAngle, rulerAngle) ||
                other.rulerAngle == rulerAngle));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, rulerEnabled, gridEnabled, rulerPosition, rulerAngle);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ToolStateCopyWith<_$_ToolState> get copyWith =>
      __$$_ToolStateCopyWithImpl<_$_ToolState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ToolStateToJson(
      this,
    );
  }
}

abstract class _ToolState implements ToolState {
  const factory _ToolState(
      {final bool rulerEnabled,
      final bool gridEnabled,
      @OffsetJsonConverter() final Offset rulerPosition,
      final double rulerAngle}) = _$_ToolState;

  factory _ToolState.fromJson(Map<String, dynamic> json) =
      _$_ToolState.fromJson;

  @override
  bool get rulerEnabled;
  @override
  bool get gridEnabled;
  @override
  @OffsetJsonConverter()
  Offset get rulerPosition;
  @override
  double get rulerAngle;
  @override
  @JsonKey(ignore: true)
  _$$_ToolStateCopyWith<_$_ToolState> get copyWith =>
      throw _privateConstructorUsedError;
}
