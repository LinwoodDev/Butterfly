import 'package:butterfly/models/project/folder.dart';
import 'package:flutter/foundation.dart';

import 'packs/collection.dart';
import 'project/pad.dart';

class AppDocument extends FolderProjectItem {
  String mainPad = 'pads/main';
  final List<PackCollection> packs = [];

  AppDocument({@required String name, String description})
      : super(name: name, description: description) {
    addFile(FolderProjectItem(name: "pads")..addFile(PadProjectItem(name: "main")));
  }

  AppDocument.fromJson(Map<String, dynamic> json)
      : mainPad = json['mainPad'],
        super.fromJson(json);
  AppDocument copyWith({String name, String description}) {
    return AppDocument(name: name ?? this.name, description: description ?? this.description)
      ..addFiles(files);
  }
}
