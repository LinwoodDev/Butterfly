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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppDocument _$AppDocumentFromJson(Map<String, dynamic> json) {
  return _AppDocument.fromJson(json);
}

/// @nodoc
class _$AppDocumentTearOff {
  const _$AppDocumentTearOff();

  _AppDocument call(
      {required String name,
      String description = '',
      List<PadElement> content = const [],
      dynamic background = const Background.empty(),
      List<ColorPalette> palettes = const [],
      List<Waypoint> waypoints = const [],
      List<Area> areas = const [],
      required DateTime createdAt,
      HandProperty handProperty = const HandProperty(),
      DateTime? updatedAt,
      List<Painter> painters = const [
        PenPainter(),
        PathEraserPainter(),
        LabelPainter()
      ]}) {
    return _AppDocument(
      name: name,
      description: description,
      content: content,
      background: background,
      palettes: palettes,
      waypoints: waypoints,
      areas: areas,
      createdAt: createdAt,
      handProperty: handProperty,
      updatedAt: updatedAt,
      painters: painters,
    );
  }

  AppDocument fromJson(Map<String, Object?> json) {
    return AppDocument.fromJson(json);
  }
}

/// @nodoc
const $AppDocument = _$AppDocumentTearOff();

/// @nodoc
mixin _$AppDocument {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<PadElement> get content => throw _privateConstructorUsedError;
  dynamic get background => throw _privateConstructorUsedError;
  List<ColorPalette> get palettes => throw _privateConstructorUsedError;
  List<Waypoint> get waypoints => throw _privateConstructorUsedError;
  List<Area> get areas => throw _privateConstructorUsedError;
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
      dynamic background,
      List<ColorPalette> palettes,
      List<Waypoint> waypoints,
      List<Area> areas,
      DateTime createdAt,
      HandProperty handProperty,
      DateTime? updatedAt,
      List<Painter> painters});
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
              as dynamic,
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
}

/// @nodoc
abstract class _$AppDocumentCopyWith<$Res>
    implements $AppDocumentCopyWith<$Res> {
  factory _$AppDocumentCopyWith(
          _AppDocument value, $Res Function(_AppDocument) then) =
      __$AppDocumentCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String description,
      List<PadElement> content,
      dynamic background,
      List<ColorPalette> palettes,
      List<Waypoint> waypoints,
      List<Area> areas,
      DateTime createdAt,
      HandProperty handProperty,
      DateTime? updatedAt,
      List<Painter> painters});
}

/// @nodoc
class __$AppDocumentCopyWithImpl<$Res> extends _$AppDocumentCopyWithImpl<$Res>
    implements _$AppDocumentCopyWith<$Res> {
  __$AppDocumentCopyWithImpl(
      _AppDocument _value, $Res Function(_AppDocument) _then)
      : super(_value, (v) => _then(v as _AppDocument));

  @override
  _AppDocument get _value => super._value as _AppDocument;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? content = freezed,
    Object? background = freezed,
    Object? palettes = freezed,
    Object? waypoints = freezed,
    Object? areas = freezed,
    Object? createdAt = freezed,
    Object? handProperty = freezed,
    Object? updatedAt = freezed,
    Object? painters = freezed,
  }) {
    return _then(_AppDocument(
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
      background: background == freezed ? _value.background : background,
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
}

/// @nodoc
@JsonSerializable()
class _$_AppDocument extends _AppDocument {
  const _$_AppDocument(
      {required this.name,
      this.description = '',
      this.content = const [],
      this.background = const Background.empty(),
      this.palettes = const [],
      this.waypoints = const [],
      this.areas = const [],
      required this.createdAt,
      this.handProperty = const HandProperty(),
      this.updatedAt,
      this.painters = const [
        PenPainter(),
        PathEraserPainter(),
        LabelPainter()
      ]})
      : super._();

  factory _$_AppDocument.fromJson(Map<String, dynamic> json) =>
      _$$_AppDocumentFromJson(json);

  @override
  final String name;
  @JsonKey()
  @override
  final String description;
  @JsonKey()
  @override
  final List<PadElement> content;
  @JsonKey()
  @override
  final dynamic background;
  @JsonKey()
  @override
  final List<ColorPalette> palettes;
  @JsonKey()
  @override
  final List<Waypoint> waypoints;
  @JsonKey()
  @override
  final List<Area> areas;
  @override
  final DateTime createdAt;
  @JsonKey()
  @override
  final HandProperty handProperty;
  @override
  final DateTime? updatedAt;
  @JsonKey()
  @override
  final List<Painter> painters;

  @override
  String toString() {
    return 'AppDocument(name: $name, description: $description, content: $content, background: $background, palettes: $palettes, waypoints: $waypoints, areas: $areas, createdAt: $createdAt, handProperty: $handProperty, updatedAt: $updatedAt, painters: $painters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppDocument &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.content, content) &&
            const DeepCollectionEquality()
                .equals(other.background, background) &&
            const DeepCollectionEquality().equals(other.palettes, palettes) &&
            const DeepCollectionEquality().equals(other.waypoints, waypoints) &&
            const DeepCollectionEquality().equals(other.areas, areas) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality()
                .equals(other.handProperty, handProperty) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality().equals(other.painters, painters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(content),
      const DeepCollectionEquality().hash(background),
      const DeepCollectionEquality().hash(palettes),
      const DeepCollectionEquality().hash(waypoints),
      const DeepCollectionEquality().hash(areas),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(handProperty),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(painters));

  @JsonKey(ignore: true)
  @override
  _$AppDocumentCopyWith<_AppDocument> get copyWith =>
      __$AppDocumentCopyWithImpl<_AppDocument>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppDocumentToJson(this);
  }
}

abstract class _AppDocument extends AppDocument {
  const factory _AppDocument(
      {required String name,
      String description,
      List<PadElement> content,
      dynamic background,
      List<ColorPalette> palettes,
      List<Waypoint> waypoints,
      List<Area> areas,
      required DateTime createdAt,
      HandProperty handProperty,
      DateTime? updatedAt,
      List<Painter> painters}) = _$_AppDocument;
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
  dynamic get background;
  @override
  List<ColorPalette> get palettes;
  @override
  List<Waypoint> get waypoints;
  @override
  List<Area> get areas;
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
  _$AppDocumentCopyWith<_AppDocument> get copyWith =>
      throw _privateConstructorUsedError;
}
