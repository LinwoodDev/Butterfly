// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
      _$AssetLocationCopyWithImpl<$Res>;
  $Res call({String remote, String path, bool absolute});
}

/// @nodoc
class _$AssetLocationCopyWithImpl<$Res>
    implements $AssetLocationCopyWith<$Res> {
  _$AssetLocationCopyWithImpl(this._value, this._then);

  final AssetLocation _value;
  // ignore: unused_field
  final $Res Function(AssetLocation) _then;

  @override
  $Res call({
    Object? remote = freezed,
    Object? path = freezed,
    Object? absolute = freezed,
  }) {
    return _then(_value.copyWith(
      remote: remote == freezed
          ? _value.remote
          : remote // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      absolute: absolute == freezed
          ? _value.absolute
          : absolute // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_AssetLocationCopyWith<$Res>
    implements $AssetLocationCopyWith<$Res> {
  factory _$$_AssetLocationCopyWith(
          _$_AssetLocation value, $Res Function(_$_AssetLocation) then) =
      __$$_AssetLocationCopyWithImpl<$Res>;
  @override
  $Res call({String remote, String path, bool absolute});
}

/// @nodoc
class __$$_AssetLocationCopyWithImpl<$Res>
    extends _$AssetLocationCopyWithImpl<$Res>
    implements _$$_AssetLocationCopyWith<$Res> {
  __$$_AssetLocationCopyWithImpl(
      _$_AssetLocation _value, $Res Function(_$_AssetLocation) _then)
      : super(_value, (v) => _then(v as _$_AssetLocation));

  @override
  _$_AssetLocation get _value => super._value as _$_AssetLocation;

  @override
  $Res call({
    Object? remote = freezed,
    Object? path = freezed,
    Object? absolute = freezed,
  }) {
    return _then(_$_AssetLocation(
      remote: remote == freezed
          ? _value.remote
          : remote // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      absolute: absolute == freezed
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
            const DeepCollectionEquality().equals(other.remote, remote) &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality().equals(other.absolute, absolute));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(remote),
      const DeepCollectionEquality().hash(path),
      const DeepCollectionEquality().hash(absolute));

  @JsonKey(ignore: true)
  @override
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
  List<ColorPalette> get palettes => throw _privateConstructorUsedError;
  List<Waypoint> get waypoints => throw _privateConstructorUsedError;
  List<Area> get areas => throw _privateConstructorUsedError;
  List<ExportPreset> get exportPresets => throw _privateConstructorUsedError;
  List<ButterflyPack> get packs => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  HandProperty get handProperty => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<Painter> get painters => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppDocumentCopyWith<AppDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppDocumentCopyWith<$Res> {
  factory $AppDocumentCopyWith(
          AppDocument value, $Res Function(AppDocument) then) =
      _$AppDocumentCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String description,
      List<PadElement> content,
      Background background,
      List<ColorPalette> palettes,
      List<Waypoint> waypoints,
      List<Area> areas,
      List<ExportPreset> exportPresets,
      List<ButterflyPack> packs,
      DateTime createdAt,
      HandProperty handProperty,
      DateTime? updatedAt,
      List<Painter> painters});

  $BackgroundCopyWith<$Res> get background;
}

/// @nodoc
class _$AppDocumentCopyWithImpl<$Res> implements $AppDocumentCopyWith<$Res> {
  _$AppDocumentCopyWithImpl(this._value, this._then);

  final AppDocument _value;
  // ignore: unused_field
  final $Res Function(AppDocument) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? content = freezed,
    Object? background = freezed,
    Object? palettes = freezed,
    Object? waypoints = freezed,
    Object? areas = freezed,
    Object? exportPresets = freezed,
    Object? packs = freezed,
    Object? createdAt = freezed,
    Object? handProperty = freezed,
    Object? updatedAt = freezed,
    Object? painters = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as List<PadElement>,
      background: background == freezed
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as Background,
      palettes: palettes == freezed
          ? _value.palettes
          : palettes // ignore: cast_nullable_to_non_nullable
              as List<ColorPalette>,
      waypoints: waypoints == freezed
          ? _value.waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<Waypoint>,
      areas: areas == freezed
          ? _value.areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<Area>,
      exportPresets: exportPresets == freezed
          ? _value.exportPresets
          : exportPresets // ignore: cast_nullable_to_non_nullable
              as List<ExportPreset>,
      packs: packs == freezed
          ? _value.packs
          : packs // ignore: cast_nullable_to_non_nullable
              as List<ButterflyPack>,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      handProperty: handProperty == freezed
          ? _value.handProperty
          : handProperty // ignore: cast_nullable_to_non_nullable
              as HandProperty,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      painters: painters == freezed
          ? _value.painters
          : painters // ignore: cast_nullable_to_non_nullable
              as List<Painter>,
    ));
  }

  @override
  $BackgroundCopyWith<$Res> get background {
    return $BackgroundCopyWith<$Res>(_value.background, (value) {
      return _then(_value.copyWith(background: value));
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
  $Res call(
      {String name,
      String description,
      List<PadElement> content,
      Background background,
      List<ColorPalette> palettes,
      List<Waypoint> waypoints,
      List<Area> areas,
      List<ExportPreset> exportPresets,
      List<ButterflyPack> packs,
      DateTime createdAt,
      HandProperty handProperty,
      DateTime? updatedAt,
      List<Painter> painters});

  @override
  $BackgroundCopyWith<$Res> get background;
}

/// @nodoc
class __$$_AppDocumentCopyWithImpl<$Res> extends _$AppDocumentCopyWithImpl<$Res>
    implements _$$_AppDocumentCopyWith<$Res> {
  __$$_AppDocumentCopyWithImpl(
      _$_AppDocument _value, $Res Function(_$_AppDocument) _then)
      : super(_value, (v) => _then(v as _$_AppDocument));

  @override
  _$_AppDocument get _value => super._value as _$_AppDocument;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? content = freezed,
    Object? background = freezed,
    Object? palettes = freezed,
    Object? waypoints = freezed,
    Object? areas = freezed,
    Object? exportPresets = freezed,
    Object? packs = freezed,
    Object? createdAt = freezed,
    Object? handProperty = freezed,
    Object? updatedAt = freezed,
    Object? painters = freezed,
  }) {
    return _then(_$_AppDocument(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<PadElement>,
      background: background == freezed
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as Background,
      palettes: palettes == freezed
          ? _value._palettes
          : palettes // ignore: cast_nullable_to_non_nullable
              as List<ColorPalette>,
      waypoints: waypoints == freezed
          ? _value._waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<Waypoint>,
      areas: areas == freezed
          ? _value._areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<Area>,
      exportPresets: exportPresets == freezed
          ? _value._exportPresets
          : exportPresets // ignore: cast_nullable_to_non_nullable
              as List<ExportPreset>,
      packs: packs == freezed
          ? _value._packs
          : packs // ignore: cast_nullable_to_non_nullable
              as List<ButterflyPack>,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      handProperty: handProperty == freezed
          ? _value.handProperty
          : handProperty // ignore: cast_nullable_to_non_nullable
              as HandProperty,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      painters: painters == freezed
          ? _value._painters
          : painters // ignore: cast_nullable_to_non_nullable
              as List<Painter>,
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
      final List<ColorPalette> palettes = const [],
      final List<Waypoint> waypoints = const [],
      final List<Area> areas = const [],
      final List<ExportPreset> exportPresets = const [],
      final List<ButterflyPack> packs = const [],
      required this.createdAt,
      this.handProperty = const HandProperty(),
      this.updatedAt,
      final List<Painter> painters = const []})
      : _content = content,
        _palettes = palettes,
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
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_content);
  }

  @override
  @JsonKey()
  final Background background;
  final List<ColorPalette> _palettes;
  @override
  @JsonKey()
  List<ColorPalette> get palettes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_palettes);
  }

  final List<Waypoint> _waypoints;
  @override
  @JsonKey()
  List<Waypoint> get waypoints {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_waypoints);
  }

  final List<Area> _areas;
  @override
  @JsonKey()
  List<Area> get areas {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  final List<ExportPreset> _exportPresets;
  @override
  @JsonKey()
  List<ExportPreset> get exportPresets {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exportPresets);
  }

  final List<ButterflyPack> _packs;
  @override
  @JsonKey()
  List<ButterflyPack> get packs {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_packs);
  }

  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final HandProperty handProperty;
  @override
  final DateTime? updatedAt;
  final List<Painter> _painters;
  @override
  @JsonKey()
  List<Painter> get painters {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_painters);
  }

  @override
  String toString() {
    return 'AppDocument(name: $name, description: $description, content: $content, background: $background, palettes: $palettes, waypoints: $waypoints, areas: $areas, exportPresets: $exportPresets, packs: $packs, createdAt: $createdAt, handProperty: $handProperty, updatedAt: $updatedAt, painters: $painters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppDocument &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            const DeepCollectionEquality()
                .equals(other.background, background) &&
            const DeepCollectionEquality().equals(other._palettes, _palettes) &&
            const DeepCollectionEquality()
                .equals(other._waypoints, _waypoints) &&
            const DeepCollectionEquality().equals(other._areas, _areas) &&
            const DeepCollectionEquality()
                .equals(other._exportPresets, _exportPresets) &&
            const DeepCollectionEquality().equals(other._packs, _packs) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality()
                .equals(other.handProperty, handProperty) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality().equals(other._painters, _painters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(_content),
      const DeepCollectionEquality().hash(background),
      const DeepCollectionEquality().hash(_palettes),
      const DeepCollectionEquality().hash(_waypoints),
      const DeepCollectionEquality().hash(_areas),
      const DeepCollectionEquality().hash(_exportPresets),
      const DeepCollectionEquality().hash(_packs),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(handProperty),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(_painters));

  @JsonKey(ignore: true)
  @override
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
      final List<ColorPalette> palettes,
      final List<Waypoint> waypoints,
      final List<Area> areas,
      final List<ExportPreset> exportPresets,
      final List<ButterflyPack> packs,
      required final DateTime createdAt,
      final HandProperty handProperty,
      final DateTime? updatedAt,
      final List<Painter> painters}) = _$_AppDocument;
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
  List<ColorPalette> get palettes;
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
  HandProperty get handProperty;
  @override
  DateTime? get updatedAt;
  @override
  List<Painter> get painters;
  @override
  @JsonKey(ignore: true)
  _$$_AppDocumentCopyWith<_$_AppDocument> get copyWith =>
      throw _privateConstructorUsedError;
}
