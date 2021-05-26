import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../inspector.dart';
import 'folder.dart';
import 'image.dart';
import 'pad.dart';

enum ProjectItemType { folder, image, pad }

extension ProjectItemTypeExtension on ProjectItemType? {
  String? get name {
    switch (this) {
      case ProjectItemType.folder:
        return "Folder";
      case ProjectItemType.image:
        return "Image";
      case ProjectItemType.pad:
        return "Pad";
      default:
        return null;
    }
  }

  IconData? get icon {
    switch (this) {
      case ProjectItemType.folder:
        return PhosphorIcons.folderLight;
      case ProjectItemType.image:
        return PhosphorIcons.imageLight;
      case ProjectItemType.pad:
        return PhosphorIcons.monitorLight;
      default:
        return null;
    }
  }

  ProjectItem? create(String name, String description) {
    switch (this) {
      case ProjectItemType.folder:
        return FolderProjectItem(name: name, description: description);
      case ProjectItemType.image:
        return ImageProjectItem(name: name, description: description);
      case ProjectItemType.pad:
        return PadProjectItem(name: name, description: description);
      default:
        return null;
    }
  }

  ProjectItem? fromJson(Map<String, dynamic> json) {
    switch (this) {
      case ProjectItemType.folder:
        return FolderProjectItem.fromJson(json);
      case ProjectItemType.pad:
        return PadProjectItem.fromJson(json);
      case ProjectItemType.image:
        return ImageProjectItem.fromJson(json);
      default:
        return null;
    }
  }

  Map<String, dynamic> toJson(Map<String, dynamic> json) {
    return Map.from(json)..addAll({"type": toString()});
  }
}

abstract class ProjectItem with InspectorItem {
  String name;
  String description = '';

  ProjectItem({required this.name, this.description = ''});

  Map<String, dynamic> toJson() => {'name': name, 'description': description};
  static ProjectItem? fromJson(Map<String, dynamic> json) => ProjectItemType.values
      .firstWhere((element) => element.toString() == json['type'])
      .fromJson(json);

  Widget buildInspector(DocumentBloc bloc) {
    return ListView(children: [
      TextField(
          decoration: InputDecoration(labelText: "Name"),
          controller: TextEditingController(text: name),
          onSubmitted: (value) {
            name = value;
            List<String?> path =
                (bloc.state as DocumentLoadSuccess).currentSelectedPath!.split('/');
            path.last = name;
            bloc.add(ProjectChanged(nextSelected: path.join('/')));
          }),
      TextField(maxLines: null, minLines: 3, decoration: InputDecoration(labelText: "Decoration"))
    ]);
  }

  ProjectItemType get type;
}
