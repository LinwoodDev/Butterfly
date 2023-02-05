// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'background.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Background _$BackgroundFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'empty':
      return EmptyBackground.fromJson(json);
    case 'box':
      return BoxBackground.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'Background', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$Background {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(
            double boxWidth,
            double boxHeight,
            int boxXCount,
            int boxYCount,
            double boxXSpace,
            double boxYSpace,
            int boxXColor,
            int boxYColor,
            int boxColor,
            double boxXStroke,
            double boxYStroke)
        box,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(
            double boxWidth,
            double boxHeight,
            int boxXCount,
            int boxYCount,
            double boxXSpace,
            double boxYSpace,
            int boxXColor,
            int boxYColor,
            int boxColor,
            double boxXStroke,
            double boxYStroke)?
        box,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(
            double boxWidth,
            double boxHeight,
            int boxXCount,
            int boxYCount,
            double boxXSpace,
            double boxYSpace,
            int boxXColor,
            int boxYColor,
            int boxColor,
            double boxXStroke,
            double boxYStroke)?
        box,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmptyBackground value) empty,
    required TResult Function(BoxBackground value) box,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmptyBackground value)? empty,
    TResult? Function(BoxBackground value)? box,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmptyBackground value)? empty,
    TResult Function(BoxBackground value)? box,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BackgroundCopyWith<$Res> {
  factory $BackgroundCopyWith(
          Background value, $Res Function(Background) then) =
      _$BackgroundCopyWithImpl<$Res, Background>;
}

/// @nodoc
class _$BackgroundCopyWithImpl<$Res, $Val extends Background>
    implements $BackgroundCopyWith<$Res> {
  _$BackgroundCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$EmptyBackgroundCopyWith<$Res> {
  factory _$$EmptyBackgroundCopyWith(
          _$EmptyBackground value, $Res Function(_$EmptyBackground) then) =
      __$$EmptyBackgroundCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EmptyBackgroundCopyWithImpl<$Res>
    extends _$BackgroundCopyWithImpl<$Res, _$EmptyBackground>
    implements _$$EmptyBackgroundCopyWith<$Res> {
  __$$EmptyBackgroundCopyWithImpl(
      _$EmptyBackground _value, $Res Function(_$EmptyBackground) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$EmptyBackground implements EmptyBackground {
  const _$EmptyBackground({final String? $type}) : $type = $type ?? 'empty';

  factory _$EmptyBackground.fromJson(Map<String, dynamic> json) =>
      _$$EmptyBackgroundFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Background.empty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EmptyBackground);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(
            double boxWidth,
            double boxHeight,
            int boxXCount,
            int boxYCount,
            double boxXSpace,
            double boxYSpace,
            int boxXColor,
            int boxYColor,
            int boxColor,
            double boxXStroke,
            double boxYStroke)
        box,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(
            double boxWidth,
            double boxHeight,
            int boxXCount,
            int boxYCount,
            double boxXSpace,
            double boxYSpace,
            int boxXColor,
            int boxYColor,
            int boxColor,
            double boxXStroke,
            double boxYStroke)?
        box,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(
            double boxWidth,
            double boxHeight,
            int boxXCount,
            int boxYCount,
            double boxXSpace,
            double boxYSpace,
            int boxXColor,
            int boxYColor,
            int boxColor,
            double boxXStroke,
            double boxYStroke)?
        box,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmptyBackground value) empty,
    required TResult Function(BoxBackground value) box,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmptyBackground value)? empty,
    TResult? Function(BoxBackground value)? box,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmptyBackground value)? empty,
    TResult Function(BoxBackground value)? box,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EmptyBackgroundToJson(
      this,
    );
  }
}

abstract class EmptyBackground implements Background {
  const factory EmptyBackground() = _$EmptyBackground;

  factory EmptyBackground.fromJson(Map<String, dynamic> json) =
      _$EmptyBackground.fromJson;
}

/// @nodoc
abstract class _$$BoxBackgroundCopyWith<$Res> {
  factory _$$BoxBackgroundCopyWith(
          _$BoxBackground value, $Res Function(_$BoxBackground) then) =
      __$$BoxBackgroundCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {double boxWidth,
      double boxHeight,
      int boxXCount,
      int boxYCount,
      double boxXSpace,
      double boxYSpace,
      int boxXColor,
      int boxYColor,
      int boxColor,
      double boxXStroke,
      double boxYStroke});
}

/// @nodoc
class __$$BoxBackgroundCopyWithImpl<$Res>
    extends _$BackgroundCopyWithImpl<$Res, _$BoxBackground>
    implements _$$BoxBackgroundCopyWith<$Res> {
  __$$BoxBackgroundCopyWithImpl(
      _$BoxBackground _value, $Res Function(_$BoxBackground) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boxWidth = null,
    Object? boxHeight = null,
    Object? boxXCount = null,
    Object? boxYCount = null,
    Object? boxXSpace = null,
    Object? boxYSpace = null,
    Object? boxXColor = null,
    Object? boxYColor = null,
    Object? boxColor = null,
    Object? boxXStroke = null,
    Object? boxYStroke = null,
  }) {
    return _then(_$BoxBackground(
      boxWidth: null == boxWidth
          ? _value.boxWidth
          : boxWidth // ignore: cast_nullable_to_non_nullable
              as double,
      boxHeight: null == boxHeight
          ? _value.boxHeight
          : boxHeight // ignore: cast_nullable_to_non_nullable
              as double,
      boxXCount: null == boxXCount
          ? _value.boxXCount
          : boxXCount // ignore: cast_nullable_to_non_nullable
              as int,
      boxYCount: null == boxYCount
          ? _value.boxYCount
          : boxYCount // ignore: cast_nullable_to_non_nullable
              as int,
      boxXSpace: null == boxXSpace
          ? _value.boxXSpace
          : boxXSpace // ignore: cast_nullable_to_non_nullable
              as double,
      boxYSpace: null == boxYSpace
          ? _value.boxYSpace
          : boxYSpace // ignore: cast_nullable_to_non_nullable
              as double,
      boxXColor: null == boxXColor
          ? _value.boxXColor
          : boxXColor // ignore: cast_nullable_to_non_nullable
              as int,
      boxYColor: null == boxYColor
          ? _value.boxYColor
          : boxYColor // ignore: cast_nullable_to_non_nullable
              as int,
      boxColor: null == boxColor
          ? _value.boxColor
          : boxColor // ignore: cast_nullable_to_non_nullable
              as int,
      boxXStroke: null == boxXStroke
          ? _value.boxXStroke
          : boxXStroke // ignore: cast_nullable_to_non_nullable
              as double,
      boxYStroke: null == boxYStroke
          ? _value.boxYStroke
          : boxYStroke // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BoxBackground implements BoxBackground {
  const _$BoxBackground(
      {this.boxWidth = 0,
      this.boxHeight = 0,
      this.boxXCount = 1,
      this.boxYCount = 1,
      this.boxXSpace = 0,
      this.boxYSpace = 0,
      this.boxXColor = kColorBlue,
      this.boxYColor = kColorRed,
      this.boxColor = kColorWhite,
      this.boxXStroke = 0.5,
      this.boxYStroke = 0.5,
      final String? $type})
      : $type = $type ?? 'box';

  factory _$BoxBackground.fromJson(Map<String, dynamic> json) =>
      _$$BoxBackgroundFromJson(json);

  @override
  @JsonKey()
  final double boxWidth;
  @override
  @JsonKey()
  final double boxHeight;
  @override
  @JsonKey()
  final int boxXCount;
  @override
  @JsonKey()
  final int boxYCount;
  @override
  @JsonKey()
  final double boxXSpace;
  @override
  @JsonKey()
  final double boxYSpace;
  @override
  @JsonKey()
  final int boxXColor;
  @override
  @JsonKey()
  final int boxYColor;
  @override
  @JsonKey()
  final int boxColor;
  @override
  @JsonKey()
  final double boxXStroke;
  @override
  @JsonKey()
  final double boxYStroke;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Background.box(boxWidth: $boxWidth, boxHeight: $boxHeight, boxXCount: $boxXCount, boxYCount: $boxYCount, boxXSpace: $boxXSpace, boxYSpace: $boxYSpace, boxXColor: $boxXColor, boxYColor: $boxYColor, boxColor: $boxColor, boxXStroke: $boxXStroke, boxYStroke: $boxYStroke)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoxBackground &&
            (identical(other.boxWidth, boxWidth) ||
                other.boxWidth == boxWidth) &&
            (identical(other.boxHeight, boxHeight) ||
                other.boxHeight == boxHeight) &&
            (identical(other.boxXCount, boxXCount) ||
                other.boxXCount == boxXCount) &&
            (identical(other.boxYCount, boxYCount) ||
                other.boxYCount == boxYCount) &&
            (identical(other.boxXSpace, boxXSpace) ||
                other.boxXSpace == boxXSpace) &&
            (identical(other.boxYSpace, boxYSpace) ||
                other.boxYSpace == boxYSpace) &&
            (identical(other.boxXColor, boxXColor) ||
                other.boxXColor == boxXColor) &&
            (identical(other.boxYColor, boxYColor) ||
                other.boxYColor == boxYColor) &&
            (identical(other.boxColor, boxColor) ||
                other.boxColor == boxColor) &&
            (identical(other.boxXStroke, boxXStroke) ||
                other.boxXStroke == boxXStroke) &&
            (identical(other.boxYStroke, boxYStroke) ||
                other.boxYStroke == boxYStroke));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      boxWidth,
      boxHeight,
      boxXCount,
      boxYCount,
      boxXSpace,
      boxYSpace,
      boxXColor,
      boxYColor,
      boxColor,
      boxXStroke,
      boxYStroke);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BoxBackgroundCopyWith<_$BoxBackground> get copyWith =>
      __$$BoxBackgroundCopyWithImpl<_$BoxBackground>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(
            double boxWidth,
            double boxHeight,
            int boxXCount,
            int boxYCount,
            double boxXSpace,
            double boxYSpace,
            int boxXColor,
            int boxYColor,
            int boxColor,
            double boxXStroke,
            double boxYStroke)
        box,
  }) {
    return box(boxWidth, boxHeight, boxXCount, boxYCount, boxXSpace, boxYSpace,
        boxXColor, boxYColor, boxColor, boxXStroke, boxYStroke);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(
            double boxWidth,
            double boxHeight,
            int boxXCount,
            int boxYCount,
            double boxXSpace,
            double boxYSpace,
            int boxXColor,
            int boxYColor,
            int boxColor,
            double boxXStroke,
            double boxYStroke)?
        box,
  }) {
    return box?.call(boxWidth, boxHeight, boxXCount, boxYCount, boxXSpace,
        boxYSpace, boxXColor, boxYColor, boxColor, boxXStroke, boxYStroke);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(
            double boxWidth,
            double boxHeight,
            int boxXCount,
            int boxYCount,
            double boxXSpace,
            double boxYSpace,
            int boxXColor,
            int boxYColor,
            int boxColor,
            double boxXStroke,
            double boxYStroke)?
        box,
    required TResult orElse(),
  }) {
    if (box != null) {
      return box(boxWidth, boxHeight, boxXCount, boxYCount, boxXSpace,
          boxYSpace, boxXColor, boxYColor, boxColor, boxXStroke, boxYStroke);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmptyBackground value) empty,
    required TResult Function(BoxBackground value) box,
  }) {
    return box(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmptyBackground value)? empty,
    TResult? Function(BoxBackground value)? box,
  }) {
    return box?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmptyBackground value)? empty,
    TResult Function(BoxBackground value)? box,
    required TResult orElse(),
  }) {
    if (box != null) {
      return box(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BoxBackgroundToJson(
      this,
    );
  }
}

abstract class BoxBackground implements Background {
  const factory BoxBackground(
      {final double boxWidth,
      final double boxHeight,
      final int boxXCount,
      final int boxYCount,
      final double boxXSpace,
      final double boxYSpace,
      final int boxXColor,
      final int boxYColor,
      final int boxColor,
      final double boxXStroke,
      final double boxYStroke}) = _$BoxBackground;

  factory BoxBackground.fromJson(Map<String, dynamic> json) =
      _$BoxBackground.fromJson;

  double get boxWidth;
  double get boxHeight;
  int get boxXCount;
  int get boxYCount;
  double get boxXSpace;
  double get boxYSpace;
  int get boxXColor;
  int get boxYColor;
  int get boxColor;
  double get boxXStroke;
  double get boxYStroke;
  @JsonKey(ignore: true)
  _$$BoxBackgroundCopyWith<_$BoxBackground> get copyWith =>
      throw _privateConstructorUsedError;
}
