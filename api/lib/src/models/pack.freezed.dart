// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pack.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ButterflyComponent _$ButterflyComponentFromJson(Map<String, dynamic> json) {
  return _ButterflyComponent.fromJson(json);
}

/// @nodoc
mixin _$ButterflyComponent {
  String get name => throw _privateConstructorUsedError;
  String? get thumbnail => throw _privateConstructorUsedError;
  List<PadElement> get elements => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ButterflyComponentCopyWith<ButterflyComponent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ButterflyComponentCopyWith<$Res> {
  factory $ButterflyComponentCopyWith(
          ButterflyComponent value, $Res Function(ButterflyComponent) then) =
      _$ButterflyComponentCopyWithImpl<$Res, ButterflyComponent>;
  @useResult
  $Res call({String name, String? thumbnail, List<PadElement> elements});
}

/// @nodoc
class _$ButterflyComponentCopyWithImpl<$Res, $Val extends ButterflyComponent>
    implements $ButterflyComponentCopyWith<$Res> {
  _$ButterflyComponentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? thumbnail = freezed,
    Object? elements = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      elements: null == elements
          ? _value.elements
          : elements // ignore: cast_nullable_to_non_nullable
              as List<PadElement>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ButterflyComponentImplCopyWith<$Res>
    implements $ButterflyComponentCopyWith<$Res> {
  factory _$$ButterflyComponentImplCopyWith(_$ButterflyComponentImpl value,
          $Res Function(_$ButterflyComponentImpl) then) =
      __$$ButterflyComponentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? thumbnail, List<PadElement> elements});
}

/// @nodoc
class __$$ButterflyComponentImplCopyWithImpl<$Res>
    extends _$ButterflyComponentCopyWithImpl<$Res, _$ButterflyComponentImpl>
    implements _$$ButterflyComponentImplCopyWith<$Res> {
  __$$ButterflyComponentImplCopyWithImpl(_$ButterflyComponentImpl _value,
      $Res Function(_$ButterflyComponentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? thumbnail = freezed,
    Object? elements = null,
  }) {
    return _then(_$ButterflyComponentImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      elements: null == elements
          ? _value._elements
          : elements // ignore: cast_nullable_to_non_nullable
              as List<PadElement>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ButterflyComponentImpl implements _ButterflyComponent {
  const _$ButterflyComponentImpl(
      {required this.name,
      this.thumbnail,
      final List<PadElement> elements = const <PadElement>[]})
      : _elements = elements;

  factory _$ButterflyComponentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ButterflyComponentImplFromJson(json);

  @override
  final String name;
  @override
  final String? thumbnail;
  final List<PadElement> _elements;
  @override
  @JsonKey()
  List<PadElement> get elements {
    if (_elements is EqualUnmodifiableListView) return _elements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_elements);
  }

  @override
  String toString() {
    return 'ButterflyComponent(name: $name, thumbnail: $thumbnail, elements: $elements)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ButterflyComponentImplCopyWith<_$ButterflyComponentImpl> get copyWith =>
      __$$ButterflyComponentImplCopyWithImpl<_$ButterflyComponentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ButterflyComponentImplToJson(
      this,
    );
  }
}

abstract class _ButterflyComponent implements ButterflyComponent {
  const factory _ButterflyComponent(
      {required final String name,
      final String? thumbnail,
      final List<PadElement> elements}) = _$ButterflyComponentImpl;

  factory _ButterflyComponent.fromJson(Map<String, dynamic> json) =
      _$ButterflyComponentImpl.fromJson;

  @override
  String get name;
  @override
  String? get thumbnail;
  @override
  List<PadElement> get elements;
  @override
  @JsonKey(ignore: true)
  _$$ButterflyComponentImplCopyWith<_$ButterflyComponentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ButterflyParameter _$ButterflyParameterFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'text':
      return TextParameter.fromJson(json);
    case 'color':
      return ColorParameter.fromJson(json);
    case 'bool':
      return BoolParameter.fromJson(json);
    case 'int':
      return IntParameter.fromJson(json);
    case 'double':
      return DoubleParameter.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'ButterflyParameter',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$ButterflyParameter {
  int get child => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Object get value => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int child, String name, String value) text,
    required TResult Function(int child, String name, int value) color,
    required TResult Function(int child, String name, bool value) bool,
    required TResult Function(int child, String name, int value) int,
    required TResult Function(int child, String name, double value) double,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int child, String name, String value)? text,
    TResult? Function(int child, String name, int value)? color,
    TResult? Function(int child, String name, bool value)? bool,
    TResult? Function(int child, String name, int value)? int,
    TResult? Function(int child, String name, double value)? double,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int child, String name, String value)? text,
    TResult Function(int child, String name, int value)? color,
    TResult Function(int child, String name, bool value)? bool,
    TResult Function(int child, String name, int value)? int,
    TResult Function(int child, String name, double value)? double,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextParameter value) text,
    required TResult Function(ColorParameter value) color,
    required TResult Function(BoolParameter value) bool,
    required TResult Function(IntParameter value) int,
    required TResult Function(DoubleParameter value) double,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextParameter value)? text,
    TResult? Function(ColorParameter value)? color,
    TResult? Function(BoolParameter value)? bool,
    TResult? Function(IntParameter value)? int,
    TResult? Function(DoubleParameter value)? double,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextParameter value)? text,
    TResult Function(ColorParameter value)? color,
    TResult Function(BoolParameter value)? bool,
    TResult Function(IntParameter value)? int,
    TResult Function(DoubleParameter value)? double,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ButterflyParameterCopyWith<ButterflyParameter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ButterflyParameterCopyWith<$Res> {
  factory $ButterflyParameterCopyWith(
          ButterflyParameter value, $Res Function(ButterflyParameter) then) =
      _$ButterflyParameterCopyWithImpl<$Res, ButterflyParameter>;
  @useResult
  $Res call({int child, String name});
}

/// @nodoc
class _$ButterflyParameterCopyWithImpl<$Res, $Val extends ButterflyParameter>
    implements $ButterflyParameterCopyWith<$Res> {
  _$ButterflyParameterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? child = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      child: null == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TextParameterImplCopyWith<$Res>
    implements $ButterflyParameterCopyWith<$Res> {
  factory _$$TextParameterImplCopyWith(
          _$TextParameterImpl value, $Res Function(_$TextParameterImpl) then) =
      __$$TextParameterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int child, String name, String value});
}

/// @nodoc
class __$$TextParameterImplCopyWithImpl<$Res>
    extends _$ButterflyParameterCopyWithImpl<$Res, _$TextParameterImpl>
    implements _$$TextParameterImplCopyWith<$Res> {
  __$$TextParameterImplCopyWithImpl(
      _$TextParameterImpl _value, $Res Function(_$TextParameterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? child = null,
    Object? name = null,
    Object? value = null,
  }) {
    return _then(_$TextParameterImpl(
      child: null == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TextParameterImpl implements TextParameter {
  const _$TextParameterImpl(
      {required this.child,
      required this.name,
      required this.value,
      final String? $type})
      : $type = $type ?? 'text';

  factory _$TextParameterImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextParameterImplFromJson(json);

  @override
  final int child;
  @override
  final String name;
  @override
  final String value;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ButterflyParameter.text(child: $child, name: $name, value: $value)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TextParameterImplCopyWith<_$TextParameterImpl> get copyWith =>
      __$$TextParameterImplCopyWithImpl<_$TextParameterImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int child, String name, String value) text,
    required TResult Function(int child, String name, int value) color,
    required TResult Function(int child, String name, bool value) bool,
    required TResult Function(int child, String name, int value) int,
    required TResult Function(int child, String name, double value) double,
  }) {
    return text(child, name, value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int child, String name, String value)? text,
    TResult? Function(int child, String name, int value)? color,
    TResult? Function(int child, String name, bool value)? bool,
    TResult? Function(int child, String name, int value)? int,
    TResult? Function(int child, String name, double value)? double,
  }) {
    return text?.call(child, name, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int child, String name, String value)? text,
    TResult Function(int child, String name, int value)? color,
    TResult Function(int child, String name, bool value)? bool,
    TResult Function(int child, String name, int value)? int,
    TResult Function(int child, String name, double value)? double,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(child, name, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextParameter value) text,
    required TResult Function(ColorParameter value) color,
    required TResult Function(BoolParameter value) bool,
    required TResult Function(IntParameter value) int,
    required TResult Function(DoubleParameter value) double,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextParameter value)? text,
    TResult? Function(ColorParameter value)? color,
    TResult? Function(BoolParameter value)? bool,
    TResult? Function(IntParameter value)? int,
    TResult? Function(DoubleParameter value)? double,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextParameter value)? text,
    TResult Function(ColorParameter value)? color,
    TResult Function(BoolParameter value)? bool,
    TResult Function(IntParameter value)? int,
    TResult Function(DoubleParameter value)? double,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TextParameterImplToJson(
      this,
    );
  }
}

abstract class TextParameter implements ButterflyParameter {
  const factory TextParameter(
      {required final int child,
      required final String name,
      required final String value}) = _$TextParameterImpl;

  factory TextParameter.fromJson(Map<String, dynamic> json) =
      _$TextParameterImpl.fromJson;

  @override
  int get child;
  @override
  String get name;
  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$TextParameterImplCopyWith<_$TextParameterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ColorParameterImplCopyWith<$Res>
    implements $ButterflyParameterCopyWith<$Res> {
  factory _$$ColorParameterImplCopyWith(_$ColorParameterImpl value,
          $Res Function(_$ColorParameterImpl) then) =
      __$$ColorParameterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int child, String name, int value});
}

/// @nodoc
class __$$ColorParameterImplCopyWithImpl<$Res>
    extends _$ButterflyParameterCopyWithImpl<$Res, _$ColorParameterImpl>
    implements _$$ColorParameterImplCopyWith<$Res> {
  __$$ColorParameterImplCopyWithImpl(
      _$ColorParameterImpl _value, $Res Function(_$ColorParameterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? child = null,
    Object? name = null,
    Object? value = null,
  }) {
    return _then(_$ColorParameterImpl(
      child: null == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ColorParameterImpl implements ColorParameter {
  const _$ColorParameterImpl(
      {required this.child,
      required this.name,
      required this.value,
      final String? $type})
      : $type = $type ?? 'color';

  factory _$ColorParameterImpl.fromJson(Map<String, dynamic> json) =>
      _$$ColorParameterImplFromJson(json);

  @override
  final int child;
  @override
  final String name;
  @override
  final int value;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ButterflyParameter.color(child: $child, name: $name, value: $value)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ColorParameterImplCopyWith<_$ColorParameterImpl> get copyWith =>
      __$$ColorParameterImplCopyWithImpl<_$ColorParameterImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int child, String name, String value) text,
    required TResult Function(int child, String name, int value) color,
    required TResult Function(int child, String name, bool value) bool,
    required TResult Function(int child, String name, int value) int,
    required TResult Function(int child, String name, double value) double,
  }) {
    return color(child, name, value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int child, String name, String value)? text,
    TResult? Function(int child, String name, int value)? color,
    TResult? Function(int child, String name, bool value)? bool,
    TResult? Function(int child, String name, int value)? int,
    TResult? Function(int child, String name, double value)? double,
  }) {
    return color?.call(child, name, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int child, String name, String value)? text,
    TResult Function(int child, String name, int value)? color,
    TResult Function(int child, String name, bool value)? bool,
    TResult Function(int child, String name, int value)? int,
    TResult Function(int child, String name, double value)? double,
    required TResult orElse(),
  }) {
    if (color != null) {
      return color(child, name, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextParameter value) text,
    required TResult Function(ColorParameter value) color,
    required TResult Function(BoolParameter value) bool,
    required TResult Function(IntParameter value) int,
    required TResult Function(DoubleParameter value) double,
  }) {
    return color(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextParameter value)? text,
    TResult? Function(ColorParameter value)? color,
    TResult? Function(BoolParameter value)? bool,
    TResult? Function(IntParameter value)? int,
    TResult? Function(DoubleParameter value)? double,
  }) {
    return color?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextParameter value)? text,
    TResult Function(ColorParameter value)? color,
    TResult Function(BoolParameter value)? bool,
    TResult Function(IntParameter value)? int,
    TResult Function(DoubleParameter value)? double,
    required TResult orElse(),
  }) {
    if (color != null) {
      return color(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ColorParameterImplToJson(
      this,
    );
  }
}

abstract class ColorParameter implements ButterflyParameter {
  const factory ColorParameter(
      {required final int child,
      required final String name,
      required final int value}) = _$ColorParameterImpl;

  factory ColorParameter.fromJson(Map<String, dynamic> json) =
      _$ColorParameterImpl.fromJson;

  @override
  int get child;
  @override
  String get name;
  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$$ColorParameterImplCopyWith<_$ColorParameterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BoolParameterImplCopyWith<$Res>
    implements $ButterflyParameterCopyWith<$Res> {
  factory _$$BoolParameterImplCopyWith(
          _$BoolParameterImpl value, $Res Function(_$BoolParameterImpl) then) =
      __$$BoolParameterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int child, String name, bool value});
}

/// @nodoc
class __$$BoolParameterImplCopyWithImpl<$Res>
    extends _$ButterflyParameterCopyWithImpl<$Res, _$BoolParameterImpl>
    implements _$$BoolParameterImplCopyWith<$Res> {
  __$$BoolParameterImplCopyWithImpl(
      _$BoolParameterImpl _value, $Res Function(_$BoolParameterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? child = null,
    Object? name = null,
    Object? value = null,
  }) {
    return _then(_$BoolParameterImpl(
      child: null == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BoolParameterImpl implements BoolParameter {
  const _$BoolParameterImpl(
      {required this.child,
      required this.name,
      required this.value,
      final String? $type})
      : $type = $type ?? 'bool';

  factory _$BoolParameterImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoolParameterImplFromJson(json);

  @override
  final int child;
  @override
  final String name;
  @override
  final bool value;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ButterflyParameter.bool(child: $child, name: $name, value: $value)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BoolParameterImplCopyWith<_$BoolParameterImpl> get copyWith =>
      __$$BoolParameterImplCopyWithImpl<_$BoolParameterImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int child, String name, String value) text,
    required TResult Function(int child, String name, int value) color,
    required TResult Function(int child, String name, bool value) bool,
    required TResult Function(int child, String name, int value) int,
    required TResult Function(int child, String name, double value) double,
  }) {
    return bool(child, name, value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int child, String name, String value)? text,
    TResult? Function(int child, String name, int value)? color,
    TResult? Function(int child, String name, bool value)? bool,
    TResult? Function(int child, String name, int value)? int,
    TResult? Function(int child, String name, double value)? double,
  }) {
    return bool?.call(child, name, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int child, String name, String value)? text,
    TResult Function(int child, String name, int value)? color,
    TResult Function(int child, String name, bool value)? bool,
    TResult Function(int child, String name, int value)? int,
    TResult Function(int child, String name, double value)? double,
    required TResult orElse(),
  }) {
    if (bool != null) {
      return bool(child, name, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextParameter value) text,
    required TResult Function(ColorParameter value) color,
    required TResult Function(BoolParameter value) bool,
    required TResult Function(IntParameter value) int,
    required TResult Function(DoubleParameter value) double,
  }) {
    return bool(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextParameter value)? text,
    TResult? Function(ColorParameter value)? color,
    TResult? Function(BoolParameter value)? bool,
    TResult? Function(IntParameter value)? int,
    TResult? Function(DoubleParameter value)? double,
  }) {
    return bool?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextParameter value)? text,
    TResult Function(ColorParameter value)? color,
    TResult Function(BoolParameter value)? bool,
    TResult Function(IntParameter value)? int,
    TResult Function(DoubleParameter value)? double,
    required TResult orElse(),
  }) {
    if (bool != null) {
      return bool(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BoolParameterImplToJson(
      this,
    );
  }
}

abstract class BoolParameter implements ButterflyParameter {
  const factory BoolParameter(
      {required final int child,
      required final String name,
      required final bool value}) = _$BoolParameterImpl;

  factory BoolParameter.fromJson(Map<String, dynamic> json) =
      _$BoolParameterImpl.fromJson;

  @override
  int get child;
  @override
  String get name;
  @override
  bool get value;
  @override
  @JsonKey(ignore: true)
  _$$BoolParameterImplCopyWith<_$BoolParameterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IntParameterImplCopyWith<$Res>
    implements $ButterflyParameterCopyWith<$Res> {
  factory _$$IntParameterImplCopyWith(
          _$IntParameterImpl value, $Res Function(_$IntParameterImpl) then) =
      __$$IntParameterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int child, String name, int value});
}

/// @nodoc
class __$$IntParameterImplCopyWithImpl<$Res>
    extends _$ButterflyParameterCopyWithImpl<$Res, _$IntParameterImpl>
    implements _$$IntParameterImplCopyWith<$Res> {
  __$$IntParameterImplCopyWithImpl(
      _$IntParameterImpl _value, $Res Function(_$IntParameterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? child = null,
    Object? name = null,
    Object? value = null,
  }) {
    return _then(_$IntParameterImpl(
      child: null == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntParameterImpl implements IntParameter {
  const _$IntParameterImpl(
      {required this.child,
      required this.name,
      required this.value,
      final String? $type})
      : $type = $type ?? 'int';

  factory _$IntParameterImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntParameterImplFromJson(json);

  @override
  final int child;
  @override
  final String name;
  @override
  final int value;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ButterflyParameter.int(child: $child, name: $name, value: $value)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntParameterImplCopyWith<_$IntParameterImpl> get copyWith =>
      __$$IntParameterImplCopyWithImpl<_$IntParameterImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int child, String name, String value) text,
    required TResult Function(int child, String name, int value) color,
    required TResult Function(int child, String name, bool value) bool,
    required TResult Function(int child, String name, int value) int,
    required TResult Function(int child, String name, double value) double,
  }) {
    return int(child, name, value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int child, String name, String value)? text,
    TResult? Function(int child, String name, int value)? color,
    TResult? Function(int child, String name, bool value)? bool,
    TResult? Function(int child, String name, int value)? int,
    TResult? Function(int child, String name, double value)? double,
  }) {
    return int?.call(child, name, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int child, String name, String value)? text,
    TResult Function(int child, String name, int value)? color,
    TResult Function(int child, String name, bool value)? bool,
    TResult Function(int child, String name, int value)? int,
    TResult Function(int child, String name, double value)? double,
    required TResult orElse(),
  }) {
    if (int != null) {
      return int(child, name, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextParameter value) text,
    required TResult Function(ColorParameter value) color,
    required TResult Function(BoolParameter value) bool,
    required TResult Function(IntParameter value) int,
    required TResult Function(DoubleParameter value) double,
  }) {
    return int(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextParameter value)? text,
    TResult? Function(ColorParameter value)? color,
    TResult? Function(BoolParameter value)? bool,
    TResult? Function(IntParameter value)? int,
    TResult? Function(DoubleParameter value)? double,
  }) {
    return int?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextParameter value)? text,
    TResult Function(ColorParameter value)? color,
    TResult Function(BoolParameter value)? bool,
    TResult Function(IntParameter value)? int,
    TResult Function(DoubleParameter value)? double,
    required TResult orElse(),
  }) {
    if (int != null) {
      return int(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$IntParameterImplToJson(
      this,
    );
  }
}

abstract class IntParameter implements ButterflyParameter {
  const factory IntParameter(
      {required final int child,
      required final String name,
      required final int value}) = _$IntParameterImpl;

  factory IntParameter.fromJson(Map<String, dynamic> json) =
      _$IntParameterImpl.fromJson;

  @override
  int get child;
  @override
  String get name;
  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$$IntParameterImplCopyWith<_$IntParameterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DoubleParameterImplCopyWith<$Res>
    implements $ButterflyParameterCopyWith<$Res> {
  factory _$$DoubleParameterImplCopyWith(_$DoubleParameterImpl value,
          $Res Function(_$DoubleParameterImpl) then) =
      __$$DoubleParameterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int child, String name, double value});
}

/// @nodoc
class __$$DoubleParameterImplCopyWithImpl<$Res>
    extends _$ButterflyParameterCopyWithImpl<$Res, _$DoubleParameterImpl>
    implements _$$DoubleParameterImplCopyWith<$Res> {
  __$$DoubleParameterImplCopyWithImpl(
      _$DoubleParameterImpl _value, $Res Function(_$DoubleParameterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? child = null,
    Object? name = null,
    Object? value = null,
  }) {
    return _then(_$DoubleParameterImpl(
      child: null == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DoubleParameterImpl implements DoubleParameter {
  const _$DoubleParameterImpl(
      {required this.child,
      required this.name,
      required this.value,
      final String? $type})
      : $type = $type ?? 'double';

  factory _$DoubleParameterImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoubleParameterImplFromJson(json);

  @override
  final int child;
  @override
  final String name;
  @override
  final double value;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ButterflyParameter.double(child: $child, name: $name, value: $value)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DoubleParameterImplCopyWith<_$DoubleParameterImpl> get copyWith =>
      __$$DoubleParameterImplCopyWithImpl<_$DoubleParameterImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int child, String name, String value) text,
    required TResult Function(int child, String name, int value) color,
    required TResult Function(int child, String name, bool value) bool,
    required TResult Function(int child, String name, int value) int,
    required TResult Function(int child, String name, double value) double,
  }) {
    return double(child, name, value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int child, String name, String value)? text,
    TResult? Function(int child, String name, int value)? color,
    TResult? Function(int child, String name, bool value)? bool,
    TResult? Function(int child, String name, int value)? int,
    TResult? Function(int child, String name, double value)? double,
  }) {
    return double?.call(child, name, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int child, String name, String value)? text,
    TResult Function(int child, String name, int value)? color,
    TResult Function(int child, String name, bool value)? bool,
    TResult Function(int child, String name, int value)? int,
    TResult Function(int child, String name, double value)? double,
    required TResult orElse(),
  }) {
    if (double != null) {
      return double(child, name, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextParameter value) text,
    required TResult Function(ColorParameter value) color,
    required TResult Function(BoolParameter value) bool,
    required TResult Function(IntParameter value) int,
    required TResult Function(DoubleParameter value) double,
  }) {
    return double(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextParameter value)? text,
    TResult? Function(ColorParameter value)? color,
    TResult? Function(BoolParameter value)? bool,
    TResult? Function(IntParameter value)? int,
    TResult? Function(DoubleParameter value)? double,
  }) {
    return double?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextParameter value)? text,
    TResult Function(ColorParameter value)? color,
    TResult Function(BoolParameter value)? bool,
    TResult Function(IntParameter value)? int,
    TResult Function(DoubleParameter value)? double,
    required TResult orElse(),
  }) {
    if (double != null) {
      return double(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DoubleParameterImplToJson(
      this,
    );
  }
}

abstract class DoubleParameter implements ButterflyParameter {
  const factory DoubleParameter(
      {required final int child,
      required final String name,
      required final double value}) = _$DoubleParameterImpl;

  factory DoubleParameter.fromJson(Map<String, dynamic> json) =
      _$DoubleParameterImpl.fromJson;

  @override
  int get child;
  @override
  String get name;
  @override
  double get value;
  @override
  @JsonKey(ignore: true)
  _$$DoubleParameterImplCopyWith<_$DoubleParameterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PackAssetLocation _$PackAssetLocationFromJson(Map<String, dynamic> json) {
  return _PackAssetLocation.fromJson(json);
}

/// @nodoc
mixin _$PackAssetLocation {
  String get pack => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PackAssetLocationCopyWith<PackAssetLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackAssetLocationCopyWith<$Res> {
  factory $PackAssetLocationCopyWith(
          PackAssetLocation value, $Res Function(PackAssetLocation) then) =
      _$PackAssetLocationCopyWithImpl<$Res, PackAssetLocation>;
  @useResult
  $Res call({String pack, String name});
}

/// @nodoc
class _$PackAssetLocationCopyWithImpl<$Res, $Val extends PackAssetLocation>
    implements $PackAssetLocationCopyWith<$Res> {
  _$PackAssetLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pack = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      pack: null == pack
          ? _value.pack
          : pack // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PackAssetLocationImplCopyWith<$Res>
    implements $PackAssetLocationCopyWith<$Res> {
  factory _$$PackAssetLocationImplCopyWith(_$PackAssetLocationImpl value,
          $Res Function(_$PackAssetLocationImpl) then) =
      __$$PackAssetLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String pack, String name});
}

/// @nodoc
class __$$PackAssetLocationImplCopyWithImpl<$Res>
    extends _$PackAssetLocationCopyWithImpl<$Res, _$PackAssetLocationImpl>
    implements _$$PackAssetLocationImplCopyWith<$Res> {
  __$$PackAssetLocationImplCopyWithImpl(_$PackAssetLocationImpl _value,
      $Res Function(_$PackAssetLocationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pack = null,
    Object? name = null,
  }) {
    return _then(_$PackAssetLocationImpl(
      null == pack
          ? _value.pack
          : pack // ignore: cast_nullable_to_non_nullable
              as String,
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PackAssetLocationImpl extends _PackAssetLocation {
  const _$PackAssetLocationImpl([this.pack = '', this.name = '']) : super._();

  factory _$PackAssetLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PackAssetLocationImplFromJson(json);

  @override
  @JsonKey()
  final String pack;
  @override
  @JsonKey()
  final String name;

  @override
  String toString() {
    return 'PackAssetLocation(pack: $pack, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PackAssetLocationImpl &&
            (identical(other.pack, pack) || other.pack == pack) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, pack, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PackAssetLocationImplCopyWith<_$PackAssetLocationImpl> get copyWith =>
      __$$PackAssetLocationImplCopyWithImpl<_$PackAssetLocationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PackAssetLocationImplToJson(
      this,
    );
  }
}

abstract class _PackAssetLocation extends PackAssetLocation {
  const factory _PackAssetLocation([final String pack, final String name]) =
      _$PackAssetLocationImpl;
  const _PackAssetLocation._() : super._();

  factory _PackAssetLocation.fromJson(Map<String, dynamic> json) =
      _$PackAssetLocationImpl.fromJson;

  @override
  String get pack;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$PackAssetLocationImplCopyWith<_$PackAssetLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
