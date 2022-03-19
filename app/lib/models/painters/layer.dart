part of 'painter.dart';

class LayerPainter extends Painter {
  final String layer;
  final bool includeEraser;

  const LayerPainter(
      {this.layer = '', String name = '', this.includeEraser = false})
      : super(name: name);
  LayerPainter.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : layer = json['layer'] ?? '',
        includeEraser = json['includeEraser'] ?? false,
        super.fromJson(json);
  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({'type': 'layer', 'layer': layer, 'includeEraser': includeEraser});

  LayerPainter copyWith({String? name, String? layer, bool? includeEraser}) =>
      LayerPainter(
          name: name ?? this.name,
          layer: layer ?? this.layer,
          includeEraser: includeEraser ?? this.includeEraser);
}
