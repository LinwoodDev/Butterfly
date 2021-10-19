import 'painter.dart';

class ImagePainter extends Painter {
  @override
  Map<String, dynamic> toJson() => super.toJson()..addAll({"type": "image"});
}
