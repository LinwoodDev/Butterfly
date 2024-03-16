// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ElementConstraintImpl _$$ElementConstraintImplFromJson(Map json) =>
    _$ElementConstraintImpl(
      size: (json['size'] as num?)?.toDouble() ?? 0,
      length: (json['length'] as num?)?.toDouble() ?? 0,
      includeArea: json['includeArea'] as bool? ?? true,
    );

Map<String, dynamic> _$$ElementConstraintImplToJson(
        _$ElementConstraintImpl instance) =>
    <String, dynamic>{
      'size': instance.size,
      'length': instance.length,
      'includeArea': instance.includeArea,
    };

_$ScaledElementConstraintsImpl _$$ScaledElementConstraintsImplFromJson(
        Map json) =>
    _$ScaledElementConstraintsImpl(
      scaleX: (json['scaleX'] as num?)?.toDouble() ?? 1,
      scaleY: (json['scaleY'] as num?)?.toDouble() ?? 1,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ScaledElementConstraintsImplToJson(
        _$ScaledElementConstraintsImpl instance) =>
    <String, dynamic>{
      'scaleX': instance.scaleX,
      'scaleY': instance.scaleY,
      'type': instance.$type,
    };

_$FixedElementConstraintsImpl _$$FixedElementConstraintsImplFromJson(
        Map json) =>
    _$FixedElementConstraintsImpl(
      (json['height'] as num).toDouble(),
      (json['width'] as num).toDouble(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$FixedElementConstraintsImplToJson(
        _$FixedElementConstraintsImpl instance) =>
    <String, dynamic>{
      'height': instance.height,
      'width': instance.width,
      'type': instance.$type,
    };

_$DynamicElementConstraintsImpl _$$DynamicElementConstraintsImplFromJson(
        Map json) =>
    _$DynamicElementConstraintsImpl(
      height: (json['height'] as num?)?.toDouble() ?? 0,
      width: (json['width'] as num?)?.toDouble() ?? 0,
      aspectRatio: (json['aspectRatio'] as num?)?.toDouble() ?? 0,
      includeArea: json['includeArea'] as bool? ?? true,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DynamicElementConstraintsImplToJson(
        _$DynamicElementConstraintsImpl instance) =>
    <String, dynamic>{
      'height': instance.height,
      'width': instance.width,
      'aspectRatio': instance.aspectRatio,
      'includeArea': instance.includeArea,
      'type': instance.$type,
    };

_$PenElementImpl _$$PenElementImplFromJson(Map json) => _$PenElementImpl(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      layer: json['layer'] as String? ?? '',
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

Map<String, dynamic> _$$PenElementImplToJson(_$PenElementImpl instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'layer': instance.layer,
      'zoom': instance.zoom,
      'points': instance.points.map((e) => e.toJson()).toList(),
      'property': instance.property.toJson(),
      'extra': instance.extra,
      'type': instance.$type,
    };

_$TextElementImpl _$$TextElementImplFromJson(Map json) => _$TextElementImpl(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      layer: json['layer'] as String? ?? '',
      position: json['position'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter().fromJson(json['position'] as Map),
      scale: (json['scale'] as num?)?.toDouble() ?? 1.0,
      styleSheet: json['styleSheet'] == null
          ? const PackAssetLocation()
          : PackAssetLocation.fromJson(
              Map<String, dynamic>.from(json['styleSheet'] as Map)),
      area: TextArea.fromJson(Map<String, dynamic>.from(json['area'] as Map)),
      constraint: json['constraint'] == null
          ? const ElementConstraint(size: 1000)
          : ElementConstraint.fromJson(
              Map<String, dynamic>.from(json['constraint'] as Map)),
      foreground: json['foreground'] as int? ?? BasicColors.black,
      extra: (json['extra'] as Map?)?.map(
            (k, e) => MapEntry(k as String, e),
          ) ??
          const {},
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TextElementImplToJson(_$TextElementImpl instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'layer': instance.layer,
      'position': const DoublePointJsonConverter().toJson(instance.position),
      'scale': instance.scale,
      'styleSheet': instance.styleSheet.toJson(),
      'area': instance.area.toJson(),
      'constraint': instance.constraint.toJson(),
      'foreground': instance.foreground,
      'extra': instance.extra,
      'type': instance.$type,
    };

_$MarkdownElementImpl _$$MarkdownElementImplFromJson(Map json) =>
    _$MarkdownElementImpl(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      layer: json['layer'] as String? ?? '',
      position: json['position'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter().fromJson(json['position'] as Map),
      scale: (json['scale'] as num?)?.toDouble() ?? 1.0,
      styleSheet: json['styleSheet'] == null
          ? const PackAssetLocation()
          : PackAssetLocation.fromJson(
              Map<String, dynamic>.from(json['styleSheet'] as Map)),
      areaProperty: json['areaProperty'] == null
          ? const AreaProperty()
          : AreaProperty.fromJson(
              Map<String, dynamic>.from(json['areaProperty'] as Map)),
      text: json['text'] as String,
      constraint: json['constraint'] == null
          ? const ElementConstraint(size: 1000)
          : ElementConstraint.fromJson(
              Map<String, dynamic>.from(json['constraint'] as Map)),
      foreground: json['foreground'] as int? ?? BasicColors.black,
      extra: (json['extra'] as Map?)?.map(
            (k, e) => MapEntry(k as String, e),
          ) ??
          const {},
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$MarkdownElementImplToJson(
        _$MarkdownElementImpl instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'layer': instance.layer,
      'position': const DoublePointJsonConverter().toJson(instance.position),
      'scale': instance.scale,
      'styleSheet': instance.styleSheet.toJson(),
      'areaProperty': instance.areaProperty.toJson(),
      'text': instance.text,
      'constraint': instance.constraint.toJson(),
      'foreground': instance.foreground,
      'extra': instance.extra,
      'type': instance.$type,
    };

_$ImageElementImpl _$$ImageElementImplFromJson(Map json) => _$ImageElementImpl(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      layer: json['layer'] as String? ?? '',
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

Map<String, dynamic> _$$ImageElementImplToJson(_$ImageElementImpl instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'layer': instance.layer,
      'position': const DoublePointJsonConverter().toJson(instance.position),
      'constraints': instance.constraints?.toJson(),
      'source': instance.source,
      'width': instance.width,
      'height': instance.height,
      'extra': instance.extra,
      'type': instance.$type,
    };

_$SvgElementImpl _$$SvgElementImplFromJson(Map json) => _$SvgElementImpl(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      layer: json['layer'] as String? ?? '',
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

Map<String, dynamic> _$$SvgElementImplToJson(_$SvgElementImpl instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'layer': instance.layer,
      'position': const DoublePointJsonConverter().toJson(instance.position),
      'constraints': instance.constraints?.toJson(),
      'source': instance.source,
      'width': instance.width,
      'height': instance.height,
      'extra': instance.extra,
      'type': instance.$type,
    };

_$ShapeElementImpl _$$ShapeElementImplFromJson(Map json) => _$ShapeElementImpl(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      layer: json['layer'] as String? ?? '',
      firstPosition: json['firstPosition'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter()
              .fromJson(json['firstPosition'] as Map),
      secondPosition: json['secondPosition'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter()
              .fromJson(json['secondPosition'] as Map),
      thirdPosition: json['thirdPosition'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter()
              .fromJson(json['thirdPosition'] as Map),
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

Map<String, dynamic> _$$ShapeElementImplToJson(_$ShapeElementImpl instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'layer': instance.layer,
      'firstPosition':
          const DoublePointJsonConverter().toJson(instance.firstPosition),
      'secondPosition':
          const DoublePointJsonConverter().toJson(instance.secondPosition),
      'thirdPosition':
          const DoublePointJsonConverter().toJson(instance.thirdPosition),
      'property': instance.property.toJson(),
      'extra': instance.extra,
      'type': instance.$type,
    };

_$TextureElementImpl _$$TextureElementImplFromJson(Map json) =>
    _$TextureElementImpl(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      layer: json['layer'] as String? ?? '',
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
      thirdPosition: json['thirdPosition'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter()
              .fromJson(json['thirdPosition'] as Map),
      extra: (json['extra'] as Map?)?.map(
            (k, e) => MapEntry(k as String, e),
          ) ??
          const {},
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TextureElementImplToJson(
        _$TextureElementImpl instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'layer': instance.layer,
      'texture': instance.texture.toJson(),
      'firstPosition':
          const DoublePointJsonConverter().toJson(instance.firstPosition),
      'secondPosition':
          const DoublePointJsonConverter().toJson(instance.secondPosition),
      'thirdPosition':
          const DoublePointJsonConverter().toJson(instance.thirdPosition),
      'extra': instance.extra,
      'type': instance.$type,
    };
