// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DefinedSpanProperty _$$DefinedSpanPropertyFromJson(Map json) =>
    _$DefinedSpanProperty(
      size: (json['size'] as num?)?.toDouble() ?? 12,
      color: json['color'] as int? ?? kColorBlack,
      fontWeight: json['fontWeight'] as int? ?? 3,
      lineThrough: json['lineThrough'] as bool? ?? false,
      underline: json['underline'] as bool? ?? false,
      overline: json['overline'] as bool? ?? false,
      italic: json['italic'] as bool? ?? false,
      letterSpacing: (json['letterSpacing'] as num?)?.toDouble() ?? 0,
      decorationColor: json['decorationColor'] as int? ?? kColorBlack,
      decorationStyle: $enumDecodeNullable(
              _$TextDecorationStyleEnumMap, json['decorationStyle']) ??
          TextDecorationStyle.solid,
      decorationThickness:
          (json['decorationThickness'] as num?)?.toDouble() ?? 1,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DefinedSpanPropertyToJson(
        _$DefinedSpanProperty instance) =>
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
      'decorationStyle':
          _$TextDecorationStyleEnumMap[instance.decorationStyle]!,
      'decorationThickness': instance.decorationThickness,
      'type': instance.$type,
    };

const _$TextDecorationStyleEnumMap = {
  TextDecorationStyle.solid: 'solid',
  TextDecorationStyle.double: 'double',
  TextDecorationStyle.dotted: 'dotted',
  TextDecorationStyle.dashed: 'dashed',
  TextDecorationStyle.wavy: 'wavy',
};

_$NamedSpanProperty _$$NamedSpanPropertyFromJson(Map json) =>
    _$NamedSpanProperty(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$NamedSpanPropertyToJson(_$NamedSpanProperty instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$UndefinedSpanProperty _$$UndefinedSpanPropertyFromJson(Map json) =>
    _$UndefinedSpanProperty(
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$UndefinedSpanPropertyToJson(
        _$UndefinedSpanProperty instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$DefinedParagraphProperty _$$DefinedParagraphPropertyFromJson(Map json) =>
    _$DefinedParagraphProperty(
      spanProperty: json['spanProperty'] == null
          ? const SpanProperty.undefined()
          : SpanProperty.fromJson(
              Map<String, dynamic>.from(json['spanProperty'] as Map)),
      alignment: $enumDecodeNullable(
              _$HorizontalAlignmentEnumMap, json['alignment']) ??
          HorizontalAlignment.left,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DefinedParagraphPropertyToJson(
        _$DefinedParagraphProperty instance) =>
    <String, dynamic>{
      'spanProperty': instance.spanProperty.toJson(),
      'alignment': _$HorizontalAlignmentEnumMap[instance.alignment]!,
      'type': instance.$type,
    };

const _$HorizontalAlignmentEnumMap = {
  HorizontalAlignment.left: 'left',
  HorizontalAlignment.center: 'center',
  HorizontalAlignment.right: 'right',
  HorizontalAlignment.justify: 'justify',
};

_$NamedParagraphProperty _$$NamedParagraphPropertyFromJson(Map json) =>
    _$NamedParagraphProperty(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$NamedParagraphPropertyToJson(
        _$NamedParagraphProperty instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$UndefinedParagraphProperty _$$UndefinedParagraphPropertyFromJson(Map json) =>
    _$UndefinedParagraphProperty(
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$UndefinedParagraphPropertyToJson(
        _$UndefinedParagraphProperty instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$DefinedAreaProperty _$$DefinedAreaPropertyFromJson(Map json) =>
    _$DefinedAreaProperty(
      paragraphProperty: json['paragraphProperty'] == null
          ? const ParagraphProperty.undefined()
          : ParagraphProperty.fromJson(
              Map<String, dynamic>.from(json['paragraphProperty'] as Map)),
      verticalAlignment: $enumDecodeNullable(
              _$VerticalAlignmentEnumMap, json['verticalAlignment']) ??
          VerticalAlignment.top,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DefinedAreaPropertyToJson(
        _$DefinedAreaProperty instance) =>
    <String, dynamic>{
      'paragraphProperty': instance.paragraphProperty.toJson(),
      'verticalAlignment':
          _$VerticalAlignmentEnumMap[instance.verticalAlignment]!,
      'type': instance.$type,
    };

const _$VerticalAlignmentEnumMap = {
  VerticalAlignment.top: 'top',
  VerticalAlignment.center: 'center',
  VerticalAlignment.bottom: 'bottom',
};

_$NamedAreaProperty _$$NamedAreaPropertyFromJson(Map json) =>
    _$NamedAreaProperty(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$NamedAreaPropertyToJson(_$NamedAreaProperty instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$UndefinedAreaProperty _$$UndefinedAreaPropertyFromJson(Map json) =>
    _$UndefinedAreaProperty(
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$UndefinedAreaPropertyToJson(
        _$UndefinedAreaProperty instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$_TextSpan _$$_TextSpanFromJson(Map json) => _$_TextSpan(
      text: json['text'] as String? ?? '',
      property: json['property'] == null
          ? const SpanProperty.undefined()
          : SpanProperty.fromJson(
              Map<String, dynamic>.from(json['property'] as Map)),
    );

Map<String, dynamic> _$$_TextSpanToJson(_$_TextSpan instance) =>
    <String, dynamic>{
      'text': instance.text,
      'property': instance.property.toJson(),
    };

_$_ParagraphProperty _$$_ParagraphPropertyFromJson(Map json) =>
    _$_ParagraphProperty(
      textProperty: json['textProperty'] == null
          ? const ParagraphProperty.undefined()
          : ParagraphProperty.fromJson(
              Map<String, dynamic>.from(json['textProperty'] as Map)),
      textSpans: (json['textSpans'] as List<dynamic>?)
              ?.map(
                  (e) => TextSpan.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ParagraphPropertyToJson(
        _$_ParagraphProperty instance) =>
    <String, dynamic>{
      'textProperty': instance.textProperty.toJson(),
      'textSpans': instance.textSpans.map((e) => e.toJson()).toList(),
    };

_$_TextArea _$$_TextAreaFromJson(Map json) => _$_TextArea(
      areaProperty: json['areaProperty'] == null
          ? const AreaProperty.undefined()
          : AreaProperty.fromJson(
              Map<String, dynamic>.from(json['areaProperty'] as Map)),
      textParagraphs: (json['textParagraphs'] as List<dynamic>?)
              ?.map((e) =>
                  TextParagraph.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_TextAreaToJson(_$_TextArea instance) =>
    <String, dynamic>{
      'areaProperty': instance.areaProperty.toJson(),
      'textParagraphs': instance.textParagraphs.map((e) => e.toJson()).toList(),
    };

_$_RichStyleSheet _$$_RichStyleSheetFromJson(Map json) => _$_RichStyleSheet(
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

Map<String, dynamic> _$$_RichStyleSheetToJson(_$_RichStyleSheet instance) =>
    <String, dynamic>{
      'name': instance.name,
      'spanProperties':
          instance.spanProperties.map((k, e) => MapEntry(k, e.toJson())),
      'paragraphProperties':
          instance.paragraphProperties.map((k, e) => MapEntry(k, e.toJson())),
    };

_$_MarkdownStyleSheet _$$_MarkdownStyleSheetFromJson(Map json) =>
    _$_MarkdownStyleSheet(
      name: json['name'] as String? ?? '',
      h1: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['h1'] as Map)),
      h2: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['h2'] as Map)),
      h3: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['h3'] as Map)),
      h4: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['h4'] as Map)),
      h5: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['h5'] as Map)),
      h6: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['h6'] as Map)),
      p: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['p'] as Map)),
      blockquote: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['blockquote'] as Map)),
      code: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['code'] as Map)),
      pre: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['pre'] as Map)),
      ol: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['ol'] as Map)),
      ul: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['ul'] as Map)),
      li: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['li'] as Map)),
      table: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['table'] as Map)),
      thead: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['thead'] as Map)),
      tbody: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['tbody'] as Map)),
      tr: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['tr'] as Map)),
      th: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['th'] as Map)),
      td: DefinedParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['td'] as Map)),
      em: DefinedSpanProperty.fromJson(
          Map<String, dynamic>.from(json['em'] as Map)),
      strong: DefinedSpanProperty.fromJson(
          Map<String, dynamic>.from(json['strong'] as Map)),
      codeSpan: DefinedSpanProperty.fromJson(
          Map<String, dynamic>.from(json['codeSpan'] as Map)),
      del: DefinedSpanProperty.fromJson(
          Map<String, dynamic>.from(json['del'] as Map)),
      a: DefinedSpanProperty.fromJson(
          Map<String, dynamic>.from(json['a'] as Map)),
      img: DefinedSpanProperty.fromJson(
          Map<String, dynamic>.from(json['img'] as Map)),
    );

Map<String, dynamic> _$$_MarkdownStyleSheetToJson(
        _$_MarkdownStyleSheet instance) =>
    <String, dynamic>{
      'name': instance.name,
      'h1': instance.h1.toJson(),
      'h2': instance.h2.toJson(),
      'h3': instance.h3.toJson(),
      'h4': instance.h4.toJson(),
      'h5': instance.h5.toJson(),
      'h6': instance.h6.toJson(),
      'p': instance.p.toJson(),
      'blockquote': instance.blockquote.toJson(),
      'code': instance.code.toJson(),
      'pre': instance.pre.toJson(),
      'ol': instance.ol.toJson(),
      'ul': instance.ul.toJson(),
      'li': instance.li.toJson(),
      'table': instance.table.toJson(),
      'thead': instance.thead.toJson(),
      'tbody': instance.tbody.toJson(),
      'tr': instance.tr.toJson(),
      'th': instance.th.toJson(),
      'td': instance.td.toJson(),
      'em': instance.em.toJson(),
      'strong': instance.strong.toJson(),
      'codeSpan': instance.codeSpan.toJson(),
      'del': instance.del.toJson(),
      'a': instance.a.toJson(),
      'img': instance.img.toJson(),
    };
