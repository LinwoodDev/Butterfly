import 'dart:typed_data';

import 'type.dart';

class ImageProjectItem extends ProjectItem {
  final Uint8List? bytes;

  ImageProjectItem({required String name, String description = '', this.bytes})
      : super(name: name, description: description);
  ImageProjectItem.fromJson(Map<String, dynamic> json)
      : bytes = Uint8List.fromList(json['root']),
        super(name: json['name'], description: json['description']);

  @override
  ProjectItemType get type => ProjectItemType.image;
}
