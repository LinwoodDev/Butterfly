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

AssetLocation _$AssetLocationFromJson(Map<String, dynamic> json) {
  return _AssetLocation.fromJson(json);
}

/// @nodoc
mixin _$AssetLocation {
  String get remote => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  bool get absolute => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssetLocationCopyWith<AssetLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetLocationCopyWith<$Res> {
  factory $AssetLocationCopyWith(
          AssetLocation value, $Res Function(AssetLocation) then) =
      _$AssetLocationCopyWithImpl<$Res, AssetLocation>;
  @useResult
  $Res call({String remote, String path, bool absolute});
}

/// @nodoc
class _$AssetLocationCopyWithImpl<$Res, $Val extends AssetLocation>
    implements $AssetLocationCopyWith<$Res> {
  _$AssetLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remote = null,
    Object? path = null,
    Object? absolute = null,
  }) {
    return _then(_value.copyWith(
      remote: null == remote
          ? _value.remote
          : remote // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      absolute: null == absolute
          ? _value.absolute
          : absolute // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AssetLocationCopyWith<$Res>
    implements $AssetLocationCopyWith<$Res> {
  factory _$$_AssetLocationCopyWith(
          _$_AssetLocation value, $Res Function(_$_AssetLocation) then) =
      __$$_AssetLocationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String remote, String path, bool absolute});
}

/// @nodoc
class __$$_AssetLocationCopyWithImpl<$Res>
    extends _$AssetLocationCopyWithImpl<$Res, _$_AssetLocation>
    implements _$$_AssetLocationCopyWith<$Res> {
  __$$_AssetLocationCopyWithImpl(
      _$_AssetLocation _value, $Res Function(_$_AssetLocation) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remote = null,
    Object? path = null,
    Object? absolute = null,
  }) {
    return _then(_$_AssetLocation(
      remote: null == remote
          ? _value.remote
          : remote // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      absolute: null == absolute
          ? _value.absolute
          : absolute // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AssetLocation extends _AssetLocation {
  const _$_AssetLocation(
      {this.remote = '', required this.path, this.absolute = false})
      : super._();

  factory _$_AssetLocation.fromJson(Map<String, dynamic> json) =>
      _$$_AssetLocationFromJson(json);

  @override
  @JsonKey()
  final String remote;
  @override
  final String path;
  @override
  @JsonKey()
  final bool absolute;

  @override
  String toString() {
    return 'AssetLocation(remote: $remote, path: $path, absolute: $absolute)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AssetLocation &&
            (identical(other.remote, remote) || other.remote == remote) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.absolute, absolute) ||
                other.absolute == absolute));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, remote, path, absolute);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AssetLocationCopyWith<_$_AssetLocation> get copyWith =>
      __$$_AssetLocationCopyWithImpl<_$_AssetLocation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AssetLocationToJson(
      this,
    );
  }
}

abstract class _AssetLocation extends AssetLocation {
  const factory _AssetLocation(
      {final String remote,
      required final String path,
      final bool absolute}) = _$_AssetLocation;
  const _AssetLocation._() : super._();

  factory _AssetLocation.fromJson(Map<String, dynamic> json) =
      _$_AssetLocation.fromJson;

  @override
  String get remote;
  @override
  String get path;
  @override
  bool get absolute;
  @override
  @JsonKey(ignore: true)
  _$$_AssetLocationCopyWith<_$_AssetLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

AppDocument _$AppDocumentFromJson(Map<String, dynamic> json) {
  return _AppDocument.fromJson(json);
}

/// @nodoc
mixin _$AppDocument {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<PadElement> get content => throw _privateConstructorUsedError;
  Background get background => throw _privateConstructorUsedError;
  List<Waypoint> get waypoints => throw _privateConstructorUsedError;
  List<Area> get areas => throw _privateConstructorUsedError;
  List<ExportPreset> get exportPresets => throw _privateConstructorUsedError;
  List<ButterflyPack> get packs => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<Painter> get painters => throw _privateConstructorUsedError;
  ToolOption get tool => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppDocumentCopyWith<AppDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppDocumentCopyWith<$Res> {
  factory $AppDocumentCopyWith(
          AppDocument value, $Res Function(AppDocument) then) =
      _$AppDocumentCopyWithImpl<$Res, AppDocument>;
  @useResult
  $Res call(
      {String name,
      String description,
      List<PadElement> content,
      Background background,
      List<Waypoint> waypoints,
      List<Area> areas,
      List<ExportPreset> exportPresets,
      List<ButterflyPack> packs,
      DateTime createdAt,
      DateTime? updatedAt,
      List<Painter> painters,
      ToolOption tool});

  $BackgroundCopyWith<$Res> get background;
  $ToolOptionCopyWith<$Res> get tool;
}

/// @nodoc
class _$AppDocumentCopyWithImpl<$Res, $Val extends AppDocument>
    implements $AppDocumentCopyWith<$Res> {
  _$AppDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? content = null,
    Object? background = null,
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
abstract class _$$_AppDocumentCopyWith<$Res>
    implements $AppDocumentCopyWith<$Res> {
  factory _$$_AppDocumentCopyWith(
          _$_AppDocument value, $Res Function(_$_AppDocument) then) =
      __$$_AppDocumentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String description,
      List<PadElement> content,
      Background background,
      List<Waypoint> waypoints,
      List<Area> areas,
      List<ExportPreset> exportPresets,
      List<ButterflyPack> packs,
      DateTime createdAt,
      DateTime? updatedAt,
      List<Painter> painters,
      ToolOption tool});

  @override
  $BackgroundCopyWith<$Res> get background;
  @override
  $ToolOptionCopyWith<$Res> get tool;
}

/// @nodoc
class __$$_AppDocumentCopyWithImpl<$Res>
    extends _$AppDocumentCopyWithImpl<$Res, _$_AppDocument>
    implements _$$_AppDocumentCopyWith<$Res> {
  __$$_AppDocumentCopyWithImpl(
      _$_AppDocument _value, $Res Function(_$_AppDocument) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? content = null,
    Object? background = null,
    Object? waypoints = null,
    Object? areas = null,
    Object? exportPresets = null,
    Object? packs = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? painters = null,
    Object? tool = null,
  }) {
    return _then(_$_AppDocument(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$_AppDocument extends _AppDocument {
  const _$_AppDocument(
      {required this.name,
      this.description = '',
      final List<PadElement> content = const [],
      this.background = const Background.empty(),
      final List<Waypoint> waypoints = const [],
      final List<Area> areas = const [],
      final List<ExportPreset> exportPresets = const [],
      final List<ButterflyPack> packs = const [],
      required this.createdAt,
      this.updatedAt,
      final List<Painter> painters = const [],
      this.tool = const ToolOption()})
      : _content = content,
        _waypoints = waypoints,
        _areas = areas,
        _exportPresets = exportPresets,
        _packs = packs,
        _painters = painters,
        super._();

  factory _$_AppDocument.fromJson(Map<String, dynamic> json) =>
      _$$_AppDocumentFromJson(json);

  @override
  final String name;
  @override
  @JsonKey()
  final String description;
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

  final List<ButterflyPack> _packs;
  @override
  @JsonKey()
  List<ButterflyPack> get packs {
    if (_packs is EqualUnmodifiableListView) return _packs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_packs);
  }

  @override
  final DateTime createdAt;
  @override
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
    return 'AppDocument(name: $name, description: $description, content: $content, background: $background, waypoints: $waypoints, areas: $areas, exportPresets: $exportPresets, packs: $packs, createdAt: $createdAt, updatedAt: $updatedAt, painters: $painters, tool: $tool)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppDocument &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.background, background) ||
                other.background == background) &&
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
      const DeepCollectionEquality().hash(_content),
      background,
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
  _$$_AppDocumentCopyWith<_$_AppDocument> get copyWith =>
      __$$_AppDocumentCopyWithImpl<_$_AppDocument>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppDocumentToJson(
      this,
    );
  }
}

abstract class _AppDocument extends AppDocument {
  const factory _AppDocument(
      {required final String name,
      final String description,
      final List<PadElement> content,
      final Background background,
      final List<Waypoint> waypoints,
      final List<Area> areas,
      final List<ExportPreset> exportPresets,
      final List<ButterflyPack> packs,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final List<Painter> painters,
      final ToolOption tool}) = _$_AppDocument;
  const _AppDocument._() : super._();

  factory _AppDocument.fromJson(Map<String, dynamic> json) =
      _$_AppDocument.fromJson;

  @override
  String get name;
  @override
  String get description;
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
  List<ButterflyPack> get packs;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  List<Painter> get painters;
  @override
  ToolOption get tool;
  @override
  @JsonKey(ignore: true)
  _$$_AppDocumentCopyWith<_$_AppDocument> get copyWith =>
      throw _privateConstructorUsedError;
}
