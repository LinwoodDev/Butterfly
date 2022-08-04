// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
    TResult Function(EmptyBackground value)? empty,
    TResult Function(BoxBackground value)? box,
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
      _$BackgroundCopyWithImpl<$Res>;
}

/// @nodoc
class _$BackgroundCopyWithImpl<$Res> implements $BackgroundCopyWith<$Res> {
  _$BackgroundCopyWithImpl(this._value, this._then);

  final Background _value;
  // ignore: unused_field
  final $Res Function(Background) _then;
}

/// @nodoc
abstract class _$$EmptyBackgroundCopyWith<$Res> {
  factory _$$EmptyBackgroundCopyWith(
          _$EmptyBackground value, $Res Function(_$EmptyBackground) then) =
      __$$EmptyBackgroundCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EmptyBackgroundCopyWithImpl<$Res>
    extends _$BackgroundCopyWithImpl<$Res>
    implements _$$EmptyBackgroundCopyWith<$Res> {
  __$$EmptyBackgroundCopyWithImpl(
      _$EmptyBackground _value, $Res Function(_$EmptyBackground) _then)
      : super(_value, (v) => _then(v as _$EmptyBackground));

  @override
  _$EmptyBackground get _value => super._value as _$EmptyBackground;
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
    TResult Function(EmptyBackground value)? empty,
    TResult Function(BoxBackground value)? box,
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
class __$$BoxBackgroundCopyWithImpl<$Res> extends _$BackgroundCopyWithImpl<$Res>
    implements _$$BoxBackgroundCopyWith<$Res> {
  __$$BoxBackgroundCopyWithImpl(
      _$BoxBackground _value, $Res Function(_$BoxBackground) _then)
      : super(_value, (v) => _then(v as _$BoxBackground));

  @override
  _$BoxBackground get _value => super._value as _$BoxBackground;

  @override
  $Res call({
    Object? boxWidth = freezed,
    Object? boxHeight = freezed,
    Object? boxXCount = freezed,
    Object? boxYCount = freezed,
    Object? boxXSpace = freezed,
    Object? boxYSpace = freezed,
    Object? boxXColor = freezed,
    Object? boxYColor = freezed,
    Object? boxColor = freezed,
    Object? boxXStroke = freezed,
    Object? boxYStroke = freezed,
  }) {
    return _then(_$BoxBackground(
      boxWidth: boxWidth == freezed
          ? _value.boxWidth
          : boxWidth // ignore: cast_nullable_to_non_nullable
              as double,
      boxHeight: boxHeight == freezed
          ? _value.boxHeight
          : boxHeight // ignore: cast_nullable_to_non_nullable
              as double,
      boxXCount: boxXCount == freezed
          ? _value.boxXCount
          : boxXCount // ignore: cast_nullable_to_non_nullable
              as int,
      boxYCount: boxYCount == freezed
          ? _value.boxYCount
          : boxYCount // ignore: cast_nullable_to_non_nullable
              as int,
      boxXSpace: boxXSpace == freezed
          ? _value.boxXSpace
          : boxXSpace // ignore: cast_nullable_to_non_nullable
              as double,
      boxYSpace: boxYSpace == freezed
          ? _value.boxYSpace
          : boxYSpace // ignore: cast_nullable_to_non_nullable
              as double,
      boxXColor: boxXColor == freezed
          ? _value.boxXColor
          : boxXColor // ignore: cast_nullable_to_non_nullable
              as int,
      boxYColor: boxYColor == freezed
          ? _value.boxYColor
          : boxYColor // ignore: cast_nullable_to_non_nullable
              as int,
      boxColor: boxColor == freezed
          ? _value.boxColor
          : boxColor // ignore: cast_nullable_to_non_nullable
              as int,
      boxXStroke: boxXStroke == freezed
          ? _value.boxXStroke
          : boxXStroke // ignore: cast_nullable_to_non_nullable
              as double,
      boxYStroke: boxYStroke == freezed
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
            const DeepCollectionEquality().equals(other.boxWidth, boxWidth) &&
            const DeepCollectionEquality().equals(other.boxHeight, boxHeight) &&
            const DeepCollectionEquality().equals(other.boxXCount, boxXCount) &&
            const DeepCollectionEquality().equals(other.boxYCount, boxYCount) &&
            const DeepCollectionEquality().equals(other.boxXSpace, boxXSpace) &&
            const DeepCollectionEquality().equals(other.boxYSpace, boxYSpace) &&
            const DeepCollectionEquality().equals(other.boxXColor, boxXColor) &&
            const DeepCollectionEquality().equals(other.boxYColor, boxYColor) &&
            const DeepCollectionEquality().equals(other.boxColor, boxColor) &&
            const DeepCollectionEquality()
                .equals(other.boxXStroke, boxXStroke) &&
            const DeepCollectionEquality()
                .equals(other.boxYStroke, boxYStroke));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(boxWidth),
      const DeepCollectionEquality().hash(boxHeight),
      const DeepCollectionEquality().hash(boxXCount),
      const DeepCollectionEquality().hash(boxYCount),
      const DeepCollectionEquality().hash(boxXSpace),
      const DeepCollectionEquality().hash(boxYSpace),
      const DeepCollectionEquality().hash(boxXColor),
      const DeepCollectionEquality().hash(boxYColor),
      const DeepCollectionEquality().hash(boxColor),
      const DeepCollectionEquality().hash(boxXStroke),
      const DeepCollectionEquality().hash(boxYStroke));

  @JsonKey(ignore: true)
  @override
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
    TResult Function(EmptyBackground value)? empty,
    TResult Function(BoxBackground value)? box,
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
