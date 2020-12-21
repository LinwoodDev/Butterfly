import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import 'item.dart';

class ImageProjectItem extends ProjectItem {
  final Uint8List bytes;

  ImageProjectItem({@required String name, String description, this.bytes})
      : super(name: name, description: description);
}
