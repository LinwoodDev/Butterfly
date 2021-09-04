import 'package:butterfly/models/elements/element.dart';

class PaintElement extends ElementLayer {
  PaintElement();
  PaintElement.fromJson(Map<String, dynamic> json);

  @override
  Map<String, dynamic> toJson() => {
        'type': 'paint',
      };
}
