// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'element.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ElementConstraint _$ElementConstraintFromJson(Map<String, dynamic> json) {
  return _ElementConstraint.fromJson(json);
}

/// @nodoc
mixin _$ElementConstraint {
  double get size => throw _privateConstructorUsedError;
  double get length => throw _privateConstructorUsedError;
  bool get includeArea => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ElementConstraintCopyWith<ElementConstraint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElementConstraintCopyWith<$Res> {
  factory $ElementConstraintCopyWith(
          ElementConstraint value, $Res Function(ElementConstraint) then) =
      _$ElementConstraintCopyWithImpl<$Res, ElementConstraint>;
  @useResult
  $Res call({double size, double length, bool includeArea});
}

/// @nodoc
class _$ElementConstraintCopyWithImpl<$Res, $Val extends ElementConstraint>
    implements $ElementConstraintCopyWith<$Res> {
  _$ElementConstraintCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? size = null,
    Object? length = null,
    Object? includeArea = null,
  }) {
    return _then(_value.copyWith(
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as double,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as double,
      includeArea: null == includeArea
          ? _value.includeArea
          : includeArea // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ElementConstraintCopyWith<$Res>
    implements $ElementConstraintCopyWith<$Res> {
  factory _$$_ElementConstraintCopyWith(_$_ElementConstraint value,
          $Res Function(_$_ElementConstraint) then) =
      __$$_ElementConstraintCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double size, double length, bool includeArea});
}

/// @nodoc
class __$$_ElementConstraintCopyWithImpl<$Res>
    extends _$ElementConstraintCopyWithImpl<$Res, _$_ElementConstraint>
    implements _$$_ElementConstraintCopyWith<$Res> {
  __$$_ElementConstraintCopyWithImpl(
      _$_ElementConstraint _value, $Res Function(_$_ElementConstraint) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? size = null,
    Object? length = null,
    Object? includeArea = null,
  }) {
    return _then(_$_ElementConstraint(
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as double,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as double,
      includeArea: null == includeArea
          ? _value.includeArea
          : includeArea // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ElementConstraint implements _ElementConstraint {
  const _$_ElementConstraint(
      {this.size = 0, this.length = 0, this.includeArea = true});

  factory _$_ElementConstraint.fromJson(Map<String, dynamic> json) =>
      _$$_ElementConstraintFromJson(json);

  @override
  @JsonKey()
  final double size;
  @override
  @JsonKey()
  final double length;
  @override
  @JsonKey()
  final bool includeArea;

  @override
  String toString() {
    return 'ElementConstraint(size: $size, length: $length, includeArea: $includeArea)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ElementConstraint &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.length, length) || other.length == length) &&
            (identical(other.includeArea, includeArea) ||
                other.includeArea == includeArea));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, size, length, includeArea);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ElementConstraintCopyWith<_$_ElementConstraint> get copyWith =>
      __$$_ElementConstraintCopyWithImpl<_$_ElementConstraint>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ElementConstraintToJson(
      this,
    );
  }
}

abstract class _ElementConstraint implements ElementConstraint {
  const factory _ElementConstraint(
      {final double size,
      final double length,
      final bool includeArea}) = _$_ElementConstraint;

  factory _ElementConstraint.fromJson(Map<String, dynamic> json) =
      _$_ElementConstraint.fromJson;

  @override
  double get size;
  @override
  double get length;
  @override
  bool get includeArea;
  @override
  @JsonKey(ignore: true)
  _$$_ElementConstraintCopyWith<_$_ElementConstraint> get copyWith =>
      throw _privateConstructorUsedError;
}

ElementConstraints _$ElementConstraintsFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'scaled':
      return ScaledElementConstraints.fromJson(json);
    case 'fixed':
      return FixedElementConstraints.fromJson(json);
    case 'dynamic':
      return DynamicElementConstraints.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'ElementConstraints',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$ElementConstraints {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double scaleX, double scaleY) scaled,
    required TResult Function(double height, double width) fixed,
    required TResult Function(
            double height, double width, double aspectRatio, bool includeArea)
        dynamic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double scaleX, double scaleY)? scaled,
    TResult? Function(double height, double width)? fixed,
    TResult? Function(
            double height, double width, double aspectRatio, bool includeArea)?
        dynamic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double scaleX, double scaleY)? scaled,
    TResult Function(double height, double width)? fixed,
    TResult Function(
            double height, double width, double aspectRatio, bool includeArea)?
        dynamic,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScaledElementConstraints value) scaled,
    required TResult Function(FixedElementConstraints value) fixed,
    required TResult Function(DynamicElementConstraints value) dynamic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScaledElementConstraints value)? scaled,
    TResult? Function(FixedElementConstraints value)? fixed,
    TResult? Function(DynamicElementConstraints value)? dynamic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScaledElementConstraints value)? scaled,
    TResult Function(FixedElementConstraints value)? fixed,
    TResult Function(DynamicElementConstraints value)? dynamic,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElementConstraintsCopyWith<$Res> {
  factory $ElementConstraintsCopyWith(
          ElementConstraints value, $Res Function(ElementConstraints) then) =
      _$ElementConstraintsCopyWithImpl<$Res, ElementConstraints>;
}

/// @nodoc
class _$ElementConstraintsCopyWithImpl<$Res, $Val extends ElementConstraints>
    implements $ElementConstraintsCopyWith<$Res> {
  _$ElementConstraintsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ScaledElementConstraintsCopyWith<$Res> {
  factory _$$ScaledElementConstraintsCopyWith(_$ScaledElementConstraints value,
          $Res Function(_$ScaledElementConstraints) then) =
      __$$ScaledElementConstraintsCopyWithImpl<$Res>;
  @useResult
  $Res call({double scaleX, double scaleY});
}

/// @nodoc
class __$$ScaledElementConstraintsCopyWithImpl<$Res>
    extends _$ElementConstraintsCopyWithImpl<$Res, _$ScaledElementConstraints>
    implements _$$ScaledElementConstraintsCopyWith<$Res> {
  __$$ScaledElementConstraintsCopyWithImpl(_$ScaledElementConstraints _value,
      $Res Function(_$ScaledElementConstraints) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scaleX = null,
    Object? scaleY = null,
  }) {
    return _then(_$ScaledElementConstraints(
      scaleX: null == scaleX
          ? _value.scaleX
          : scaleX // ignore: cast_nullable_to_non_nullable
              as double,
      scaleY: null == scaleY
          ? _value.scaleY
          : scaleY // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScaledElementConstraints implements ScaledElementConstraints {
  const _$ScaledElementConstraints(
      {this.scaleX = 1, this.scaleY = 1, final String? $type})
      : $type = $type ?? 'scaled';

  factory _$ScaledElementConstraints.fromJson(Map<String, dynamic> json) =>
      _$$ScaledElementConstraintsFromJson(json);

  @override
  @JsonKey()
  final double scaleX;
  @override
  @JsonKey()
  final double scaleY;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ElementConstraints.scaled(scaleX: $scaleX, scaleY: $scaleY)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScaledElementConstraints &&
            (identical(other.scaleX, scaleX) || other.scaleX == scaleX) &&
            (identical(other.scaleY, scaleY) || other.scaleY == scaleY));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, scaleX, scaleY);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScaledElementConstraintsCopyWith<_$ScaledElementConstraints>
      get copyWith =>
          __$$ScaledElementConstraintsCopyWithImpl<_$ScaledElementConstraints>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double scaleX, double scaleY) scaled,
    required TResult Function(double height, double width) fixed,
    required TResult Function(
            double height, double width, double aspectRatio, bool includeArea)
        dynamic,
  }) {
    return scaled(scaleX, scaleY);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double scaleX, double scaleY)? scaled,
    TResult? Function(double height, double width)? fixed,
    TResult? Function(
            double height, double width, double aspectRatio, bool includeArea)?
        dynamic,
  }) {
    return scaled?.call(scaleX, scaleY);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double scaleX, double scaleY)? scaled,
    TResult Function(double height, double width)? fixed,
    TResult Function(
            double height, double width, double aspectRatio, bool includeArea)?
        dynamic,
    required TResult orElse(),
  }) {
    if (scaled != null) {
      return scaled(scaleX, scaleY);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScaledElementConstraints value) scaled,
    required TResult Function(FixedElementConstraints value) fixed,
    required TResult Function(DynamicElementConstraints value) dynamic,
  }) {
    return scaled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScaledElementConstraints value)? scaled,
    TResult? Function(FixedElementConstraints value)? fixed,
    TResult? Function(DynamicElementConstraints value)? dynamic,
  }) {
    return scaled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScaledElementConstraints value)? scaled,
    TResult Function(FixedElementConstraints value)? fixed,
    TResult Function(DynamicElementConstraints value)? dynamic,
    required TResult orElse(),
  }) {
    if (scaled != null) {
      return scaled(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ScaledElementConstraintsToJson(
      this,
    );
  }
}

abstract class ScaledElementConstraints implements ElementConstraints {
  const factory ScaledElementConstraints(
      {final double scaleX, final double scaleY}) = _$ScaledElementConstraints;

  factory ScaledElementConstraints.fromJson(Map<String, dynamic> json) =
      _$ScaledElementConstraints.fromJson;

  double get scaleX;
  double get scaleY;
  @JsonKey(ignore: true)
  _$$ScaledElementConstraintsCopyWith<_$ScaledElementConstraints>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FixedElementConstraintsCopyWith<$Res> {
  factory _$$FixedElementConstraintsCopyWith(_$FixedElementConstraints value,
          $Res Function(_$FixedElementConstraints) then) =
      __$$FixedElementConstraintsCopyWithImpl<$Res>;
  @useResult
  $Res call({double height, double width});
}

/// @nodoc
class __$$FixedElementConstraintsCopyWithImpl<$Res>
    extends _$ElementConstraintsCopyWithImpl<$Res, _$FixedElementConstraints>
    implements _$$FixedElementConstraintsCopyWith<$Res> {
  __$$FixedElementConstraintsCopyWithImpl(_$FixedElementConstraints _value,
      $Res Function(_$FixedElementConstraints) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? height = null,
    Object? width = null,
  }) {
    return _then(_$FixedElementConstraints(
      null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FixedElementConstraints implements FixedElementConstraints {
  const _$FixedElementConstraints(this.height, this.width,
      {final String? $type})
      : $type = $type ?? 'fixed';

  factory _$FixedElementConstraints.fromJson(Map<String, dynamic> json) =>
      _$$FixedElementConstraintsFromJson(json);

  @override
  final double height;
  @override
  final double width;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ElementConstraints.fixed(height: $height, width: $width)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FixedElementConstraints &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.width, width) || other.width == width));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, height, width);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FixedElementConstraintsCopyWith<_$FixedElementConstraints> get copyWith =>
      __$$FixedElementConstraintsCopyWithImpl<_$FixedElementConstraints>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double scaleX, double scaleY) scaled,
    required TResult Function(double height, double width) fixed,
    required TResult Function(
            double height, double width, double aspectRatio, bool includeArea)
        dynamic,
  }) {
    return fixed(height, width);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double scaleX, double scaleY)? scaled,
    TResult? Function(double height, double width)? fixed,
    TResult? Function(
            double height, double width, double aspectRatio, bool includeArea)?
        dynamic,
  }) {
    return fixed?.call(height, width);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double scaleX, double scaleY)? scaled,
    TResult Function(double height, double width)? fixed,
    TResult Function(
            double height, double width, double aspectRatio, bool includeArea)?
        dynamic,
    required TResult orElse(),
  }) {
    if (fixed != null) {
      return fixed(height, width);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScaledElementConstraints value) scaled,
    required TResult Function(FixedElementConstraints value) fixed,
    required TResult Function(DynamicElementConstraints value) dynamic,
  }) {
    return fixed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScaledElementConstraints value)? scaled,
    TResult? Function(FixedElementConstraints value)? fixed,
    TResult? Function(DynamicElementConstraints value)? dynamic,
  }) {
    return fixed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScaledElementConstraints value)? scaled,
    TResult Function(FixedElementConstraints value)? fixed,
    TResult Function(DynamicElementConstraints value)? dynamic,
    required TResult orElse(),
  }) {
    if (fixed != null) {
      return fixed(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FixedElementConstraintsToJson(
      this,
    );
  }
}

abstract class FixedElementConstraints implements ElementConstraints {
  const factory FixedElementConstraints(
      final double height, final double width) = _$FixedElementConstraints;

  factory FixedElementConstraints.fromJson(Map<String, dynamic> json) =
      _$FixedElementConstraints.fromJson;

  double get height;
  double get width;
  @JsonKey(ignore: true)
  _$$FixedElementConstraintsCopyWith<_$FixedElementConstraints> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DynamicElementConstraintsCopyWith<$Res> {
  factory _$$DynamicElementConstraintsCopyWith(
          _$DynamicElementConstraints value,
          $Res Function(_$DynamicElementConstraints) then) =
      __$$DynamicElementConstraintsCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {double height, double width, double aspectRatio, bool includeArea});
}

/// @nodoc
class __$$DynamicElementConstraintsCopyWithImpl<$Res>
    extends _$ElementConstraintsCopyWithImpl<$Res, _$DynamicElementConstraints>
    implements _$$DynamicElementConstraintsCopyWith<$Res> {
  __$$DynamicElementConstraintsCopyWithImpl(_$DynamicElementConstraints _value,
      $Res Function(_$DynamicElementConstraints) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? height = null,
    Object? width = null,
    Object? aspectRatio = null,
    Object? includeArea = null,
  }) {
    return _then(_$DynamicElementConstraints(
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      aspectRatio: null == aspectRatio
          ? _value.aspectRatio
          : aspectRatio // ignore: cast_nullable_to_non_nullable
              as double,
      includeArea: null == includeArea
          ? _value.includeArea
          : includeArea // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DynamicElementConstraints implements DynamicElementConstraints {
  const _$DynamicElementConstraints(
      {this.height = 0,
      this.width = 0,
      this.aspectRatio = 0,
      this.includeArea = true,
      final String? $type})
      : $type = $type ?? 'dynamic';

  factory _$DynamicElementConstraints.fromJson(Map<String, dynamic> json) =>
      _$$DynamicElementConstraintsFromJson(json);

  @override
  @JsonKey()
  final double height;
  @override
  @JsonKey()
  final double width;
  @override
  @JsonKey()
  final double aspectRatio;
  @override
  @JsonKey()
  final bool includeArea;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ElementConstraints.dynamic(height: $height, width: $width, aspectRatio: $aspectRatio, includeArea: $includeArea)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DynamicElementConstraints &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.aspectRatio, aspectRatio) ||
                other.aspectRatio == aspectRatio) &&
            (identical(other.includeArea, includeArea) ||
                other.includeArea == includeArea));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, height, width, aspectRatio, includeArea);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DynamicElementConstraintsCopyWith<_$DynamicElementConstraints>
      get copyWith => __$$DynamicElementConstraintsCopyWithImpl<
          _$DynamicElementConstraints>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double scaleX, double scaleY) scaled,
    required TResult Function(double height, double width) fixed,
    required TResult Function(
            double height, double width, double aspectRatio, bool includeArea)
        dynamic,
  }) {
    return dynamic(height, width, aspectRatio, includeArea);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double scaleX, double scaleY)? scaled,
    TResult? Function(double height, double width)? fixed,
    TResult? Function(
            double height, double width, double aspectRatio, bool includeArea)?
        dynamic,
  }) {
    return dynamic?.call(height, width, aspectRatio, includeArea);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double scaleX, double scaleY)? scaled,
    TResult Function(double height, double width)? fixed,
    TResult Function(
            double height, double width, double aspectRatio, bool includeArea)?
        dynamic,
    required TResult orElse(),
  }) {
    if (dynamic != null) {
      return dynamic(height, width, aspectRatio, includeArea);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScaledElementConstraints value) scaled,
    required TResult Function(FixedElementConstraints value) fixed,
    required TResult Function(DynamicElementConstraints value) dynamic,
  }) {
    return dynamic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScaledElementConstraints value)? scaled,
    TResult? Function(FixedElementConstraints value)? fixed,
    TResult? Function(DynamicElementConstraints value)? dynamic,
  }) {
    return dynamic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScaledElementConstraints value)? scaled,
    TResult Function(FixedElementConstraints value)? fixed,
    TResult Function(DynamicElementConstraints value)? dynamic,
    required TResult orElse(),
  }) {
    if (dynamic != null) {
      return dynamic(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DynamicElementConstraintsToJson(
      this,
    );
  }
}

abstract class DynamicElementConstraints implements ElementConstraints {
  const factory DynamicElementConstraints(
      {final double height,
      final double width,
      final double aspectRatio,
      final bool includeArea}) = _$DynamicElementConstraints;

  factory DynamicElementConstraints.fromJson(Map<String, dynamic> json) =
      _$DynamicElementConstraints.fromJson;

  double get height;
  double get width;
  double get aspectRatio;
  bool get includeArea;
  @JsonKey(ignore: true)
  _$$DynamicElementConstraintsCopyWith<_$DynamicElementConstraints>
      get copyWith => throw _privateConstructorUsedError;
}

PadElement _$PadElementFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'pen':
      return PenElement.fromJson(json);
    case 'text':
      return TextElement.fromJson(json);
    case 'markdown':
      return MarkdownElement.fromJson(json);
    case 'image':
      return ImageElement.fromJson(json);
    case 'svg':
      return SvgElement.fromJson(json);
    case 'shape':
      return ShapeElement.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'PadElement', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$PadElement {
  String get layer => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String layer, double? zoom,
            List<PathPoint> points, PenProperty property)
        pen,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)
        text,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)
        markdown,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)
        image,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)
        svg,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)
        shape,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String layer, double? zoom, List<PathPoint> points,
            PenProperty property)?
        pen,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)?
        text,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)?
        markdown,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        image,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        svg,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)?
        shape,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String layer, double? zoom, List<PathPoint> points,
            PenProperty property)?
        pen,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)?
        text,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)?
        markdown,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        image,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        svg,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)?
        shape,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PenElement value) pen,
    required TResult Function(TextElement value) text,
    required TResult Function(MarkdownElement value) markdown,
    required TResult Function(ImageElement value) image,
    required TResult Function(SvgElement value) svg,
    required TResult Function(ShapeElement value) shape,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PenElement value)? pen,
    TResult? Function(TextElement value)? text,
    TResult? Function(MarkdownElement value)? markdown,
    TResult? Function(ImageElement value)? image,
    TResult? Function(SvgElement value)? svg,
    TResult? Function(ShapeElement value)? shape,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PenElement value)? pen,
    TResult Function(TextElement value)? text,
    TResult Function(MarkdownElement value)? markdown,
    TResult Function(ImageElement value)? image,
    TResult Function(SvgElement value)? svg,
    TResult Function(ShapeElement value)? shape,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PadElementCopyWith<PadElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PadElementCopyWith<$Res> {
  factory $PadElementCopyWith(
          PadElement value, $Res Function(PadElement) then) =
      _$PadElementCopyWithImpl<$Res, PadElement>;
  @useResult
  $Res call({String layer});
}

/// @nodoc
class _$PadElementCopyWithImpl<$Res, $Val extends PadElement>
    implements $PadElementCopyWith<$Res> {
  _$PadElementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? layer = null,
  }) {
    return _then(_value.copyWith(
      layer: null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PenElementCopyWith<$Res>
    implements $PadElementCopyWith<$Res> {
  factory _$$PenElementCopyWith(
          _$PenElement value, $Res Function(_$PenElement) then) =
      __$$PenElementCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String layer,
      double? zoom,
      List<PathPoint> points,
      PenProperty property});
}

/// @nodoc
class __$$PenElementCopyWithImpl<$Res>
    extends _$PadElementCopyWithImpl<$Res, _$PenElement>
    implements _$$PenElementCopyWith<$Res> {
  __$$PenElementCopyWithImpl(
      _$PenElement _value, $Res Function(_$PenElement) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? layer = null,
    Object? zoom = freezed,
    Object? points = null,
    Object? property = freezed,
  }) {
    return _then(_$PenElement(
      layer: null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      zoom: freezed == zoom
          ? _value.zoom
          : zoom // ignore: cast_nullable_to_non_nullable
              as double?,
      points: null == points
          ? _value._points
          : points // ignore: cast_nullable_to_non_nullable
              as List<PathPoint>,
      property: freezed == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as PenProperty,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PenElement implements PenElement {
  const _$PenElement(
      {this.layer = '',
      this.zoom,
      final List<PathPoint> points = const [],
      this.property = const PenProperty(),
      final String? $type})
      : _points = points,
        $type = $type ?? 'pen';

  factory _$PenElement.fromJson(Map<String, dynamic> json) =>
      _$$PenElementFromJson(json);

  @override
  @JsonKey()
  final String layer;
  @override
  final double? zoom;
  final List<PathPoint> _points;
  @override
  @JsonKey()
  List<PathPoint> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  @override
  @JsonKey()
  final PenProperty property;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadElement.pen(layer: $layer, zoom: $zoom, points: $points, property: $property)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PenElementCopyWith<_$PenElement> get copyWith =>
      __$$PenElementCopyWithImpl<_$PenElement>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String layer, double? zoom,
            List<PathPoint> points, PenProperty property)
        pen,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)
        text,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)
        markdown,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)
        image,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)
        svg,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)
        shape,
  }) {
    return pen(layer, zoom, points, property);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String layer, double? zoom, List<PathPoint> points,
            PenProperty property)?
        pen,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)?
        text,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)?
        markdown,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        image,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        svg,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)?
        shape,
  }) {
    return pen?.call(layer, zoom, points, property);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String layer, double? zoom, List<PathPoint> points,
            PenProperty property)?
        pen,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)?
        text,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)?
        markdown,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        image,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        svg,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)?
        shape,
    required TResult orElse(),
  }) {
    if (pen != null) {
      return pen(layer, zoom, points, property);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PenElement value) pen,
    required TResult Function(TextElement value) text,
    required TResult Function(MarkdownElement value) markdown,
    required TResult Function(ImageElement value) image,
    required TResult Function(SvgElement value) svg,
    required TResult Function(ShapeElement value) shape,
  }) {
    return pen(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PenElement value)? pen,
    TResult? Function(TextElement value)? text,
    TResult? Function(MarkdownElement value)? markdown,
    TResult? Function(ImageElement value)? image,
    TResult? Function(SvgElement value)? svg,
    TResult? Function(ShapeElement value)? shape,
  }) {
    return pen?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PenElement value)? pen,
    TResult Function(TextElement value)? text,
    TResult Function(MarkdownElement value)? markdown,
    TResult Function(ImageElement value)? image,
    TResult Function(SvgElement value)? svg,
    TResult Function(ShapeElement value)? shape,
    required TResult orElse(),
  }) {
    if (pen != null) {
      return pen(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PenElementToJson(
      this,
    );
  }
}

abstract class PenElement implements PadElement, PathElement {
  const factory PenElement(
      {final String layer,
      final double? zoom,
      final List<PathPoint> points,
      final PenProperty property}) = _$PenElement;

  factory PenElement.fromJson(Map<String, dynamic> json) =
      _$PenElement.fromJson;

  @override
  String get layer;
  double? get zoom;
  List<PathPoint> get points;
  PenProperty get property;
  @override
  @JsonKey(ignore: true)
  _$$PenElementCopyWith<_$PenElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TextElementCopyWith<$Res>
    implements $PadElementCopyWith<$Res> {
  factory _$$TextElementCopyWith(
          _$TextElement value, $Res Function(_$TextElement) then) =
      __$$TextElementCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String layer,
      @DoublePointJsonConverter() Point<double> position,
      double scale,
      PackAssetLocation styleSheet,
      TextArea area,
      ElementConstraint constraint});

  $PackAssetLocationCopyWith<$Res> get styleSheet;
  $TextAreaCopyWith<$Res> get area;
  $ElementConstraintCopyWith<$Res> get constraint;
}

/// @nodoc
class __$$TextElementCopyWithImpl<$Res>
    extends _$PadElementCopyWithImpl<$Res, _$TextElement>
    implements _$$TextElementCopyWith<$Res> {
  __$$TextElementCopyWithImpl(
      _$TextElement _value, $Res Function(_$TextElement) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? layer = null,
    Object? position = null,
    Object? scale = null,
    Object? styleSheet = null,
    Object? area = null,
    Object? constraint = null,
  }) {
    return _then(_$TextElement(
      layer: null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Point<double>,
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
      styleSheet: null == styleSheet
          ? _value.styleSheet
          : styleSheet // ignore: cast_nullable_to_non_nullable
              as PackAssetLocation,
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as TextArea,
      constraint: null == constraint
          ? _value.constraint
          : constraint // ignore: cast_nullable_to_non_nullable
              as ElementConstraint,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $PackAssetLocationCopyWith<$Res> get styleSheet {
    return $PackAssetLocationCopyWith<$Res>(_value.styleSheet, (value) {
      return _then(_value.copyWith(styleSheet: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TextAreaCopyWith<$Res> get area {
    return $TextAreaCopyWith<$Res>(_value.area, (value) {
      return _then(_value.copyWith(area: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ElementConstraintCopyWith<$Res> get constraint {
    return $ElementConstraintCopyWith<$Res>(_value.constraint, (value) {
      return _then(_value.copyWith(constraint: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$TextElement implements TextElement {
  const _$TextElement(
      {this.layer = '',
      @DoublePointJsonConverter() this.position = const Point(0.0, 0.0),
      this.scale = 1.0,
      this.styleSheet = const PackAssetLocation(),
      required this.area,
      this.constraint = const ElementConstraint(size: 1000),
      final String? $type})
      : $type = $type ?? 'text';

  factory _$TextElement.fromJson(Map<String, dynamic> json) =>
      _$$TextElementFromJson(json);

  @override
  @JsonKey()
  final String layer;
  @override
  @JsonKey()
  @DoublePointJsonConverter()
  final Point<double> position;
  @override
  @JsonKey()
  final double scale;
  @override
  @JsonKey()
  final PackAssetLocation styleSheet;
  @override
  final TextArea area;
  @override
  @JsonKey()
  final ElementConstraint constraint;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadElement.text(layer: $layer, position: $position, scale: $scale, styleSheet: $styleSheet, area: $area, constraint: $constraint)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TextElementCopyWith<_$TextElement> get copyWith =>
      __$$TextElementCopyWithImpl<_$TextElement>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String layer, double? zoom,
            List<PathPoint> points, PenProperty property)
        pen,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)
        text,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)
        markdown,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)
        image,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)
        svg,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)
        shape,
  }) {
    return text(layer, position, scale, styleSheet, area, constraint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String layer, double? zoom, List<PathPoint> points,
            PenProperty property)?
        pen,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)?
        text,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)?
        markdown,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        image,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        svg,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)?
        shape,
  }) {
    return text?.call(layer, position, scale, styleSheet, area, constraint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String layer, double? zoom, List<PathPoint> points,
            PenProperty property)?
        pen,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)?
        text,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)?
        markdown,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        image,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        svg,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)?
        shape,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(layer, position, scale, styleSheet, area, constraint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PenElement value) pen,
    required TResult Function(TextElement value) text,
    required TResult Function(MarkdownElement value) markdown,
    required TResult Function(ImageElement value) image,
    required TResult Function(SvgElement value) svg,
    required TResult Function(ShapeElement value) shape,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PenElement value)? pen,
    TResult? Function(TextElement value)? text,
    TResult? Function(MarkdownElement value)? markdown,
    TResult? Function(ImageElement value)? image,
    TResult? Function(SvgElement value)? svg,
    TResult? Function(ShapeElement value)? shape,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PenElement value)? pen,
    TResult Function(TextElement value)? text,
    TResult Function(MarkdownElement value)? markdown,
    TResult Function(ImageElement value)? image,
    TResult Function(SvgElement value)? svg,
    TResult Function(ShapeElement value)? shape,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TextElementToJson(
      this,
    );
  }
}

abstract class TextElement implements PadElement, LabelElement {
  const factory TextElement(
      {final String layer,
      @DoublePointJsonConverter() final Point<double> position,
      final double scale,
      final PackAssetLocation styleSheet,
      required final TextArea area,
      final ElementConstraint constraint}) = _$TextElement;

  factory TextElement.fromJson(Map<String, dynamic> json) =
      _$TextElement.fromJson;

  @override
  String get layer;
  @DoublePointJsonConverter()
  Point<double> get position;
  double get scale;
  PackAssetLocation get styleSheet;
  TextArea get area;
  ElementConstraint get constraint;
  @override
  @JsonKey(ignore: true)
  _$$TextElementCopyWith<_$TextElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarkdownElementCopyWith<$Res>
    implements $PadElementCopyWith<$Res> {
  factory _$$MarkdownElementCopyWith(
          _$MarkdownElement value, $Res Function(_$MarkdownElement) then) =
      __$$MarkdownElementCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String layer,
      @DoublePointJsonConverter() Point<double> position,
      double scale,
      PackAssetLocation styleSheet,
      AreaProperty areaProperty,
      String text,
      ElementConstraint constraint});

  $PackAssetLocationCopyWith<$Res> get styleSheet;
  $AreaPropertyCopyWith<$Res> get areaProperty;
  $ElementConstraintCopyWith<$Res> get constraint;
}

/// @nodoc
class __$$MarkdownElementCopyWithImpl<$Res>
    extends _$PadElementCopyWithImpl<$Res, _$MarkdownElement>
    implements _$$MarkdownElementCopyWith<$Res> {
  __$$MarkdownElementCopyWithImpl(
      _$MarkdownElement _value, $Res Function(_$MarkdownElement) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? layer = null,
    Object? position = null,
    Object? scale = null,
    Object? styleSheet = null,
    Object? areaProperty = null,
    Object? text = null,
    Object? constraint = null,
  }) {
    return _then(_$MarkdownElement(
      layer: null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Point<double>,
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
      styleSheet: null == styleSheet
          ? _value.styleSheet
          : styleSheet // ignore: cast_nullable_to_non_nullable
              as PackAssetLocation,
      areaProperty: null == areaProperty
          ? _value.areaProperty
          : areaProperty // ignore: cast_nullable_to_non_nullable
              as AreaProperty,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      constraint: null == constraint
          ? _value.constraint
          : constraint // ignore: cast_nullable_to_non_nullable
              as ElementConstraint,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $PackAssetLocationCopyWith<$Res> get styleSheet {
    return $PackAssetLocationCopyWith<$Res>(_value.styleSheet, (value) {
      return _then(_value.copyWith(styleSheet: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AreaPropertyCopyWith<$Res> get areaProperty {
    return $AreaPropertyCopyWith<$Res>(_value.areaProperty, (value) {
      return _then(_value.copyWith(areaProperty: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ElementConstraintCopyWith<$Res> get constraint {
    return $ElementConstraintCopyWith<$Res>(_value.constraint, (value) {
      return _then(_value.copyWith(constraint: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$MarkdownElement implements MarkdownElement {
  const _$MarkdownElement(
      {this.layer = '',
      @DoublePointJsonConverter() this.position = const Point(0.0, 0.0),
      this.scale = 1.0,
      this.styleSheet = const PackAssetLocation(),
      this.areaProperty = const AreaProperty(),
      required this.text,
      this.constraint = const ElementConstraint(size: 1000),
      final String? $type})
      : $type = $type ?? 'markdown';

  factory _$MarkdownElement.fromJson(Map<String, dynamic> json) =>
      _$$MarkdownElementFromJson(json);

  @override
  @JsonKey()
  final String layer;
  @override
  @JsonKey()
  @DoublePointJsonConverter()
  final Point<double> position;
  @override
  @JsonKey()
  final double scale;
  @override
  @JsonKey()
  final PackAssetLocation styleSheet;
  @override
  @JsonKey()
  final AreaProperty areaProperty;
  @override
  final String text;
  @override
  @JsonKey()
  final ElementConstraint constraint;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadElement.markdown(layer: $layer, position: $position, scale: $scale, styleSheet: $styleSheet, areaProperty: $areaProperty, text: $text, constraint: $constraint)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkdownElementCopyWith<_$MarkdownElement> get copyWith =>
      __$$MarkdownElementCopyWithImpl<_$MarkdownElement>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String layer, double? zoom,
            List<PathPoint> points, PenProperty property)
        pen,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)
        text,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)
        markdown,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)
        image,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)
        svg,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)
        shape,
  }) {
    return markdown(layer, position, scale, styleSheet, areaProperty, this.text,
        constraint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String layer, double? zoom, List<PathPoint> points,
            PenProperty property)?
        pen,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)?
        text,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)?
        markdown,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        image,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        svg,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)?
        shape,
  }) {
    return markdown?.call(layer, position, scale, styleSheet, areaProperty,
        this.text, constraint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String layer, double? zoom, List<PathPoint> points,
            PenProperty property)?
        pen,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)?
        text,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)?
        markdown,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        image,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        svg,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)?
        shape,
    required TResult orElse(),
  }) {
    if (markdown != null) {
      return markdown(layer, position, scale, styleSheet, areaProperty,
          this.text, constraint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PenElement value) pen,
    required TResult Function(TextElement value) text,
    required TResult Function(MarkdownElement value) markdown,
    required TResult Function(ImageElement value) image,
    required TResult Function(SvgElement value) svg,
    required TResult Function(ShapeElement value) shape,
  }) {
    return markdown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PenElement value)? pen,
    TResult? Function(TextElement value)? text,
    TResult? Function(MarkdownElement value)? markdown,
    TResult? Function(ImageElement value)? image,
    TResult? Function(SvgElement value)? svg,
    TResult? Function(ShapeElement value)? shape,
  }) {
    return markdown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PenElement value)? pen,
    TResult Function(TextElement value)? text,
    TResult Function(MarkdownElement value)? markdown,
    TResult Function(ImageElement value)? image,
    TResult Function(SvgElement value)? svg,
    TResult Function(ShapeElement value)? shape,
    required TResult orElse(),
  }) {
    if (markdown != null) {
      return markdown(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MarkdownElementToJson(
      this,
    );
  }
}

abstract class MarkdownElement implements PadElement, LabelElement {
  const factory MarkdownElement(
      {final String layer,
      @DoublePointJsonConverter() final Point<double> position,
      final double scale,
      final PackAssetLocation styleSheet,
      final AreaProperty areaProperty,
      required final String text,
      final ElementConstraint constraint}) = _$MarkdownElement;

  factory MarkdownElement.fromJson(Map<String, dynamic> json) =
      _$MarkdownElement.fromJson;

  @override
  String get layer;
  @DoublePointJsonConverter()
  Point<double> get position;
  double get scale;
  PackAssetLocation get styleSheet;
  AreaProperty get areaProperty;
  String get text;
  ElementConstraint get constraint;
  @override
  @JsonKey(ignore: true)
  _$$MarkdownElementCopyWith<_$MarkdownElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ImageElementCopyWith<$Res>
    implements $PadElementCopyWith<$Res> {
  factory _$$ImageElementCopyWith(
          _$ImageElement value, $Res Function(_$ImageElement) then) =
      __$$ImageElementCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String layer,
      @DoublePointJsonConverter() Point<double> position,
      ElementConstraints? constraints,
      String source,
      double width,
      double height});

  $ElementConstraintsCopyWith<$Res>? get constraints;
}

/// @nodoc
class __$$ImageElementCopyWithImpl<$Res>
    extends _$PadElementCopyWithImpl<$Res, _$ImageElement>
    implements _$$ImageElementCopyWith<$Res> {
  __$$ImageElementCopyWithImpl(
      _$ImageElement _value, $Res Function(_$ImageElement) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? layer = null,
    Object? position = null,
    Object? constraints = freezed,
    Object? source = null,
    Object? width = null,
    Object? height = null,
  }) {
    return _then(_$ImageElement(
      layer: null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Point<double>,
      constraints: freezed == constraints
          ? _value.constraints
          : constraints // ignore: cast_nullable_to_non_nullable
              as ElementConstraints?,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ElementConstraintsCopyWith<$Res>? get constraints {
    if (_value.constraints == null) {
      return null;
    }

    return $ElementConstraintsCopyWith<$Res>(_value.constraints!, (value) {
      return _then(_value.copyWith(constraints: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageElement implements ImageElement {
  const _$ImageElement(
      {this.layer = '',
      @DoublePointJsonConverter() this.position = const Point(0.0, 0.0),
      this.constraints = const ScaledElementConstraints(scaleX: 1, scaleY: 1),
      required this.source,
      required this.width,
      required this.height,
      final String? $type})
      : $type = $type ?? 'image';

  factory _$ImageElement.fromJson(Map<String, dynamic> json) =>
      _$$ImageElementFromJson(json);

  @override
  @JsonKey()
  final String layer;
  @override
  @JsonKey()
  @DoublePointJsonConverter()
  final Point<double> position;
  @override
  @JsonKey()
  final ElementConstraints? constraints;
  @override
  final String source;
  @override
  final double width;
  @override
  final double height;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadElement.image(layer: $layer, position: $position, constraints: $constraints, source: $source, width: $width, height: $height)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageElementCopyWith<_$ImageElement> get copyWith =>
      __$$ImageElementCopyWithImpl<_$ImageElement>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String layer, double? zoom,
            List<PathPoint> points, PenProperty property)
        pen,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)
        text,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)
        markdown,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)
        image,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)
        svg,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)
        shape,
  }) {
    return image(layer, position, constraints, source, width, height);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String layer, double? zoom, List<PathPoint> points,
            PenProperty property)?
        pen,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)?
        text,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)?
        markdown,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        image,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        svg,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)?
        shape,
  }) {
    return image?.call(layer, position, constraints, source, width, height);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String layer, double? zoom, List<PathPoint> points,
            PenProperty property)?
        pen,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)?
        text,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)?
        markdown,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        image,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        svg,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)?
        shape,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(layer, position, constraints, source, width, height);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PenElement value) pen,
    required TResult Function(TextElement value) text,
    required TResult Function(MarkdownElement value) markdown,
    required TResult Function(ImageElement value) image,
    required TResult Function(SvgElement value) svg,
    required TResult Function(ShapeElement value) shape,
  }) {
    return image(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PenElement value)? pen,
    TResult? Function(TextElement value)? text,
    TResult? Function(MarkdownElement value)? markdown,
    TResult? Function(ImageElement value)? image,
    TResult? Function(SvgElement value)? svg,
    TResult? Function(ShapeElement value)? shape,
  }) {
    return image?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PenElement value)? pen,
    TResult Function(TextElement value)? text,
    TResult Function(MarkdownElement value)? markdown,
    TResult Function(ImageElement value)? image,
    TResult Function(SvgElement value)? svg,
    TResult Function(ShapeElement value)? shape,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageElementToJson(
      this,
    );
  }
}

abstract class ImageElement implements PadElement, SourcedElement {
  const factory ImageElement(
      {final String layer,
      @DoublePointJsonConverter() final Point<double> position,
      final ElementConstraints? constraints,
      required final String source,
      required final double width,
      required final double height}) = _$ImageElement;

  factory ImageElement.fromJson(Map<String, dynamic> json) =
      _$ImageElement.fromJson;

  @override
  String get layer;
  @DoublePointJsonConverter()
  Point<double> get position;
  ElementConstraints? get constraints;
  String get source;
  double get width;
  double get height;
  @override
  @JsonKey(ignore: true)
  _$$ImageElementCopyWith<_$ImageElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SvgElementCopyWith<$Res>
    implements $PadElementCopyWith<$Res> {
  factory _$$SvgElementCopyWith(
          _$SvgElement value, $Res Function(_$SvgElement) then) =
      __$$SvgElementCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String layer,
      @DoublePointJsonConverter() Point<double> position,
      ElementConstraints? constraints,
      String source,
      double width,
      double height});

  $ElementConstraintsCopyWith<$Res>? get constraints;
}

/// @nodoc
class __$$SvgElementCopyWithImpl<$Res>
    extends _$PadElementCopyWithImpl<$Res, _$SvgElement>
    implements _$$SvgElementCopyWith<$Res> {
  __$$SvgElementCopyWithImpl(
      _$SvgElement _value, $Res Function(_$SvgElement) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? layer = null,
    Object? position = null,
    Object? constraints = freezed,
    Object? source = null,
    Object? width = null,
    Object? height = null,
  }) {
    return _then(_$SvgElement(
      layer: null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Point<double>,
      constraints: freezed == constraints
          ? _value.constraints
          : constraints // ignore: cast_nullable_to_non_nullable
              as ElementConstraints?,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ElementConstraintsCopyWith<$Res>? get constraints {
    if (_value.constraints == null) {
      return null;
    }

    return $ElementConstraintsCopyWith<$Res>(_value.constraints!, (value) {
      return _then(_value.copyWith(constraints: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$SvgElement implements SvgElement {
  const _$SvgElement(
      {this.layer = '',
      @DoublePointJsonConverter() this.position = const Point(0.0, 0.0),
      this.constraints = const ScaledElementConstraints(scaleX: 1, scaleY: 1),
      required this.source,
      required this.width,
      required this.height,
      final String? $type})
      : $type = $type ?? 'svg';

  factory _$SvgElement.fromJson(Map<String, dynamic> json) =>
      _$$SvgElementFromJson(json);

  @override
  @JsonKey()
  final String layer;
  @override
  @JsonKey()
  @DoublePointJsonConverter()
  final Point<double> position;
  @override
  @JsonKey()
  final ElementConstraints? constraints;
  @override
  final String source;
  @override
  final double width;
  @override
  final double height;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadElement.svg(layer: $layer, position: $position, constraints: $constraints, source: $source, width: $width, height: $height)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SvgElementCopyWith<_$SvgElement> get copyWith =>
      __$$SvgElementCopyWithImpl<_$SvgElement>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String layer, double? zoom,
            List<PathPoint> points, PenProperty property)
        pen,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)
        text,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)
        markdown,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)
        image,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)
        svg,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)
        shape,
  }) {
    return svg(layer, position, constraints, source, width, height);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String layer, double? zoom, List<PathPoint> points,
            PenProperty property)?
        pen,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)?
        text,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)?
        markdown,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        image,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        svg,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)?
        shape,
  }) {
    return svg?.call(layer, position, constraints, source, width, height);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String layer, double? zoom, List<PathPoint> points,
            PenProperty property)?
        pen,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)?
        text,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)?
        markdown,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        image,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        svg,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)?
        shape,
    required TResult orElse(),
  }) {
    if (svg != null) {
      return svg(layer, position, constraints, source, width, height);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PenElement value) pen,
    required TResult Function(TextElement value) text,
    required TResult Function(MarkdownElement value) markdown,
    required TResult Function(ImageElement value) image,
    required TResult Function(SvgElement value) svg,
    required TResult Function(ShapeElement value) shape,
  }) {
    return svg(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PenElement value)? pen,
    TResult? Function(TextElement value)? text,
    TResult? Function(MarkdownElement value)? markdown,
    TResult? Function(ImageElement value)? image,
    TResult? Function(SvgElement value)? svg,
    TResult? Function(ShapeElement value)? shape,
  }) {
    return svg?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PenElement value)? pen,
    TResult Function(TextElement value)? text,
    TResult Function(MarkdownElement value)? markdown,
    TResult Function(ImageElement value)? image,
    TResult Function(SvgElement value)? svg,
    TResult Function(ShapeElement value)? shape,
    required TResult orElse(),
  }) {
    if (svg != null) {
      return svg(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SvgElementToJson(
      this,
    );
  }
}

abstract class SvgElement implements PadElement, SourcedElement {
  const factory SvgElement(
      {final String layer,
      @DoublePointJsonConverter() final Point<double> position,
      final ElementConstraints? constraints,
      required final String source,
      required final double width,
      required final double height}) = _$SvgElement;

  factory SvgElement.fromJson(Map<String, dynamic> json) =
      _$SvgElement.fromJson;

  @override
  String get layer;
  @DoublePointJsonConverter()
  Point<double> get position;
  ElementConstraints? get constraints;
  String get source;
  double get width;
  double get height;
  @override
  @JsonKey(ignore: true)
  _$$SvgElementCopyWith<_$SvgElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShapeElementCopyWith<$Res>
    implements $PadElementCopyWith<$Res> {
  factory _$$ShapeElementCopyWith(
          _$ShapeElement value, $Res Function(_$ShapeElement) then) =
      __$$ShapeElementCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String layer,
      @DoublePointJsonConverter() Point<double> firstPosition,
      @DoublePointJsonConverter() Point<double> secondPosition,
      ShapeProperty property});
}

/// @nodoc
class __$$ShapeElementCopyWithImpl<$Res>
    extends _$PadElementCopyWithImpl<$Res, _$ShapeElement>
    implements _$$ShapeElementCopyWith<$Res> {
  __$$ShapeElementCopyWithImpl(
      _$ShapeElement _value, $Res Function(_$ShapeElement) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? layer = null,
    Object? firstPosition = null,
    Object? secondPosition = null,
    Object? property = freezed,
  }) {
    return _then(_$ShapeElement(
      layer: null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      firstPosition: null == firstPosition
          ? _value.firstPosition
          : firstPosition // ignore: cast_nullable_to_non_nullable
              as Point<double>,
      secondPosition: null == secondPosition
          ? _value.secondPosition
          : secondPosition // ignore: cast_nullable_to_non_nullable
              as Point<double>,
      property: freezed == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as ShapeProperty,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShapeElement implements ShapeElement {
  const _$ShapeElement(
      {this.layer = '',
      @DoublePointJsonConverter() this.firstPosition = const Point(0.0, 0.0),
      @DoublePointJsonConverter() this.secondPosition = const Point(0.0, 0.0),
      this.property = const ShapeProperty(shape: RectangleShape()),
      final String? $type})
      : $type = $type ?? 'shape';

  factory _$ShapeElement.fromJson(Map<String, dynamic> json) =>
      _$$ShapeElementFromJson(json);

  @override
  @JsonKey()
  final String layer;
  @override
  @JsonKey()
  @DoublePointJsonConverter()
  final Point<double> firstPosition;
  @override
  @JsonKey()
  @DoublePointJsonConverter()
  final Point<double> secondPosition;
  @override
  @JsonKey()
  final ShapeProperty property;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadElement.shape(layer: $layer, firstPosition: $firstPosition, secondPosition: $secondPosition, property: $property)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShapeElementCopyWith<_$ShapeElement> get copyWith =>
      __$$ShapeElementCopyWithImpl<_$ShapeElement>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String layer, double? zoom,
            List<PathPoint> points, PenProperty property)
        pen,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)
        text,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)
        markdown,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)
        image,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)
        svg,
    required TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)
        shape,
  }) {
    return shape(layer, firstPosition, secondPosition, property);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String layer, double? zoom, List<PathPoint> points,
            PenProperty property)?
        pen,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)?
        text,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)?
        markdown,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        image,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        svg,
    TResult? Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)?
        shape,
  }) {
    return shape?.call(layer, firstPosition, secondPosition, property);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String layer, double? zoom, List<PathPoint> points,
            PenProperty property)?
        pen,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint)?
        text,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint)?
        markdown,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        image,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height)?
        svg,
    TResult Function(
            String layer,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property)?
        shape,
    required TResult orElse(),
  }) {
    if (shape != null) {
      return shape(layer, firstPosition, secondPosition, property);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PenElement value) pen,
    required TResult Function(TextElement value) text,
    required TResult Function(MarkdownElement value) markdown,
    required TResult Function(ImageElement value) image,
    required TResult Function(SvgElement value) svg,
    required TResult Function(ShapeElement value) shape,
  }) {
    return shape(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PenElement value)? pen,
    TResult? Function(TextElement value)? text,
    TResult? Function(MarkdownElement value)? markdown,
    TResult? Function(ImageElement value)? image,
    TResult? Function(SvgElement value)? svg,
    TResult? Function(ShapeElement value)? shape,
  }) {
    return shape?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PenElement value)? pen,
    TResult Function(TextElement value)? text,
    TResult Function(MarkdownElement value)? markdown,
    TResult Function(ImageElement value)? image,
    TResult Function(SvgElement value)? svg,
    TResult Function(ShapeElement value)? shape,
    required TResult orElse(),
  }) {
    if (shape != null) {
      return shape(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ShapeElementToJson(
      this,
    );
  }
}

abstract class ShapeElement implements PadElement {
  const factory ShapeElement(
      {final String layer,
      @DoublePointJsonConverter() final Point<double> firstPosition,
      @DoublePointJsonConverter() final Point<double> secondPosition,
      final ShapeProperty property}) = _$ShapeElement;

  factory ShapeElement.fromJson(Map<String, dynamic> json) =
      _$ShapeElement.fromJson;

  @override
  String get layer;
  @DoublePointJsonConverter()
  Point<double> get firstPosition;
  @DoublePointJsonConverter()
  Point<double> get secondPosition;
  ShapeProperty get property;
  @override
  @JsonKey(ignore: true)
  _$$ShapeElementCopyWith<_$ShapeElement> get copyWith =>
      throw _privateConstructorUsedError;
}
