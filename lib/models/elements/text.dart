import 'package:butterfly/models/elements/type.dart';

class GroupElement extends ElementLayer {
  String? text;
  int? size;

  GroupElement({required String name, String? description})
      : super(name: name, description: description);

  GroupElement.fromJson(Map<String, dynamic> json)
      : super(name: json['name'], description: json['description']);

  @override
  LayerType get type => LayerType.text;
}
