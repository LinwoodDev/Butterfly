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
  switch (json['type']) {
    case 'document':
      return AppDocument.fromJson(json);
    case 'template':
      return DocumentTemplate.fromJson(json);
    case 'pack':
      return ButterflyPack.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'NoteData', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$NoteData {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name,
            String description,
            String thumbnail,
            List<AnimationTrack> animations,
            List<PadElement> content,
            Background background,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)
        document,
    required TResult Function(AppDocument document, String directory) template,
    required TResult Function(
            String name,
            String description,
            String author,
            List<ButterflyComponent> components,
            List<TextStyleSheet> styles,
            List<ColorPalette> palettes,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime updatedAt)
        pack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String name,
            String description,
            String thumbnail,
            List<AnimationTrack> animations,
            List<PadElement> content,
            Background background,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)?
        document,
    TResult? Function(AppDocument document, String directory)? template,
    TResult? Function(
            String name,
            String description,
            String author,
            List<ButterflyComponent> components,
            List<TextStyleSheet> styles,
            List<ColorPalette> palettes,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime updatedAt)?
        pack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String name,
            String description,
            String thumbnail,
            List<AnimationTrack> animations,
            List<PadElement> content,
            Background background,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)?
        document,
    TResult Function(AppDocument document, String directory)? template,
    TResult Function(
            String name,
            String description,
            String author,
            List<ButterflyComponent> components,
            List<TextStyleSheet> styles,
            List<ColorPalette> palettes,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime updatedAt)?
        pack,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppDocument value) document,
    required TResult Function(DocumentTemplate value) template,
    required TResult Function(ButterflyPack value) pack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppDocument value)? document,
    TResult? Function(DocumentTemplate value)? template,
    TResult? Function(ButterflyPack value)? pack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppDocument value)? document,
    TResult Function(DocumentTemplate value)? template,
    TResult Function(ButterflyPack value)? pack,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteDataCopyWith<$Res> {
  factory $NoteDataCopyWith(NoteData value, $Res Function(NoteData) then) =
      _$NoteDataCopyWithImpl<$Res, NoteData>;
}

/// @nodoc
class _$NoteDataCopyWithImpl<$Res, $Val extends NoteData>
    implements $NoteDataCopyWith<$Res> {
  _$NoteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AppDocumentCopyWith<$Res> {
  factory _$$AppDocumentCopyWith(
          _$AppDocument value, $Res Function(_$AppDocument) then) =
      __$$AppDocumentCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String name,
      String description,
      String thumbnail,
      List<AnimationTrack> animations,
      List<PadElement> content,
      Background background,
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
    Object? animations = null,
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

  @override
  @pragma('vm:prefer-inline')
  $BackgroundCopyWith<$Res> get background {
    return $BackgroundCopyWith<$Res>(_value.background, (value) {
      return _then(_value.copyWith(background: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ToolOptionCopyWith<$Res> get tool {
    return $ToolOptionCopyWith<$Res>(_value.tool, (value) {
      return _then(_value.copyWith(tool: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$AppDocument extends AppDocument {
  const _$AppDocument(
      {this.name = '',
      this.description = '',
      this.thumbnail = '',
      final List<AnimationTrack> animations = const [],
      final List<PadElement> content = const [],
      this.background = const Background.empty(),
      final List<Waypoint> waypoints = const [],
      final List<Area> areas = const [],
      final List<ExportPreset> exportPresets = const [],
      final List<ButterflyPack> packs = const [],
      @DateTimeJsonConverter() required this.createdAt,
      @DateTimeJsonConverter() this.updatedAt,
      final List<Painter> painters = const [],
      this.tool = const ToolOption(),
      final String? $type})
      : _animations = animations,
        _content = content,
        _waypoints = waypoints,
        _areas = areas,
        _exportPresets = exportPresets,
        _packs = packs,
        _painters = painters,
        $type = $type ?? 'document',
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

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'NoteData.document(name: $name, description: $description, thumbnail: $thumbnail, animations: $animations, content: $content, background: $background, waypoints: $waypoints, areas: $areas, exportPresets: $exportPresets, packs: $packs, createdAt: $createdAt, updatedAt: $updatedAt, painters: $painters, tool: $tool)';
  }

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
            List<AnimationTrack> animations,
            List<PadElement> content,
            Background background,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)
        document,
    required TResult Function(AppDocument document, String directory) template,
    required TResult Function(
            String name,
            String description,
            String author,
            List<ButterflyComponent> components,
            List<TextStyleSheet> styles,
            List<ColorPalette> palettes,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime updatedAt)
        pack,
  }) {
    return document(
        name,
        description,
        thumbnail,
        animations,
        content,
        background,
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
            List<AnimationTrack> animations,
            List<PadElement> content,
            Background background,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)?
        document,
    TResult? Function(AppDocument document, String directory)? template,
    TResult? Function(
            String name,
            String description,
            String author,
            List<ButterflyComponent> components,
            List<TextStyleSheet> styles,
            List<ColorPalette> palettes,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime updatedAt)?
        pack,
  }) {
    return document?.call(
        name,
        description,
        thumbnail,
        animations,
        content,
        background,
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
            List<AnimationTrack> animations,
            List<PadElement> content,
            Background background,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)?
        document,
    TResult Function(AppDocument document, String directory)? template,
    TResult Function(
            String name,
            String description,
            String author,
            List<ButterflyComponent> components,
            List<TextStyleSheet> styles,
            List<ColorPalette> palettes,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime updatedAt)?
        pack,
    required TResult orElse(),
  }) {
    if (document != null) {
      return document(
          name,
          description,
          thumbnail,
          animations,
          content,
          background,
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
    required TResult Function(DocumentTemplate value) template,
    required TResult Function(ButterflyPack value) pack,
  }) {
    return document(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppDocument value)? document,
    TResult? Function(DocumentTemplate value)? template,
    TResult? Function(ButterflyPack value)? pack,
  }) {
    return document?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppDocument value)? document,
    TResult Function(DocumentTemplate value)? template,
    TResult Function(ButterflyPack value)? pack,
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
      final List<AnimationTrack> animations,
      final List<PadElement> content,
      final Background background,
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

  String get name;
  String get description;
  String get thumbnail;
  List<AnimationTrack> get animations;
  List<PadElement> get content;
  Background get background;
  List<Waypoint> get waypoints;
  List<Area> get areas;
  List<ExportPreset> get exportPresets;
  List<ButterflyPack> get packs;
  @DateTimeJsonConverter()
  DateTime get createdAt;
  @DateTimeJsonConverter()
  DateTime? get updatedAt;
  List<Painter> get painters;
  ToolOption get tool;
  @JsonKey(ignore: true)
  _$$AppDocumentCopyWith<_$AppDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DocumentTemplateCopyWith<$Res> {
  factory _$$DocumentTemplateCopyWith(
          _$DocumentTemplate value, $Res Function(_$DocumentTemplate) then) =
      __$$DocumentTemplateCopyWithImpl<$Res>;
  @useResult
  $Res call({AppDocument document, String directory});
}

/// @nodoc
class __$$DocumentTemplateCopyWithImpl<$Res>
    extends _$NoteDataCopyWithImpl<$Res, _$DocumentTemplate>
    implements _$$DocumentTemplateCopyWith<$Res> {
  __$$DocumentTemplateCopyWithImpl(
      _$DocumentTemplate _value, $Res Function(_$DocumentTemplate) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? document = freezed,
    Object? directory = null,
  }) {
    return _then(_$DocumentTemplate(
      document: freezed == document
          ? _value.document
          : document // ignore: cast_nullable_to_non_nullable
              as AppDocument,
      directory: null == directory
          ? _value.directory
          : directory // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentTemplate extends DocumentTemplate {
  const _$DocumentTemplate(
      {required this.document, this.directory = '/', final String? $type})
      : $type = $type ?? 'template',
        super._();

  factory _$DocumentTemplate.fromJson(Map<String, dynamic> json) =>
      _$$DocumentTemplateFromJson(json);

  @override
  final AppDocument document;
  @override
  @JsonKey()
  final String directory;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'NoteData.template(document: $document, directory: $directory)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentTemplateCopyWith<_$DocumentTemplate> get copyWith =>
      __$$DocumentTemplateCopyWithImpl<_$DocumentTemplate>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name,
            String description,
            String thumbnail,
            List<AnimationTrack> animations,
            List<PadElement> content,
            Background background,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)
        document,
    required TResult Function(AppDocument document, String directory) template,
    required TResult Function(
            String name,
            String description,
            String author,
            List<ButterflyComponent> components,
            List<TextStyleSheet> styles,
            List<ColorPalette> palettes,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime updatedAt)
        pack,
  }) {
    return template(this.document, directory);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String name,
            String description,
            String thumbnail,
            List<AnimationTrack> animations,
            List<PadElement> content,
            Background background,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)?
        document,
    TResult? Function(AppDocument document, String directory)? template,
    TResult? Function(
            String name,
            String description,
            String author,
            List<ButterflyComponent> components,
            List<TextStyleSheet> styles,
            List<ColorPalette> palettes,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime updatedAt)?
        pack,
  }) {
    return template?.call(this.document, directory);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String name,
            String description,
            String thumbnail,
            List<AnimationTrack> animations,
            List<PadElement> content,
            Background background,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)?
        document,
    TResult Function(AppDocument document, String directory)? template,
    TResult Function(
            String name,
            String description,
            String author,
            List<ButterflyComponent> components,
            List<TextStyleSheet> styles,
            List<ColorPalette> palettes,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime updatedAt)?
        pack,
    required TResult orElse(),
  }) {
    if (template != null) {
      return template(this.document, directory);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppDocument value) document,
    required TResult Function(DocumentTemplate value) template,
    required TResult Function(ButterflyPack value) pack,
  }) {
    return template(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppDocument value)? document,
    TResult? Function(DocumentTemplate value)? template,
    TResult? Function(ButterflyPack value)? pack,
  }) {
    return template?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppDocument value)? document,
    TResult Function(DocumentTemplate value)? template,
    TResult Function(ButterflyPack value)? pack,
    required TResult orElse(),
  }) {
    if (template != null) {
      return template(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentTemplateToJson(
      this,
    );
  }
}

abstract class DocumentTemplate extends NoteData {
  const factory DocumentTemplate(
      {required final AppDocument document,
      final String directory}) = _$DocumentTemplate;
  const DocumentTemplate._() : super._();

  factory DocumentTemplate.fromJson(Map<String, dynamic> json) =
      _$DocumentTemplate.fromJson;

  AppDocument get document;
  String get directory;
  @JsonKey(ignore: true)
  _$$DocumentTemplateCopyWith<_$DocumentTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ButterflyPackCopyWith<$Res> {
  factory _$$ButterflyPackCopyWith(
          _$ButterflyPack value, $Res Function(_$ButterflyPack) then) =
      __$$ButterflyPackCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String name,
      String description,
      String author,
      List<ButterflyComponent> components,
      List<TextStyleSheet> styles,
      List<ColorPalette> palettes,
      @DateTimeJsonConverter() DateTime createdAt,
      @DateTimeJsonConverter() DateTime updatedAt});
}

/// @nodoc
class __$$ButterflyPackCopyWithImpl<$Res>
    extends _$NoteDataCopyWithImpl<$Res, _$ButterflyPack>
    implements _$$ButterflyPackCopyWith<$Res> {
  __$$ButterflyPackCopyWithImpl(
      _$ButterflyPack _value, $Res Function(_$ButterflyPack) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? author = null,
    Object? components = null,
    Object? styles = null,
    Object? palettes = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ButterflyPack(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      components: null == components
          ? _value._components
          : components // ignore: cast_nullable_to_non_nullable
              as List<ButterflyComponent>,
      styles: null == styles
          ? _value._styles
          : styles // ignore: cast_nullable_to_non_nullable
              as List<TextStyleSheet>,
      palettes: null == palettes
          ? _value._palettes
          : palettes // ignore: cast_nullable_to_non_nullable
              as List<ColorPalette>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ButterflyPack extends ButterflyPack {
  const _$ButterflyPack(
      {this.name = '',
      this.description = '',
      this.author = '',
      final List<ButterflyComponent> components = const <ButterflyComponent>[],
      final List<TextStyleSheet> styles = const <TextStyleSheet>[],
      final List<ColorPalette> palettes = const <ColorPalette>[],
      @DateTimeJsonConverter() required this.createdAt,
      @DateTimeJsonConverter() required this.updatedAt,
      final String? $type})
      : _components = components,
        _styles = styles,
        _palettes = palettes,
        $type = $type ?? 'pack',
        super._();

  factory _$ButterflyPack.fromJson(Map<String, dynamic> json) =>
      _$$ButterflyPackFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String author;
  final List<ButterflyComponent> _components;
  @override
  @JsonKey()
  List<ButterflyComponent> get components {
    if (_components is EqualUnmodifiableListView) return _components;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_components);
  }

  final List<TextStyleSheet> _styles;
  @override
  @JsonKey()
  List<TextStyleSheet> get styles {
    if (_styles is EqualUnmodifiableListView) return _styles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_styles);
  }

  final List<ColorPalette> _palettes;
  @override
  @JsonKey()
  List<ColorPalette> get palettes {
    if (_palettes is EqualUnmodifiableListView) return _palettes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_palettes);
  }

  @override
  @DateTimeJsonConverter()
  final DateTime createdAt;
  @override
  @DateTimeJsonConverter()
  final DateTime updatedAt;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'NoteData.pack(name: $name, description: $description, author: $author, components: $components, styles: $styles, palettes: $palettes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ButterflyPackCopyWith<_$ButterflyPack> get copyWith =>
      __$$ButterflyPackCopyWithImpl<_$ButterflyPack>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name,
            String description,
            String thumbnail,
            List<AnimationTrack> animations,
            List<PadElement> content,
            Background background,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)
        document,
    required TResult Function(AppDocument document, String directory) template,
    required TResult Function(
            String name,
            String description,
            String author,
            List<ButterflyComponent> components,
            List<TextStyleSheet> styles,
            List<ColorPalette> palettes,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime updatedAt)
        pack,
  }) {
    return pack(name, description, author, components, styles, palettes,
        createdAt, updatedAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String name,
            String description,
            String thumbnail,
            List<AnimationTrack> animations,
            List<PadElement> content,
            Background background,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)?
        document,
    TResult? Function(AppDocument document, String directory)? template,
    TResult? Function(
            String name,
            String description,
            String author,
            List<ButterflyComponent> components,
            List<TextStyleSheet> styles,
            List<ColorPalette> palettes,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime updatedAt)?
        pack,
  }) {
    return pack?.call(name, description, author, components, styles, palettes,
        createdAt, updatedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String name,
            String description,
            String thumbnail,
            List<AnimationTrack> animations,
            List<PadElement> content,
            Background background,
            List<Waypoint> waypoints,
            List<Area> areas,
            List<ExportPreset> exportPresets,
            List<ButterflyPack> packs,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime? updatedAt,
            List<Painter> painters,
            ToolOption tool)?
        document,
    TResult Function(AppDocument document, String directory)? template,
    TResult Function(
            String name,
            String description,
            String author,
            List<ButterflyComponent> components,
            List<TextStyleSheet> styles,
            List<ColorPalette> palettes,
            @DateTimeJsonConverter() DateTime createdAt,
            @DateTimeJsonConverter() DateTime updatedAt)?
        pack,
    required TResult orElse(),
  }) {
    if (pack != null) {
      return pack(name, description, author, components, styles, palettes,
          createdAt, updatedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppDocument value) document,
    required TResult Function(DocumentTemplate value) template,
    required TResult Function(ButterflyPack value) pack,
  }) {
    return pack(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppDocument value)? document,
    TResult? Function(DocumentTemplate value)? template,
    TResult? Function(ButterflyPack value)? pack,
  }) {
    return pack?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppDocument value)? document,
    TResult Function(DocumentTemplate value)? template,
    TResult Function(ButterflyPack value)? pack,
    required TResult orElse(),
  }) {
    if (pack != null) {
      return pack(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ButterflyPackToJson(
      this,
    );
  }
}

abstract class ButterflyPack extends NoteData {
  const factory ButterflyPack(
          {final String name,
          final String description,
          final String author,
          final List<ButterflyComponent> components,
          final List<TextStyleSheet> styles,
          final List<ColorPalette> palettes,
          @DateTimeJsonConverter() required final DateTime createdAt,
          @DateTimeJsonConverter() required final DateTime updatedAt}) =
      _$ButterflyPack;
  const ButterflyPack._() : super._();

  factory ButterflyPack.fromJson(Map<String, dynamic> json) =
      _$ButterflyPack.fromJson;

  String get name;
  String get description;
  String get author;
  List<ButterflyComponent> get components;
  List<TextStyleSheet> get styles;
  List<ColorPalette> get palettes;
  @DateTimeJsonConverter()
  DateTime get createdAt;
  @DateTimeJsonConverter()
  DateTime get updatedAt;
  @JsonKey(ignore: true)
  _$$ButterflyPackCopyWith<_$ButterflyPack> get copyWith =>
      throw _privateConstructorUsedError;
}
