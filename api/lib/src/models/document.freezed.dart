// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NoteData _$NoteDataFromJson(Map<String, dynamic> json) {
  return AppDocument.fromJson(json);
}

/// @nodoc
mixin _$NoteData {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get thumbnail => throw _privateConstructorUsedError;
  List<PadElement> get content => throw _privateConstructorUsedError;
  Background get background => throw _privateConstructorUsedError;
  List<AnimationTrack> get animations => throw _privateConstructorUsedError;
  List<Waypoint> get waypoints => throw _privateConstructorUsedError;
  List<Area> get areas => throw _privateConstructorUsedError;
  List<ExportPreset> get exportPresets => throw _privateConstructorUsedError;
  List<ButterflyPack> get packs => throw _privateConstructorUsedError;
  @DateTimeJsonConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @DateTimeJsonConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<Painter> get painters => throw _privateConstructorUsedError;
  ToolOption get tool => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name,
            String description,
            String thumbnail,
            List<PadElement> content,
            Background background,
            List<AnimationTrack> animations,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)
        document,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String name,
            String description,
            String thumbnail,
            List<PadElement> content,
            Background background,
            List<AnimationTrack> animations,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)?
        document,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String name,
            String description,
            String thumbnail,
            List<PadElement> content,
            Background background,
            List<AnimationTrack> animations,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)?
        document,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppDocument value) document,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppDocument value)? document,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppDocument value)? document,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoteDataCopyWith<NoteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteDataCopyWith<$Res> {
  factory $NoteDataCopyWith(NoteData value, $Res Function(NoteData) then) =
      _$NoteDataCopyWithImpl<$Res, NoteData>;
  @useResult
  $Res call(
      {String name,
      String description,
      String thumbnail,
      List<PadElement> content,
      Background background,
      List<AnimationTrack> animations,
      List<Waypoint> waypoints,
      List<Area> areas,
      List<ExportPreset> exportPresets,
      List<ButterflyPack> packs,
      @DateTimeJsonConverter() DateTime createdAt,
      @DateTimeJsonConverter() DateTime? updatedAt,
      List<Painter> painters,
      ToolOption tool});

  $BackgroundCopyWith<$Res> get background;
  $ToolOptionCopyWith<$Res> get tool;
}

/// @nodoc
class _$NoteDataCopyWithImpl<$Res, $Val extends NoteData>
    implements $NoteDataCopyWith<$Res> {
  _$NoteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? thumbnail = null,
    Object? content = null,
    Object? background = null,
    Object? animations = null,
    Object? waypoints = null,
    Object? areas = null,
    Object? exportPresets = null,
    Object? packs = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? painters = null,
    Object? tool = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as List<PadElement>,
      background: null == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as Background,
      animations: null == animations
          ? _value.animations
          : animations // ignore: cast_nullable_to_non_nullable
              as List<AnimationTrack>,
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
      packs: null == packs
          ? _value.packs
          : packs // ignore: cast_nullable_to_non_nullable
              as List<ButterflyPack>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      painters: null == painters
          ? _value.painters
          : painters // ignore: cast_nullable_to_non_nullable
              as List<Painter>,
      tool: null == tool
          ? _value.tool
          : tool // ignore: cast_nullable_to_non_nullable
              as ToolOption,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BackgroundCopyWith<$Res> get background {
    return $BackgroundCopyWith<$Res>(_value.background, (value) {
      return _then(_value.copyWith(background: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ToolOptionCopyWith<$Res> get tool {
    return $ToolOptionCopyWith<$Res>(_value.tool, (value) {
      return _then(_value.copyWith(tool: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppDocumentCopyWith<$Res> implements $NoteDataCopyWith<$Res> {
  factory _$$AppDocumentCopyWith(
          _$AppDocument value, $Res Function(_$AppDocument) then) =
      __$$AppDocumentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String description,
      String thumbnail,
      List<PadElement> content,
      Background background,
      List<AnimationTrack> animations,
      List<Waypoint> waypoints,
      List<Area> areas,
      List<ExportPreset> exportPresets,
      List<ButterflyPack> packs,
      @DateTimeJsonConverter() DateTime createdAt,
      @DateTimeJsonConverter() DateTime? updatedAt,
      List<Painter> painters,
      ToolOption tool});

  @override
  $BackgroundCopyWith<$Res> get background;
  @override
  $ToolOptionCopyWith<$Res> get tool;
}

/// @nodoc
class __$$AppDocumentCopyWithImpl<$Res>
    extends _$NoteDataCopyWithImpl<$Res, _$AppDocument>
    implements _$$AppDocumentCopyWith<$Res> {
  __$$AppDocumentCopyWithImpl(
      _$AppDocument _value, $Res Function(_$AppDocument) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? thumbnail = null,
    Object? content = null,
    Object? background = null,
    Object? animations = null,
    Object? waypoints = null,
    Object? areas = null,
    Object? exportPresets = null,
    Object? packs = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? painters = null,
    Object? tool = null,
  }) {
    return _then(_$AppDocument(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<PadElement>,
      background: null == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as Background,
      animations: null == animations
          ? _value._animations
          : animations // ignore: cast_nullable_to_non_nullable
              as List<AnimationTrack>,
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
      packs: null == packs
          ? _value._packs
          : packs // ignore: cast_nullable_to_non_nullable
              as List<ButterflyPack>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      painters: null == painters
          ? _value._painters
          : painters // ignore: cast_nullable_to_non_nullable
              as List<Painter>,
      tool: null == tool
          ? _value.tool
          : tool // ignore: cast_nullable_to_non_nullable
              as ToolOption,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppDocument extends AppDocument {
  const _$AppDocument(
      {this.name = '',
      this.description = '',
      this.thumbnail = '',
      final List<PadElement> content = const [],
      this.background = const Background.empty(),
      final List<AnimationTrack> animations = const [],
      final List<Waypoint> waypoints = const [],
      final List<Area> areas = const [],
      final List<ExportPreset> exportPresets = const [],
      final List<ButterflyPack> packs = const [],
      @DateTimeJsonConverter() required this.createdAt,
      @DateTimeJsonConverter() this.updatedAt,
      final List<Painter> painters = const [],
      this.tool = const ToolOption()})
      : _content = content,
        _animations = animations,
        _waypoints = waypoints,
        _areas = areas,
        _exportPresets = exportPresets,
        _packs = packs,
        _painters = painters,
        super._();

  factory _$AppDocument.fromJson(Map<String, dynamic> json) =>
      _$$AppDocumentFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String thumbnail;
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
  final List<AnimationTrack> _animations;
  @override
  @JsonKey()
  List<AnimationTrack> get animations {
    if (_animations is EqualUnmodifiableListView) return _animations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_animations);
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

  final List<ExportPreset> _exportPresets;
  @override
  @JsonKey()
  List<ExportPreset> get exportPresets {
    if (_exportPresets is EqualUnmodifiableListView) return _exportPresets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exportPresets);
  }

  final List<ButterflyPack> _packs;
  @override
  @JsonKey()
  List<ButterflyPack> get packs {
    if (_packs is EqualUnmodifiableListView) return _packs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_packs);
  }

  @override
  @DateTimeJsonConverter()
  final DateTime createdAt;
  @override
  @DateTimeJsonConverter()
  final DateTime? updatedAt;
  final List<Painter> _painters;
  @override
  @JsonKey()
  List<Painter> get painters {
    if (_painters is EqualUnmodifiableListView) return _painters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_painters);
  }

  @override
  @JsonKey()
  final ToolOption tool;

  @override
  String toString() {
    return 'NoteData.document(name: $name, description: $description, thumbnail: $thumbnail, content: $content, background: $background, animations: $animations, waypoints: $waypoints, areas: $areas, exportPresets: $exportPresets, packs: $packs, createdAt: $createdAt, updatedAt: $updatedAt, painters: $painters, tool: $tool)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppDocument &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.background, background) ||
                other.background == background) &&
            const DeepCollectionEquality()
                .equals(other._animations, _animations) &&
            const DeepCollectionEquality()
                .equals(other._waypoints, _waypoints) &&
            const DeepCollectionEquality().equals(other._areas, _areas) &&
            const DeepCollectionEquality()
                .equals(other._exportPresets, _exportPresets) &&
            const DeepCollectionEquality().equals(other._packs, _packs) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._painters, _painters) &&
            (identical(other.tool, tool) || other.tool == tool));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      description,
      thumbnail,
      const DeepCollectionEquality().hash(_content),
      background,
      const DeepCollectionEquality().hash(_animations),
      const DeepCollectionEquality().hash(_waypoints),
      const DeepCollectionEquality().hash(_areas),
      const DeepCollectionEquality().hash(_exportPresets),
      const DeepCollectionEquality().hash(_packs),
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_painters),
      tool);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppDocumentCopyWith<_$AppDocument> get copyWith =>
      __$$AppDocumentCopyWithImpl<_$AppDocument>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name,
            String description,
            String thumbnail,
            List<PadElement> content,
            Background background,
            List<AnimationTrack> animations,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)
        document,
  }) {
    return document(
        name,
        description,
        thumbnail,
        content,
        background,
        animations,
        waypoints,
        areas,
        exportPresets,
        packs,
        createdAt,
        updatedAt,
        painters,
        tool);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String name,
            String description,
            String thumbnail,
            List<PadElement> content,
            Background background,
            List<AnimationTrack> animations,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)?
        document,
  }) {
    return document?.call(
        name,
        description,
        thumbnail,
        content,
        background,
        animations,
        waypoints,
        areas,
        exportPresets,
        packs,
        createdAt,
        updatedAt,
        painters,
        tool);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String name,
            String description,
            String thumbnail,
            List<PadElement> content,
            Background background,
            List<AnimationTrack> animations,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)?
        document,
    required TResult orElse(),
  }) {
    if (document != null) {
      return document(
          name,
          description,
          thumbnail,
          content,
          background,
          animations,
          waypoints,
          areas,
          exportPresets,
          packs,
          createdAt,
          updatedAt,
          painters,
          tool);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppDocument value) document,
  }) {
    return document(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppDocument value)? document,
  }) {
    return document?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppDocument value)? document,
    required TResult orElse(),
  }) {
    if (document != null) {
      return document(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AppDocumentToJson(
      this,
    );
  }
}

abstract class AppDocument extends NoteData {
  const factory AppDocument(
      {final String name,
      final String description,
      final String thumbnail,
      final List<PadElement> content,
      final Background background,
      final List<AnimationTrack> animations,
      final List<Waypoint> waypoints,
      final List<Area> areas,
      final List<ExportPreset> exportPresets,
      final List<ButterflyPack> packs,
      @DateTimeJsonConverter() required final DateTime createdAt,
      @DateTimeJsonConverter() final DateTime? updatedAt,
      final List<Painter> painters,
      final ToolOption tool}) = _$AppDocument;
  const AppDocument._() : super._();

  factory AppDocument.fromJson(Map<String, dynamic> json) =
      _$AppDocument.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  String get thumbnail;
  @override
  List<PadElement> get content;
  @override
  Background get background;
  @override
  List<AnimationTrack> get animations;
  @override
  List<Waypoint> get waypoints;
  @override
  List<Area> get areas;
  @override
  List<ExportPreset> get exportPresets;
  @override
  List<ButterflyPack> get packs;
  @override
  @DateTimeJsonConverter()
  DateTime get createdAt;
  @override
  @DateTimeJsonConverter()
  DateTime? get updatedAt;
  @override
  List<Painter> get painters;
  @override
  ToolOption get tool;
  @override
  @JsonKey(ignore: true)
  _$$AppDocumentCopyWith<_$AppDocument> get copyWith =>
      throw _privateConstructorUsedError;
}
