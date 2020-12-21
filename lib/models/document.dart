import 'package:butterfly/models/elements/layer.dart';
import 'package:butterfly/models/packs/collection.dart';
import 'package:butterfly/models/project/folder.dart';

import 'elements/container.dart';

class AppDocument {
  String name;
  String description;
  FolderProjectItem folder = FolderProjectItem();
  List<PackCollection> packs = [];

  AppDocument({this.name, this.description});
}
