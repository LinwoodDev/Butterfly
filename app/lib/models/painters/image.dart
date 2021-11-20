import 'painter.dart';

class ImagePainter extends Painter {
  const ImagePainter({String name = ''}) : super(name: name);
  ImagePainter.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => super.toJson()..addAll({'type': 'image'});

  ImagePainter copyWith({String? name}) =>
      ImagePainter(name: name ?? this.name);
}
