import 'package:butterfly/models/project/folder.dart';
import 'package:flutter/foundation.dart';

import 'packs/collection.dart';
import 'project/pad.dart';

class AppDocument extends FolderProjectItem {
  String mainPad = 'pads/main';
  List<PackCollection> packs = [];

  AppDocument({@required String name, String description})
      : super(name: name, description: description) {
    addFile(FolderProjectItem(name: "pads")..addFile(PadProjectItem(name: "main")));
  }

  AppDocument.fromJson(Map<String, dynamic> json)
      : mainPad = json['mainPad'],
        super.fromJson(json);
}
