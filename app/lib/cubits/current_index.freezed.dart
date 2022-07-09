// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'current_index.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CurrentIndex {
  int get index => throw _privateConstructorUsedError;
  Handler? get handler => throw _privateConstructorUsedError;
  List<Renderer> get foregrounds => throw _privateConstructorUsedError;
  List<Rect> get selections => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CurrentIndexCopyWith<CurrentIndex> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentIndexCopyWith<$Res> {
  factory $CurrentIndexCopyWith(
          CurrentIndex value, $Res Function(CurrentIndex) then) =
      _$CurrentIndexCopyWithImpl<$Res>;
  $Res call(
      {int index,
      Handler? handler,
      List<Renderer> foregrounds,
      List<Rect> selections});
}

/// @nodoc
class _$CurrentIndexCopyWithImpl<$Res> implements $CurrentIndexCopyWith<$Res> {
  _$CurrentIndexCopyWithImpl(this._value, this._then);

  final CurrentIndex _value;
  // ignore: unused_field
  final $Res Function(CurrentIndex) _then;

  @override
  $Res call({
    Object? index = freezed,
    Object? handler = freezed,
    Object? foregrounds = freezed,
    Object? selections = freezed,
  }) {
    return _then(_value.copyWith(
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      handler: handler == freezed
          ? _value.handler
          : handler // ignore: cast_nullable_to_non_nullable
              as Handler?,
      foregrounds: foregrounds == freezed
          ? _value.foregrounds
          : foregrounds // ignore: cast_nullable_to_non_nullable
              as List<Renderer>,
      selections: selections == freezed
          ? _value.selections
          : selections // ignore: cast_nullable_to_non_nullable
              as List<Rect>,
    ));
  }
}

/// @nodoc
abstract class _$$_CurrentIndexCopyWith<$Res>
    implements $CurrentIndexCopyWith<$Res> {
  factory _$$_CurrentIndexCopyWith(
          _$_CurrentIndex value, $Res Function(_$_CurrentIndex) then) =
      __$$_CurrentIndexCopyWithImpl<$Res>;
  @override
  $Res call(
      {int index,
      Handler? handler,
      List<Renderer> foregrounds,
      List<Rect> selections});
}

/// @nodoc
class __$$_CurrentIndexCopyWithImpl<$Res>
    extends _$CurrentIndexCopyWithImpl<$Res>
    implements _$$_CurrentIndexCopyWith<$Res> {
  __$$_CurrentIndexCopyWithImpl(
      _$_CurrentIndex _value, $Res Function(_$_CurrentIndex) _then)
      : super(_value, (v) => _then(v as _$_CurrentIndex));

  @override
  _$_CurrentIndex get _value => super._value as _$_CurrentIndex;

  @override
  $Res call({
    Object? index = freezed,
    Object? handler = freezed,
    Object? foregrounds = freezed,
    Object? selections = freezed,
  }) {
    return _then(_$_CurrentIndex(
      index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      handler == freezed
          ? _value.handler
          : handler // ignore: cast_nullable_to_non_nullable
              as Handler?,
      foregrounds == freezed
          ? _value._foregrounds
          : foregrounds // ignore: cast_nullable_to_non_nullable
              as List<Renderer>,
      selections == freezed
          ? _value._selections
          : selections // ignore: cast_nullable_to_non_nullable
              as List<Rect>,
    ));
  }
}

/// @nodoc

class _$_CurrentIndex implements _CurrentIndex {
  const _$_CurrentIndex(this.index, this.handler,
      [final List<Renderer> foregrounds = const [],
      final List<Rect> selections = const []])
      : _foregrounds = foregrounds,
        _selections = selections;

  @override
  final int index;
  @override
  final Handler? handler;
  final List<Renderer> _foregrounds;
  @override
  @JsonKey()
  List<Renderer> get foregrounds {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foregrounds);
  }

  final List<Rect> _selections;
  @override
  @JsonKey()
  List<Rect> get selections {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selections);
  }

  @override
  String toString() {
    return 'CurrentIndex(index: $index, handler: $handler, foregrounds: $foregrounds, selections: $selections)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CurrentIndex &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality().equals(other.handler, handler) &&
            const DeepCollectionEquality()
                .equals(other._foregrounds, _foregrounds) &&
            const DeepCollectionEquality()
                .equals(other._selections, _selections));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(handler),
      const DeepCollectionEquality().hash(_foregrounds),
      const DeepCollectionEquality().hash(_selections));

  @JsonKey(ignore: true)
  @override
  _$$_CurrentIndexCopyWith<_$_CurrentIndex> get copyWith =>
      __$$_CurrentIndexCopyWithImpl<_$_CurrentIndex>(this, _$identity);
}

abstract class _CurrentIndex implements CurrentIndex {
  const factory _CurrentIndex(final int index, final Handler? handler,
      [final List<Renderer> foregrounds,
      final List<Rect> selections]) = _$_CurrentIndex;

  @override
  int get index;
  @override
  Handler? get handler;
  @override
  List<Renderer> get foregrounds;
  @override
  List<Rect> get selections;
  @override
  @JsonKey(ignore: true)
  _$$_CurrentIndexCopyWith<_$_CurrentIndex> get copyWith =>
      throw _privateConstructorUsedError;
}
