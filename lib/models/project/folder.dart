import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mdi/mdi.dart';

import 'item.dart';

class FolderProjectItem extends ProjectItem {
  final List<ProjectItem> _files;

  FolderProjectItem({@required String name, String description})
      : _files = [],
        super(name: name, description: description);

  FolderProjectItem.fromJson(Map<String, dynamic> json)
      : _files = (json['files'] as List<Map<String, dynamic>>)
            .map((e) => ProjectItem.fromJson(e))
            .toList(),
        super(name: json['name'], description: json['description']);

  List<ProjectItem> get files => List.unmodifiable(_files);

  bool addFile(ProjectItem item) {
    if (!hasFile(item.name))
      _files.add(item);
    else
      return false;
    return true;
  }

  bool deleteFile(String path) {
    List<String> directories = path.split('/');
    List<String> parentPath = directories.sublist(0, directories.length - 1);
    var parent = getFile(parentPath.join('/'));
    if (parent == null || !(parent is FolderProjectItem)) return false;
    (getFile(path) as FolderProjectItem)._files.remove(directories[directories.length - 1]);
    return true;
  }

  bool hasFile(String path) => getFile(path) != null;

  ProjectItem getFile(String path) {
    List<String> directories = path.split('/');
    if (directories.isEmpty || directories[0].isEmpty) return this;
    var iterator = _files.where((element) => element.name == directories.first);
    if (iterator.isEmpty) return null;
    ProjectItem current = iterator.first;
    var next = directories.sublist(1, directories.length);
    if (current is FolderProjectItem)
      return current.getFile(next.join('/'));
    else if (next.isEmpty)
      return current;
    else
      return this;
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({'files': _files.map((file) => file.toJson())});
  }

  @override
  IconData get icon => Mdi.folderOutline;
}
