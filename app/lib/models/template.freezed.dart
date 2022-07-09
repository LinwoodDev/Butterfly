// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DocumentTemplate _$DocumentTemplateFromJson(Map<String, dynamic> json) {
  return _DocumentTemplate.fromJson(json);
}

/// @nodoc
mixin _$DocumentTemplate {
  @DocumentJsonConverter()
  AppDocument get document => throw _privateConstructorUsedError;
  String get folder => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DocumentTemplateCopyWith<DocumentTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentTemplateCopyWith<$Res> {
  factory $DocumentTemplateCopyWith(
          DocumentTemplate value, $Res Function(DocumentTemplate) then) =
      _$DocumentTemplateCopyWithImpl<$Res>;
  $Res call({@DocumentJsonConverter() AppDocument document, String folder});

  $AppDocumentCopyWith<$Res> get document;
}

/// @nodoc
class _$DocumentTemplateCopyWithImpl<$Res>
    implements $DocumentTemplateCopyWith<$Res> {
  _$DocumentTemplateCopyWithImpl(this._value, this._then);

  final DocumentTemplate _value;
  // ignore: unused_field
  final $Res Function(DocumentTemplate) _then;

  @override
  $Res call({
    Object? document = freezed,
    Object? folder = freezed,
  }) {
    return _then(_value.copyWith(
      document: document == freezed
          ? _value.document
          : document // ignore: cast_nullable_to_non_nullable
              as AppDocument,
      folder: folder == freezed
          ? _value.folder
          : folder // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $AppDocumentCopyWith<$Res> get document {
    return $AppDocumentCopyWith<$Res>(_value.document, (value) {
      return _then(_value.copyWith(document: value));
    });
  }
}

/// @nodoc
abstract class _$$_DocumentTemplateCopyWith<$Res>
    implements $DocumentTemplateCopyWith<$Res> {
  factory _$$_DocumentTemplateCopyWith(
          _$_DocumentTemplate value, $Res Function(_$_DocumentTemplate) then) =
      __$$_DocumentTemplateCopyWithImpl<$Res>;
  @override
  $Res call({@DocumentJsonConverter() AppDocument document, String folder});

  @override
  $AppDocumentCopyWith<$Res> get document;
}

/// @nodoc
class __$$_DocumentTemplateCopyWithImpl<$Res>
    extends _$DocumentTemplateCopyWithImpl<$Res>
    implements _$$_DocumentTemplateCopyWith<$Res> {
  __$$_DocumentTemplateCopyWithImpl(
      _$_DocumentTemplate _value, $Res Function(_$_DocumentTemplate) _then)
      : super(_value, (v) => _then(v as _$_DocumentTemplate));

  @override
  _$_DocumentTemplate get _value => super._value as _$_DocumentTemplate;

  @override
  $Res call({
    Object? document = freezed,
    Object? folder = freezed,
  }) {
    return _then(_$_DocumentTemplate(
      document: document == freezed
          ? _value.document
          : document // ignore: cast_nullable_to_non_nullable
              as AppDocument,
      folder: folder == freezed
          ? _value.folder
          : folder // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DocumentTemplate extends _DocumentTemplate {
  const _$_DocumentTemplate(
      {@DocumentJsonConverter() required this.document, this.folder = '/'})
      : super._();

  factory _$_DocumentTemplate.fromJson(Map<String, dynamic> json) =>
      _$$_DocumentTemplateFromJson(json);

  @override
  @DocumentJsonConverter()
  final AppDocument document;
  @override
  @JsonKey()
  final String folder;

  @override
  String toString() {
    return 'DocumentTemplate(document: $document, folder: $folder)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DocumentTemplate &&
            const DeepCollectionEquality().equals(other.document, document) &&
            const DeepCollectionEquality().equals(other.folder, folder));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(document),
      const DeepCollectionEquality().hash(folder));

  @JsonKey(ignore: true)
  @override
  _$$_DocumentTemplateCopyWith<_$_DocumentTemplate> get copyWith =>
      __$$_DocumentTemplateCopyWithImpl<_$_DocumentTemplate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DocumentTemplateToJson(this);
  }
}

abstract class _DocumentTemplate extends DocumentTemplate {
  const factory _DocumentTemplate(
      {@DocumentJsonConverter() required final AppDocument document,
      final String folder}) = _$_DocumentTemplate;
  const _DocumentTemplate._() : super._();

  factory _DocumentTemplate.fromJson(Map<String, dynamic> json) =
      _$_DocumentTemplate.fromJson;

  @override
  @DocumentJsonConverter()
  AppDocument get document;
  @override
  String get folder;
  @override
  @JsonKey(ignore: true)
  _$$_DocumentTemplateCopyWith<_$_DocumentTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}
