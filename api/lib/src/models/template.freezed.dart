// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$DocumentTemplateCopyWithImpl<$Res, DocumentTemplate>;
  @useResult
  $Res call({@DocumentJsonConverter() AppDocument document, String folder});

  $AppDocumentCopyWith<$Res> get document;
}

/// @nodoc
class _$DocumentTemplateCopyWithImpl<$Res, $Val extends DocumentTemplate>
    implements $DocumentTemplateCopyWith<$Res> {
  _$DocumentTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? document = null,
    Object? folder = null,
  }) {
    return _then(_value.copyWith(
      document: null == document
          ? _value.document
          : document // ignore: cast_nullable_to_non_nullable
              as AppDocument,
      folder: null == folder
          ? _value.folder
          : folder // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AppDocumentCopyWith<$Res> get document {
    return $AppDocumentCopyWith<$Res>(_value.document, (value) {
      return _then(_value.copyWith(document: value) as $Val);
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
  @useResult
  $Res call({@DocumentJsonConverter() AppDocument document, String folder});

  @override
  $AppDocumentCopyWith<$Res> get document;
}

/// @nodoc
class __$$_DocumentTemplateCopyWithImpl<$Res>
    extends _$DocumentTemplateCopyWithImpl<$Res, _$_DocumentTemplate>
    implements _$$_DocumentTemplateCopyWith<$Res> {
  __$$_DocumentTemplateCopyWithImpl(
      _$_DocumentTemplate _value, $Res Function(_$_DocumentTemplate) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? document = null,
    Object? folder = null,
  }) {
    return _then(_$_DocumentTemplate(
      document: null == document
          ? _value.document
          : document // ignore: cast_nullable_to_non_nullable
              as AppDocument,
      folder: null == folder
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
            (identical(other.document, document) ||
                other.document == document) &&
            (identical(other.folder, folder) || other.folder == folder));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, document, folder);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DocumentTemplateCopyWith<_$_DocumentTemplate> get copyWith =>
      __$$_DocumentTemplateCopyWithImpl<_$_DocumentTemplate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DocumentTemplateToJson(
      this,
    );
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
