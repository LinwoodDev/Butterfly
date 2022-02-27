import 'package:butterfly/models/painters/painter.dart';

class AreaPainter extends Painter {
  final double constrainedWidth, constrainedHeight, constrainedAspectRatio;
  const AreaPainter({
    String name = '',
    this.constrainedWidth = 0,
    this.constrainedHeight = 0,
    this.constrainedAspectRatio = 0,
  }) : super(name: name);
  AreaPainter.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : constrainedWidth = json['constrainedWidth'] ?? 0,
        constrainedHeight = json['constrainedHeight'] ?? 0,
        constrainedAspectRatio = json['constrainedAspectRatio'] ?? 0,
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      'type': 'area',
      'constrainedWidth': constrainedWidth,
      'constrainedHeight': constrainedHeight,
      'constrainedAspectRatio': constrainedAspectRatio
    });

  AreaPainter copyWith({
    String? name,
    double? constrainedWidth,
    double? constrainedHeight,
    double? constrainedAspectRatio,
  }) =>
      AreaPainter(
        name: name ?? this.name,
        constrainedWidth: constrainedWidth ?? this.constrainedWidth,
        constrainedHeight: constrainedHeight ?? this.constrainedHeight,
        constrainedAspectRatio:
            constrainedAspectRatio ?? this.constrainedAspectRatio,
      );
}
