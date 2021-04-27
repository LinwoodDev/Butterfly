import 'package:butterfly/models/project/folder.dart';

import 'packs/collection.dart';
import 'project/pad.dart';

class AppDocument extends FolderProjectItem {
  String? mainPad = 'pads/main';
  final List<PackCollection> packs = [];

  AppDocument({required String name, String description = '', bool blank = false})
      : super(name: name, description: description) {
    if (!blank) addFile(FolderProjectItem(name: "pads")..addFile(PadProjectItem(name: "main")));
  }

  AppDocument.fromJson(Map<String, dynamic> json)
      : mainPad = json['mainPad'],
        super.fromJson(json);
  AppDocument copyWith({String? name, String? description}) {
    return AppDocument(
        name: name ?? this.name, description: description ?? this.description, blank: true)
      ..addFiles(files);
  }
}
