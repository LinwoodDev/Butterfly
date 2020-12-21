import 'package:butterfly/models/packs/collection.dart';
import 'package:butterfly/models/project/folder.dart';
import 'package:butterfly/models/project/pad.dart';

class AppDocument {
  String name;
  String description;
  String mainPad = 'pads/main';
  FolderProjectItem folder = FolderProjectItem(name: 'pads')..addFile(PadProjectItem(name: 'main'));
  List<PackCollection> packs = [];

  AppDocument({this.name, this.description});
}
