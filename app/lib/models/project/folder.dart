import 'type.dart';

class FolderProjectItem extends ProjectItem {
  final List<ProjectItem?> _files;

  FolderProjectItem({required String name, String description = ''})
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

  List<ProjectItem> addFiles(List<ProjectItem> items) {
    return items.where((element) => addFile(element)).toList();
  }

  bool deleteFile(String path) {
    List<String> directories = path.split('/');
    List<String> parentPath = directories.sublist(0, directories.length - 1);
    var parent = getFile(parentPath.join('/'));
    if (parent == this || !(parent is FolderProjectItem)) return false;
    (getFile(path) as FolderProjectItem)._files.remove(directories[directories.length - 1]);
    return true;
  }

  bool hasFile(String path) => getFile(path) != this;

  ProjectItem getFile(String path) {
    List<String> directories = path.split('/');
    directories.removeWhere((element) => element.isEmpty);
    if (directories.isEmpty) return this;
    var current =
        files.firstWhere((element) => element.name == directories.first, orElse: () => this);
    directories.removeAt(0);
    if (current is FolderProjectItem) return current.getFile(directories.join("/"));
    return current;
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({'files': _files.map((file) => file!.toJson())});
  }

  @override
  ProjectItemType get type => ProjectItemType.folder;
}
