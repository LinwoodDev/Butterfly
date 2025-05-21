// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ElementConstraint _$ElementConstraintFromJson(Map json) => _ElementConstraint(
      size: (json['size'] as num?)?.toDouble() ?? 0,
      length: (json['length'] as num?)?.toDouble() ?? 0,
      includeArea: json['includeArea'] as bool? ?? true,
    );

Map<String, dynamic> _$ElementConstraintToJson(_ElementConstraint instance) =>
    <String, dynamic>{
      'size': instance.size,
      'length': instance.length,
      'includeArea': instance.includeArea,
    };

ScaledElementConstraints _$ScaledElementConstraintsFromJson(Map json) =>
    ScaledElementConstraints(
      scaleX: (json['scaleX'] as num?)?.toDouble() ?? 1,
      scaleY: (json['scaleY'] as num?)?.toDouble() ?? 1,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ScaledElementConstraintsToJson(
        ScaledElementConstraints instance) =>
    <String, dynamic>{
      'scaleX': instance.scaleX,
      'scaleY': instance.scaleY,
      'type': instance.$type,
    };

FixedElementConstraints _$FixedElementConstraintsFromJson(Map json) =>
    FixedElementConstraints(
      (json['height'] as num).toDouble(),
      (json['width'] as num).toDouble(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$FixedElementConstraintsToJson(
        FixedElementConstraints instance) =>
    <String, dynamic>{
      'height': instance.height,
      'width': instance.width,
      'type': instance.$type,
    };

DynamicElementConstraints _$DynamicElementConstraintsFromJson(Map json) =>
    DynamicElementConstraints(
      height: (json['height'] as num?)?.toDouble() ?? 0,
      width: (json['width'] as num?)?.toDouble() ?? 0,
      aspectRatio: (json['aspectRatio'] as num?)?.toDouble() ?? 0,
      includeArea: json['includeArea'] as bool? ?? true,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$DynamicElementConstraintsToJson(
        DynamicElementConstraints instance) =>
    <String, dynamic>{
      'height': instance.height,
      'width': instance.width,
      'aspectRatio': instance.aspectRatio,
      'includeArea': instance.includeArea,
      'type': instance.$type,
    };

PenElement _$PenElementFromJson(Map json) => PenElement(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      collection: json['collection'] as String? ?? '',
      id: const IdJsonConverter().fromJson(json['id'] as String?),
      zoom: (json['zoom'] as num?)?.toDouble(),
      points: (json['points'] as List<dynamic>?)
              ?.map((e) =>
                  PathPoint.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      property: json['property'] == null
          ? const PenProperty()
          : PenProperty.fromJson(
              Map<String, dynamic>.from(json['property'] as Map)),
      extra: (json['extra'] as Map?)?.map(
            (k, e) => MapEntry(k as String, e),
          ) ??
          const {},
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$PenElementToJson(PenElement instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'collection': instance.collection,
      'id': const IdJsonConverter().toJson(instance.id),
      'zoom': instance.zoom,
      'points': instance.points.map((e) => e.toJson()).toList(),
      'property': instance.property.toJson(),
      'extra': instance.extra,
      'type': instance.$type,
    };

TextElement _$TextElementFromJson(Map json) => TextElement(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      collection: json['collection'] as String? ?? '',
      id: const IdJsonConverter().fromJson(json['id'] as String?),
      position: json['position'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter().fromJson(json['position'] as Map),
      scale: (json['scale'] as num?)?.toDouble() ?? 1.0,
      styleSheet: json['styleSheet'] == null
          ? null
          : NamedItem<TextStyleSheet>.fromJson(
              Map<String, dynamic>.from(json['styleSheet'] as Map),
              (value) => TextStyleSheet.fromJson(
                  Map<String, dynamic>.from(value as Map))),
      area: TextArea.fromJson(Map<String, dynamic>.from(json['area'] as Map)),
      constraint: json['constraint'] == null
          ? const ElementConstraint(size: 1000)
          : ElementConstraint.fromJson(
              Map<String, dynamic>.from(json['constraint'] as Map)),
      foreground: json['foreground'] == null
          ? SRGBColor.black
          : const ColorJsonConverter()
              .fromJson((json['foreground'] as num).toInt()),
      extra: (json['extra'] as Map?)?.map(
            (k, e) => MapEntry(k as String, e),
          ) ??
          const {},
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$TextElementToJson(TextElement instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'collection': instance.collection,
      'id': const IdJsonConverter().toJson(instance.id),
      'position': const DoublePointJsonConverter().toJson(instance.position),
      'scale': instance.scale,
      'styleSheet': instance.styleSheet?.toJson(
        (value) => value.toJson(),
      ),
      'area': instance.area.toJson(),
      'constraint': instance.constraint.toJson(),
      'foreground': const ColorJsonConverter().toJson(instance.foreground),
      'extra': instance.extra,
      'type': instance.$type,
    };

MarkdownElement _$MarkdownElementFromJson(Map json) => MarkdownElement(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      collection: json['collection'] as String? ?? '',
      id: const IdJsonConverter().fromJson(json['id'] as String?),
      position: json['position'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter().fromJson(json['position'] as Map),
      scale: (json['scale'] as num?)?.toDouble() ?? 1.0,
      styleSheet: json['styleSheet'] == null
          ? null
          : NamedItem<TextStyleSheet>.fromJson(
              Map<String, dynamic>.from(json['styleSheet'] as Map),
              (value) => TextStyleSheet.fromJson(
                  Map<String, dynamic>.from(value as Map))),
      areaProperty: json['areaProperty'] == null
          ? const AreaProperty()
          : AreaProperty.fromJson(
              Map<String, dynamic>.from(json['areaProperty'] as Map)),
      text: json['text'] as String,
      constraint: json['constraint'] == null
          ? const ElementConstraint(size: 1000)
          : ElementConstraint.fromJson(
              Map<String, dynamic>.from(json['constraint'] as Map)),
      foreground: json['foreground'] == null
          ? SRGBColor.black
          : const ColorJsonConverter()
              .fromJson((json['foreground'] as num).toInt()),
      extra: (json['extra'] as Map?)?.map(
            (k, e) => MapEntry(k as String, e),
          ) ??
          const {},
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$MarkdownElementToJson(MarkdownElement instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'collection': instance.collection,
      'id': const IdJsonConverter().toJson(instance.id),
      'position': const DoublePointJsonConverter().toJson(instance.position),
      'scale': instance.scale,
      'styleSheet': instance.styleSheet?.toJson(
        (value) => value.toJson(),
      ),
      'areaProperty': instance.areaProperty.toJson(),
      'text': instance.text,
      'constraint': instance.constraint.toJson(),
      'foreground': const ColorJsonConverter().toJson(instance.foreground),
      'extra': instance.extra,
      'type': instance.$type,
    };

ImageElement _$ImageElementFromJson(Map json) => ImageElement(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      collection: json['collection'] as String? ?? '',
      id: const IdJsonConverter().fromJson(json['id'] as String?),
      position: json['position'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter().fromJson(json['position'] as Map),
      constraints: json['constraints'] == null
          ? const ScaledElementConstraints(scaleX: 1, scaleY: 1)
          : ElementConstraints.fromJson(
              Map<String, dynamic>.from(json['constraints'] as Map)),
      source: json['source'] as String,
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      extra: (json['extra'] as Map?)?.map(
            (k, e) => MapEntry(k as String, e),
          ) ??
          const {},
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ImageElementToJson(ImageElement instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'collection': instance.collection,
      'id': const IdJsonConverter().toJson(instance.id),
      'position': const DoublePointJsonConverter().toJson(instance.position),
      'constraints': instance.constraints?.toJson(),
      'source': instance.source,
      'width': instance.width,
      'height': instance.height,
      'extra': instance.extra,
      'type': instance.$type,
    };

SvgElement _$SvgElementFromJson(Map json) => SvgElement(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      collection: json['collection'] as String? ?? '',
      id: const IdJsonConverter().fromJson(json['id'] as String?),
      position: json['position'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter().fromJson(json['position'] as Map),
      constraints: json['constraints'] == null
          ? const ScaledElementConstraints(scaleX: 1, scaleY: 1)
          : ElementConstraints.fromJson(
              Map<String, dynamic>.from(json['constraints'] as Map)),
      source: json['source'] as String,
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      extra: (json['extra'] as Map?)?.map(
            (k, e) => MapEntry(k as String, e),
          ) ??
          const {},
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SvgElementToJson(SvgElement instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'collection': instance.collection,
      'id': const IdJsonConverter().toJson(instance.id),
      'position': const DoublePointJsonConverter().toJson(instance.position),
      'constraints': instance.constraints?.toJson(),
      'source': instance.source,
      'width': instance.width,
      'height': instance.height,
      'extra': instance.extra,
      'type': instance.$type,
    };

ShapeElement _$ShapeElementFromJson(Map json) => ShapeElement(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      collection: json['collection'] as String? ?? '',
      id: const IdJsonConverter().fromJson(json['id'] as String?),
      firstPosition: json['firstPosition'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter()
              .fromJson(json['firstPosition'] as Map),
      secondPosition: json['secondPosition'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter()
              .fromJson(json['secondPosition'] as Map),
      property: json['property'] == null
          ? const ShapeProperty(shape: RectangleShape())
          : ShapeProperty.fromJson(
              Map<String, dynamic>.from(json['property'] as Map)),
      extra: (json['extra'] as Map?)?.map(
            (k, e) => MapEntry(k as String, e),
          ) ??
          const {},
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ShapeElementToJson(ShapeElement instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'collection': instance.collection,
      'id': const IdJsonConverter().toJson(instance.id),
      'firstPosition':
          const DoublePointJsonConverter().toJson(instance.firstPosition),
      'secondPosition':
          const DoublePointJsonConverter().toJson(instance.secondPosition),
      'property': instance.property.toJson(),
      'extra': instance.extra,
      'type': instance.$type,
    };

TextureElement _$TextureElementFromJson(Map json) => TextureElement(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      collection: json['collection'] as String? ?? '',
      id: const IdJsonConverter().fromJson(json['id'] as String?),
      texture: json['texture'] == null
          ? const SurfaceTexture.pattern()
          : SurfaceTexture.fromJson(
              Map<String, dynamic>.from(json['texture'] as Map)),
      firstPosition: json['firstPosition'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter()
              .fromJson(json['firstPosition'] as Map),
      secondPosition: json['secondPosition'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter()
              .fromJson(json['secondPosition'] as Map),
      extra: (json['extra'] as Map?)?.map(
            (k, e) => MapEntry(k as String, e),
          ) ??
          const {},
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$TextureElementToJson(TextureElement instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'collection': instance.collection,
      'id': const IdJsonConverter().toJson(instance.id),
      'texture': instance.texture.toJson(),
      'firstPosition':
          const DoublePointJsonConverter().toJson(instance.firstPosition),
      'secondPosition':
          const DoublePointJsonConverter().toJson(instance.secondPosition),
      'extra': instance.extra,
      'type': instance.$type,
    };
