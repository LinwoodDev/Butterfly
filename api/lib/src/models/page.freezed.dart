// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DocumentPage _$DocumentPageFromJson(Map<String, dynamic> json) {
  return _DocumentPage.fromJson(json);
}

/// @nodoc
mixin _$DocumentPage {
  List<AnimationTrack> get animations => throw _privateConstructorUsedError;
  List<PadElement> get content => throw _privateConstructorUsedError;
  List<Background> get backgrounds => throw _privateConstructorUsedError;
  List<Waypoint> get waypoints => throw _privateConstructorUsedError;
  List<Area> get areas => throw _privateConstructorUsedError;
  Map<String, dynamic> get extra => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DocumentPageCopyWith<DocumentPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentPageCopyWith<$Res> {
  factory $DocumentPageCopyWith(
          DocumentPage value, $Res Function(DocumentPage) then) =
      _$DocumentPageCopyWithImpl<$Res, DocumentPage>;
  @useResult
  $Res call(
      {List<AnimationTrack> animations,
      List<PadElement> content,
      List<Background> backgrounds,
      List<Waypoint> waypoints,
      List<Area> areas,
      Map<String, dynamic> extra});
}

/// @nodoc
class _$DocumentPageCopyWithImpl<$Res, $Val extends DocumentPage>
    implements $DocumentPageCopyWith<$Res> {
  _$DocumentPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? animations = null,
    Object? content = null,
    Object? backgrounds = null,
    Object? waypoints = null,
    Object? areas = null,
    Object? extra = null,
  }) {
    return _then(_value.copyWith(
      animations: null == animations
          ? _value.animations
          : animations // ignore: cast_nullable_to_non_nullable
              as List<AnimationTrack>,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as List<PadElement>,
      backgrounds: null == backgrounds
          ? _value.backgrounds
          : backgrounds // ignore: cast_nullable_to_non_nullable
              as List<Background>,
      waypoints: null == waypoints
          ? _value.waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<Waypoint>,
      areas: null == areas
          ? _value.areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<Area>,
      extra: null == extra
          ? _value.extra
          : extra // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentPageImplCopyWith<$Res>
    implements $DocumentPageCopyWith<$Res> {
  factory _$$DocumentPageImplCopyWith(
          _$DocumentPageImpl value, $Res Function(_$DocumentPageImpl) then) =
      __$$DocumentPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<AnimationTrack> animations,
      List<PadElement> content,
      List<Background> backgrounds,
      List<Waypoint> waypoints,
      List<Area> areas,
      Map<String, dynamic> extra});
}

/// @nodoc
class __$$DocumentPageImplCopyWithImpl<$Res>
    extends _$DocumentPageCopyWithImpl<$Res, _$DocumentPageImpl>
    implements _$$DocumentPageImplCopyWith<$Res> {
  __$$DocumentPageImplCopyWithImpl(
      _$DocumentPageImpl _value, $Res Function(_$DocumentPageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? animations = null,
    Object? content = null,
    Object? backgrounds = null,
    Object? waypoints = null,
    Object? areas = null,
    Object? extra = null,
  }) {
    return _then(_$DocumentPageImpl(
      animations: null == animations
          ? _value._animations
          : animations // ignore: cast_nullable_to_non_nullable
              as List<AnimationTrack>,
      content: null == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<PadElement>,
      backgrounds: null == backgrounds
          ? _value._backgrounds
          : backgrounds // ignore: cast_nullable_to_non_nullable
              as List<Background>,
      waypoints: null == waypoints
          ? _value._waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<Waypoint>,
      areas: null == areas
          ? _value._areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<Area>,
      extra: null == extra
          ? _value._extra
          : extra // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentPageImpl extends _DocumentPage {
  const _$DocumentPageImpl(
      {final List<AnimationTrack> animations = const [],
      final List<PadElement> content = const [],
      final List<Background> backgrounds = const [],
      final List<Waypoint> waypoints = const [],
      final List<Area> areas = const [],
      final Map<String, dynamic> extra = const {}})
      : _animations = animations,
        _content = content,
        _backgrounds = backgrounds,
        _waypoints = waypoints,
        _areas = areas,
        _extra = extra,
        super._();

  factory _$DocumentPageImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentPageImplFromJson(json);

  final List<AnimationTrack> _animations;
  @override
  @JsonKey()
  List<AnimationTrack> get animations {
    if (_animations is EqualUnmodifiableListView) return _animations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_animations);
  }

  final List<PadElement> _content;
  @override
  @JsonKey()
  List<PadElement> get content {
    if (_content is EqualUnmodifiableListView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_content);
  }

  final List<Background> _backgrounds;
  @override
  @JsonKey()
  List<Background> get backgrounds {
    if (_backgrounds is EqualUnmodifiableListView) return _backgrounds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_backgrounds);
  }

  final List<Waypoint> _waypoints;
  @override
  @JsonKey()
  List<Waypoint> get waypoints {
    if (_waypoints is EqualUnmodifiableListView) return _waypoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_waypoints);
  }

  final List<Area> _areas;
  @override
  @JsonKey()
  List<Area> get areas {
    if (_areas is EqualUnmodifiableListView) return _areas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  final Map<String, dynamic> _extra;
  @override
  @JsonKey()
  Map<String, dynamic> get extra {
    if (_extra is EqualUnmodifiableMapView) return _extra;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_extra);
  }

  @override
  String toString() {
    return 'DocumentPage(animations: $animations, content: $content, backgrounds: $backgrounds, waypoints: $waypoints, areas: $areas, extra: $extra)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentPageImpl &&
            const DeepCollectionEquality()
                .equals(other._animations, _animations) &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            const DeepCollectionEquality()
                .equals(other._backgrounds, _backgrounds) &&
            const DeepCollectionEquality()
                .equals(other._waypoints, _waypoints) &&
            const DeepCollectionEquality().equals(other._areas, _areas) &&
            const DeepCollectionEquality().equals(other._extra, _extra));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_animations),
      const DeepCollectionEquality().hash(_content),
      const DeepCollectionEquality().hash(_backgrounds),
      const DeepCollectionEquality().hash(_waypoints),
      const DeepCollectionEquality().hash(_areas),
      const DeepCollectionEquality().hash(_extra));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentPageImplCopyWith<_$DocumentPageImpl> get copyWith =>
      __$$DocumentPageImplCopyWithImpl<_$DocumentPageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentPageImplToJson(
      this,
    );
  }
}

abstract class _DocumentPage extends DocumentPage {
  const factory _DocumentPage(
      {final List<AnimationTrack> animations,
      final List<PadElement> content,
      final List<Background> backgrounds,
      final List<Waypoint> waypoints,
      final List<Area> areas,
      final Map<String, dynamic> extra}) = _$DocumentPageImpl;
  const _DocumentPage._() : super._();

  factory _DocumentPage.fromJson(Map<String, dynamic> json) =
      _$DocumentPageImpl.fromJson;

  @override
  List<AnimationTrack> get animations;
  @override
  List<PadElement> get content;
  @override
  List<Background> get backgrounds;
  @override
  List<Waypoint> get waypoints;
  @override
  List<Area> get areas;
  @override
  Map<String, dynamic> get extra;
  @override
  @JsonKey(ignore: true)
  _$$DocumentPageImplCopyWith<_$DocumentPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
