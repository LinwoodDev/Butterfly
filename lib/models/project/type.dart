import 'folder.dart';
import 'item.dart';
import 'pad.dart';

enum ProjectItemType { folder, image, pad }

extension ProjectItemTypeExtension on ProjectItemType {
  String getName() {
    return "";
  }

  ProjectItem fromJson(Map<String, dynamic> json) {
    switch (this) {
      case ProjectItemType.folder:
        return FolderProjectItem.fromJson(json);
      case ProjectItemType.pad:
        return PadProjectItem.fromJson(json);
      case ProjectItemType.image:
    }
    return null;
  }

  Map<String, dynamic> toJson(Map<String, dynamic> json) {
    return Map.from(json)..addAll({"type": toString()});
  }
}
