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
  List<DocumentLayer> get layers => throw _privateConstructorUsedError;
  List<Background> get backgrounds => throw _privateConstructorUsedError;
  List<Waypoint> get waypoints => throw _privateConstructorUsedError;
  List<Area> get areas => throw _privateConstructorUsedError;
  Map<String, dynamic> get extra => throw _privateConstructorUsedError;

  /// Serializes this DocumentPage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DocumentPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      List<DocumentLayer> layers,
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

  /// Create a copy of DocumentPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? animations = null,
    Object? layers = null,
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
      layers: null == layers
          ? _value.layers
          : layers // ignore: cast_nullable_to_non_nullable
              as List<DocumentLayer>,
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
      List<DocumentLayer> layers,
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

  /// Create a copy of DocumentPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? animations = null,
    Object? layers = null,
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
      layers: null == layers
          ? _value._layers
          : layers // ignore: cast_nullable_to_non_nullable
              as List<DocumentLayer>,
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
      final List<DocumentLayer> layers = const [],
      final List<Background> backgrounds = const [],
      final List<Waypoint> waypoints = const [],
      final List<Area> areas = const [],
      final Map<String, dynamic> extra = const {}})
      : _animations = animations,
        _layers = layers,
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

  final List<DocumentLayer> _layers;
  @override
  @JsonKey()
  List<DocumentLayer> get layers {
    if (_layers is EqualUnmodifiableListView) return _layers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_layers);
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
    return 'DocumentPage(animations: $animations, layers: $layers, backgrounds: $backgrounds, waypoints: $waypoints, areas: $areas, extra: $extra)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentPageImpl &&
            const DeepCollectionEquality()
                .equals(other._animations, _animations) &&
            const DeepCollectionEquality().equals(other._layers, _layers) &&
            const DeepCollectionEquality()
                .equals(other._backgrounds, _backgrounds) &&
            const DeepCollectionEquality()
                .equals(other._waypoints, _waypoints) &&
            const DeepCollectionEquality().equals(other._areas, _areas) &&
            const DeepCollectionEquality().equals(other._extra, _extra));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_animations),
      const DeepCollectionEquality().hash(_layers),
      const DeepCollectionEquality().hash(_backgrounds),
      const DeepCollectionEquality().hash(_waypoints),
      const DeepCollectionEquality().hash(_areas),
      const DeepCollectionEquality().hash(_extra));

  /// Create a copy of DocumentPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      final List<DocumentLayer> layers,
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
  List<DocumentLayer> get layers;
  @override
  List<Background> get backgrounds;
  @override
  List<Waypoint> get waypoints;
  @override
  List<Area> get areas;
  @override
  Map<String, dynamic> get extra;

  /// Create a copy of DocumentPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentPageImplCopyWith<_$DocumentPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DocumentLayer _$DocumentLayerFromJson(Map<String, dynamic> json) {
  return _DocumentLayer.fromJson(json);
}

/// @nodoc
mixin _$DocumentLayer {
  String get name => throw _privateConstructorUsedError;
  List<PadElement> get content => throw _privateConstructorUsedError;

  /// Serializes this DocumentLayer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DocumentLayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentLayerCopyWith<DocumentLayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentLayerCopyWith<$Res> {
  factory $DocumentLayerCopyWith(
          DocumentLayer value, $Res Function(DocumentLayer) then) =
      _$DocumentLayerCopyWithImpl<$Res, DocumentLayer>;
  @useResult
  $Res call({String name, List<PadElement> content});
}

/// @nodoc
class _$DocumentLayerCopyWithImpl<$Res, $Val extends DocumentLayer>
    implements $DocumentLayerCopyWith<$Res> {
  _$DocumentLayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentLayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as List<PadElement>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentLayerImplCopyWith<$Res>
    implements $DocumentLayerCopyWith<$Res> {
  factory _$$DocumentLayerImplCopyWith(
          _$DocumentLayerImpl value, $Res Function(_$DocumentLayerImpl) then) =
      __$$DocumentLayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<PadElement> content});
}

/// @nodoc
class __$$DocumentLayerImplCopyWithImpl<$Res>
    extends _$DocumentLayerCopyWithImpl<$Res, _$DocumentLayerImpl>
    implements _$$DocumentLayerImplCopyWith<$Res> {
  __$$DocumentLayerImplCopyWithImpl(
      _$DocumentLayerImpl _value, $Res Function(_$DocumentLayerImpl) _then)
      : super(_value, _then);

  /// Create a copy of DocumentLayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? content = null,
  }) {
    return _then(_$DocumentLayerImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<PadElement>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentLayerImpl extends _DocumentLayer {
  const _$DocumentLayerImpl(
      {this.name = '', final List<PadElement> content = const []})
      : _content = content,
        super._();

  factory _$DocumentLayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentLayerImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  final List<PadElement> _content;
  @override
  @JsonKey()
  List<PadElement> get content {
    if (_content is EqualUnmodifiableListView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_content);
  }

  @override
  String toString() {
    return 'DocumentLayer(name: $name, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentLayerImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._content, _content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_content));

  /// Create a copy of DocumentLayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentLayerImplCopyWith<_$DocumentLayerImpl> get copyWith =>
      __$$DocumentLayerImplCopyWithImpl<_$DocumentLayerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentLayerImplToJson(
      this,
    );
  }
}

abstract class _DocumentLayer extends DocumentLayer {
  const factory _DocumentLayer(
      {final String name,
      final List<PadElement> content}) = _$DocumentLayerImpl;
  const _DocumentLayer._() : super._();

  factory _DocumentLayer.fromJson(Map<String, dynamic> json) =
      _$DocumentLayerImpl.fromJson;

  @override
  String get name;
  @override
  List<PadElement> get content;

  /// Create a copy of DocumentLayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentLayerImplCopyWith<_$DocumentLayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
