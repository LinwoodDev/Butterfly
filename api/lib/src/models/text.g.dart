// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DefinedSpanPropertyImpl _$$DefinedSpanPropertyImplFromJson(Map json) =>
    _$DefinedSpanPropertyImpl(
      size: (json['size'] as num?)?.toDouble(),
      color: (json['color'] as num?)?.toInt(),
      fontWeight: (json['fontWeight'] as num?)?.toInt(),
      lineThrough: json['lineThrough'] as bool?,
      underline: json['underline'] as bool?,
      overline: json['overline'] as bool?,
      italic: json['italic'] as bool?,
      letterSpacing: (json['letterSpacing'] as num?)?.toDouble(),
      decorationColor: (json['decorationColor'] as num?)?.toInt(),
      decorationStyle: $enumDecodeNullable(
          _$TextDecorationStyleEnumMap, json['decorationStyle']),
      decorationThickness: (json['decorationThickness'] as num?)?.toDouble(),
      backgroundColor: (json['backgroundColor'] as num?)?.toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DefinedSpanPropertyImplToJson(
        _$DefinedSpanPropertyImpl instance) =>
    <String, dynamic>{
      'size': instance.size,
      'color': instance.color,
      'fontWeight': instance.fontWeight,
      'lineThrough': instance.lineThrough,
      'underline': instance.underline,
      'overline': instance.overline,
      'italic': instance.italic,
      'letterSpacing': instance.letterSpacing,
      'decorationColor': instance.decorationColor,
      'decorationStyle': _$TextDecorationStyleEnumMap[instance.decorationStyle],
      'decorationThickness': instance.decorationThickness,
      'backgroundColor': instance.backgroundColor,
      'type': instance.$type,
    };

const _$TextDecorationStyleEnumMap = {
  TextDecorationStyle.solid: 'solid',
  TextDecorationStyle.double: 'double',
  TextDecorationStyle.dotted: 'dotted',
  TextDecorationStyle.dashed: 'dashed',
  TextDecorationStyle.wavy: 'wavy',
};

_$NamedSpanPropertyImpl _$$NamedSpanPropertyImplFromJson(Map json) =>
    _$NamedSpanPropertyImpl(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$NamedSpanPropertyImplToJson(
        _$NamedSpanPropertyImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$UndefinedSpanPropertyImpl _$$UndefinedSpanPropertyImplFromJson(Map json) =>
    _$UndefinedSpanPropertyImpl(
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$UndefinedSpanPropertyImplToJson(
        _$UndefinedSpanPropertyImpl instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$DefinedParagraphPropertyImpl _$$DefinedParagraphPropertyImplFromJson(
        Map json) =>
    _$DefinedParagraphPropertyImpl(
      span: json['span'] == null
          ? const DefinedSpanProperty()
          : DefinedSpanProperty.fromJson(
              Map<String, dynamic>.from(json['span'] as Map)),
      alignment: $enumDecodeNullable(
              _$HorizontalAlignmentEnumMap, json['alignment']) ??
          HorizontalAlignment.left,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DefinedParagraphPropertyImplToJson(
        _$DefinedParagraphPropertyImpl instance) =>
    <String, dynamic>{
      'span': instance.span.toJson(),
      'alignment': _$HorizontalAlignmentEnumMap[instance.alignment]!,
      'type': instance.$type,
    };

const _$HorizontalAlignmentEnumMap = {
  HorizontalAlignment.left: 'left',
  HorizontalAlignment.center: 'center',
  HorizontalAlignment.right: 'right',
  HorizontalAlignment.justify: 'justify',
};

_$NamedParagraphPropertyImpl _$$NamedParagraphPropertyImplFromJson(Map json) =>
    _$NamedParagraphPropertyImpl(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$NamedParagraphPropertyImplToJson(
        _$NamedParagraphPropertyImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$UndefinedParagraphPropertyImpl _$$UndefinedParagraphPropertyImplFromJson(
        Map json) =>
    _$UndefinedParagraphPropertyImpl(
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$UndefinedParagraphPropertyImplToJson(
        _$UndefinedParagraphPropertyImpl instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$AreaPropertyImpl _$$AreaPropertyImplFromJson(Map json) => _$AreaPropertyImpl(
      alignment:
          $enumDecodeNullable(_$VerticalAlignmentEnumMap, json['alignment']) ??
              VerticalAlignment.top,
    );

Map<String, dynamic> _$$AreaPropertyImplToJson(_$AreaPropertyImpl instance) =>
    <String, dynamic>{
      'alignment': _$VerticalAlignmentEnumMap[instance.alignment]!,
    };

const _$VerticalAlignmentEnumMap = {
  VerticalAlignment.top: 'top',
  VerticalAlignment.center: 'center',
  VerticalAlignment.bottom: 'bottom',
};

_$TextSpanImpl _$$TextSpanImplFromJson(Map json) => _$TextSpanImpl(
      text: json['text'] as String? ?? '',
      property: json['property'] == null
          ? const SpanProperty.undefined()
          : SpanProperty.fromJson(
              Map<String, dynamic>.from(json['property'] as Map)),
    );

Map<String, dynamic> _$$TextSpanImplToJson(_$TextSpanImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'property': instance.property.toJson(),
    };

_$ParagraphPropertyImpl _$$ParagraphPropertyImplFromJson(Map json) =>
    _$ParagraphPropertyImpl(
      property: json['property'] == null
          ? const ParagraphProperty.undefined()
          : ParagraphProperty.fromJson(
              Map<String, dynamic>.from(json['property'] as Map)),
      textSpans: (json['textSpans'] as List<dynamic>?)
              ?.map(
                  (e) => TextSpan.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ParagraphPropertyImplToJson(
        _$ParagraphPropertyImpl instance) =>
    <String, dynamic>{
      'property': instance.property.toJson(),
      'textSpans': instance.textSpans.map((e) => e.toJson()).toList(),
    };

_$TextAreaImpl _$$TextAreaImplFromJson(Map json) => _$TextAreaImpl(
      areaProperty: json['areaProperty'] == null
          ? const AreaProperty()
          : AreaProperty.fromJson(
              Map<String, dynamic>.from(json['areaProperty'] as Map)),
      paragraph: TextParagraph.fromJson(
          Map<String, dynamic>.from(json['paragraph'] as Map)),
    );

Map<String, dynamic> _$$TextAreaImplToJson(_$TextAreaImpl instance) =>
    <String, dynamic>{
      'areaProperty': instance.areaProperty.toJson(),
      'paragraph': instance.paragraph.toJson(),
    };

_$TextStyleSheetImpl _$$TextStyleSheetImplFromJson(Map json) =>
    _$TextStyleSheetImpl(
      name: json['name'] as String? ?? '',
      spanProperties: (json['spanProperties'] as Map?)?.map(
            (k, e) => MapEntry(
                k as String,
                DefinedSpanProperty.fromJson(
                    Map<String, dynamic>.from(e as Map))),
          ) ??
          const {},
      paragraphProperties: (json['paragraphProperties'] as Map?)?.map(
            (k, e) => MapEntry(
                k as String,
                DefinedParagraphProperty.fromJson(
                    Map<String, dynamic>.from(e as Map))),
          ) ??
          const {},
    );

Map<String, dynamic> _$$TextStyleSheetImplToJson(
        _$TextStyleSheetImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'spanProperties':
          instance.spanProperties.map((k, e) => MapEntry(k, e.toJson())),
      'paragraphProperties':
          instance.paragraphProperties.map((k, e) => MapEntry(k, e.toJson())),
    };
