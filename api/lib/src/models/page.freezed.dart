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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DocumentPage _$DocumentPageFromJson(Map<String, dynamic> json) {
  return _DocumentPage.fromJson(json);
}

/// @nodoc
mixin _$DocumentPage {
  List<AnimationTrack> get animations => throw _privateConstructorUsedError;
  List<PadElement> get content => throw _privateConstructorUsedError;
  Background get background => throw _privateConstructorUsedError;
  List<Waypoint> get waypoints => throw _privateConstructorUsedError;
  List<Area> get areas => throw _privateConstructorUsedError;
  List<ExportPreset> get exportPresets => throw _privateConstructorUsedError;

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
      Background background,
      List<Waypoint> waypoints,
      List<Area> areas,
      List<ExportPreset> exportPresets});

  $BackgroundCopyWith<$Res> get background;
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
    Object? background = null,
    Object? waypoints = null,
    Object? areas = null,
    Object? exportPresets = null,
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
      background: null == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as Background,
      waypoints: null == waypoints
          ? _value.waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<Waypoint>,
      areas: null == areas
          ? _value.areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<Area>,
      exportPresets: null == exportPresets
          ? _value.exportPresets
          : exportPresets // ignore: cast_nullable_to_non_nullable
              as List<ExportPreset>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BackgroundCopyWith<$Res> get background {
    return $BackgroundCopyWith<$Res>(_value.background, (value) {
      return _then(_value.copyWith(background: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DocumentPageCopyWith<$Res>
    implements $DocumentPageCopyWith<$Res> {
  factory _$$_DocumentPageCopyWith(
          _$_DocumentPage value, $Res Function(_$_DocumentPage) then) =
      __$$_DocumentPageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<AnimationTrack> animations,
      List<PadElement> content,
      Background background,
      List<Waypoint> waypoints,
      List<Area> areas,
      List<ExportPreset> exportPresets});

  @override
  $BackgroundCopyWith<$Res> get background;
}

/// @nodoc
class __$$_DocumentPageCopyWithImpl<$Res>
    extends _$DocumentPageCopyWithImpl<$Res, _$_DocumentPage>
    implements _$$_DocumentPageCopyWith<$Res> {
  __$$_DocumentPageCopyWithImpl(
      _$_DocumentPage _value, $Res Function(_$_DocumentPage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? animations = null,
    Object? content = null,
    Object? background = null,
    Object? waypoints = null,
    Object? areas = null,
    Object? exportPresets = null,
  }) {
    return _then(_$_DocumentPage(
      animations: null == animations
          ? _value._animations
          : animations // ignore: cast_nullable_to_non_nullable
              as List<AnimationTrack>,
      content: null == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<PadElement>,
      background: null == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as Background,
      waypoints: null == waypoints
          ? _value._waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<Waypoint>,
      areas: null == areas
          ? _value._areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<Area>,
      exportPresets: null == exportPresets
          ? _value._exportPresets
          : exportPresets // ignore: cast_nullable_to_non_nullable
              as List<ExportPreset>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DocumentPage extends _DocumentPage {
  const _$_DocumentPage(
      {final List<AnimationTrack> animations = const [],
      final List<PadElement> content = const [],
      this.background = const Background.empty(),
      final List<Waypoint> waypoints = const [],
      final List<Area> areas = const [],
      final List<ExportPreset> exportPresets = const []})
      : _animations = animations,
        _content = content,
        _waypoints = waypoints,
        _areas = areas,
        _exportPresets = exportPresets,
        super._();

  factory _$_DocumentPage.fromJson(Map<String, dynamic> json) =>
      _$$_DocumentPageFromJson(json);

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

  @override
  @JsonKey()
  final Background background;
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

  final List<ExportPreset> _exportPresets;
  @override
  @JsonKey()
  List<ExportPreset> get exportPresets {
    if (_exportPresets is EqualUnmodifiableListView) return _exportPresets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exportPresets);
  }

  @override
  String toString() {
    return 'DocumentPage(animations: $animations, content: $content, background: $background, waypoints: $waypoints, areas: $areas, exportPresets: $exportPresets)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DocumentPage &&
            const DeepCollectionEquality()
                .equals(other._animations, _animations) &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.background, background) ||
                other.background == background) &&
            const DeepCollectionEquality()
                .equals(other._waypoints, _waypoints) &&
            const DeepCollectionEquality().equals(other._areas, _areas) &&
            const DeepCollectionEquality()
                .equals(other._exportPresets, _exportPresets));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_animations),
      const DeepCollectionEquality().hash(_content),
      background,
      const DeepCollectionEquality().hash(_waypoints),
      const DeepCollectionEquality().hash(_areas),
      const DeepCollectionEquality().hash(_exportPresets));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DocumentPageCopyWith<_$_DocumentPage> get copyWith =>
      __$$_DocumentPageCopyWithImpl<_$_DocumentPage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DocumentPageToJson(
      this,
    );
  }
}

abstract class _DocumentPage extends DocumentPage {
  const factory _DocumentPage(
      {final List<AnimationTrack> animations,
      final List<PadElement> content,
      final Background background,
      final List<Waypoint> waypoints,
      final List<Area> areas,
      final List<ExportPreset> exportPresets}) = _$_DocumentPage;
  const _DocumentPage._() : super._();

  factory _DocumentPage.fromJson(Map<String, dynamic> json) =
      _$_DocumentPage.fromJson;

  @override
  List<AnimationTrack> get animations;
  @override
  List<PadElement> get content;
  @override
  Background get background;
  @override
  List<Waypoint> get waypoints;
  @override
  List<Area> get areas;
  @override
  List<ExportPreset> get exportPresets;
  @override
  @JsonKey(ignore: true)
  _$$_DocumentPageCopyWith<_$_DocumentPage> get copyWith =>
      throw _privateConstructorUsedError;
}
