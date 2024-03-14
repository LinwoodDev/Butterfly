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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$ElementConstraintImplCopyWith<$Res>
    implements $ElementConstraintCopyWith<$Res> {
  factory _$$ElementConstraintImplCopyWith(_$ElementConstraintImpl value,
          $Res Function(_$ElementConstraintImpl) then) =
      __$$ElementConstraintImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double size, double length, bool includeArea});
}

/// @nodoc
class __$$ElementConstraintImplCopyWithImpl<$Res>
    extends _$ElementConstraintCopyWithImpl<$Res, _$ElementConstraintImpl>
    implements _$$ElementConstraintImplCopyWith<$Res> {
  __$$ElementConstraintImplCopyWithImpl(_$ElementConstraintImpl _value,
      $Res Function(_$ElementConstraintImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? size = null,
    Object? length = null,
    Object? includeArea = null,
  }) {
    return _then(_$ElementConstraintImpl(
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
class _$ElementConstraintImpl implements _ElementConstraint {
  const _$ElementConstraintImpl(
      {this.size = 0, this.length = 0, this.includeArea = true});

  factory _$ElementConstraintImpl.fromJson(Map<String, dynamic> json) =>
      _$$ElementConstraintImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElementConstraintImpl &&
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
  _$$ElementConstraintImplCopyWith<_$ElementConstraintImpl> get copyWith =>
      __$$ElementConstraintImplCopyWithImpl<_$ElementConstraintImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ElementConstraintImplToJson(
      this,
    );
  }
}

abstract class _ElementConstraint implements ElementConstraint {
  const factory _ElementConstraint(
      {final double size,
      final double length,
      final bool includeArea}) = _$ElementConstraintImpl;

  factory _ElementConstraint.fromJson(Map<String, dynamic> json) =
      _$ElementConstraintImpl.fromJson;

  @override
  double get size;
  @override
  double get length;
  @override
  bool get includeArea;
  @override
  @JsonKey(ignore: true)
  _$$ElementConstraintImplCopyWith<_$ElementConstraintImpl> get copyWith =>
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
abstract class _$$ScaledElementConstraintsImplCopyWith<$Res> {
  factory _$$ScaledElementConstraintsImplCopyWith(
          _$ScaledElementConstraintsImpl value,
          $Res Function(_$ScaledElementConstraintsImpl) then) =
      __$$ScaledElementConstraintsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double scaleX, double scaleY});
}

/// @nodoc
class __$$ScaledElementConstraintsImplCopyWithImpl<$Res>
    extends _$ElementConstraintsCopyWithImpl<$Res,
        _$ScaledElementConstraintsImpl>
    implements _$$ScaledElementConstraintsImplCopyWith<$Res> {
  __$$ScaledElementConstraintsImplCopyWithImpl(
      _$ScaledElementConstraintsImpl _value,
      $Res Function(_$ScaledElementConstraintsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scaleX = null,
    Object? scaleY = null,
  }) {
    return _then(_$ScaledElementConstraintsImpl(
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
class _$ScaledElementConstraintsImpl implements ScaledElementConstraints {
  const _$ScaledElementConstraintsImpl(
      {this.scaleX = 1, this.scaleY = 1, final String? $type})
      : $type = $type ?? 'scaled';

  factory _$ScaledElementConstraintsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScaledElementConstraintsImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScaledElementConstraintsImpl &&
            (identical(other.scaleX, scaleX) || other.scaleX == scaleX) &&
            (identical(other.scaleY, scaleY) || other.scaleY == scaleY));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, scaleX, scaleY);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScaledElementConstraintsImplCopyWith<_$ScaledElementConstraintsImpl>
      get copyWith => __$$ScaledElementConstraintsImplCopyWithImpl<
          _$ScaledElementConstraintsImpl>(this, _$identity);

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
    return _$$ScaledElementConstraintsImplToJson(
      this,
    );
  }
}

abstract class ScaledElementConstraints implements ElementConstraints {
  const factory ScaledElementConstraints(
      {final double scaleX,
      final double scaleY}) = _$ScaledElementConstraintsImpl;

  factory ScaledElementConstraints.fromJson(Map<String, dynamic> json) =
      _$ScaledElementConstraintsImpl.fromJson;

  double get scaleX;
  double get scaleY;
  @JsonKey(ignore: true)
  _$$ScaledElementConstraintsImplCopyWith<_$ScaledElementConstraintsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FixedElementConstraintsImplCopyWith<$Res> {
  factory _$$FixedElementConstraintsImplCopyWith(
          _$FixedElementConstraintsImpl value,
          $Res Function(_$FixedElementConstraintsImpl) then) =
      __$$FixedElementConstraintsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double height, double width});
}

/// @nodoc
class __$$FixedElementConstraintsImplCopyWithImpl<$Res>
    extends _$ElementConstraintsCopyWithImpl<$Res,
        _$FixedElementConstraintsImpl>
    implements _$$FixedElementConstraintsImplCopyWith<$Res> {
  __$$FixedElementConstraintsImplCopyWithImpl(
      _$FixedElementConstraintsImpl _value,
      $Res Function(_$FixedElementConstraintsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? height = null,
    Object? width = null,
  }) {
    return _then(_$FixedElementConstraintsImpl(
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
class _$FixedElementConstraintsImpl implements FixedElementConstraints {
  const _$FixedElementConstraintsImpl(this.height, this.width,
      {final String? $type})
      : $type = $type ?? 'fixed';

  factory _$FixedElementConstraintsImpl.fromJson(Map<String, dynamic> json) =>
      _$$FixedElementConstraintsImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FixedElementConstraintsImpl &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.width, width) || other.width == width));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, height, width);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FixedElementConstraintsImplCopyWith<_$FixedElementConstraintsImpl>
      get copyWith => __$$FixedElementConstraintsImplCopyWithImpl<
          _$FixedElementConstraintsImpl>(this, _$identity);

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
    return _$$FixedElementConstraintsImplToJson(
      this,
    );
  }
}

abstract class FixedElementConstraints implements ElementConstraints {
  const factory FixedElementConstraints(
      final double height, final double width) = _$FixedElementConstraintsImpl;

  factory FixedElementConstraints.fromJson(Map<String, dynamic> json) =
      _$FixedElementConstraintsImpl.fromJson;

  double get height;
  double get width;
  @JsonKey(ignore: true)
  _$$FixedElementConstraintsImplCopyWith<_$FixedElementConstraintsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DynamicElementConstraintsImplCopyWith<$Res> {
  factory _$$DynamicElementConstraintsImplCopyWith(
          _$DynamicElementConstraintsImpl value,
          $Res Function(_$DynamicElementConstraintsImpl) then) =
      __$$DynamicElementConstraintsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {double height, double width, double aspectRatio, bool includeArea});
}

/// @nodoc
class __$$DynamicElementConstraintsImplCopyWithImpl<$Res>
    extends _$ElementConstraintsCopyWithImpl<$Res,
        _$DynamicElementConstraintsImpl>
    implements _$$DynamicElementConstraintsImplCopyWith<$Res> {
  __$$DynamicElementConstraintsImplCopyWithImpl(
      _$DynamicElementConstraintsImpl _value,
      $Res Function(_$DynamicElementConstraintsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? height = null,
    Object? width = null,
    Object? aspectRatio = null,
    Object? includeArea = null,
  }) {
    return _then(_$DynamicElementConstraintsImpl(
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
class _$DynamicElementConstraintsImpl implements DynamicElementConstraints {
  const _$DynamicElementConstraintsImpl(
      {this.height = 0,
      this.width = 0,
      this.aspectRatio = 0,
      this.includeArea = true,
      final String? $type})
      : $type = $type ?? 'dynamic';

  factory _$DynamicElementConstraintsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DynamicElementConstraintsImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DynamicElementConstraintsImpl &&
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
  _$$DynamicElementConstraintsImplCopyWith<_$DynamicElementConstraintsImpl>
      get copyWith => __$$DynamicElementConstraintsImplCopyWithImpl<
          _$DynamicElementConstraintsImpl>(this, _$identity);

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
    return _$$DynamicElementConstraintsImplToJson(
      this,
    );
  }
}

abstract class DynamicElementConstraints implements ElementConstraints {
  const factory DynamicElementConstraints(
      {final double height,
      final double width,
      final double aspectRatio,
      final bool includeArea}) = _$DynamicElementConstraintsImpl;

  factory DynamicElementConstraints.fromJson(Map<String, dynamic> json) =
      _$DynamicElementConstraintsImpl.fromJson;

  double get height;
  double get width;
  double get aspectRatio;
  bool get includeArea;
  @JsonKey(ignore: true)
  _$$DynamicElementConstraintsImplCopyWith<_$DynamicElementConstraintsImpl>
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
    case 'texture':
      return TextureElement.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'PadElement', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$PadElement {
  double get rotation => throw _privateConstructorUsedError;
  String get layer => throw _privateConstructorUsedError;
  @IdJsonConverter()
  String get id => throw _privateConstructorUsedError;
  Map<String, dynamic> get extra => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)
        pen,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)
        text,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)
        markdown,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)
        image,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)
        svg,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)
        shape,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)
        texture,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)?
        pen,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        text,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        markdown,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        image,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        svg,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)?
        shape,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)?
        texture,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)?
        pen,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        text,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        markdown,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        image,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        svg,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)?
        shape,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)?
        texture,
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
    required TResult Function(TextureElement value) texture,
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
    TResult? Function(TextureElement value)? texture,
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
    TResult Function(TextureElement value)? texture,
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
  $Res call(
      {double rotation,
      String layer,
      @IdJsonConverter() String id,
      Map<String, dynamic> extra});
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
    Object? rotation = null,
    Object? layer = null,
    Object? id = null,
    Object? extra = null,
  }) {
    return _then(_value.copyWith(
      rotation: null == rotation
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as double,
      layer: null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      extra: null == extra
          ? _value.extra
          : extra // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PenElementImplCopyWith<$Res>
    implements $PadElementCopyWith<$Res> {
  factory _$$PenElementImplCopyWith(
          _$PenElementImpl value, $Res Function(_$PenElementImpl) then) =
      __$$PenElementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double rotation,
      String layer,
      @IdJsonConverter() String id,
      double? zoom,
      List<PathPoint> points,
      PenProperty property,
      Map<String, dynamic> extra});
}

/// @nodoc
class __$$PenElementImplCopyWithImpl<$Res>
    extends _$PadElementCopyWithImpl<$Res, _$PenElementImpl>
    implements _$$PenElementImplCopyWith<$Res> {
  __$$PenElementImplCopyWithImpl(
      _$PenElementImpl _value, $Res Function(_$PenElementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rotation = null,
    Object? layer = null,
    Object? id = null,
    Object? zoom = freezed,
    Object? points = null,
    Object? property = freezed,
    Object? extra = null,
  }) {
    return _then(_$PenElementImpl(
      rotation: null == rotation
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as double,
      layer: null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      extra: null == extra
          ? _value._extra
          : extra // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PenElementImpl implements PenElement {
  _$PenElementImpl(
      {this.rotation = 0,
      this.layer = '',
      @IdJsonConverter() this.id = '',
      this.zoom,
      final List<PathPoint> points = const [],
      this.property = const PenProperty(),
      final Map<String, dynamic> extra = const {},
      final String? $type})
      : _points = points,
        _extra = extra,
        $type = $type ?? 'pen';

  factory _$PenElementImpl.fromJson(Map<String, dynamic> json) =>
      _$$PenElementImplFromJson(json);

  @override
  @JsonKey()
  final double rotation;
  @override
  @JsonKey()
  final String layer;
  @override
  @JsonKey()
  @IdJsonConverter()
  final String id;
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
  final Map<String, dynamic> _extra;
  @override
  @JsonKey()
  Map<String, dynamic> get extra {
    if (_extra is EqualUnmodifiableMapView) return _extra;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_extra);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadElement.pen(rotation: $rotation, layer: $layer, id: $id, zoom: $zoom, points: $points, property: $property, extra: $extra)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PenElementImplCopyWith<_$PenElementImpl> get copyWith =>
      __$$PenElementImplCopyWithImpl<_$PenElementImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)
        pen,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)
        text,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)
        markdown,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)
        image,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)
        svg,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)
        shape,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)
        texture,
  }) {
    return pen(rotation, layer, id, zoom, points, property, extra);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)?
        pen,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        text,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        markdown,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        image,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        svg,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)?
        shape,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)?
        texture,
  }) {
    return pen?.call(rotation, layer, id, zoom, points, property, extra);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)?
        pen,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        text,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        markdown,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        image,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        svg,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)?
        shape,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)?
        texture,
    required TResult orElse(),
  }) {
    if (pen != null) {
      return pen(rotation, layer, id, zoom, points, property, extra);
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
    required TResult Function(TextureElement value) texture,
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
    TResult? Function(TextureElement value)? texture,
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
    TResult Function(TextureElement value)? texture,
    required TResult orElse(),
  }) {
    if (pen != null) {
      return pen(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PenElementImplToJson(
      this,
    );
  }
}

abstract class PenElement implements PadElement, PathElement {
  factory PenElement(
      {final double rotation,
      final String layer,
      @IdJsonConverter() final String id,
      final double? zoom,
      final List<PathPoint> points,
      final PenProperty property,
      final Map<String, dynamic> extra}) = _$PenElementImpl;

  factory PenElement.fromJson(Map<String, dynamic> json) =
      _$PenElementImpl.fromJson;

  @override
  double get rotation;
  @override
  String get layer;
  @override
  @IdJsonConverter()
  String get id;
  double? get zoom;
  List<PathPoint> get points;
  PenProperty get property;
  @override
  Map<String, dynamic> get extra;
  @override
  @JsonKey(ignore: true)
  _$$PenElementImplCopyWith<_$PenElementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TextElementImplCopyWith<$Res>
    implements $PadElementCopyWith<$Res> {
  factory _$$TextElementImplCopyWith(
          _$TextElementImpl value, $Res Function(_$TextElementImpl) then) =
      __$$TextElementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double rotation,
      String layer,
      @IdJsonConverter() String id,
      @DoublePointJsonConverter() Point<double> position,
      double scale,
      PackAssetLocation styleSheet,
      TextArea area,
      ElementConstraint constraint,
      int foreground,
      Map<String, dynamic> extra});

  $PackAssetLocationCopyWith<$Res> get styleSheet;
  $TextAreaCopyWith<$Res> get area;
  $ElementConstraintCopyWith<$Res> get constraint;
}

/// @nodoc
class __$$TextElementImplCopyWithImpl<$Res>
    extends _$PadElementCopyWithImpl<$Res, _$TextElementImpl>
    implements _$$TextElementImplCopyWith<$Res> {
  __$$TextElementImplCopyWithImpl(
      _$TextElementImpl _value, $Res Function(_$TextElementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rotation = null,
    Object? layer = null,
    Object? id = null,
    Object? position = null,
    Object? scale = null,
    Object? styleSheet = null,
    Object? area = null,
    Object? constraint = null,
    Object? foreground = null,
    Object? extra = null,
  }) {
    return _then(_$TextElementImpl(
      rotation: null == rotation
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as double,
      layer: null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      foreground: null == foreground
          ? _value.foreground
          : foreground // ignore: cast_nullable_to_non_nullable
              as int,
      extra: null == extra
          ? _value._extra
          : extra // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
class _$TextElementImpl with LabelElement implements TextElement {
  _$TextElementImpl(
      {this.rotation = 0,
      this.layer = '',
      @IdJsonConverter() this.id = '',
      @DoublePointJsonConverter() this.position = const Point(0.0, 0.0),
      this.scale = 1.0,
      this.styleSheet = const PackAssetLocation(),
      required this.area,
      this.constraint = const ElementConstraint(size: 1000),
      this.foreground = BasicColors.black,
      final Map<String, dynamic> extra = const {},
      final String? $type})
      : _extra = extra,
        $type = $type ?? 'text';

  factory _$TextElementImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextElementImplFromJson(json);

  @override
  @JsonKey()
  final double rotation;
  @override
  @JsonKey()
  final String layer;
  @override
  @JsonKey()
  @IdJsonConverter()
  final String id;
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
  @override
  @JsonKey()
  final int foreground;
  final Map<String, dynamic> _extra;
  @override
  @JsonKey()
  Map<String, dynamic> get extra {
    if (_extra is EqualUnmodifiableMapView) return _extra;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_extra);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadElement.text(rotation: $rotation, layer: $layer, id: $id, position: $position, scale: $scale, styleSheet: $styleSheet, area: $area, constraint: $constraint, foreground: $foreground, extra: $extra)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TextElementImplCopyWith<_$TextElementImpl> get copyWith =>
      __$$TextElementImplCopyWithImpl<_$TextElementImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)
        pen,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)
        text,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)
        markdown,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)
        image,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)
        svg,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)
        shape,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)
        texture,
  }) {
    return text(rotation, layer, id, position, scale, styleSheet, area,
        constraint, foreground, extra);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)?
        pen,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        text,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        markdown,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        image,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        svg,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)?
        shape,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)?
        texture,
  }) {
    return text?.call(rotation, layer, id, position, scale, styleSheet, area,
        constraint, foreground, extra);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)?
        pen,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        text,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        markdown,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        image,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        svg,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)?
        shape,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)?
        texture,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(rotation, layer, id, position, scale, styleSheet, area,
          constraint, foreground, extra);
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
    required TResult Function(TextureElement value) texture,
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
    TResult? Function(TextureElement value)? texture,
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
    TResult Function(TextureElement value)? texture,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TextElementImplToJson(
      this,
    );
  }
}

abstract class TextElement implements PadElement, LabelElement {
  factory TextElement(
      {final double rotation,
      final String layer,
      @IdJsonConverter() final String id,
      @DoublePointJsonConverter() final Point<double> position,
      final double scale,
      final PackAssetLocation styleSheet,
      required final TextArea area,
      final ElementConstraint constraint,
      final int foreground,
      final Map<String, dynamic> extra}) = _$TextElementImpl;

  factory TextElement.fromJson(Map<String, dynamic> json) =
      _$TextElementImpl.fromJson;

  @override
  double get rotation;
  @override
  String get layer;
  @override
  @IdJsonConverter()
  String get id;
  @DoublePointJsonConverter()
  Point<double> get position;
  double get scale;
  PackAssetLocation get styleSheet;
  TextArea get area;
  ElementConstraint get constraint;
  int get foreground;
  @override
  Map<String, dynamic> get extra;
  @override
  @JsonKey(ignore: true)
  _$$TextElementImplCopyWith<_$TextElementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarkdownElementImplCopyWith<$Res>
    implements $PadElementCopyWith<$Res> {
  factory _$$MarkdownElementImplCopyWith(_$MarkdownElementImpl value,
          $Res Function(_$MarkdownElementImpl) then) =
      __$$MarkdownElementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double rotation,
      String layer,
      @IdJsonConverter() String id,
      @DoublePointJsonConverter() Point<double> position,
      double scale,
      PackAssetLocation styleSheet,
      AreaProperty areaProperty,
      String text,
      ElementConstraint constraint,
      int foreground,
      Map<String, dynamic> extra});

  $PackAssetLocationCopyWith<$Res> get styleSheet;
  $AreaPropertyCopyWith<$Res> get areaProperty;
  $ElementConstraintCopyWith<$Res> get constraint;
}

/// @nodoc
class __$$MarkdownElementImplCopyWithImpl<$Res>
    extends _$PadElementCopyWithImpl<$Res, _$MarkdownElementImpl>
    implements _$$MarkdownElementImplCopyWith<$Res> {
  __$$MarkdownElementImplCopyWithImpl(
      _$MarkdownElementImpl _value, $Res Function(_$MarkdownElementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rotation = null,
    Object? layer = null,
    Object? id = null,
    Object? position = null,
    Object? scale = null,
    Object? styleSheet = null,
    Object? areaProperty = null,
    Object? text = null,
    Object? constraint = null,
    Object? foreground = null,
    Object? extra = null,
  }) {
    return _then(_$MarkdownElementImpl(
      rotation: null == rotation
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as double,
      layer: null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      foreground: null == foreground
          ? _value.foreground
          : foreground // ignore: cast_nullable_to_non_nullable
              as int,
      extra: null == extra
          ? _value._extra
          : extra // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
class _$MarkdownElementImpl with LabelElement implements MarkdownElement {
  _$MarkdownElementImpl(
      {this.rotation = 0,
      this.layer = '',
      @IdJsonConverter() this.id = '',
      @DoublePointJsonConverter() this.position = const Point(0.0, 0.0),
      this.scale = 1.0,
      this.styleSheet = const PackAssetLocation(),
      this.areaProperty = const AreaProperty(),
      required this.text,
      this.constraint = const ElementConstraint(size: 1000),
      this.foreground = BasicColors.black,
      final Map<String, dynamic> extra = const {},
      final String? $type})
      : _extra = extra,
        $type = $type ?? 'markdown';

  factory _$MarkdownElementImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarkdownElementImplFromJson(json);

  @override
  @JsonKey()
  final double rotation;
  @override
  @JsonKey()
  final String layer;
  @override
  @JsonKey()
  @IdJsonConverter()
  final String id;
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
  @override
  @JsonKey()
  final int foreground;
  final Map<String, dynamic> _extra;
  @override
  @JsonKey()
  Map<String, dynamic> get extra {
    if (_extra is EqualUnmodifiableMapView) return _extra;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_extra);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadElement.markdown(rotation: $rotation, layer: $layer, id: $id, position: $position, scale: $scale, styleSheet: $styleSheet, areaProperty: $areaProperty, text: $text, constraint: $constraint, foreground: $foreground, extra: $extra)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkdownElementImplCopyWith<_$MarkdownElementImpl> get copyWith =>
      __$$MarkdownElementImplCopyWithImpl<_$MarkdownElementImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)
        pen,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)
        text,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)
        markdown,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)
        image,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)
        svg,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)
        shape,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)
        texture,
  }) {
    return markdown(rotation, layer, id, position, scale, styleSheet,
        areaProperty, this.text, constraint, foreground, extra);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)?
        pen,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        text,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        markdown,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        image,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        svg,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)?
        shape,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)?
        texture,
  }) {
    return markdown?.call(rotation, layer, id, position, scale, styleSheet,
        areaProperty, this.text, constraint, foreground, extra);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)?
        pen,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        text,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        markdown,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        image,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        svg,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)?
        shape,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)?
        texture,
    required TResult orElse(),
  }) {
    if (markdown != null) {
      return markdown(rotation, layer, id, position, scale, styleSheet,
          areaProperty, this.text, constraint, foreground, extra);
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
    required TResult Function(TextureElement value) texture,
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
    TResult? Function(TextureElement value)? texture,
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
    TResult Function(TextureElement value)? texture,
    required TResult orElse(),
  }) {
    if (markdown != null) {
      return markdown(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MarkdownElementImplToJson(
      this,
    );
  }
}

abstract class MarkdownElement implements PadElement, LabelElement {
  factory MarkdownElement(
      {final double rotation,
      final String layer,
      @IdJsonConverter() final String id,
      @DoublePointJsonConverter() final Point<double> position,
      final double scale,
      final PackAssetLocation styleSheet,
      final AreaProperty areaProperty,
      required final String text,
      final ElementConstraint constraint,
      final int foreground,
      final Map<String, dynamic> extra}) = _$MarkdownElementImpl;

  factory MarkdownElement.fromJson(Map<String, dynamic> json) =
      _$MarkdownElementImpl.fromJson;

  @override
  double get rotation;
  @override
  String get layer;
  @override
  @IdJsonConverter()
  String get id;
  @DoublePointJsonConverter()
  Point<double> get position;
  double get scale;
  PackAssetLocation get styleSheet;
  AreaProperty get areaProperty;
  String get text;
  ElementConstraint get constraint;
  int get foreground;
  @override
  Map<String, dynamic> get extra;
  @override
  @JsonKey(ignore: true)
  _$$MarkdownElementImplCopyWith<_$MarkdownElementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ImageElementImplCopyWith<$Res>
    implements $PadElementCopyWith<$Res> {
  factory _$$ImageElementImplCopyWith(
          _$ImageElementImpl value, $Res Function(_$ImageElementImpl) then) =
      __$$ImageElementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double rotation,
      String layer,
      @IdJsonConverter() String id,
      @DoublePointJsonConverter() Point<double> position,
      ElementConstraints? constraints,
      String source,
      double width,
      double height,
      Map<String, dynamic> extra});

  $ElementConstraintsCopyWith<$Res>? get constraints;
}

/// @nodoc
class __$$ImageElementImplCopyWithImpl<$Res>
    extends _$PadElementCopyWithImpl<$Res, _$ImageElementImpl>
    implements _$$ImageElementImplCopyWith<$Res> {
  __$$ImageElementImplCopyWithImpl(
      _$ImageElementImpl _value, $Res Function(_$ImageElementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rotation = null,
    Object? layer = null,
    Object? id = null,
    Object? position = null,
    Object? constraints = freezed,
    Object? source = null,
    Object? width = null,
    Object? height = null,
    Object? extra = null,
  }) {
    return _then(_$ImageElementImpl(
      rotation: null == rotation
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as double,
      layer: null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      extra: null == extra
          ? _value._extra
          : extra // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
class _$ImageElementImpl implements ImageElement {
  _$ImageElementImpl(
      {this.rotation = 0,
      this.layer = '',
      @IdJsonConverter() this.id = '',
      @DoublePointJsonConverter() this.position = const Point(0.0, 0.0),
      this.constraints = const ScaledElementConstraints(scaleX: 1, scaleY: 1),
      required this.source,
      required this.width,
      required this.height,
      final Map<String, dynamic> extra = const {},
      final String? $type})
      : _extra = extra,
        $type = $type ?? 'image';

  factory _$ImageElementImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageElementImplFromJson(json);

  @override
  @JsonKey()
  final double rotation;
  @override
  @JsonKey()
  final String layer;
  @override
  @JsonKey()
  @IdJsonConverter()
  final String id;
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
  final Map<String, dynamic> _extra;
  @override
  @JsonKey()
  Map<String, dynamic> get extra {
    if (_extra is EqualUnmodifiableMapView) return _extra;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_extra);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadElement.image(rotation: $rotation, layer: $layer, id: $id, position: $position, constraints: $constraints, source: $source, width: $width, height: $height, extra: $extra)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageElementImplCopyWith<_$ImageElementImpl> get copyWith =>
      __$$ImageElementImplCopyWithImpl<_$ImageElementImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)
        pen,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)
        text,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)
        markdown,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)
        image,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)
        svg,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)
        shape,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)
        texture,
  }) {
    return image(rotation, layer, id, position, constraints, source, width,
        height, extra);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)?
        pen,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        text,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        markdown,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        image,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        svg,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)?
        shape,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)?
        texture,
  }) {
    return image?.call(rotation, layer, id, position, constraints, source,
        width, height, extra);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)?
        pen,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        text,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        markdown,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        image,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        svg,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)?
        shape,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)?
        texture,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(rotation, layer, id, position, constraints, source, width,
          height, extra);
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
    required TResult Function(TextureElement value) texture,
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
    TResult? Function(TextureElement value)? texture,
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
    TResult Function(TextureElement value)? texture,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageElementImplToJson(
      this,
    );
  }
}

abstract class ImageElement implements PadElement, SourcedElement {
  factory ImageElement(
      {final double rotation,
      final String layer,
      @IdJsonConverter() final String id,
      @DoublePointJsonConverter() final Point<double> position,
      final ElementConstraints? constraints,
      required final String source,
      required final double width,
      required final double height,
      final Map<String, dynamic> extra}) = _$ImageElementImpl;

  factory ImageElement.fromJson(Map<String, dynamic> json) =
      _$ImageElementImpl.fromJson;

  @override
  double get rotation;
  @override
  String get layer;
  @override
  @IdJsonConverter()
  String get id;
  @DoublePointJsonConverter()
  Point<double> get position;
  ElementConstraints? get constraints;
  String get source;
  double get width;
  double get height;
  @override
  Map<String, dynamic> get extra;
  @override
  @JsonKey(ignore: true)
  _$$ImageElementImplCopyWith<_$ImageElementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SvgElementImplCopyWith<$Res>
    implements $PadElementCopyWith<$Res> {
  factory _$$SvgElementImplCopyWith(
          _$SvgElementImpl value, $Res Function(_$SvgElementImpl) then) =
      __$$SvgElementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double rotation,
      String layer,
      @IdJsonConverter() String id,
      @DoublePointJsonConverter() Point<double> position,
      ElementConstraints? constraints,
      String source,
      double width,
      double height,
      Map<String, dynamic> extra});

  $ElementConstraintsCopyWith<$Res>? get constraints;
}

/// @nodoc
class __$$SvgElementImplCopyWithImpl<$Res>
    extends _$PadElementCopyWithImpl<$Res, _$SvgElementImpl>
    implements _$$SvgElementImplCopyWith<$Res> {
  __$$SvgElementImplCopyWithImpl(
      _$SvgElementImpl _value, $Res Function(_$SvgElementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rotation = null,
    Object? layer = null,
    Object? id = null,
    Object? position = null,
    Object? constraints = freezed,
    Object? source = null,
    Object? width = null,
    Object? height = null,
    Object? extra = null,
  }) {
    return _then(_$SvgElementImpl(
      rotation: null == rotation
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as double,
      layer: null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      extra: null == extra
          ? _value._extra
          : extra // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
class _$SvgElementImpl implements SvgElement {
  _$SvgElementImpl(
      {this.rotation = 0,
      this.layer = '',
      @IdJsonConverter() this.id = '',
      @DoublePointJsonConverter() this.position = const Point(0.0, 0.0),
      this.constraints = const ScaledElementConstraints(scaleX: 1, scaleY: 1),
      required this.source,
      required this.width,
      required this.height,
      final Map<String, dynamic> extra = const {},
      final String? $type})
      : _extra = extra,
        $type = $type ?? 'svg';

  factory _$SvgElementImpl.fromJson(Map<String, dynamic> json) =>
      _$$SvgElementImplFromJson(json);

  @override
  @JsonKey()
  final double rotation;
  @override
  @JsonKey()
  final String layer;
  @override
  @JsonKey()
  @IdJsonConverter()
  final String id;
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
  final Map<String, dynamic> _extra;
  @override
  @JsonKey()
  Map<String, dynamic> get extra {
    if (_extra is EqualUnmodifiableMapView) return _extra;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_extra);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadElement.svg(rotation: $rotation, layer: $layer, id: $id, position: $position, constraints: $constraints, source: $source, width: $width, height: $height, extra: $extra)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SvgElementImplCopyWith<_$SvgElementImpl> get copyWith =>
      __$$SvgElementImplCopyWithImpl<_$SvgElementImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)
        pen,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)
        text,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)
        markdown,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)
        image,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)
        svg,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)
        shape,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)
        texture,
  }) {
    return svg(rotation, layer, id, position, constraints, source, width,
        height, extra);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)?
        pen,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        text,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        markdown,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        image,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        svg,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)?
        shape,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)?
        texture,
  }) {
    return svg?.call(rotation, layer, id, position, constraints, source, width,
        height, extra);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)?
        pen,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        text,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        markdown,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        image,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        svg,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)?
        shape,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)?
        texture,
    required TResult orElse(),
  }) {
    if (svg != null) {
      return svg(rotation, layer, id, position, constraints, source, width,
          height, extra);
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
    required TResult Function(TextureElement value) texture,
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
    TResult? Function(TextureElement value)? texture,
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
    TResult Function(TextureElement value)? texture,
    required TResult orElse(),
  }) {
    if (svg != null) {
      return svg(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SvgElementImplToJson(
      this,
    );
  }
}

abstract class SvgElement implements PadElement, SourcedElement {
  factory SvgElement(
      {final double rotation,
      final String layer,
      @IdJsonConverter() final String id,
      @DoublePointJsonConverter() final Point<double> position,
      final ElementConstraints? constraints,
      required final String source,
      required final double width,
      required final double height,
      final Map<String, dynamic> extra}) = _$SvgElementImpl;

  factory SvgElement.fromJson(Map<String, dynamic> json) =
      _$SvgElementImpl.fromJson;

  @override
  double get rotation;
  @override
  String get layer;
  @override
  @IdJsonConverter()
  String get id;
  @DoublePointJsonConverter()
  Point<double> get position;
  ElementConstraints? get constraints;
  String get source;
  double get width;
  double get height;
  @override
  Map<String, dynamic> get extra;
  @override
  @JsonKey(ignore: true)
  _$$SvgElementImplCopyWith<_$SvgElementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShapeElementImplCopyWith<$Res>
    implements $PadElementCopyWith<$Res> {
  factory _$$ShapeElementImplCopyWith(
          _$ShapeElementImpl value, $Res Function(_$ShapeElementImpl) then) =
      __$$ShapeElementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double rotation,
      String layer,
      @IdJsonConverter() String id,
      @DoublePointJsonConverter() Point<double> firstPosition,
      @DoublePointJsonConverter() Point<double> secondPosition,
      ShapeProperty property,
      Map<String, dynamic> extra});
}

/// @nodoc
class __$$ShapeElementImplCopyWithImpl<$Res>
    extends _$PadElementCopyWithImpl<$Res, _$ShapeElementImpl>
    implements _$$ShapeElementImplCopyWith<$Res> {
  __$$ShapeElementImplCopyWithImpl(
      _$ShapeElementImpl _value, $Res Function(_$ShapeElementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rotation = null,
    Object? layer = null,
    Object? id = null,
    Object? firstPosition = null,
    Object? secondPosition = null,
    Object? property = freezed,
    Object? extra = null,
  }) {
    return _then(_$ShapeElementImpl(
      rotation: null == rotation
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as double,
      layer: null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      extra: null == extra
          ? _value._extra
          : extra // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShapeElementImpl implements ShapeElement {
  _$ShapeElementImpl(
      {this.rotation = 0,
      this.layer = '',
      @IdJsonConverter() this.id = '',
      @DoublePointJsonConverter() this.firstPosition = const Point(0.0, 0.0),
      @DoublePointJsonConverter() this.secondPosition = const Point(0.0, 0.0),
      this.property = const ShapeProperty(shape: RectangleShape()),
      final Map<String, dynamic> extra = const {},
      final String? $type})
      : _extra = extra,
        $type = $type ?? 'shape';

  factory _$ShapeElementImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShapeElementImplFromJson(json);

  @override
  @JsonKey()
  final double rotation;
  @override
  @JsonKey()
  final String layer;
  @override
  @JsonKey()
  @IdJsonConverter()
  final String id;
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
  final Map<String, dynamic> _extra;
  @override
  @JsonKey()
  Map<String, dynamic> get extra {
    if (_extra is EqualUnmodifiableMapView) return _extra;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_extra);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadElement.shape(rotation: $rotation, layer: $layer, id: $id, firstPosition: $firstPosition, secondPosition: $secondPosition, property: $property, extra: $extra)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShapeElementImplCopyWith<_$ShapeElementImpl> get copyWith =>
      __$$ShapeElementImplCopyWithImpl<_$ShapeElementImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)
        pen,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)
        text,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)
        markdown,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)
        image,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)
        svg,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)
        shape,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)
        texture,
  }) {
    return shape(
        rotation, layer, id, firstPosition, secondPosition, property, extra);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)?
        pen,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        text,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        markdown,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        image,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        svg,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)?
        shape,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)?
        texture,
  }) {
    return shape?.call(
        rotation, layer, id, firstPosition, secondPosition, property, extra);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)?
        pen,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        text,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        markdown,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        image,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        svg,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)?
        shape,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)?
        texture,
    required TResult orElse(),
  }) {
    if (shape != null) {
      return shape(
          rotation, layer, id, firstPosition, secondPosition, property, extra);
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
    required TResult Function(TextureElement value) texture,
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
    TResult? Function(TextureElement value)? texture,
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
    TResult Function(TextureElement value)? texture,
    required TResult orElse(),
  }) {
    if (shape != null) {
      return shape(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ShapeElementImplToJson(
      this,
    );
  }
}

abstract class ShapeElement implements PadElement {
  factory ShapeElement(
      {final double rotation,
      final String layer,
      @IdJsonConverter() final String id,
      @DoublePointJsonConverter() final Point<double> firstPosition,
      @DoublePointJsonConverter() final Point<double> secondPosition,
      final ShapeProperty property,
      final Map<String, dynamic> extra}) = _$ShapeElementImpl;

  factory ShapeElement.fromJson(Map<String, dynamic> json) =
      _$ShapeElementImpl.fromJson;

  @override
  double get rotation;
  @override
  String get layer;
  @override
  @IdJsonConverter()
  String get id;
  @DoublePointJsonConverter()
  Point<double> get firstPosition;
  @DoublePointJsonConverter()
  Point<double> get secondPosition;
  ShapeProperty get property;
  @override
  Map<String, dynamic> get extra;
  @override
  @JsonKey(ignore: true)
  _$$ShapeElementImplCopyWith<_$ShapeElementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TextureElementImplCopyWith<$Res>
    implements $PadElementCopyWith<$Res> {
  factory _$$TextureElementImplCopyWith(_$TextureElementImpl value,
          $Res Function(_$TextureElementImpl) then) =
      __$$TextureElementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double rotation,
      String layer,
      @IdJsonConverter() String id,
      SurfaceTexture texture,
      @DoublePointJsonConverter() Point<double> firstPosition,
      @DoublePointJsonConverter() Point<double> secondPosition,
      Map<String, dynamic> extra});

  $SurfaceTextureCopyWith<$Res> get texture;
}

/// @nodoc
class __$$TextureElementImplCopyWithImpl<$Res>
    extends _$PadElementCopyWithImpl<$Res, _$TextureElementImpl>
    implements _$$TextureElementImplCopyWith<$Res> {
  __$$TextureElementImplCopyWithImpl(
      _$TextureElementImpl _value, $Res Function(_$TextureElementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rotation = null,
    Object? layer = null,
    Object? id = null,
    Object? texture = null,
    Object? firstPosition = null,
    Object? secondPosition = null,
    Object? extra = null,
  }) {
    return _then(_$TextureElementImpl(
      rotation: null == rotation
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as double,
      layer: null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      texture: null == texture
          ? _value.texture
          : texture // ignore: cast_nullable_to_non_nullable
              as SurfaceTexture,
      firstPosition: null == firstPosition
          ? _value.firstPosition
          : firstPosition // ignore: cast_nullable_to_non_nullable
              as Point<double>,
      secondPosition: null == secondPosition
          ? _value.secondPosition
          : secondPosition // ignore: cast_nullable_to_non_nullable
              as Point<double>,
      extra: null == extra
          ? _value._extra
          : extra // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SurfaceTextureCopyWith<$Res> get texture {
    return $SurfaceTextureCopyWith<$Res>(_value.texture, (value) {
      return _then(_value.copyWith(texture: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$TextureElementImpl implements TextureElement {
  _$TextureElementImpl(
      {this.rotation = 0,
      this.layer = '',
      @IdJsonConverter() this.id = '',
      this.texture = const SurfaceTexture.pattern(),
      @DoublePointJsonConverter() this.firstPosition = const Point(0.0, 0.0),
      @DoublePointJsonConverter() this.secondPosition = const Point(0.0, 0.0),
      final Map<String, dynamic> extra = const {},
      final String? $type})
      : _extra = extra,
        $type = $type ?? 'texture';

  factory _$TextureElementImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextureElementImplFromJson(json);

  @override
  @JsonKey()
  final double rotation;
  @override
  @JsonKey()
  final String layer;
  @override
  @JsonKey()
  @IdJsonConverter()
  final String id;
  @override
  @JsonKey()
  final SurfaceTexture texture;
  @override
  @JsonKey()
  @DoublePointJsonConverter()
  final Point<double> firstPosition;
  @override
  @JsonKey()
  @DoublePointJsonConverter()
  final Point<double> secondPosition;
  final Map<String, dynamic> _extra;
  @override
  @JsonKey()
  Map<String, dynamic> get extra {
    if (_extra is EqualUnmodifiableMapView) return _extra;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_extra);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadElement.texture(rotation: $rotation, layer: $layer, id: $id, texture: $texture, firstPosition: $firstPosition, secondPosition: $secondPosition, extra: $extra)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TextureElementImplCopyWith<_$TextureElementImpl> get copyWith =>
      __$$TextureElementImplCopyWithImpl<_$TextureElementImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)
        pen,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)
        text,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)
        markdown,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)
        image,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)
        svg,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)
        shape,
    required TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)
        texture,
  }) {
    return texture(rotation, layer, id, this.texture, firstPosition,
        secondPosition, extra);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)?
        pen,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        text,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        markdown,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        image,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        svg,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)?
        shape,
    TResult? Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)?
        texture,
  }) {
    return texture?.call(rotation, layer, id, this.texture, firstPosition,
        secondPosition, extra);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            double? zoom,
            List<PathPoint> points,
            PenProperty property,
            Map<String, dynamic> extra)?
        pen,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            TextArea area,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        text,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            double scale,
            PackAssetLocation styleSheet,
            AreaProperty areaProperty,
            String text,
            ElementConstraint constraint,
            int foreground,
            Map<String, dynamic> extra)?
        markdown,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        image,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> position,
            ElementConstraints? constraints,
            String source,
            double width,
            double height,
            Map<String, dynamic> extra)?
        svg,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            ShapeProperty property,
            Map<String, dynamic> extra)?
        shape,
    TResult Function(
            double rotation,
            String layer,
            @IdJsonConverter() String id,
            SurfaceTexture texture,
            @DoublePointJsonConverter() Point<double> firstPosition,
            @DoublePointJsonConverter() Point<double> secondPosition,
            Map<String, dynamic> extra)?
        texture,
    required TResult orElse(),
  }) {
    if (texture != null) {
      return texture(rotation, layer, id, this.texture, firstPosition,
          secondPosition, extra);
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
    required TResult Function(TextureElement value) texture,
  }) {
    return texture(this);
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
    TResult? Function(TextureElement value)? texture,
  }) {
    return texture?.call(this);
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
    TResult Function(TextureElement value)? texture,
    required TResult orElse(),
  }) {
    if (texture != null) {
      return texture(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TextureElementImplToJson(
      this,
    );
  }
}

abstract class TextureElement implements PadElement {
  factory TextureElement(
      {final double rotation,
      final String layer,
      @IdJsonConverter() final String id,
      final SurfaceTexture texture,
      @DoublePointJsonConverter() final Point<double> firstPosition,
      @DoublePointJsonConverter() final Point<double> secondPosition,
      final Map<String, dynamic> extra}) = _$TextureElementImpl;

  factory TextureElement.fromJson(Map<String, dynamic> json) =
      _$TextureElementImpl.fromJson;

  @override
  double get rotation;
  @override
  String get layer;
  @override
  @IdJsonConverter()
  String get id;
  SurfaceTexture get texture;
  @DoublePointJsonConverter()
  Point<double> get firstPosition;
  @DoublePointJsonConverter()
  Point<double> get secondPosition;
  @override
  Map<String, dynamic> get extra;
  @override
  @JsonKey(ignore: true)
  _$$TextureElementImplCopyWith<_$TextureElementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
