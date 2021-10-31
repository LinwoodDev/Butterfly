import 'package:butterfly/models/properties/label.dart';

import 'painter.dart';

class LabelPainter extends Painter {
  final LabelProperty property;

  const LabelPainter({String name = '', this.property = const LabelProperty()})
      : super(name: name);
  LabelPainter.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : property = LabelProperty.fromJson(json),
        super.fromJson(json);
  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({'type': 'label'})
    ..addAll(property.toJson());

  LabelPainter copyWith({String? name, LabelProperty? property}) =>
      LabelPainter(
          name: name ?? this.name, property: property ?? this.property);
}
