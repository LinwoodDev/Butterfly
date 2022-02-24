import 'package:butterfly/models/painters/painter.dart';

class AreaPainter extends Painter {
  const AreaPainter({
    String name = '',
  }) : super(name: name);
  AreaPainter.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => super.toJson()..addAll({'type': 'area'});

  AreaPainter copyWith({
    String? name,
  }) =>
      AreaPainter(
        name: name ?? this.name,
      );
}
